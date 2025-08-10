part of "matrix_sdk_ffi.dart";

class FfiConverterMediaRetentionPolicy {
  static MediaRetentionPolicy lift(RustBuffer buf) {
    return FfiConverterMediaRetentionPolicy.read(buf.asUint8List()).value;
  }

  static RustBuffer lower(MediaRetentionPolicy value) {
    final total_length = FfiConverterOptionalUInt64.allocationSize(
            value.maxCacheSize) +
        FfiConverterOptionalUInt64.allocationSize(value.maxFileSize) +
        FfiConverterOptionalDuration.allocationSize(value.lastAccessExpiry) +
        FfiConverterOptionalDuration.allocationSize(value.cleanupFrequency) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static LiftRetVal<MediaRetentionPolicy> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;

    final maxCacheSize_lifted =
        FfiConverterOptionalUInt64.read(Uint8List.view(buf.buffer, new_offset));
    final maxCacheSize = maxCacheSize_lifted.value;
    new_offset += maxCacheSize_lifted.bytesRead;
    final maxFileSize_lifted =
        FfiConverterOptionalUInt64.read(Uint8List.view(buf.buffer, new_offset));
    final maxFileSize = maxFileSize_lifted.value;
    new_offset += maxFileSize_lifted.bytesRead;
    final lastAccessExpiry_lifted = FfiConverterOptionalDuration.read(
        Uint8List.view(buf.buffer, new_offset));
    final lastAccessExpiry = lastAccessExpiry_lifted.value;
    new_offset += lastAccessExpiry_lifted.bytesRead;
    final cleanupFrequency_lifted = FfiConverterOptionalDuration.read(
        Uint8List.view(buf.buffer, new_offset));
    final cleanupFrequency = cleanupFrequency_lifted.value;
    new_offset += cleanupFrequency_lifted.bytesRead;
    return LiftRetVal(
        MediaRetentionPolicy(
          maxCacheSize: maxCacheSize,
          maxFileSize: maxFileSize,
          lastAccessExpiry: lastAccessExpiry,
          cleanupFrequency: cleanupFrequency,
        ),
        new_offset - buf.offsetInBytes);
  }

  static int write(MediaRetentionPolicy value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;

    new_offset += FfiConverterOptionalUInt64.write(
        value.maxCacheSize, Uint8List.view(buf.buffer, new_offset));
    new_offset += FfiConverterOptionalUInt64.write(
        value.maxFileSize, Uint8List.view(buf.buffer, new_offset));
    new_offset += FfiConverterOptionalDuration.write(
        value.lastAccessExpiry, Uint8List.view(buf.buffer, new_offset));
    new_offset += FfiConverterOptionalDuration.write(
        value.cleanupFrequency, Uint8List.view(buf.buffer, new_offset));
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(MediaRetentionPolicy value) {
    return FfiConverterOptionalUInt64.allocationSize(value.maxCacheSize) +
        FfiConverterOptionalUInt64.allocationSize(value.maxFileSize) +
        FfiConverterOptionalDuration.allocationSize(value.lastAccessExpiry) +
        FfiConverterOptionalDuration.allocationSize(value.cleanupFrequency) +
        0;
  }
}

class FfiConverterBackupDownloadStrategy {
  static BackupDownloadStrategy lift(RustBuffer buffer) {
    return FfiConverterBackupDownloadStrategy.read(buffer.asUint8List()).value;
  }

  static LiftRetVal<BackupDownloadStrategy> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    switch (index) {
      case 1:
        return LiftRetVal(BackupDownloadStrategy.oneShot, 4);
      case 2:
        return LiftRetVal(BackupDownloadStrategy.afterDecryptionFailure, 4);
      case 3:
        return LiftRetVal(BackupDownloadStrategy.manual, 4);
      default:
        throw UniffiInternalError(UniffiInternalError.unexpectedEnumCase,
            "Unable to determine enum variant");
    }
  }

  static RustBuffer lower(BackupDownloadStrategy input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }

  static int allocationSize(BackupDownloadStrategy value) {
    return 4;
  }

  static int write(BackupDownloadStrategy value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.index + 1);
    return 4;
  }
}

class FfiConverterDecryptionSettings {
  static DecryptionSettings lift(RustBuffer buf) {
    return FfiConverterDecryptionSettings.read(buf.asUint8List()).value;
  }

  static RustBuffer lower(DecryptionSettings value) {
    final total_length = FfiConverterTrustRequirement.allocationSize(
            value.senderDeviceTrustRequirement) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static LiftRetVal<DecryptionSettings> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;

    final senderDeviceTrustRequirement_lifted =
        FfiConverterTrustRequirement.read(
            Uint8List.view(buf.buffer, new_offset));
    final senderDeviceTrustRequirement =
        senderDeviceTrustRequirement_lifted.value;
    new_offset += senderDeviceTrustRequirement_lifted.bytesRead;
    return LiftRetVal(
        DecryptionSettings(
          senderDeviceTrustRequirement: senderDeviceTrustRequirement,
        ),
        new_offset - buf.offsetInBytes);
  }

  static int write(DecryptionSettings value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;

    new_offset += FfiConverterTrustRequirement.write(
        value.senderDeviceTrustRequirement,
        Uint8List.view(buf.buffer, new_offset));
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(DecryptionSettings value) {
    return FfiConverterTrustRequirement.allocationSize(
            value.senderDeviceTrustRequirement) +
        0;
  }
}

abstract class RoomPaginationStatus {
  RustBuffer lower();
  int allocationSize();
  int write(Uint8List buf);
}

class FfiConverterRoomPaginationStatus {
  static RoomPaginationStatus lift(RustBuffer buffer) {
    return FfiConverterRoomPaginationStatus.read(buffer.asUint8List()).value;
  }

  static LiftRetVal<RoomPaginationStatus> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final subview = Uint8List.view(buf.buffer, buf.offsetInBytes + 4);
    switch (index) {
      case 1:
        return IdleRoomPaginationStatus.read(subview);
      case 2:
        return PaginatingRoomPaginationStatus.read(subview);
      default:
        throw UniffiInternalError(UniffiInternalError.unexpectedEnumCase,
            "Unable to determine enum variant");
    }
  }

  static RustBuffer lower(RoomPaginationStatus value) {
    return value.lower();
  }

  static int allocationSize(RoomPaginationStatus value) {
    return value.allocationSize();
  }

  static int write(RoomPaginationStatus value, Uint8List buf) {
    return value.write(buf);
  }
}

class IdleRoomPaginationStatus extends RoomPaginationStatus {
  final bool hitTimelineStart;

  IdleRoomPaginationStatus(
    bool this.hitTimelineStart,
  );

  IdleRoomPaginationStatus._(
    bool this.hitTimelineStart,
  );

  static LiftRetVal<IdleRoomPaginationStatus> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;

    final hitTimelineStart_lifted =
        FfiConverterBool.read(Uint8List.view(buf.buffer, new_offset));
    final hitTimelineStart = hitTimelineStart_lifted.value;
    new_offset += hitTimelineStart_lifted.bytesRead;
    return LiftRetVal(
        IdleRoomPaginationStatus._(
          hitTimelineStart,
        ),
        new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterBool.allocationSize(hitTimelineStart) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 1);
    int new_offset = buf.offsetInBytes + 4;

    new_offset += FfiConverterBool.write(
        hitTimelineStart, Uint8List.view(buf.buffer, new_offset));

    return new_offset;
  }
}

class PaginatingRoomPaginationStatus extends RoomPaginationStatus {
  PaginatingRoomPaginationStatus();

  PaginatingRoomPaginationStatus._();

  static LiftRetVal<PaginatingRoomPaginationStatus> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;

    return LiftRetVal(PaginatingRoomPaginationStatus._(), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 2);
    int new_offset = buf.offsetInBytes + 4;

    return new_offset;
  }
}
