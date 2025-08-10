library uniffi;

import "dart:async";
import "dart:convert";
import "dart:ffi";
import "dart:io" show Platform, File, Directory;
import "dart:isolate";
import "dart:typed_data";
import "package:ffi/ffi.dart";
import "package:matrix_sdk_ffi/matrix_sdk_ffi.dart";

class MediaRetentionPolicy {
  final int? maxCacheSize;
  final int? maxFileSize;
  final Duration? lastAccessExpiry;
  final Duration? cleanupFrequency;

  MediaRetentionPolicy({
    this.maxCacheSize,
    this.maxFileSize,
    this.lastAccessExpiry,
    this.cleanupFrequency,
  });
}

enum EncryptionState {
  encrypted,
  notEncrypted,
  unknown,
  ;
}

class UniffiInternalError implements Exception {
  static const int bufferOverflow = 0;
  static const int incompleteData = 1;
  static const int unexpectedOptionalTag = 2;
  static const int unexpectedEnumCase = 3;
  static const int unexpectedNullPointer = 4;
  static const int unexpectedRustCallStatusCode = 5;
  static const int unexpectedRustCallError = 6;
  static const int unexpectedStaleHandle = 7;
  static const int rustPanic = 8;

  final int errorCode;
  final String? panicMessage;

  const UniffiInternalError(this.errorCode, this.panicMessage);

  static UniffiInternalError panicked(String message) {
    return UniffiInternalError(rustPanic, message);
  }

  @override
  String toString() {
    switch (errorCode) {
      case bufferOverflow:
        return "UniFfi::BufferOverflow";
      case incompleteData:
        return "UniFfi::IncompleteData";
      case unexpectedOptionalTag:
        return "UniFfi::UnexpectedOptionalTag";
      case unexpectedEnumCase:
        return "UniFfi::UnexpectedEnumCase";
      case unexpectedNullPointer:
        return "UniFfi::UnexpectedNullPointer";
      case unexpectedRustCallStatusCode:
        return "UniFfi::UnexpectedRustCallStatusCode";
      case unexpectedRustCallError:
        return "UniFfi::UnexpectedRustCallError";
      case unexpectedStaleHandle:
        return "UniFfi::UnexpectedStaleHandle";
      case rustPanic:
        return "UniFfi::rustPanic: $panicMessage";
      default:
        return "UniFfi::UnknownError: $errorCode";
    }
  }
}

const int CALL_SUCCESS = 0;
const int CALL_ERROR = 1;
const int CALL_UNEXPECTED_ERROR = 2;

final class RustCallStatus extends Struct {
  @Int8()
  external int code;

  external RustBuffer errorBuf;
}

void checkCallStatus(UniffiRustCallStatusErrorHandler errorHandler,
    Pointer<RustCallStatus> status) {
  if (status.ref.code == CALL_SUCCESS) {
    return;
  } else if (status.ref.code == CALL_ERROR) {
    throw errorHandler.lift(status.ref.errorBuf);
  } else if (status.ref.code == CALL_UNEXPECTED_ERROR) {
    if (status.ref.errorBuf.len > 0) {
      throw UniffiInternalError.panicked(
          FfiConverterString.lift(status.ref.errorBuf));
    } else {
      throw UniffiInternalError.panicked("Rust panic");
    }
  } else {
    throw UniffiInternalError.panicked(
        "Unexpected RustCallStatus code: \${status.ref.code}");
  }
}

T rustCall<T>(T Function(Pointer<RustCallStatus>) callback,
    [UniffiRustCallStatusErrorHandler? errorHandler]) {
  final status = calloc<RustCallStatus>();
  try {
    final result = callback(status);
    checkCallStatus(errorHandler ?? NullRustCallStatusErrorHandler(), status);
    return result;
  } finally {
    calloc.free(status);
  }
}

class NullRustCallStatusErrorHandler extends UniffiRustCallStatusErrorHandler {
  @override
  Exception lift(RustBuffer errorBuf) {
    errorBuf.free();
    return UniffiInternalError.panicked("Unexpected CALL_ERROR");
  }
}

class ParseExceptionErrorHandler extends UniffiRustCallStatusErrorHandler {
  @override
  Exception lift(RustBuffer errorBuf) {
    final message = FfiConverterString.lift(errorBuf);
    return FormatException(message);
  }
}

class MatrixExceptionErrorHandler extends UniffiRustCallStatusErrorHandler {
  @override
  Exception lift(RustBuffer errorBuf) {
    final message = FfiConverterString.lift(errorBuf);
    return FormatException("Matrix error: \$message");
  }
}

final parseExceptionErrorHandler = ParseExceptionErrorHandler();
final matrixExceptionErrorHandler = MatrixExceptionErrorHandler();

abstract class UniffiRustCallStatusErrorHandler {
  Exception lift(RustBuffer errorBuf);
}

final class RustBuffer extends Struct {
  @Uint64()
  external int capacity;

  @Uint64()
  external int len;

  external Pointer<Uint8> data;

  static RustBuffer alloc(int size) {
    return rustCall((status) =>
        _UniffiLib.instance.ffi_matrix_sdk_base_rustbuffer_alloc(size, status));
  }

  static RustBuffer fromBytes(ForeignBytes bytes) {
    return rustCall((status) => _UniffiLib.instance
        .ffi_matrix_sdk_base_rustbuffer_from_bytes(bytes, status));
  }

  void free() {
    rustCall((status) =>
        _UniffiLib.instance.ffi_matrix_sdk_base_rustbuffer_free(this, status));
  }

  RustBuffer reserve(int additionalCapacity) {
    return rustCall((status) => _UniffiLib.instance
        .ffi_matrix_sdk_base_rustbuffer_reserve(
            this, additionalCapacity, status));
  }

  Uint8List asUint8List() {
    final dataList = data.asTypedList(len);
    final byteData = ByteData.sublistView(dataList);
    return Uint8List.view(byteData.buffer);
  }

  @override
  String toString() {
    return "RustBuffer{capacity: \$capacity, len: \$len, data: \$data}";
  }
}

RustBuffer toRustBuffer(Uint8List data) {
  final length = data.length;

  final Pointer<Uint8> frameData = calloc<Uint8>(length);
  final pointerList = frameData.asTypedList(length);
  pointerList.setAll(0, data);

  final bytes = calloc<ForeignBytes>();
  bytes.ref.len = length;
  bytes.ref.data = frameData;
  return RustBuffer.fromBytes(bytes.ref);
}

final class ForeignBytes extends Struct {
  @Int32()
  external int len;
  external Pointer<Uint8> data;

  void free() {
    calloc.free(data);
  }
}

class LiftRetVal<T> {
  final T value;
  final int bytesRead;
  const LiftRetVal(this.value, this.bytesRead);

  LiftRetVal<T> copyWithOffset(int offset) {
    return LiftRetVal(value, bytesRead + offset);
  }
}

abstract class FfiConverter<D, F> {
  const FfiConverter();

  D lift(F value);
  F lower(D value);
  D read(ByteData buffer, int offset);
  void write(D value, ByteData buffer, int offset);
  int size(D value);
}

mixin FfiConverterPrimitive<T> on FfiConverter<T, T> {
  @override
  T lift(T value) => value;

  @override
  T lower(T value) => value;
}

Uint8List createUint8ListFromInt(int value) {
  int length = value.bitLength ~/ 8 + 1;

  if (length != 4 && length != 8) {
    length = (value < 0x100000000) ? 4 : 8;
  }

  Uint8List uint8List = Uint8List(length);

  for (int i = length - 1; i >= 0; i--) {
    uint8List[i] = value & 0xFF;
    value >>= 8;
  }

  return uint8List;
}

class FfiConverterDouble64 {
  static double lift(double value) => value;

  static LiftRetVal<double> read(Uint8List buf) {
    return LiftRetVal(
        buf.buffer.asByteData(buf.offsetInBytes).getFloat64(0), 8);
  }

  static double lower(double value) => value;

  static int allocationSize([double value = 0]) {
    return 8;
  }

  static int write(double value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setFloat64(0, value);
    return FfiConverterDouble64.allocationSize();
  }
}

class FfiConverterUint32 {
  static int lift(int value) => value;
  static int lower(int value) => value;
  static LiftRetVal<int> read(Uint8List buf) {
    final end = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0) + 4;
    final result =
        buf.buffer.asByteData().getUint32(buf.offsetInBytes, Endian.little);
    return LiftRetVal(result, end);
  }

  static int write(int value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value);
    int offset = buf.offsetInBytes + 4;
    offset +=
        FfiConverterInt32.write(value, Uint8List.view(buf.buffer, offset));
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(int value) => 4;
}

class FfiConverterInt32 {
  static int lift(int value) => value;
  static int lower(int value) => value;
  static LiftRetVal<int> read(Uint8List buf) {
    final end = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0) + 4;
    final result =
        buf.buffer.asByteData().getInt32(buf.offsetInBytes, Endian.little);
    return LiftRetVal(result, end);
  }

  static int write(int value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value);
    int offset = buf.offsetInBytes + 4;
    offset +=
        FfiConverterInt32.write(value, Uint8List.view(buf.buffer, offset));
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(int value) => 4;
}

class FfiConverterBool {
  static bool lift(int value) {
    return value == 1;
  }

  static int lower(bool value) {
    return value ? 1 : 0;
  }

  static LiftRetVal<bool> read(Uint8List buf) {
    return LiftRetVal(FfiConverterBool.lift(buf.first), 1);
  }

  static RustBuffer lowerIntoRustBuffer(bool value) {
    return toRustBuffer(Uint8List.fromList([FfiConverterBool.lower(value)]));
  }

  static int allocationSize([bool value = false]) => 1;

  static int write(bool value, Uint8List buf) {
    buf.setAll(0, [value ? 1 : 0]);
    return allocationSize();
  }
}

class FfiConverterUint8List {
  static Uint8List lift(RustBuffer value) => value.asUint8List();
  static RustBuffer lower(Uint8List value) => toRustBuffer(value);
  static LiftRetVal<Uint8List> read(Uint8List buf) {
    final end = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0) + 4;
    final length =
        buf.buffer.asByteData().getUint32(buf.offsetInBytes, Endian.little);
    final result = Uint8List.view(buf.buffer, buf.offsetInBytes + 4, length);
    return LiftRetVal(result, end);
  }

  static int write(Uint8List value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset +=
          FfiConverterInt32.write(value[i], Uint8List.view(buf.buffer, offset));
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(Uint8List value) => 4 + value.length;
}

class FfiConverterString {
  static String lift(RustBuffer buf) {
    return utf8.decoder.convert(buf.asUint8List());
  }

  static RustBuffer lower(String value) {
    return toRustBuffer(Utf8Encoder().convert(value));
  }

  static LiftRetVal<String> read(Uint8List buf) {
    final end = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0) + 4;
    return LiftRetVal(utf8.decoder.convert(buf, 4, end), end);
  }

  static int allocationSize([String value = ""]) {
    return utf8.encoder.convert(value).length + 4;
  }

  static int write(String value, Uint8List buf) {
    final list = utf8.encoder.convert(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, list.length);
    buf.setAll(4, list);
    return list.length + 4;
  }
}

class FfiConverterOptionalDuration {
  static Duration? lift(RustBuffer buf) {
    return FfiConverterOptionalDuration.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Duration?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterDuration.read(
        Uint8List.view(buf.buffer, buf.offsetInBytes + 1));
    return LiftRetVal<Duration?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([Duration? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterDuration.allocationSize(value) + 1;
  }

  static RustBuffer lower(Duration? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }

    final length = FfiConverterOptionalDuration.allocationSize(value);

    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);

    FfiConverterOptionalDuration.write(value, buf);

    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(Duration? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }

    buf[0] = 1;

    return FfiConverterDuration.write(
            value, Uint8List.view(buf.buffer, buf.offsetInBytes + 1)) +
        1;
  }
}

class FfiConverterOptionalUInt64 {
  static int? lift(RustBuffer buf) {
    return FfiConverterOptionalUInt64.read(buf.asUint8List()).value;
  }

  static LiftRetVal<int?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterUInt64.read(
        Uint8List.view(buf.buffer, buf.offsetInBytes + 1));
    return LiftRetVal<int?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([int? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterUInt64.allocationSize(value) + 1;
  }

  static RustBuffer lower(int? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }

    final length = FfiConverterOptionalUInt64.allocationSize(value);

    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);

    FfiConverterOptionalUInt64.write(value, buf);

    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(int? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }

    buf[0] = 1;

    return FfiConverterUInt64.write(
            value, Uint8List.view(buf.buffer, buf.offsetInBytes + 1)) +
        1;
  }
}

const int UNIFFI_RUST_FUTURE_POLL_READY = 0;
const int UNIFFI_RUST_FUTURE_POLL_MAYBE_READY = 1;

typedef UniffiRustFutureContinuationCallback = Void Function(Uint64, Int8);

Future<T> uniffiRustCallAsync<T, F>(
  Pointer<Void> Function() rustFutureFunc,
  void Function(
          Pointer<Void>,
          Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
          Pointer<Void>)
      pollFunc,
  F Function(Pointer<Void>, Pointer<RustCallStatus>) completeFunc,
  void Function(Pointer<Void>) freeFunc,
  T Function(F) liftFunc, [
  UniffiRustCallStatusErrorHandler? errorHandler,
]) async {
  final rustFuture = rustFutureFunc();
  final completer = Completer<int>();

  late final NativeCallable<UniffiRustFutureContinuationCallback> callback;

  void poll() {
    pollFunc(
      rustFuture,
      callback.nativeFunction,
      Pointer<Void>.fromAddress(0),
    );
  }

  void onResponse(int _idx, int pollResult) {
    if (pollResult == UNIFFI_RUST_FUTURE_POLL_READY) {
      completer.complete(pollResult);
    } else {
      poll();
    }
  }

  callback =
      NativeCallable<UniffiRustFutureContinuationCallback>.listener(onResponse);

  try {
    poll();
    await completer.future;
    callback.close();

    final status = calloc<RustCallStatus>();
    try {
      final result = completeFunc(rustFuture, status);

      return liftFunc(result);
    } finally {
      calloc.free(status);
    }
  } finally {
    freeFunc(rustFuture);
  }
}

class UniffiHandleMap<T> {
  final Map<int, T> _map = {};
  int _counter = 0;

  int insert(T obj) {
    final handle = _counter++;
    _map[handle] = obj;
    return handle;
  }

  T get(int handle) {
    final obj = _map[handle];
    if (obj == null) {
      throw UniffiInternalError(
          UniffiInternalError.unexpectedStaleHandle, "Handle not found");
    }
    return obj;
  }

  void remove(int handle) {
    if (_map.remove(handle) == null) {
      throw UniffiInternalError(
          UniffiInternalError.unexpectedStaleHandle, "Handle not found");
    }
  }
}

class _UniffiLib {
  _UniffiLib._();

  static final DynamicLibrary _dylib = _open();

  static DynamicLibrary _open() {
    if (Platform.isAndroid)
      return DynamicLibrary.open(
          "${Directory.current.path}/libmatrix_sdk_ffi.so");
    if (Platform.isIOS) return DynamicLibrary.executable();
    if (Platform.isLinux)
      return DynamicLibrary.open(
          "${Directory.current.path}/libmatrix_sdk_ffi.so");
    if (Platform.isMacOS) return DynamicLibrary.open("libmatrix_sdk_ffi.dylib");
    if (Platform.isWindows) return DynamicLibrary.open("matrix_sdk_ffi.dll");
    throw UnsupportedError(
        "Unsupported platform: \${Platform.operatingSystem}");
  }

  static final _UniffiLib instance = _UniffiLib._();

  late final RustBuffer Function(int, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rustbuffer_alloc = _dylib.lookupFunction<
          RustBuffer Function(Uint64, Pointer<RustCallStatus>),
          RustBuffer Function(int,
              Pointer<RustCallStatus>)>("ffi_matrix_sdk_base_rustbuffer_alloc");
  late final RustBuffer Function(ForeignBytes, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rustbuffer_from_bytes = _dylib.lookupFunction<
              RustBuffer Function(ForeignBytes, Pointer<RustCallStatus>),
              RustBuffer Function(ForeignBytes, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rustbuffer_from_bytes");
  late final void Function(RustBuffer, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rustbuffer_free = _dylib.lookupFunction<
          Void Function(RustBuffer, Pointer<RustCallStatus>),
          void Function(RustBuffer,
              Pointer<RustCallStatus>)>("ffi_matrix_sdk_base_rustbuffer_free");
  late final RustBuffer Function(RustBuffer, int, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rustbuffer_reserve = _dylib.lookupFunction<
              RustBuffer Function(RustBuffer, Uint64, Pointer<RustCallStatus>),
              RustBuffer Function(RustBuffer, int, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rustbuffer_reserve");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_u8 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_u8");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_u8 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_u8");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_u8 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_u8");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_u8 = _dylib.lookupFunction<
              Uint8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_u8");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_i8 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_i8");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_i8 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_i8");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_i8 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_i8");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_i8 = _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_i8");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_u16 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_u16");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_u16 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_u16");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_u16 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_u16");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_u16 = _dylib.lookupFunction<
              Uint16 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_u16");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_i16 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_i16");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_i16 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_i16");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_i16 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_i16");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_i16 = _dylib.lookupFunction<
              Int16 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_i16");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_u32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_u32");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_u32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_u32");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_u32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_u32");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_u32 = _dylib.lookupFunction<
              Uint32 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_u32");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_i32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_i32");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_i32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_i32");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_i32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_i32");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_i32 = _dylib.lookupFunction<
              Int32 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_i32");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_u64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_u64");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_u64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_u64");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_u64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_u64");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_u64 = _dylib.lookupFunction<
              Uint64 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_u64");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_i64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_i64");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_i64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_i64");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_i64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_i64");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_i64 = _dylib.lookupFunction<
              Int64 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_i64");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_f32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_f32");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_f32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_f32");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_f32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_f32");
  late final double Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_f32 = _dylib.lookupFunction<
              Float Function(Pointer<Void>, Pointer<RustCallStatus>),
              double Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_f32");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_f64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_f64");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_f64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_f64");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_f64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_f64");
  late final double Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_f64 = _dylib.lookupFunction<
              Double Function(Pointer<Void>, Pointer<RustCallStatus>),
              double Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_f64");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_pointer = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_pointer");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_pointer = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_pointer");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_pointer = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_pointer");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_pointer = _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_pointer");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_rust_buffer = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_rust_buffer");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_rust_buffer = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_rust_buffer");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_rust_buffer = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_rust_buffer");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_rust_buffer =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_rust_buffer");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_poll_void = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_poll_void");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_cancel_void = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_cancel_void");
  late final void Function(
    Pointer<Void>,
  ) ffi_matrix_sdk_base_rust_future_free_void = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
      )>("ffi_matrix_sdk_base_rust_future_free_void");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_base_rust_future_complete_void = _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_base_rust_future_complete_void");
  late final int Function() ffi_matrix_sdk_base_uniffi_contract_version =
      _dylib.lookupFunction<Uint32 Function(), int Function()>(
          "ffi_matrix_sdk_base_uniffi_contract_version");

  static void _checkApiVersion() {
    final bindingsVersion = 29;
    final scaffoldingVersion =
        _UniffiLib.instance.ffi_matrix_sdk_base_uniffi_contract_version();
    if (bindingsVersion != scaffoldingVersion) {
      throw UniffiInternalError.panicked(
          "UniFFI contract version mismatch: bindings version \$bindingsVersion, scaffolding version \$scaffoldingVersion");
    }
  }

  static void _checkApiChecksums() {}
}

void initialize() {
  _UniffiLib._open();
}

void ensureInitialized() {
  _UniffiLib._checkApiVersion();
  _UniffiLib._checkApiChecksums();
}
