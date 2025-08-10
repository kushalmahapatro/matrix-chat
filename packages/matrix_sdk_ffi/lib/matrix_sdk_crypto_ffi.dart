library uniffi;

import "dart:async";
import "dart:convert";
import "dart:ffi";
import "dart:io" show Platform, File, Directory;
import "dart:isolate";
import "dart:typed_data";
import "package:ffi/ffi.dart";
import "package:matrix_sdk_ffi/matrix_sdk_ffi.dart";
import "matrix_sdk_common.dart";
import "matrix_sdk_common.dart" as matrix_sdk_common;
import "matrix_sdk_crypto.dart";
import "matrix_sdk_crypto.dart" as matrix_sdk_crypto;

class BootstrapCrossSigningResult {
  final Request? uploadKeysRequest;
  final UploadSigningKeysRequest uploadSigningKeysRequest;
  final SignatureUploadRequest uploadSignatureRequest;
  BootstrapCrossSigningResult(
    this.uploadKeysRequest,
    this.uploadSigningKeysRequest,
    this.uploadSignatureRequest,
  );
}

class FfiConverterBootstrapCrossSigningResult {
  static BootstrapCrossSigningResult lift(RustBuffer buf) {
    return FfiConverterBootstrapCrossSigningResult.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<BootstrapCrossSigningResult> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final uploadKeysRequest_lifted = FfiConverterOptionalRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final uploadKeysRequest = uploadKeysRequest_lifted.value;
    new_offset += uploadKeysRequest_lifted.bytesRead;
    final uploadSigningKeysRequest_lifted =
        FfiConverterUploadSigningKeysRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final uploadSigningKeysRequest = uploadSigningKeysRequest_lifted.value;
    new_offset += uploadSigningKeysRequest_lifted.bytesRead;
    final uploadSignatureRequest_lifted =
        FfiConverterSignatureUploadRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final uploadSignatureRequest = uploadSignatureRequest_lifted.value;
    new_offset += uploadSignatureRequest_lifted.bytesRead;
    return LiftRetVal(
      BootstrapCrossSigningResult(
        uploadKeysRequest,
        uploadSigningKeysRequest,
        uploadSignatureRequest,
      ),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(BootstrapCrossSigningResult value) {
    final total_length =
        FfiConverterOptionalRequest.allocationSize(value.uploadKeysRequest) +
            FfiConverterUploadSigningKeysRequest.allocationSize(
              value.uploadSigningKeysRequest,
            ) +
            FfiConverterSignatureUploadRequest.allocationSize(
              value.uploadSignatureRequest,
            ) +
            0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(BootstrapCrossSigningResult value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterOptionalRequest.write(
      value.uploadKeysRequest,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterUploadSigningKeysRequest.write(
      value.uploadSigningKeysRequest,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSignatureUploadRequest.write(
      value.uploadSignatureRequest,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(BootstrapCrossSigningResult value) {
    return FfiConverterOptionalRequest.allocationSize(value.uploadKeysRequest) +
        FfiConverterUploadSigningKeysRequest.allocationSize(
          value.uploadSigningKeysRequest,
        ) +
        FfiConverterSignatureUploadRequest.allocationSize(
          value.uploadSignatureRequest,
        ) +
        0;
  }
}

class CancelInfo {
  final String reason;
  final String cancelCode;
  final bool cancelledByUs;
  CancelInfo(this.reason, this.cancelCode, this.cancelledByUs);
}

class FfiConverterCancelInfo {
  static CancelInfo lift(RustBuffer buf) {
    return FfiConverterCancelInfo.read(buf.asUint8List()).value;
  }

  static LiftRetVal<CancelInfo> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final reason_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final reason = reason_lifted.value;
    new_offset += reason_lifted.bytesRead;
    final cancelCode_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final cancelCode = cancelCode_lifted.value;
    new_offset += cancelCode_lifted.bytesRead;
    final cancelledByUs_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final cancelledByUs = cancelledByUs_lifted.value;
    new_offset += cancelledByUs_lifted.bytesRead;
    return LiftRetVal(
      CancelInfo(reason, cancelCode, cancelledByUs),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(CancelInfo value) {
    final total_length = FfiConverterString.allocationSize(value.reason) +
        FfiConverterString.allocationSize(value.cancelCode) +
        FfiConverterBool.allocationSize(value.cancelledByUs) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(CancelInfo value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.reason,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.cancelCode,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.cancelledByUs,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(CancelInfo value) {
    return FfiConverterString.allocationSize(value.reason) +
        FfiConverterString.allocationSize(value.cancelCode) +
        FfiConverterBool.allocationSize(value.cancelledByUs) +
        0;
  }
}

class ConfirmVerificationResult {
  final List<OutgoingVerificationRequest> requests;
  final SignatureUploadRequest? signatureRequest;
  ConfirmVerificationResult(this.requests, this.signatureRequest);
}

class FfiConverterConfirmVerificationResult {
  static ConfirmVerificationResult lift(RustBuffer buf) {
    return FfiConverterConfirmVerificationResult.read(buf.asUint8List()).value;
  }

  static LiftRetVal<ConfirmVerificationResult> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requests_lifted =
        FfiConverterSequenceOutgoingVerificationRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requests = requests_lifted.value;
    new_offset += requests_lifted.bytesRead;
    final signatureRequest_lifted =
        FfiConverterOptionalSignatureUploadRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final signatureRequest = signatureRequest_lifted.value;
    new_offset += signatureRequest_lifted.bytesRead;
    return LiftRetVal(
      ConfirmVerificationResult(requests, signatureRequest),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(ConfirmVerificationResult value) {
    final total_length =
        FfiConverterSequenceOutgoingVerificationRequest.allocationSize(
              value.requests,
            ) +
            FfiConverterOptionalSignatureUploadRequest.allocationSize(
              value.signatureRequest,
            ) +
            0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(ConfirmVerificationResult value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterSequenceOutgoingVerificationRequest.write(
      value.requests,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalSignatureUploadRequest.write(
      value.signatureRequest,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(ConfirmVerificationResult value) {
    return FfiConverterSequenceOutgoingVerificationRequest.allocationSize(
          value.requests,
        ) +
        FfiConverterOptionalSignatureUploadRequest.allocationSize(
          value.signatureRequest,
        ) +
        0;
  }
}

class CrossSigningKeyExport {
  final String? masterKey;
  final String? selfSigningKey;
  final String? userSigningKey;
  CrossSigningKeyExport(
    this.masterKey,
    this.selfSigningKey,
    this.userSigningKey,
  );
}

class FfiConverterCrossSigningKeyExport {
  static CrossSigningKeyExport lift(RustBuffer buf) {
    return FfiConverterCrossSigningKeyExport.read(buf.asUint8List()).value;
  }

  static LiftRetVal<CrossSigningKeyExport> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final masterKey_lifted = FfiConverterOptionalString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final masterKey = masterKey_lifted.value;
    new_offset += masterKey_lifted.bytesRead;
    final selfSigningKey_lifted = FfiConverterOptionalString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final selfSigningKey = selfSigningKey_lifted.value;
    new_offset += selfSigningKey_lifted.bytesRead;
    final userSigningKey_lifted = FfiConverterOptionalString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final userSigningKey = userSigningKey_lifted.value;
    new_offset += userSigningKey_lifted.bytesRead;
    return LiftRetVal(
      CrossSigningKeyExport(masterKey, selfSigningKey, userSigningKey),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(CrossSigningKeyExport value) {
    final total_length =
        FfiConverterOptionalString.allocationSize(value.masterKey) +
            FfiConverterOptionalString.allocationSize(value.selfSigningKey) +
            FfiConverterOptionalString.allocationSize(value.userSigningKey) +
            0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(CrossSigningKeyExport value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterOptionalString.write(
      value.masterKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalString.write(
      value.selfSigningKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalString.write(
      value.userSigningKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(CrossSigningKeyExport value) {
    return FfiConverterOptionalString.allocationSize(value.masterKey) +
        FfiConverterOptionalString.allocationSize(value.selfSigningKey) +
        FfiConverterOptionalString.allocationSize(value.userSigningKey) +
        0;
  }
}

class CrossSigningStatus {
  final bool hasMaster;
  final bool hasSelfSigning;
  final bool hasUserSigning;
  CrossSigningStatus(this.hasMaster, this.hasSelfSigning, this.hasUserSigning);
}

class FfiConverterCrossSigningStatus {
  static CrossSigningStatus lift(RustBuffer buf) {
    return FfiConverterCrossSigningStatus.read(buf.asUint8List()).value;
  }

  static LiftRetVal<CrossSigningStatus> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final hasMaster_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final hasMaster = hasMaster_lifted.value;
    new_offset += hasMaster_lifted.bytesRead;
    final hasSelfSigning_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final hasSelfSigning = hasSelfSigning_lifted.value;
    new_offset += hasSelfSigning_lifted.bytesRead;
    final hasUserSigning_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final hasUserSigning = hasUserSigning_lifted.value;
    new_offset += hasUserSigning_lifted.bytesRead;
    return LiftRetVal(
      CrossSigningStatus(hasMaster, hasSelfSigning, hasUserSigning),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(CrossSigningStatus value) {
    final total_length = FfiConverterBool.allocationSize(value.hasMaster) +
        FfiConverterBool.allocationSize(value.hasSelfSigning) +
        FfiConverterBool.allocationSize(value.hasUserSigning) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(CrossSigningStatus value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterBool.write(
      value.hasMaster,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.hasSelfSigning,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.hasUserSigning,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(CrossSigningStatus value) {
    return FfiConverterBool.allocationSize(value.hasMaster) +
        FfiConverterBool.allocationSize(value.hasSelfSigning) +
        FfiConverterBool.allocationSize(value.hasUserSigning) +
        0;
  }
}

class DecryptedEvent {
  final String clearEvent;
  final String senderCurve25519Key;
  final String? claimedEd25519Key;
  final List<String> forwardingCurve25519Chain;
  final ShieldState shieldState;
  DecryptedEvent(
    this.clearEvent,
    this.senderCurve25519Key,
    this.claimedEd25519Key,
    this.forwardingCurve25519Chain,
    this.shieldState,
  );
}

class FfiConverterDecryptedEvent {
  static DecryptedEvent lift(RustBuffer buf) {
    return FfiConverterDecryptedEvent.read(buf.asUint8List()).value;
  }

  static LiftRetVal<DecryptedEvent> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final clearEvent_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final clearEvent = clearEvent_lifted.value;
    new_offset += clearEvent_lifted.bytesRead;
    final senderCurve25519Key_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final senderCurve25519Key = senderCurve25519Key_lifted.value;
    new_offset += senderCurve25519Key_lifted.bytesRead;
    final claimedEd25519Key_lifted = FfiConverterOptionalString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final claimedEd25519Key = claimedEd25519Key_lifted.value;
    new_offset += claimedEd25519Key_lifted.bytesRead;
    final forwardingCurve25519Chain_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final forwardingCurve25519Chain = forwardingCurve25519Chain_lifted.value;
    new_offset += forwardingCurve25519Chain_lifted.bytesRead;
    final shieldState_lifted = FfiConverterShieldState.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final shieldState = shieldState_lifted.value;
    new_offset += shieldState_lifted.bytesRead;
    return LiftRetVal(
      DecryptedEvent(
        clearEvent,
        senderCurve25519Key,
        claimedEd25519Key,
        forwardingCurve25519Chain,
        shieldState,
      ),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(DecryptedEvent value) {
    final total_length = FfiConverterString.allocationSize(value.clearEvent) +
        FfiConverterString.allocationSize(value.senderCurve25519Key) +
        FfiConverterOptionalString.allocationSize(value.claimedEd25519Key) +
        FfiConverterSequenceString.allocationSize(
          value.forwardingCurve25519Chain,
        ) +
        FfiConverterShieldState.allocationSize(value.shieldState) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(DecryptedEvent value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.clearEvent,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.senderCurve25519Key,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalString.write(
      value.claimedEd25519Key,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequenceString.write(
      value.forwardingCurve25519Chain,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterShieldState.write(
      value.shieldState,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(DecryptedEvent value) {
    return FfiConverterString.allocationSize(value.clearEvent) +
        FfiConverterString.allocationSize(value.senderCurve25519Key) +
        FfiConverterOptionalString.allocationSize(value.claimedEd25519Key) +
        FfiConverterSequenceString.allocationSize(
          value.forwardingCurve25519Chain,
        ) +
        FfiConverterShieldState.allocationSize(value.shieldState) +
        0;
  }
}

class DehydratedDeviceKey {
  final Uint8List inner;
  DehydratedDeviceKey(this.inner);
}

class FfiConverterDehydratedDeviceKey {
  static DehydratedDeviceKey lift(RustBuffer buf) {
    return FfiConverterDehydratedDeviceKey.read(buf.asUint8List()).value;
  }

  static LiftRetVal<DehydratedDeviceKey> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final inner_lifted = FfiConverterUint8List.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final inner = inner_lifted.value;
    new_offset += inner_lifted.bytesRead;
    return LiftRetVal(
      DehydratedDeviceKey(inner),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(DehydratedDeviceKey value) {
    final total_length = FfiConverterUint8List.allocationSize(value.inner) + 0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(DehydratedDeviceKey value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterUint8List.write(
      value.inner,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(DehydratedDeviceKey value) {
    return FfiConverterUint8List.allocationSize(value.inner) + 0;
  }
}

class Device {
  final String userId;
  final String deviceId;
  final Map<String, String> keys;
  final List<String> algorithms;
  final String? displayName;
  final bool isBlocked;
  final bool locallyTrusted;
  final bool crossSigningTrusted;
  final int firstTimeSeenTs;
  final bool dehydrated;
  Device(
    this.userId,
    this.deviceId,
    this.keys,
    this.algorithms,
    this.displayName,
    this.isBlocked,
    this.locallyTrusted,
    this.crossSigningTrusted,
    this.firstTimeSeenTs,
    this.dehydrated,
  );
}

class FfiConverterDevice {
  static Device lift(RustBuffer buf) {
    return FfiConverterDevice.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Device> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final userId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final userId = userId_lifted.value;
    new_offset += userId_lifted.bytesRead;
    final deviceId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final deviceId = deviceId_lifted.value;
    new_offset += deviceId_lifted.bytesRead;
    final keys_lifted = FfiConverterMapStringString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final keys = keys_lifted.value;
    new_offset += keys_lifted.bytesRead;
    final algorithms_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final algorithms = algorithms_lifted.value;
    new_offset += algorithms_lifted.bytesRead;
    final displayName_lifted = FfiConverterOptionalString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final displayName = displayName_lifted.value;
    new_offset += displayName_lifted.bytesRead;
    final isBlocked_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final isBlocked = isBlocked_lifted.value;
    new_offset += isBlocked_lifted.bytesRead;
    final locallyTrusted_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final locallyTrusted = locallyTrusted_lifted.value;
    new_offset += locallyTrusted_lifted.bytesRead;
    final crossSigningTrusted_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final crossSigningTrusted = crossSigningTrusted_lifted.value;
    new_offset += crossSigningTrusted_lifted.bytesRead;
    final firstTimeSeenTs_lifted = FfiConverterUInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final firstTimeSeenTs = firstTimeSeenTs_lifted.value;
    new_offset += firstTimeSeenTs_lifted.bytesRead;
    final dehydrated_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final dehydrated = dehydrated_lifted.value;
    new_offset += dehydrated_lifted.bytesRead;
    return LiftRetVal(
      Device(
        userId,
        deviceId,
        keys,
        algorithms,
        displayName,
        isBlocked,
        locallyTrusted,
        crossSigningTrusted,
        firstTimeSeenTs,
        dehydrated,
      ),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(Device value) {
    final total_length = FfiConverterString.allocationSize(value.userId) +
        FfiConverterString.allocationSize(value.deviceId) +
        FfiConverterMapStringString.allocationSize(value.keys) +
        FfiConverterSequenceString.allocationSize(value.algorithms) +
        FfiConverterOptionalString.allocationSize(value.displayName) +
        FfiConverterBool.allocationSize(value.isBlocked) +
        FfiConverterBool.allocationSize(value.locallyTrusted) +
        FfiConverterBool.allocationSize(value.crossSigningTrusted) +
        FfiConverterUInt64.allocationSize(value.firstTimeSeenTs) +
        FfiConverterBool.allocationSize(value.dehydrated) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(Device value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.userId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.deviceId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterMapStringString.write(
      value.keys,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequenceString.write(
      value.algorithms,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalString.write(
      value.displayName,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.isBlocked,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.locallyTrusted,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.crossSigningTrusted,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterUInt64.write(
      value.firstTimeSeenTs,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.dehydrated,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(Device value) {
    return FfiConverterString.allocationSize(value.userId) +
        FfiConverterString.allocationSize(value.deviceId) +
        FfiConverterMapStringString.allocationSize(value.keys) +
        FfiConverterSequenceString.allocationSize(value.algorithms) +
        FfiConverterOptionalString.allocationSize(value.displayName) +
        FfiConverterBool.allocationSize(value.isBlocked) +
        FfiConverterBool.allocationSize(value.locallyTrusted) +
        FfiConverterBool.allocationSize(value.crossSigningTrusted) +
        FfiConverterUInt64.allocationSize(value.firstTimeSeenTs) +
        FfiConverterBool.allocationSize(value.dehydrated) +
        0;
  }
}

class DeviceLists {
  final List<String> changed;
  final List<String> left;
  DeviceLists(this.changed, this.left);
}

class FfiConverterDeviceLists {
  static DeviceLists lift(RustBuffer buf) {
    return FfiConverterDeviceLists.read(buf.asUint8List()).value;
  }

  static LiftRetVal<DeviceLists> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final changed_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final changed = changed_lifted.value;
    new_offset += changed_lifted.bytesRead;
    final left_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final left = left_lifted.value;
    new_offset += left_lifted.bytesRead;
    return LiftRetVal(
      DeviceLists(changed, left),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(DeviceLists value) {
    final total_length =
        FfiConverterSequenceString.allocationSize(value.changed) +
            FfiConverterSequenceString.allocationSize(value.left) +
            0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(DeviceLists value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterSequenceString.write(
      value.changed,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequenceString.write(
      value.left,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(DeviceLists value) {
    return FfiConverterSequenceString.allocationSize(value.changed) +
        FfiConverterSequenceString.allocationSize(value.left) +
        0;
  }
}

class EncryptionSettings {
  final EventEncryptionAlgorithm algorithm;
  final int rotationPeriod;
  final int rotationPeriodMsgs;
  final HistoryVisibility historyVisibility;
  final bool onlyAllowTrustedDevices;
  final bool errorOnVerifiedUserProblem;
  EncryptionSettings(
    this.algorithm,
    this.rotationPeriod,
    this.rotationPeriodMsgs,
    this.historyVisibility,
    this.onlyAllowTrustedDevices,
    this.errorOnVerifiedUserProblem,
  );
}

class FfiConverterEncryptionSettings {
  static EncryptionSettings lift(RustBuffer buf) {
    return FfiConverterEncryptionSettings.read(buf.asUint8List()).value;
  }

  static LiftRetVal<EncryptionSettings> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final algorithm_lifted = FfiConverterEventEncryptionAlgorithm.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final algorithm = algorithm_lifted.value;
    new_offset += algorithm_lifted.bytesRead;
    final rotationPeriod_lifted = FfiConverterUInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final rotationPeriod = rotationPeriod_lifted.value;
    new_offset += rotationPeriod_lifted.bytesRead;
    final rotationPeriodMsgs_lifted = FfiConverterUInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final rotationPeriodMsgs = rotationPeriodMsgs_lifted.value;
    new_offset += rotationPeriodMsgs_lifted.bytesRead;
    final historyVisibility_lifted = FfiConverterHistoryVisibility.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final historyVisibility = historyVisibility_lifted.value;
    new_offset += historyVisibility_lifted.bytesRead;
    final onlyAllowTrustedDevices_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final onlyAllowTrustedDevices = onlyAllowTrustedDevices_lifted.value;
    new_offset += onlyAllowTrustedDevices_lifted.bytesRead;
    final errorOnVerifiedUserProblem_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final errorOnVerifiedUserProblem = errorOnVerifiedUserProblem_lifted.value;
    new_offset += errorOnVerifiedUserProblem_lifted.bytesRead;
    return LiftRetVal(
      EncryptionSettings(
        algorithm,
        rotationPeriod,
        rotationPeriodMsgs,
        historyVisibility,
        onlyAllowTrustedDevices,
        errorOnVerifiedUserProblem,
      ),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(EncryptionSettings value) {
    final total_length = FfiConverterEventEncryptionAlgorithm.allocationSize(
            value.algorithm) +
        FfiConverterUInt64.allocationSize(value.rotationPeriod) +
        FfiConverterUInt64.allocationSize(value.rotationPeriodMsgs) +
        FfiConverterHistoryVisibility.allocationSize(value.historyVisibility) +
        FfiConverterBool.allocationSize(value.onlyAllowTrustedDevices) +
        FfiConverterBool.allocationSize(value.errorOnVerifiedUserProblem) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(EncryptionSettings value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterEventEncryptionAlgorithm.write(
      value.algorithm,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterUInt64.write(
      value.rotationPeriod,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterUInt64.write(
      value.rotationPeriodMsgs,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterHistoryVisibility.write(
      value.historyVisibility,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.onlyAllowTrustedDevices,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.errorOnVerifiedUserProblem,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(EncryptionSettings value) {
    return FfiConverterEventEncryptionAlgorithm.allocationSize(
          value.algorithm,
        ) +
        FfiConverterUInt64.allocationSize(value.rotationPeriod) +
        FfiConverterUInt64.allocationSize(value.rotationPeriodMsgs) +
        FfiConverterHistoryVisibility.allocationSize(value.historyVisibility) +
        FfiConverterBool.allocationSize(value.onlyAllowTrustedDevices) +
        FfiConverterBool.allocationSize(value.errorOnVerifiedUserProblem) +
        0;
  }
}

class KeyRequestPair {
  final Request? cancellation;
  final Request keyRequest;
  KeyRequestPair(this.cancellation, this.keyRequest);
}

class FfiConverterKeyRequestPair {
  static KeyRequestPair lift(RustBuffer buf) {
    return FfiConverterKeyRequestPair.read(buf.asUint8List()).value;
  }

  static LiftRetVal<KeyRequestPair> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final cancellation_lifted = FfiConverterOptionalRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final cancellation = cancellation_lifted.value;
    new_offset += cancellation_lifted.bytesRead;
    final keyRequest_lifted = FfiConverterRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final keyRequest = keyRequest_lifted.value;
    new_offset += keyRequest_lifted.bytesRead;
    return LiftRetVal(
      KeyRequestPair(cancellation, keyRequest),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(KeyRequestPair value) {
    final total_length =
        FfiConverterOptionalRequest.allocationSize(value.cancellation) +
            FfiConverterRequest.allocationSize(value.keyRequest) +
            0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(KeyRequestPair value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterOptionalRequest.write(
      value.cancellation,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterRequest.write(
      value.keyRequest,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(KeyRequestPair value) {
    return FfiConverterOptionalRequest.allocationSize(value.cancellation) +
        FfiConverterRequest.allocationSize(value.keyRequest) +
        0;
  }
}

class KeysImportResult {
  final int imported;
  final int total;
  final Map<String, Map<String, List<String>>> keys;
  KeysImportResult(this.imported, this.total, this.keys);
}

class FfiConverterKeysImportResult {
  static KeysImportResult lift(RustBuffer buf) {
    return FfiConverterKeysImportResult.read(buf.asUint8List()).value;
  }

  static LiftRetVal<KeysImportResult> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final imported_lifted = FfiConverterInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final imported = imported_lifted.value;
    new_offset += imported_lifted.bytesRead;
    final total_lifted = FfiConverterInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final total = total_lifted.value;
    new_offset += total_lifted.bytesRead;
    final keys_lifted = FfiConverterMapStringMapStringSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final keys = keys_lifted.value;
    new_offset += keys_lifted.bytesRead;
    return LiftRetVal(
      KeysImportResult(imported, total, keys),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(KeysImportResult value) {
    final total_length = FfiConverterInt64.allocationSize(value.imported) +
        FfiConverterInt64.allocationSize(value.total) +
        FfiConverterMapStringMapStringSequenceString.allocationSize(
          value.keys,
        ) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(KeysImportResult value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterInt64.write(
      value.imported,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterInt64.write(
      value.total,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterMapStringMapStringSequenceString.write(
      value.keys,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(KeysImportResult value) {
    return FfiConverterInt64.allocationSize(value.imported) +
        FfiConverterInt64.allocationSize(value.total) +
        FfiConverterMapStringMapStringSequenceString.allocationSize(
          value.keys,
        ) +
        0;
  }
}

class MegolmV1BackupKey {
  final String publicKey;
  final Map<String, Map<String, String>> signatures;
  final PassphraseInfo? passphraseInfo;
  final String backupAlgorithm;
  MegolmV1BackupKey(
    this.publicKey,
    this.signatures,
    this.passphraseInfo,
    this.backupAlgorithm,
  );
}

class FfiConverterMegolmV1BackupKey {
  static MegolmV1BackupKey lift(RustBuffer buf) {
    return FfiConverterMegolmV1BackupKey.read(buf.asUint8List()).value;
  }

  static LiftRetVal<MegolmV1BackupKey> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final publicKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final publicKey = publicKey_lifted.value;
    new_offset += publicKey_lifted.bytesRead;
    final signatures_lifted = FfiConverterMapStringMapStringString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final signatures = signatures_lifted.value;
    new_offset += signatures_lifted.bytesRead;
    final passphraseInfo_lifted = FfiConverterOptionalPassphraseInfo.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final passphraseInfo = passphraseInfo_lifted.value;
    new_offset += passphraseInfo_lifted.bytesRead;
    final backupAlgorithm_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final backupAlgorithm = backupAlgorithm_lifted.value;
    new_offset += backupAlgorithm_lifted.bytesRead;
    return LiftRetVal(
      MegolmV1BackupKey(publicKey, signatures, passphraseInfo, backupAlgorithm),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(MegolmV1BackupKey value) {
    final total_length = FfiConverterString.allocationSize(value.publicKey) +
        FfiConverterMapStringMapStringString.allocationSize(value.signatures) +
        FfiConverterOptionalPassphraseInfo.allocationSize(
          value.passphraseInfo,
        ) +
        FfiConverterString.allocationSize(value.backupAlgorithm) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(MegolmV1BackupKey value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.publicKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterMapStringMapStringString.write(
      value.signatures,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalPassphraseInfo.write(
      value.passphraseInfo,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.backupAlgorithm,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(MegolmV1BackupKey value) {
    return FfiConverterString.allocationSize(value.publicKey) +
        FfiConverterMapStringMapStringString.allocationSize(value.signatures) +
        FfiConverterOptionalPassphraseInfo.allocationSize(
          value.passphraseInfo,
        ) +
        FfiConverterString.allocationSize(value.backupAlgorithm) +
        0;
  }
}

class MigrationData {
  final PickledAccount account;
  final List<PickledSession> sessions;
  final List<PickledInboundGroupSession> inboundGroupSessions;
  final Uint8List pickleKey;
  final String? backupVersion;
  final String? backupRecoveryKey;
  final CrossSigningKeyExport crossSigning;
  final List<String> trackedUsers;
  final Map<String, RoomSettings> roomSettings;
  MigrationData(
    this.account,
    this.sessions,
    this.inboundGroupSessions,
    this.pickleKey,
    this.backupVersion,
    this.backupRecoveryKey,
    this.crossSigning,
    this.trackedUsers,
    this.roomSettings,
  );
}

class FfiConverterMigrationData {
  static MigrationData lift(RustBuffer buf) {
    return FfiConverterMigrationData.read(buf.asUint8List()).value;
  }

  static LiftRetVal<MigrationData> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final account_lifted = FfiConverterPickledAccount.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final account = account_lifted.value;
    new_offset += account_lifted.bytesRead;
    final sessions_lifted = FfiConverterSequencePickledSession.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final sessions = sessions_lifted.value;
    new_offset += sessions_lifted.bytesRead;
    final inboundGroupSessions_lifted =
        FfiConverterSequencePickledInboundGroupSession.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final inboundGroupSessions = inboundGroupSessions_lifted.value;
    new_offset += inboundGroupSessions_lifted.bytesRead;
    final pickleKey_lifted = FfiConverterUint8List.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final pickleKey = pickleKey_lifted.value;
    new_offset += pickleKey_lifted.bytesRead;
    final backupVersion_lifted = FfiConverterOptionalString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final backupVersion = backupVersion_lifted.value;
    new_offset += backupVersion_lifted.bytesRead;
    final backupRecoveryKey_lifted = FfiConverterOptionalString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final backupRecoveryKey = backupRecoveryKey_lifted.value;
    new_offset += backupRecoveryKey_lifted.bytesRead;
    final crossSigning_lifted = FfiConverterCrossSigningKeyExport.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final crossSigning = crossSigning_lifted.value;
    new_offset += crossSigning_lifted.bytesRead;
    final trackedUsers_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final trackedUsers = trackedUsers_lifted.value;
    new_offset += trackedUsers_lifted.bytesRead;
    final roomSettings_lifted = FfiConverterMapStringRoomSettings.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final roomSettings = roomSettings_lifted.value;
    new_offset += roomSettings_lifted.bytesRead;
    return LiftRetVal(
      MigrationData(
        account,
        sessions,
        inboundGroupSessions,
        pickleKey,
        backupVersion,
        backupRecoveryKey,
        crossSigning,
        trackedUsers,
        roomSettings,
      ),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(MigrationData value) {
    final total_length = FfiConverterPickledAccount.allocationSize(
            value.account) +
        FfiConverterSequencePickledSession.allocationSize(value.sessions) +
        FfiConverterSequencePickledInboundGroupSession.allocationSize(
          value.inboundGroupSessions,
        ) +
        FfiConverterUint8List.allocationSize(value.pickleKey) +
        FfiConverterOptionalString.allocationSize(value.backupVersion) +
        FfiConverterOptionalString.allocationSize(value.backupRecoveryKey) +
        FfiConverterCrossSigningKeyExport.allocationSize(value.crossSigning) +
        FfiConverterSequenceString.allocationSize(value.trackedUsers) +
        FfiConverterMapStringRoomSettings.allocationSize(value.roomSettings) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(MigrationData value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterPickledAccount.write(
      value.account,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequencePickledSession.write(
      value.sessions,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequencePickledInboundGroupSession.write(
      value.inboundGroupSessions,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterUint8List.write(
      value.pickleKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalString.write(
      value.backupVersion,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalString.write(
      value.backupRecoveryKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterCrossSigningKeyExport.write(
      value.crossSigning,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequenceString.write(
      value.trackedUsers,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterMapStringRoomSettings.write(
      value.roomSettings,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(MigrationData value) {
    return FfiConverterPickledAccount.allocationSize(value.account) +
        FfiConverterSequencePickledSession.allocationSize(value.sessions) +
        FfiConverterSequencePickledInboundGroupSession.allocationSize(
          value.inboundGroupSessions,
        ) +
        FfiConverterUint8List.allocationSize(value.pickleKey) +
        FfiConverterOptionalString.allocationSize(value.backupVersion) +
        FfiConverterOptionalString.allocationSize(value.backupRecoveryKey) +
        FfiConverterCrossSigningKeyExport.allocationSize(value.crossSigning) +
        FfiConverterSequenceString.allocationSize(value.trackedUsers) +
        FfiConverterMapStringRoomSettings.allocationSize(value.roomSettings) +
        0;
  }
}

class PassphraseInfo {
  final String privateKeySalt;
  final int privateKeyIterations;
  PassphraseInfo(this.privateKeySalt, this.privateKeyIterations);
}

class FfiConverterPassphraseInfo {
  static PassphraseInfo lift(RustBuffer buf) {
    return FfiConverterPassphraseInfo.read(buf.asUint8List()).value;
  }

  static LiftRetVal<PassphraseInfo> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final privateKeySalt_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final privateKeySalt = privateKeySalt_lifted.value;
    new_offset += privateKeySalt_lifted.bytesRead;
    final privateKeyIterations_lifted = FfiConverterInt32.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final privateKeyIterations = privateKeyIterations_lifted.value;
    new_offset += privateKeyIterations_lifted.bytesRead;
    return LiftRetVal(
      PassphraseInfo(privateKeySalt, privateKeyIterations),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(PassphraseInfo value) {
    final total_length =
        FfiConverterString.allocationSize(value.privateKeySalt) +
            FfiConverterInt32.allocationSize(value.privateKeyIterations) +
            0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(PassphraseInfo value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.privateKeySalt,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterInt32.write(
      value.privateKeyIterations,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(PassphraseInfo value) {
    return FfiConverterString.allocationSize(value.privateKeySalt) +
        FfiConverterInt32.allocationSize(value.privateKeyIterations) +
        0;
  }
}

class PickledAccount {
  final String userId;
  final String deviceId;
  final String pickle;
  final bool shared;
  final int uploadedSignedKeyCount;
  PickledAccount(
    this.userId,
    this.deviceId,
    this.pickle,
    this.shared,
    this.uploadedSignedKeyCount,
  );
}

class FfiConverterPickledAccount {
  static PickledAccount lift(RustBuffer buf) {
    return FfiConverterPickledAccount.read(buf.asUint8List()).value;
  }

  static LiftRetVal<PickledAccount> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final userId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final userId = userId_lifted.value;
    new_offset += userId_lifted.bytesRead;
    final deviceId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final deviceId = deviceId_lifted.value;
    new_offset += deviceId_lifted.bytesRead;
    final pickle_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final pickle = pickle_lifted.value;
    new_offset += pickle_lifted.bytesRead;
    final shared_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final shared = shared_lifted.value;
    new_offset += shared_lifted.bytesRead;
    final uploadedSignedKeyCount_lifted = FfiConverterInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final uploadedSignedKeyCount = uploadedSignedKeyCount_lifted.value;
    new_offset += uploadedSignedKeyCount_lifted.bytesRead;
    return LiftRetVal(
      PickledAccount(userId, deviceId, pickle, shared, uploadedSignedKeyCount),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(PickledAccount value) {
    final total_length = FfiConverterString.allocationSize(value.userId) +
        FfiConverterString.allocationSize(value.deviceId) +
        FfiConverterString.allocationSize(value.pickle) +
        FfiConverterBool.allocationSize(value.shared) +
        FfiConverterInt64.allocationSize(value.uploadedSignedKeyCount) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(PickledAccount value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.userId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.deviceId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.pickle,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.shared,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterInt64.write(
      value.uploadedSignedKeyCount,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(PickledAccount value) {
    return FfiConverterString.allocationSize(value.userId) +
        FfiConverterString.allocationSize(value.deviceId) +
        FfiConverterString.allocationSize(value.pickle) +
        FfiConverterBool.allocationSize(value.shared) +
        FfiConverterInt64.allocationSize(value.uploadedSignedKeyCount) +
        0;
  }
}

class PickledInboundGroupSession {
  final String pickle;
  final String senderKey;
  final Map<String, String> signingKey;
  final String roomId;
  final List<String> forwardingChains;
  final bool imported;
  final bool backedUp;
  PickledInboundGroupSession(
    this.pickle,
    this.senderKey,
    this.signingKey,
    this.roomId,
    this.forwardingChains,
    this.imported,
    this.backedUp,
  );
}

class FfiConverterPickledInboundGroupSession {
  static PickledInboundGroupSession lift(RustBuffer buf) {
    return FfiConverterPickledInboundGroupSession.read(buf.asUint8List()).value;
  }

  static LiftRetVal<PickledInboundGroupSession> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final pickle_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final pickle = pickle_lifted.value;
    new_offset += pickle_lifted.bytesRead;
    final senderKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final senderKey = senderKey_lifted.value;
    new_offset += senderKey_lifted.bytesRead;
    final signingKey_lifted = FfiConverterMapStringString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final signingKey = signingKey_lifted.value;
    new_offset += signingKey_lifted.bytesRead;
    final roomId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final roomId = roomId_lifted.value;
    new_offset += roomId_lifted.bytesRead;
    final forwardingChains_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final forwardingChains = forwardingChains_lifted.value;
    new_offset += forwardingChains_lifted.bytesRead;
    final imported_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final imported = imported_lifted.value;
    new_offset += imported_lifted.bytesRead;
    final backedUp_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final backedUp = backedUp_lifted.value;
    new_offset += backedUp_lifted.bytesRead;
    return LiftRetVal(
      PickledInboundGroupSession(
        pickle,
        senderKey,
        signingKey,
        roomId,
        forwardingChains,
        imported,
        backedUp,
      ),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(PickledInboundGroupSession value) {
    final total_length = FfiConverterString.allocationSize(value.pickle) +
        FfiConverterString.allocationSize(value.senderKey) +
        FfiConverterMapStringString.allocationSize(value.signingKey) +
        FfiConverterString.allocationSize(value.roomId) +
        FfiConverterSequenceString.allocationSize(value.forwardingChains) +
        FfiConverterBool.allocationSize(value.imported) +
        FfiConverterBool.allocationSize(value.backedUp) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(PickledInboundGroupSession value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.pickle,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.senderKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterMapStringString.write(
      value.signingKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.roomId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequenceString.write(
      value.forwardingChains,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.imported,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.backedUp,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(PickledInboundGroupSession value) {
    return FfiConverterString.allocationSize(value.pickle) +
        FfiConverterString.allocationSize(value.senderKey) +
        FfiConverterMapStringString.allocationSize(value.signingKey) +
        FfiConverterString.allocationSize(value.roomId) +
        FfiConverterSequenceString.allocationSize(value.forwardingChains) +
        FfiConverterBool.allocationSize(value.imported) +
        FfiConverterBool.allocationSize(value.backedUp) +
        0;
  }
}

class PickledSession {
  final String pickle;
  final String senderKey;
  final bool createdUsingFallbackKey;
  final int creationTime;
  final int lastUseTime;
  PickledSession(
    this.pickle,
    this.senderKey,
    this.createdUsingFallbackKey,
    this.creationTime,
    this.lastUseTime,
  );
}

class FfiConverterPickledSession {
  static PickledSession lift(RustBuffer buf) {
    return FfiConverterPickledSession.read(buf.asUint8List()).value;
  }

  static LiftRetVal<PickledSession> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final pickle_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final pickle = pickle_lifted.value;
    new_offset += pickle_lifted.bytesRead;
    final senderKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final senderKey = senderKey_lifted.value;
    new_offset += senderKey_lifted.bytesRead;
    final createdUsingFallbackKey_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final createdUsingFallbackKey = createdUsingFallbackKey_lifted.value;
    new_offset += createdUsingFallbackKey_lifted.bytesRead;
    final creationTime_lifted = FfiConverterUInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final creationTime = creationTime_lifted.value;
    new_offset += creationTime_lifted.bytesRead;
    final lastUseTime_lifted = FfiConverterUInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final lastUseTime = lastUseTime_lifted.value;
    new_offset += lastUseTime_lifted.bytesRead;
    return LiftRetVal(
      PickledSession(
        pickle,
        senderKey,
        createdUsingFallbackKey,
        creationTime,
        lastUseTime,
      ),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(PickledSession value) {
    final total_length = FfiConverterString.allocationSize(value.pickle) +
        FfiConverterString.allocationSize(value.senderKey) +
        FfiConverterBool.allocationSize(value.createdUsingFallbackKey) +
        FfiConverterUInt64.allocationSize(value.creationTime) +
        FfiConverterUInt64.allocationSize(value.lastUseTime) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(PickledSession value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.pickle,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.senderKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.createdUsingFallbackKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterUInt64.write(
      value.creationTime,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterUInt64.write(
      value.lastUseTime,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(PickledSession value) {
    return FfiConverterString.allocationSize(value.pickle) +
        FfiConverterString.allocationSize(value.senderKey) +
        FfiConverterBool.allocationSize(value.createdUsingFallbackKey) +
        FfiConverterUInt64.allocationSize(value.creationTime) +
        FfiConverterUInt64.allocationSize(value.lastUseTime) +
        0;
  }
}

class PkMessage {
  final String ciphertext;
  final String mac;
  final String ephemeralKey;
  PkMessage(this.ciphertext, this.mac, this.ephemeralKey);
}

class FfiConverterPkMessage {
  static PkMessage lift(RustBuffer buf) {
    return FfiConverterPkMessage.read(buf.asUint8List()).value;
  }

  static LiftRetVal<PkMessage> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final ciphertext_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final ciphertext = ciphertext_lifted.value;
    new_offset += ciphertext_lifted.bytesRead;
    final mac_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final mac = mac_lifted.value;
    new_offset += mac_lifted.bytesRead;
    final ephemeralKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final ephemeralKey = ephemeralKey_lifted.value;
    new_offset += ephemeralKey_lifted.bytesRead;
    return LiftRetVal(
      PkMessage(ciphertext, mac, ephemeralKey),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(PkMessage value) {
    final total_length = FfiConverterString.allocationSize(value.ciphertext) +
        FfiConverterString.allocationSize(value.mac) +
        FfiConverterString.allocationSize(value.ephemeralKey) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(PkMessage value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.ciphertext,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.mac,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.ephemeralKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(PkMessage value) {
    return FfiConverterString.allocationSize(value.ciphertext) +
        FfiConverterString.allocationSize(value.mac) +
        FfiConverterString.allocationSize(value.ephemeralKey) +
        0;
  }
}

class RequestVerificationResult {
  final VerificationRequest verification;
  final OutgoingVerificationRequest request;
  RequestVerificationResult(this.verification, this.request);
}

class FfiConverterRequestVerificationResult {
  static RequestVerificationResult lift(RustBuffer buf) {
    return FfiConverterRequestVerificationResult.read(buf.asUint8List()).value;
  }

  static LiftRetVal<RequestVerificationResult> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final verification_lifted = VerificationRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final verification = verification_lifted.value;
    new_offset += verification_lifted.bytesRead;
    final request_lifted = FfiConverterOutgoingVerificationRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final request = request_lifted.value;
    new_offset += request_lifted.bytesRead;
    return LiftRetVal(
      RequestVerificationResult(verification, request),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(RequestVerificationResult value) {
    final total_length = VerificationRequest.allocationSize(
            value.verification) +
        FfiConverterOutgoingVerificationRequest.allocationSize(value.request) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(RequestVerificationResult value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += VerificationRequest.write(
      value.verification,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOutgoingVerificationRequest.write(
      value.request,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(RequestVerificationResult value) {
    return VerificationRequest.allocationSize(value.verification) +
        FfiConverterOutgoingVerificationRequest.allocationSize(value.request) +
        0;
  }
}

class RoomKeyCounts {
  final int total;
  final int backedUp;
  RoomKeyCounts(this.total, this.backedUp);
}

class FfiConverterRoomKeyCounts {
  static RoomKeyCounts lift(RustBuffer buf) {
    return FfiConverterRoomKeyCounts.read(buf.asUint8List()).value;
  }

  static LiftRetVal<RoomKeyCounts> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final total_lifted = FfiConverterInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final total = total_lifted.value;
    new_offset += total_lifted.bytesRead;
    final backedUp_lifted = FfiConverterInt64.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final backedUp = backedUp_lifted.value;
    new_offset += backedUp_lifted.bytesRead;
    return LiftRetVal(
      RoomKeyCounts(total, backedUp),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(RoomKeyCounts value) {
    final total_length = FfiConverterInt64.allocationSize(value.total) +
        FfiConverterInt64.allocationSize(value.backedUp) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(RoomKeyCounts value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterInt64.write(
      value.total,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterInt64.write(
      value.backedUp,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(RoomKeyCounts value) {
    return FfiConverterInt64.allocationSize(value.total) +
        FfiConverterInt64.allocationSize(value.backedUp) +
        0;
  }
}

class RoomKeyInfo {
  final String algorithm;
  final String roomId;
  final String senderKey;
  final String sessionId;
  RoomKeyInfo(this.algorithm, this.roomId, this.senderKey, this.sessionId);
}

class FfiConverterRoomKeyInfo {
  static RoomKeyInfo lift(RustBuffer buf) {
    return FfiConverterRoomKeyInfo.read(buf.asUint8List()).value;
  }

  static LiftRetVal<RoomKeyInfo> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final algorithm_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final algorithm = algorithm_lifted.value;
    new_offset += algorithm_lifted.bytesRead;
    final roomId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final roomId = roomId_lifted.value;
    new_offset += roomId_lifted.bytesRead;
    final senderKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final senderKey = senderKey_lifted.value;
    new_offset += senderKey_lifted.bytesRead;
    final sessionId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final sessionId = sessionId_lifted.value;
    new_offset += sessionId_lifted.bytesRead;
    return LiftRetVal(
      RoomKeyInfo(algorithm, roomId, senderKey, sessionId),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(RoomKeyInfo value) {
    final total_length = FfiConverterString.allocationSize(value.algorithm) +
        FfiConverterString.allocationSize(value.roomId) +
        FfiConverterString.allocationSize(value.senderKey) +
        FfiConverterString.allocationSize(value.sessionId) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(RoomKeyInfo value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.algorithm,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.roomId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.senderKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.sessionId,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(RoomKeyInfo value) {
    return FfiConverterString.allocationSize(value.algorithm) +
        FfiConverterString.allocationSize(value.roomId) +
        FfiConverterString.allocationSize(value.senderKey) +
        FfiConverterString.allocationSize(value.sessionId) +
        0;
  }
}

class RoomSettings {
  final EventEncryptionAlgorithm algorithm;
  final bool onlyAllowTrustedDevices;
  RoomSettings(this.algorithm, this.onlyAllowTrustedDevices);
}

class FfiConverterRoomSettings {
  static RoomSettings lift(RustBuffer buf) {
    return FfiConverterRoomSettings.read(buf.asUint8List()).value;
  }

  static LiftRetVal<RoomSettings> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final algorithm_lifted = FfiConverterEventEncryptionAlgorithm.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final algorithm = algorithm_lifted.value;
    new_offset += algorithm_lifted.bytesRead;
    final onlyAllowTrustedDevices_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final onlyAllowTrustedDevices = onlyAllowTrustedDevices_lifted.value;
    new_offset += onlyAllowTrustedDevices_lifted.bytesRead;
    return LiftRetVal(
      RoomSettings(algorithm, onlyAllowTrustedDevices),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(RoomSettings value) {
    final total_length =
        FfiConverterEventEncryptionAlgorithm.allocationSize(value.algorithm) +
            FfiConverterBool.allocationSize(value.onlyAllowTrustedDevices) +
            0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(RoomSettings value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterEventEncryptionAlgorithm.write(
      value.algorithm,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.onlyAllowTrustedDevices,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(RoomSettings value) {
    return FfiConverterEventEncryptionAlgorithm.allocationSize(
          value.algorithm,
        ) +
        FfiConverterBool.allocationSize(value.onlyAllowTrustedDevices) +
        0;
  }
}

class ScanResult {
  final QrCode qr;
  final OutgoingVerificationRequest request;
  ScanResult(this.qr, this.request);
}

class FfiConverterScanResult {
  static ScanResult lift(RustBuffer buf) {
    return FfiConverterScanResult.read(buf.asUint8List()).value;
  }

  static LiftRetVal<ScanResult> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final qr_lifted = QrCode.read(Uint8List.view(buf.buffer, new_offset));
    final qr = qr_lifted.value;
    new_offset += qr_lifted.bytesRead;
    final request_lifted = FfiConverterOutgoingVerificationRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final request = request_lifted.value;
    new_offset += request_lifted.bytesRead;
    return LiftRetVal(ScanResult(qr, request), new_offset - buf.offsetInBytes);
  }

  static RustBuffer lower(ScanResult value) {
    final total_length = QrCode.allocationSize(value.qr) +
        FfiConverterOutgoingVerificationRequest.allocationSize(value.request) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(ScanResult value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += QrCode.write(
      value.qr,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOutgoingVerificationRequest.write(
      value.request,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(ScanResult value) {
    return QrCode.allocationSize(value.qr) +
        FfiConverterOutgoingVerificationRequest.allocationSize(value.request) +
        0;
  }
}

class SessionMigrationData {
  final String userId;
  final String deviceId;
  final String curve25519Key;
  final String ed25519Key;
  final List<PickledSession> sessions;
  final List<PickledInboundGroupSession> inboundGroupSessions;
  final Uint8List pickleKey;
  SessionMigrationData(
    this.userId,
    this.deviceId,
    this.curve25519Key,
    this.ed25519Key,
    this.sessions,
    this.inboundGroupSessions,
    this.pickleKey,
  );
}

class FfiConverterSessionMigrationData {
  static SessionMigrationData lift(RustBuffer buf) {
    return FfiConverterSessionMigrationData.read(buf.asUint8List()).value;
  }

  static LiftRetVal<SessionMigrationData> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final userId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final userId = userId_lifted.value;
    new_offset += userId_lifted.bytesRead;
    final deviceId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final deviceId = deviceId_lifted.value;
    new_offset += deviceId_lifted.bytesRead;
    final curve25519Key_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final curve25519Key = curve25519Key_lifted.value;
    new_offset += curve25519Key_lifted.bytesRead;
    final ed25519Key_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final ed25519Key = ed25519Key_lifted.value;
    new_offset += ed25519Key_lifted.bytesRead;
    final sessions_lifted = FfiConverterSequencePickledSession.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final sessions = sessions_lifted.value;
    new_offset += sessions_lifted.bytesRead;
    final inboundGroupSessions_lifted =
        FfiConverterSequencePickledInboundGroupSession.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final inboundGroupSessions = inboundGroupSessions_lifted.value;
    new_offset += inboundGroupSessions_lifted.bytesRead;
    final pickleKey_lifted = FfiConverterUint8List.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final pickleKey = pickleKey_lifted.value;
    new_offset += pickleKey_lifted.bytesRead;
    return LiftRetVal(
      SessionMigrationData(
        userId,
        deviceId,
        curve25519Key,
        ed25519Key,
        sessions,
        inboundGroupSessions,
        pickleKey,
      ),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(SessionMigrationData value) {
    final total_length = FfiConverterString.allocationSize(value.userId) +
        FfiConverterString.allocationSize(value.deviceId) +
        FfiConverterString.allocationSize(value.curve25519Key) +
        FfiConverterString.allocationSize(value.ed25519Key) +
        FfiConverterSequencePickledSession.allocationSize(value.sessions) +
        FfiConverterSequencePickledInboundGroupSession.allocationSize(
          value.inboundGroupSessions,
        ) +
        FfiConverterUint8List.allocationSize(value.pickleKey) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(SessionMigrationData value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.userId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.deviceId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.curve25519Key,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.ed25519Key,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequencePickledSession.write(
      value.sessions,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequencePickledInboundGroupSession.write(
      value.inboundGroupSessions,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterUint8List.write(
      value.pickleKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(SessionMigrationData value) {
    return FfiConverterString.allocationSize(value.userId) +
        FfiConverterString.allocationSize(value.deviceId) +
        FfiConverterString.allocationSize(value.curve25519Key) +
        FfiConverterString.allocationSize(value.ed25519Key) +
        FfiConverterSequencePickledSession.allocationSize(value.sessions) +
        FfiConverterSequencePickledInboundGroupSession.allocationSize(
          value.inboundGroupSessions,
        ) +
        FfiConverterUint8List.allocationSize(value.pickleKey) +
        0;
  }
}

class ShieldState {
  final ShieldColor color;
  final ShieldStateCode? code;
  final String? message;
  ShieldState(this.color, this.code, this.message);
}

class FfiConverterShieldState {
  static ShieldState lift(RustBuffer buf) {
    return FfiConverterShieldState.read(buf.asUint8List()).value;
  }

  static LiftRetVal<ShieldState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final color_lifted = FfiConverterShieldColor.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final color = color_lifted.value;
    new_offset += color_lifted.bytesRead;
    final code_lifted = FfiConverterOptionalShieldStateCode.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final code = code_lifted.value;
    new_offset += code_lifted.bytesRead;
    final message_lifted = FfiConverterOptionalString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final message = message_lifted.value;
    new_offset += message_lifted.bytesRead;
    return LiftRetVal(
      ShieldState(color, code, message),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(ShieldState value) {
    final total_length = FfiConverterShieldColor.allocationSize(value.color) +
        FfiConverterOptionalShieldStateCode.allocationSize(value.code) +
        FfiConverterOptionalString.allocationSize(value.message) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(ShieldState value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterShieldColor.write(
      value.color,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalShieldStateCode.write(
      value.code,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalString.write(
      value.message,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(ShieldState value) {
    return FfiConverterShieldColor.allocationSize(value.color) +
        FfiConverterOptionalShieldStateCode.allocationSize(value.code) +
        FfiConverterOptionalString.allocationSize(value.message) +
        0;
  }
}

// class SignatureUploadRequest extends Request {
//   final String body;
//   SignatureUploadRequest(this.body);

//   static LiftRetVal<SignatureUploadRequest> read(Uint8List buf) {
//     int new_offset = buf.offsetInBytes;
//     final requestId_lifted = FfiConverterString.read(
//       Uint8List.view(buf.buffer, new_offset),
//     );
//     final requestId = requestId_lifted.value;
//     new_offset += requestId_lifted.bytesRead;
//     final users_lifted = FfiConverterSequenceString.read(
//       Uint8List.view(buf.buffer, new_offset),
//     );
//     final users = users_lifted.value;
//     new_offset += users_lifted.bytesRead;
//     return LiftRetVal(SignatureUploadRequest(requestId, users), new_offset);
//   }

//   @override
//   int allocationSize() {
//     return FfiConverterString.allocationSize(requestId) +
//         FfiConverterSequenceString.allocationSize(users) +
//         0;
//   }

//   @override
//   RustBuffer lower() {
//     final total_length = FfiConverterString.allocationSize(requestId) +
//         FfiConverterSequenceString.allocationSize(users) +
//         0;
//     final buf = Uint8List(total_length);
//     write(this, buf);
//     return toRustBuffer(buf);
//   }

//   @override
//   int write(Uint8List buf) {
//     int new_offset = buf.offsetInBytes;
//     new_offset += FfiConverterString.write(
//       requestId,
//       Uint8List.view(buf.buffer, new_offset),
//     );
//     new_offset += FfiConverterSequenceString.write(
//       users,
//       Uint8List.view(buf.buffer, new_offset),
//     );
//     return new_offset - buf.offsetInBytes;
//   }
// }

class FfiConverterSignatureUploadRequest {
  static SignatureUploadRequest lift(RustBuffer buf) {
    return FfiConverterSignatureUploadRequest.read(buf.asUint8List()).value;
  }

  static LiftRetVal<SignatureUploadRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final body_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final body = body_lifted.value;
    new_offset += body_lifted.bytesRead;
    return LiftRetVal(
      SignatureUploadRequest(body),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(SignatureUploadRequest value) {
    final total_length = FfiConverterString.allocationSize(value.body) + 0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(SignatureUploadRequest value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.body,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(SignatureUploadRequest value) {
    return FfiConverterString.allocationSize(value.body) + 0;
  }
}

class SignatureVerification {
  final SignatureState deviceSignature;
  final SignatureState userIdentitySignature;
  final Map<String, SignatureState> otherDevicesSignatures;
  final bool trusted;
  SignatureVerification(
    this.deviceSignature,
    this.userIdentitySignature,
    this.otherDevicesSignatures,
    this.trusted,
  );
}

class FfiConverterSignatureVerification {
  static SignatureVerification lift(RustBuffer buf) {
    return FfiConverterSignatureVerification.read(buf.asUint8List()).value;
  }

  static LiftRetVal<SignatureVerification> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final deviceSignature_lifted = FfiConverterSignatureState.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final deviceSignature = deviceSignature_lifted.value;
    new_offset += deviceSignature_lifted.bytesRead;
    final userIdentitySignature_lifted = FfiConverterSignatureState.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final userIdentitySignature = userIdentitySignature_lifted.value;
    new_offset += userIdentitySignature_lifted.bytesRead;
    final otherDevicesSignatures_lifted =
        FfiConverterMapStringSignatureState.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final otherDevicesSignatures = otherDevicesSignatures_lifted.value;
    new_offset += otherDevicesSignatures_lifted.bytesRead;
    final trusted_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final trusted = trusted_lifted.value;
    new_offset += trusted_lifted.bytesRead;
    return LiftRetVal(
      SignatureVerification(
        deviceSignature,
        userIdentitySignature,
        otherDevicesSignatures,
        trusted,
      ),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(SignatureVerification value) {
    final total_length = FfiConverterSignatureState.allocationSize(
            value.deviceSignature) +
        FfiConverterSignatureState.allocationSize(value.userIdentitySignature) +
        FfiConverterMapStringSignatureState.allocationSize(
          value.otherDevicesSignatures,
        ) +
        FfiConverterBool.allocationSize(value.trusted) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(SignatureVerification value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterSignatureState.write(
      value.deviceSignature,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSignatureState.write(
      value.userIdentitySignature,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterMapStringSignatureState.write(
      value.otherDevicesSignatures,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      value.trusted,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(SignatureVerification value) {
    return FfiConverterSignatureState.allocationSize(value.deviceSignature) +
        FfiConverterSignatureState.allocationSize(value.userIdentitySignature) +
        FfiConverterMapStringSignatureState.allocationSize(
          value.otherDevicesSignatures,
        ) +
        FfiConverterBool.allocationSize(value.trusted) +
        0;
  }
}

class StartSasResult {
  final Sas sas;
  final OutgoingVerificationRequest request;
  StartSasResult(this.sas, this.request);
}

class FfiConverterStartSasResult {
  static StartSasResult lift(RustBuffer buf) {
    return FfiConverterStartSasResult.read(buf.asUint8List()).value;
  }

  static LiftRetVal<StartSasResult> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final sas_lifted = Sas.read(Uint8List.view(buf.buffer, new_offset));
    final sas = sas_lifted.value;
    new_offset += sas_lifted.bytesRead;
    final request_lifted = FfiConverterOutgoingVerificationRequest.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final request = request_lifted.value;
    new_offset += request_lifted.bytesRead;
    return LiftRetVal(
      StartSasResult(sas, request),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(StartSasResult value) {
    final total_length = Sas.allocationSize(value.sas) +
        FfiConverterOutgoingVerificationRequest.allocationSize(value.request) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(StartSasResult value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += Sas.write(value.sas, Uint8List.view(buf.buffer, new_offset));
    new_offset += FfiConverterOutgoingVerificationRequest.write(
      value.request,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(StartSasResult value) {
    return Sas.allocationSize(value.sas) +
        FfiConverterOutgoingVerificationRequest.allocationSize(value.request) +
        0;
  }
}

class SyncChangesResult {
  final List<String> toDeviceEvents;
  final List<RoomKeyInfo> roomKeyInfos;
  SyncChangesResult(this.toDeviceEvents, this.roomKeyInfos);
}

class FfiConverterSyncChangesResult {
  static SyncChangesResult lift(RustBuffer buf) {
    return FfiConverterSyncChangesResult.read(buf.asUint8List()).value;
  }

  static LiftRetVal<SyncChangesResult> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final toDeviceEvents_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final toDeviceEvents = toDeviceEvents_lifted.value;
    new_offset += toDeviceEvents_lifted.bytesRead;
    final roomKeyInfos_lifted = FfiConverterSequenceRoomKeyInfo.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final roomKeyInfos = roomKeyInfos_lifted.value;
    new_offset += roomKeyInfos_lifted.bytesRead;
    return LiftRetVal(
      SyncChangesResult(toDeviceEvents, roomKeyInfos),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(SyncChangesResult value) {
    final total_length =
        FfiConverterSequenceString.allocationSize(value.toDeviceEvents) +
            FfiConverterSequenceRoomKeyInfo.allocationSize(value.roomKeyInfos) +
            0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(SyncChangesResult value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterSequenceString.write(
      value.toDeviceEvents,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequenceRoomKeyInfo.write(
      value.roomKeyInfos,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(SyncChangesResult value) {
    return FfiConverterSequenceString.allocationSize(value.toDeviceEvents) +
        FfiConverterSequenceRoomKeyInfo.allocationSize(value.roomKeyInfos) +
        0;
  }
}

class UploadDehydratedDeviceRequest {
  final String body;
  UploadDehydratedDeviceRequest(this.body);
}

class FfiConverterUploadDehydratedDeviceRequest {
  static UploadDehydratedDeviceRequest lift(RustBuffer buf) {
    return FfiConverterUploadDehydratedDeviceRequest.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<UploadDehydratedDeviceRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final body_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final body = body_lifted.value;
    new_offset += body_lifted.bytesRead;
    return LiftRetVal(
      UploadDehydratedDeviceRequest(body),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(UploadDehydratedDeviceRequest value) {
    final total_length = FfiConverterString.allocationSize(value.body) + 0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(UploadDehydratedDeviceRequest value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.body,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(UploadDehydratedDeviceRequest value) {
    return FfiConverterString.allocationSize(value.body) + 0;
  }
}

class UploadSigningKeysRequest {
  final String masterKey;
  final String selfSigningKey;
  final String userSigningKey;
  UploadSigningKeysRequest(
    this.masterKey,
    this.selfSigningKey,
    this.userSigningKey,
  );
}

class FfiConverterUploadSigningKeysRequest {
  static UploadSigningKeysRequest lift(RustBuffer buf) {
    return FfiConverterUploadSigningKeysRequest.read(buf.asUint8List()).value;
  }

  static LiftRetVal<UploadSigningKeysRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final masterKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final masterKey = masterKey_lifted.value;
    new_offset += masterKey_lifted.bytesRead;
    final selfSigningKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final selfSigningKey = selfSigningKey_lifted.value;
    new_offset += selfSigningKey_lifted.bytesRead;
    final userSigningKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final userSigningKey = userSigningKey_lifted.value;
    new_offset += userSigningKey_lifted.bytesRead;
    return LiftRetVal(
      UploadSigningKeysRequest(masterKey, selfSigningKey, userSigningKey),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(UploadSigningKeysRequest value) {
    final total_length = FfiConverterString.allocationSize(value.masterKey) +
        FfiConverterString.allocationSize(value.selfSigningKey) +
        FfiConverterString.allocationSize(value.userSigningKey) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(UploadSigningKeysRequest value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.masterKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.selfSigningKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.userSigningKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(UploadSigningKeysRequest value) {
    return FfiConverterString.allocationSize(value.masterKey) +
        FfiConverterString.allocationSize(value.selfSigningKey) +
        FfiConverterString.allocationSize(value.userSigningKey) +
        0;
  }
}

class VersionInfo {
  final String version;
  final String vodozemacVersion;
  final String gitSha;
  final String gitDescription;
  VersionInfo(
    this.version,
    this.vodozemacVersion,
    this.gitSha,
    this.gitDescription,
  );
}

class FfiConverterVersionInfo {
  static VersionInfo lift(RustBuffer buf) {
    return FfiConverterVersionInfo.read(buf.asUint8List()).value;
  }

  static LiftRetVal<VersionInfo> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final version_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final version = version_lifted.value;
    new_offset += version_lifted.bytesRead;
    final vodozemacVersion_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final vodozemacVersion = vodozemacVersion_lifted.value;
    new_offset += vodozemacVersion_lifted.bytesRead;
    final gitSha_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final gitSha = gitSha_lifted.value;
    new_offset += gitSha_lifted.bytesRead;
    final gitDescription_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final gitDescription = gitDescription_lifted.value;
    new_offset += gitDescription_lifted.bytesRead;
    return LiftRetVal(
      VersionInfo(version, vodozemacVersion, gitSha, gitDescription),
      new_offset - buf.offsetInBytes,
    );
  }

  static RustBuffer lower(VersionInfo value) {
    final total_length = FfiConverterString.allocationSize(value.version) +
        FfiConverterString.allocationSize(value.vodozemacVersion) +
        FfiConverterString.allocationSize(value.gitSha) +
        FfiConverterString.allocationSize(value.gitDescription) +
        0;
    final buf = Uint8List(total_length);
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int write(VersionInfo value, Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    new_offset += FfiConverterString.write(
      value.version,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.vodozemacVersion,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.gitSha,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      value.gitDescription,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset - buf.offsetInBytes;
  }

  static int allocationSize(VersionInfo value) {
    return FfiConverterString.allocationSize(value.version) +
        FfiConverterString.allocationSize(value.vodozemacVersion) +
        FfiConverterString.allocationSize(value.gitSha) +
        FfiConverterString.allocationSize(value.gitDescription) +
        0;
  }
}

enum CryptoStoreException {
  openStore,
  cryptoStore,
  olmError,
  serialization,
  invalidUserId,
  identifier,
  dehydrationError,
}

class FfiConverterCryptoStoreException {
  static CryptoStoreException lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return CryptoStoreException.openStore;
      case 2:
        return CryptoStoreException.cryptoStore;
      case 3:
        return CryptoStoreException.olmError;
      case 4:
        return CryptoStoreException.serialization;
      case 5:
        return CryptoStoreException.invalidUserId;
      case 6:
        return CryptoStoreException.identifier;
      case 7:
        return CryptoStoreException.dehydrationError;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(CryptoStoreException input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }
}

enum DecodeException { decode, cryptoStore }

class FfiConverterDecodeException {
  static DecodeException lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return DecodeException.decode;
      case 2:
        return DecodeException.cryptoStore;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(DecodeException input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }
}

abstract class DecryptionException implements Exception {
  RustBuffer lower();
  int allocationSize();
  int write(Uint8List buf);
}

class FfiConverterDecryptionException {
  static DecryptionException lift(RustBuffer buffer) {
    return FfiConverterDecryptionException.read(buffer.asUint8List()).value;
  }

  static LiftRetVal<DecryptionException> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final subview = Uint8List.view(buf.buffer, buf.offsetInBytes + 4);
    switch (index) {
      case 1:
        return SerializationDecryptionException.read(subview);
      case 2:
        return IdentifierDecryptionException.read(subview);
      case 3:
        return MegolmDecryptionException.read(subview);
      case 4:
        return MissingRoomKeyDecryptionException.read(subview);
      case 5:
        return StoreDecryptionException.read(subview);
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(DecryptionException value) {
    return value.lower();
  }

  static int allocationSize(DecryptionException value) {
    return value.allocationSize();
  }

  static int write(DecryptionException value, Uint8List buf) {
    return value.write(buf);
  }
}

class SerializationDecryptionException extends DecryptionException {
  final String error;
  SerializationDecryptionException(String this.error);
  SerializationDecryptionException._(String this.error);
  static LiftRetVal<SerializationDecryptionException> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final error_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final error = error_lifted.value;
    new_offset += error_lifted.bytesRead;
    return LiftRetVal(SerializationDecryptionException._(error), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(error) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 1);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      error,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }

  @override
  String toString() {
    return "SerializationDecryptionException($error)";
  }
}

class IdentifierDecryptionException extends DecryptionException {
  final String error;
  IdentifierDecryptionException(String this.error);
  IdentifierDecryptionException._(String this.error);
  static LiftRetVal<IdentifierDecryptionException> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final error_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final error = error_lifted.value;
    new_offset += error_lifted.bytesRead;
    return LiftRetVal(IdentifierDecryptionException._(error), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(error) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 2);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      error,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }

  @override
  String toString() {
    return "IdentifierDecryptionException($error)";
  }
}

class MegolmDecryptionException extends DecryptionException {
  final String error;
  MegolmDecryptionException(String this.error);
  MegolmDecryptionException._(String this.error);
  static LiftRetVal<MegolmDecryptionException> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final error_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final error = error_lifted.value;
    new_offset += error_lifted.bytesRead;
    return LiftRetVal(MegolmDecryptionException._(error), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(error) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 3);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      error,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }

  @override
  String toString() {
    return "MegolmDecryptionException($error)";
  }
}

class MissingRoomKeyDecryptionException extends DecryptionException {
  final String error;
  final String? withheldCode;
  MissingRoomKeyDecryptionException({
    required String this.error,
    required String? this.withheldCode,
  });
  MissingRoomKeyDecryptionException._(
    String this.error,
    String? this.withheldCode,
  );
  static LiftRetVal<MissingRoomKeyDecryptionException> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final error_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final error = error_lifted.value;
    new_offset += error_lifted.bytesRead;
    final withheldCode_lifted = FfiConverterOptionalString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final withheldCode = withheldCode_lifted.value;
    new_offset += withheldCode_lifted.bytesRead;
    return LiftRetVal(
      MissingRoomKeyDecryptionException._(error, withheldCode),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(error) +
        FfiConverterOptionalString.allocationSize(withheldCode) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 4);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      error,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterOptionalString.write(
      withheldCode,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }

  @override
  String toString() {
    return "MissingRoomKeyDecryptionException($error, $withheldCode)";
  }
}

class StoreDecryptionException extends DecryptionException {
  final String error;
  StoreDecryptionException(String this.error);
  StoreDecryptionException._(String this.error);
  static LiftRetVal<StoreDecryptionException> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final error_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final error = error_lifted.value;
    new_offset += error_lifted.bytesRead;
    return LiftRetVal(StoreDecryptionException._(error), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(error) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 5);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      error,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }

  @override
  String toString() {
    return "StoreDecryptionException($error)";
  }
}

class DecryptionExceptionErrorHandler extends UniffiRustCallStatusErrorHandler {
  @override
  Exception lift(RustBuffer errorBuf) {
    return FfiConverterDecryptionException.lift(errorBuf);
  }
}

final DecryptionExceptionErrorHandler decryptionExceptionErrorHandler =
    DecryptionExceptionErrorHandler();

enum DehydrationException {
  pickle,
  legacyPickle,
  missingSigningKey,
  json,
  store,
  pickleKeyLength,
  rand,
}

class FfiConverterDehydrationException {
  static DehydrationException lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return DehydrationException.pickle;
      case 2:
        return DehydrationException.legacyPickle;
      case 3:
        return DehydrationException.missingSigningKey;
      case 4:
        return DehydrationException.json;
      case 5:
        return DehydrationException.store;
      case 6:
        return DehydrationException.pickleKeyLength;
      case 7:
        return DehydrationException.rand;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(DehydrationException input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }
}

enum EventEncryptionAlgorithm { olmV1Curve25519AesSha2, megolmV1AesSha2 }

class FfiConverterEventEncryptionAlgorithm {
  static EventEncryptionAlgorithm lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return EventEncryptionAlgorithm.olmV1Curve25519AesSha2;
      case 2:
        return EventEncryptionAlgorithm.megolmV1AesSha2;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(EventEncryptionAlgorithm input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }

  static LiftRetVal<EventEncryptionAlgorithm> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final value = (() {
      switch (index) {
        case 1:
          return EventEncryptionAlgorithm.olmV1Curve25519AesSha2;
        case 2:
          return EventEncryptionAlgorithm.megolmV1AesSha2;
        default:
          throw UniffiInternalError(
            UniffiInternalError.unexpectedEnumCase,
            "Unable to determine enum variant",
          );
      }
    })();
    return LiftRetVal(value, 4);
  }

  static int allocationSize(EventEncryptionAlgorithm value) {
    return 4;
  }

  static int write(EventEncryptionAlgorithm value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.index + 1);
    return 4;
  }
}

enum HistoryVisibility { invited, joined, shared, worldReadable }

class FfiConverterHistoryVisibility {
  static HistoryVisibility lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return HistoryVisibility.invited;
      case 2:
        return HistoryVisibility.joined;
      case 3:
        return HistoryVisibility.shared;
      case 4:
        return HistoryVisibility.worldReadable;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(HistoryVisibility input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }

  static LiftRetVal<HistoryVisibility> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final value = (() {
      switch (index) {
        case 1:
          return HistoryVisibility.invited;
        case 2:
          return HistoryVisibility.joined;
        case 3:
          return HistoryVisibility.shared;
        case 4:
          return HistoryVisibility.worldReadable;
        default:
          throw UniffiInternalError(
            UniffiInternalError.unexpectedEnumCase,
            "Unable to determine enum variant",
          );
      }
    })();
    return LiftRetVal(value, 4);
  }

  static int allocationSize(HistoryVisibility value) {
    return 4;
  }

  static int write(HistoryVisibility value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.index + 1);
    return 4;
  }
}

enum KeyImportException { export_, cryptoStore, json }

class FfiConverterKeyImportException {
  static KeyImportException lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return KeyImportException.export_;
      case 2:
        return KeyImportException.cryptoStore;
      case 3:
        return KeyImportException.json;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(KeyImportException input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }
}

abstract class MigrationException implements Exception {
  RustBuffer lower();
  int allocationSize();
  int write(Uint8List buf);
}

class FfiConverterMigrationException {
  static MigrationException lift(RustBuffer buffer) {
    return FfiConverterMigrationException.read(buffer.asUint8List()).value;
  }

  static LiftRetVal<MigrationException> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final subview = Uint8List.view(buf.buffer, buf.offsetInBytes + 4);
    switch (index) {
      case 1:
        return GenericMigrationException.read(subview);
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(MigrationException value) {
    return value.lower();
  }

  static int allocationSize(MigrationException value) {
    return value.allocationSize();
  }

  static int write(MigrationException value, Uint8List buf) {
    return value.write(buf);
  }
}

class GenericMigrationException extends MigrationException {
  final String errorMessage;
  GenericMigrationException(String this.errorMessage);
  GenericMigrationException._(String this.errorMessage);
  static LiftRetVal<GenericMigrationException> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final errorMessage_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final errorMessage = errorMessage_lifted.value;
    new_offset += errorMessage_lifted.bytesRead;
    return LiftRetVal(GenericMigrationException._(errorMessage), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(errorMessage) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 1);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      errorMessage,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }

  @override
  String toString() {
    return "GenericMigrationException($errorMessage)";
  }
}

class MigrationExceptionErrorHandler extends UniffiRustCallStatusErrorHandler {
  @override
  Exception lift(RustBuffer errorBuf) {
    return FfiConverterMigrationException.lift(errorBuf);
  }
}

final MigrationExceptionErrorHandler migrationExceptionErrorHandler =
    MigrationExceptionErrorHandler();

abstract class OutgoingVerificationRequest {
  RustBuffer lower();
  int allocationSize();
  int write(Uint8List buf);
}

class FfiConverterOutgoingVerificationRequest {
  static OutgoingVerificationRequest lift(RustBuffer buffer) {
    return FfiConverterOutgoingVerificationRequest.read(
      buffer.asUint8List(),
    ).value;
  }

  static LiftRetVal<OutgoingVerificationRequest> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final subview = Uint8List.view(buf.buffer, buf.offsetInBytes + 4);
    switch (index) {
      case 1:
        return ToDeviceOutgoingVerificationRequest.read(subview);
      case 2:
        return InRoomOutgoingVerificationRequest.read(subview);
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(OutgoingVerificationRequest value) {
    return value.lower();
  }

  static int allocationSize(OutgoingVerificationRequest value) {
    return value.allocationSize();
  }

  static int write(OutgoingVerificationRequest value, Uint8List buf) {
    return value.write(buf);
  }
}

class ToDeviceOutgoingVerificationRequest extends OutgoingVerificationRequest {
  final String requestId;
  final String eventType;
  final String body;
  ToDeviceOutgoingVerificationRequest({
    required String this.requestId,
    required String this.eventType,
    required String this.body,
  });
  ToDeviceOutgoingVerificationRequest._(
    String this.requestId,
    String this.eventType,
    String this.body,
  );
  static LiftRetVal<ToDeviceOutgoingVerificationRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requestId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requestId = requestId_lifted.value;
    new_offset += requestId_lifted.bytesRead;
    final eventType_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final eventType = eventType_lifted.value;
    new_offset += eventType_lifted.bytesRead;
    final body_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final body = body_lifted.value;
    new_offset += body_lifted.bytesRead;
    return LiftRetVal(
      ToDeviceOutgoingVerificationRequest._(requestId, eventType, body),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(requestId) +
        FfiConverterString.allocationSize(eventType) +
        FfiConverterString.allocationSize(body) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 1);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      requestId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      eventType,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      body,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class InRoomOutgoingVerificationRequest extends OutgoingVerificationRequest {
  final String requestId;
  final String roomId;
  final String eventType;
  final String content;
  InRoomOutgoingVerificationRequest({
    required String this.requestId,
    required String this.roomId,
    required String this.eventType,
    required String this.content,
  });
  InRoomOutgoingVerificationRequest._(
    String this.requestId,
    String this.roomId,
    String this.eventType,
    String this.content,
  );
  static LiftRetVal<InRoomOutgoingVerificationRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requestId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requestId = requestId_lifted.value;
    new_offset += requestId_lifted.bytesRead;
    final roomId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final roomId = roomId_lifted.value;
    new_offset += roomId_lifted.bytesRead;
    final eventType_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final eventType = eventType_lifted.value;
    new_offset += eventType_lifted.bytesRead;
    final content_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final content = content_lifted.value;
    new_offset += content_lifted.bytesRead;
    return LiftRetVal(
      InRoomOutgoingVerificationRequest._(
        requestId,
        roomId,
        eventType,
        content,
      ),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(requestId) +
        FfiConverterString.allocationSize(roomId) +
        FfiConverterString.allocationSize(eventType) +
        FfiConverterString.allocationSize(content) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 2);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      requestId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      roomId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      eventType,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      content,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

enum PkDecryptionException { olm }

class FfiConverterPkDecryptionException {
  static PkDecryptionException lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return PkDecryptionException.olm;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(PkDecryptionException input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }
}

abstract class QrCodeState {
  RustBuffer lower();
  int allocationSize();
  int write(Uint8List buf);
}

class FfiConverterQrCodeState {
  static QrCodeState lift(RustBuffer buffer) {
    return FfiConverterQrCodeState.read(buffer.asUint8List()).value;
  }

  static LiftRetVal<QrCodeState> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final subview = Uint8List.view(buf.buffer, buf.offsetInBytes + 4);
    switch (index) {
      case 1:
        return StartedQrCodeState.read(subview);
      case 2:
        return ScannedQrCodeState.read(subview);
      case 3:
        return ConfirmedQrCodeState.read(subview);
      case 4:
        return ReciprocatedQrCodeState.read(subview);
      case 5:
        return DoneQrCodeState.read(subview);
      case 6:
        return CancelledQrCodeState.read(subview);
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(QrCodeState value) {
    return value.lower();
  }

  static int allocationSize(QrCodeState value) {
    return value.allocationSize();
  }

  static int write(QrCodeState value, Uint8List buf) {
    return value.write(buf);
  }
}

class StartedQrCodeState extends QrCodeState {
  StartedQrCodeState();
  StartedQrCodeState._();
  static LiftRetVal<StartedQrCodeState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(StartedQrCodeState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 1);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class ScannedQrCodeState extends QrCodeState {
  ScannedQrCodeState();
  ScannedQrCodeState._();
  static LiftRetVal<ScannedQrCodeState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(ScannedQrCodeState._(), new_offset);
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

class ConfirmedQrCodeState extends QrCodeState {
  ConfirmedQrCodeState();
  ConfirmedQrCodeState._();
  static LiftRetVal<ConfirmedQrCodeState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(ConfirmedQrCodeState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 3);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class ReciprocatedQrCodeState extends QrCodeState {
  ReciprocatedQrCodeState();
  ReciprocatedQrCodeState._();
  static LiftRetVal<ReciprocatedQrCodeState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(ReciprocatedQrCodeState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 4);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class DoneQrCodeState extends QrCodeState {
  DoneQrCodeState();
  DoneQrCodeState._();
  static LiftRetVal<DoneQrCodeState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(DoneQrCodeState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 5);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class CancelledQrCodeState extends QrCodeState {
  final CancelInfo cancelInfo;
  CancelledQrCodeState(CancelInfo this.cancelInfo);
  CancelledQrCodeState._(CancelInfo this.cancelInfo);
  static LiftRetVal<CancelledQrCodeState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final cancelInfo_lifted = FfiConverterCancelInfo.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final cancelInfo = cancelInfo_lifted.value;
    new_offset += cancelInfo_lifted.bytesRead;
    return LiftRetVal(CancelledQrCodeState._(cancelInfo), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterCancelInfo.allocationSize(cancelInfo) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 6);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterCancelInfo.write(
      cancelInfo,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

abstract class Request {
  RustBuffer lower();
  int allocationSize();
  int write(Uint8List buf);
}

class FfiConverterRequest {
  static Request lift(RustBuffer buffer) {
    return FfiConverterRequest.read(buffer.asUint8List()).value;
  }

  static LiftRetVal<Request> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final subview = Uint8List.view(buf.buffer, buf.offsetInBytes + 4);
    switch (index) {
      case 1:
        return ToDeviceRequest.read(subview);
      case 2:
        return KeysUploadRequest.read(subview);
      case 3:
        return KeysQueryRequest.read(subview);
      case 4:
        return KeysClaimRequest.read(subview);
      case 5:
        return KeysBackupRequest.read(subview);
      case 6:
        return RoomMessageRequest.read(subview);
      case 7:
        return SignatureUploadRequest.read(subview);
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(Request value) {
    return value.lower();
  }

  static int allocationSize(Request value) {
    return value.allocationSize();
  }

  static int write(Request value, Uint8List buf) {
    return value.write(buf);
  }
}

class ToDeviceRequest extends Request {
  final String requestId;
  final String eventType;
  final String body;
  ToDeviceRequest({
    required String this.requestId,
    required String this.eventType,
    required String this.body,
  });
  ToDeviceRequest._(
    String this.requestId,
    String this.eventType,
    String this.body,
  );
  static LiftRetVal<ToDeviceRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requestId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requestId = requestId_lifted.value;
    new_offset += requestId_lifted.bytesRead;
    final eventType_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final eventType = eventType_lifted.value;
    new_offset += eventType_lifted.bytesRead;
    final body_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final body = body_lifted.value;
    new_offset += body_lifted.bytesRead;
    return LiftRetVal(
      ToDeviceRequest._(requestId, eventType, body),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(requestId) +
        FfiConverterString.allocationSize(eventType) +
        FfiConverterString.allocationSize(body) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 1);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      requestId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      eventType,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      body,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class KeysUploadRequest extends Request {
  final String requestId;
  final String body;
  KeysUploadRequest({
    required String this.requestId,
    required String this.body,
  });
  KeysUploadRequest._(String this.requestId, String this.body);
  static LiftRetVal<KeysUploadRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requestId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requestId = requestId_lifted.value;
    new_offset += requestId_lifted.bytesRead;
    final body_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final body = body_lifted.value;
    new_offset += body_lifted.bytesRead;
    return LiftRetVal(KeysUploadRequest._(requestId, body), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(requestId) +
        FfiConverterString.allocationSize(body) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 2);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      requestId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      body,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class KeysQueryRequest extends Request {
  final String requestId;
  final List<String> users;
  KeysQueryRequest({
    required String this.requestId,
    required List<String> this.users,
  });
  KeysQueryRequest._(String this.requestId, List<String> this.users);
  static LiftRetVal<KeysQueryRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requestId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requestId = requestId_lifted.value;
    new_offset += requestId_lifted.bytesRead;
    final users_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final users = users_lifted.value;
    new_offset += users_lifted.bytesRead;
    return LiftRetVal(KeysQueryRequest._(requestId, users), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(requestId) +
        FfiConverterSequenceString.allocationSize(users) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 3);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      requestId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequenceString.write(
      users,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class KeysClaimRequest extends Request {
  final String requestId;
  final Map<String, Map<String, String>> oneTimeKeys;
  KeysClaimRequest({
    required String this.requestId,
    required Map<String, Map<String, String>> this.oneTimeKeys,
  });
  KeysClaimRequest._(
    String this.requestId,
    Map<String, Map<String, String>> this.oneTimeKeys,
  );
  static LiftRetVal<KeysClaimRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requestId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requestId = requestId_lifted.value;
    new_offset += requestId_lifted.bytesRead;
    final oneTimeKeys_lifted = FfiConverterMapStringMapStringString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final oneTimeKeys = oneTimeKeys_lifted.value;
    new_offset += oneTimeKeys_lifted.bytesRead;
    return LiftRetVal(KeysClaimRequest._(requestId, oneTimeKeys), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(requestId) +
        FfiConverterMapStringMapStringString.allocationSize(oneTimeKeys) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 4);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      requestId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterMapStringMapStringString.write(
      oneTimeKeys,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class KeysBackupRequest extends Request {
  final String requestId;
  final String version;
  final String rooms;
  KeysBackupRequest({
    required String this.requestId,
    required String this.version,
    required String this.rooms,
  });
  KeysBackupRequest._(
    String this.requestId,
    String this.version,
    String this.rooms,
  );
  static LiftRetVal<KeysBackupRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requestId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requestId = requestId_lifted.value;
    new_offset += requestId_lifted.bytesRead;
    final version_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final version = version_lifted.value;
    new_offset += version_lifted.bytesRead;
    final rooms_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final rooms = rooms_lifted.value;
    new_offset += rooms_lifted.bytesRead;
    return LiftRetVal(
      KeysBackupRequest._(requestId, version, rooms),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(requestId) +
        FfiConverterString.allocationSize(version) +
        FfiConverterString.allocationSize(rooms) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 5);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      requestId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      version,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      rooms,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class RoomMessageRequest extends Request {
  final String requestId;
  final String roomId;
  final String eventType;
  final String content;
  RoomMessageRequest({
    required String this.requestId,
    required String this.roomId,
    required String this.eventType,
    required String this.content,
  });
  RoomMessageRequest._(
    String this.requestId,
    String this.roomId,
    String this.eventType,
    String this.content,
  );
  static LiftRetVal<RoomMessageRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requestId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requestId = requestId_lifted.value;
    new_offset += requestId_lifted.bytesRead;
    final roomId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final roomId = roomId_lifted.value;
    new_offset += roomId_lifted.bytesRead;
    final eventType_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final eventType = eventType_lifted.value;
    new_offset += eventType_lifted.bytesRead;
    final content_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final content = content_lifted.value;
    new_offset += content_lifted.bytesRead;
    return LiftRetVal(
      RoomMessageRequest._(requestId, roomId, eventType, content),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(requestId) +
        FfiConverterString.allocationSize(roomId) +
        FfiConverterString.allocationSize(eventType) +
        FfiConverterString.allocationSize(content) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 6);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      requestId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      roomId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      eventType,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      content,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class SignatureUploadRequest extends Request {
  final String body;
  SignatureUploadRequest(String this.body);
  SignatureUploadRequest._(String this.body);
  static LiftRetVal<SignatureUploadRequest> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final requestId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final requestId = requestId_lifted.value;
    new_offset += requestId_lifted.bytesRead;
    final body_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final body = body_lifted.value;
    new_offset += body_lifted.bytesRead;
    return LiftRetVal(SignatureUploadRequest._(body), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(body) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 7);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      body,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

// class SignatureUploadRequest extends Request {
//   final String requestId;
//   final String body;
//   SignatureUploadRequest({
//     required String this.requestId,
//     required String this.body,
//   });
//   SignatureUploadRequest._(String this.requestId, String this.body);
//   static LiftRetVal<SignatureUploadRequest> read(Uint8List buf) {
//     int new_offset = buf.offsetInBytes;
//     final requestId_lifted = FfiConverterString.read(
//       Uint8List.view(buf.buffer, new_offset),
//     );
//     final requestId = requestId_lifted.value;
//     new_offset += requestId_lifted.bytesRead;
//     final body_lifted = FfiConverterString.read(
//       Uint8List.view(buf.buffer, new_offset),
//     );
//     final body = body_lifted.value;
//     new_offset += body_lifted.bytesRead;
//     return LiftRetVal(SignatureUploadRequest._(requestId, body), new_offset);
//   }

//   @override
//   RustBuffer lower() {
//     final buf = Uint8List(allocationSize());
//     write(buf);
//     return toRustBuffer(buf);
//   }

//   @override
//   int allocationSize() {
//     return FfiConverterString.allocationSize(requestId) +
//         FfiConverterString.allocationSize(body) +
//         4;
//   }

//   @override
//   int write(Uint8List buf) {
//     buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 7);
//     int new_offset = buf.offsetInBytes + 4;
//     new_offset += FfiConverterString.write(
//       requestId,
//       Uint8List.view(buf.buffer, new_offset),
//     );
//     new_offset += FfiConverterString.write(
//       body,
//       Uint8List.view(buf.buffer, new_offset),
//     );
//     return new_offset;
//   }
// }

enum RequestType {
  keysQuery,
  keysClaim,
  keysUpload,
  toDevice,
  signatureUpload,
  keysBackup,
  roomMessage,
}

class FfiConverterRequestType {
  static RequestType lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return RequestType.keysQuery;
      case 2:
        return RequestType.keysClaim;
      case 3:
        return RequestType.keysUpload;
      case 4:
        return RequestType.toDevice;
      case 5:
        return RequestType.signatureUpload;
      case 6:
        return RequestType.keysBackup;
      case 7:
        return RequestType.roomMessage;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(RequestType input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }
}

abstract class SasState {
  RustBuffer lower();
  int allocationSize();
  int write(Uint8List buf);
}

class FfiConverterSasState {
  static SasState lift(RustBuffer buffer) {
    return FfiConverterSasState.read(buffer.asUint8List()).value;
  }

  static LiftRetVal<SasState> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final subview = Uint8List.view(buf.buffer, buf.offsetInBytes + 4);
    switch (index) {
      case 1:
        return CreatedSasState.read(subview);
      case 2:
        return StartedSasState.read(subview);
      case 3:
        return AcceptedSasState.read(subview);
      case 4:
        return KeysExchangedSasState.read(subview);
      case 5:
        return ConfirmedSasState.read(subview);
      case 6:
        return DoneSasState.read(subview);
      case 7:
        return CancelledSasState.read(subview);
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(SasState value) {
    return value.lower();
  }

  static int allocationSize(SasState value) {
    return value.allocationSize();
  }

  static int write(SasState value, Uint8List buf) {
    return value.write(buf);
  }
}

class CreatedSasState extends SasState {
  CreatedSasState();
  CreatedSasState._();
  static LiftRetVal<CreatedSasState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(CreatedSasState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 1);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class StartedSasState extends SasState {
  StartedSasState();
  StartedSasState._();
  static LiftRetVal<StartedSasState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(StartedSasState._(), new_offset);
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

class AcceptedSasState extends SasState {
  AcceptedSasState();
  AcceptedSasState._();
  static LiftRetVal<AcceptedSasState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(AcceptedSasState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 3);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class KeysExchangedSasState extends SasState {
  final List<int>? emojis;
  final List<int> decimals;
  KeysExchangedSasState({
    required List<int>? this.emojis,
    required List<int> this.decimals,
  });
  KeysExchangedSasState._(List<int>? this.emojis, List<int> this.decimals);
  static LiftRetVal<KeysExchangedSasState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final emojis_lifted = FfiConverterOptionalSequenceInt32.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final emojis = emojis_lifted.value;
    new_offset += emojis_lifted.bytesRead;
    final decimals_lifted = FfiConverterSequenceInt32.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final decimals = decimals_lifted.value;
    new_offset += decimals_lifted.bytesRead;
    return LiftRetVal(KeysExchangedSasState._(emojis, decimals), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterOptionalSequenceInt32.allocationSize(emojis) +
        FfiConverterSequenceInt32.allocationSize(decimals) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 4);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterOptionalSequenceInt32.write(
      emojis,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequenceInt32.write(
      decimals,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class ConfirmedSasState extends SasState {
  ConfirmedSasState();
  ConfirmedSasState._();
  static LiftRetVal<ConfirmedSasState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(ConfirmedSasState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 5);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class DoneSasState extends SasState {
  DoneSasState();
  DoneSasState._();
  static LiftRetVal<DoneSasState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(DoneSasState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 6);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class CancelledSasState extends SasState {
  final CancelInfo cancelInfo;
  CancelledSasState(CancelInfo this.cancelInfo);
  CancelledSasState._(CancelInfo this.cancelInfo);
  static LiftRetVal<CancelledSasState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final cancelInfo_lifted = FfiConverterCancelInfo.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final cancelInfo = cancelInfo_lifted.value;
    new_offset += cancelInfo_lifted.bytesRead;
    return LiftRetVal(CancelledSasState._(cancelInfo), new_offset);
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterCancelInfo.allocationSize(cancelInfo) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 7);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterCancelInfo.write(
      cancelInfo,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

enum SecretImportException { cryptoStore, import_ }

class FfiConverterSecretImportException {
  static SecretImportException lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return SecretImportException.cryptoStore;
      case 2:
        return SecretImportException.import_;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(SecretImportException input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }
}

enum ShieldColor { red, grey, none }

class FfiConverterShieldColor {
  static ShieldColor lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return ShieldColor.red;
      case 2:
        return ShieldColor.grey;
      case 3:
        return ShieldColor.none;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(ShieldColor input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }

  static LiftRetVal<ShieldColor> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final value = (() {
      switch (index) {
        case 1:
          return ShieldColor.red;
        case 2:
          return ShieldColor.grey;
        case 3:
          return ShieldColor.none;
        default:
          throw UniffiInternalError(
            UniffiInternalError.unexpectedEnumCase,
            "Unable to determine enum variant",
          );
      }
    })();
    return LiftRetVal(value, 4);
  }

  static int allocationSize(ShieldColor value) {
    return 4;
  }

  static int write(ShieldColor value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.index + 1);
    return 4;
  }
}

enum SignatureException {
  signature,
  identifier,
  cryptoStore,
  unknownDevice,
  unknownUserIdentity,
}

class FfiConverterSignatureException {
  static SignatureException lift(RustBuffer buffer) {
    final index = buffer.asUint8List().buffer.asByteData().getInt32(0);
    switch (index) {
      case 1:
        return SignatureException.signature;
      case 2:
        return SignatureException.identifier;
      case 3:
        return SignatureException.cryptoStore;
      case 4:
        return SignatureException.unknownDevice;
      case 5:
        return SignatureException.unknownUserIdentity;
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(SignatureException input) {
    return toRustBuffer(createUint8ListFromInt(input.index + 1));
  }
}

abstract class UserIdentity {
  RustBuffer lower();
  int allocationSize();
  int write(Uint8List buf);
}

class FfiConverterUserIdentity {
  static UserIdentity lift(RustBuffer buffer) {
    return FfiConverterUserIdentity.read(buffer.asUint8List()).value;
  }

  static LiftRetVal<UserIdentity> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final subview = Uint8List.view(buf.buffer, buf.offsetInBytes + 4);
    switch (index) {
      case 1:
        return OwnUserIdentity.read(subview);
      case 2:
        return OtherUserIdentity.read(subview);
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(UserIdentity value) {
    return value.lower();
  }

  static int allocationSize(UserIdentity value) {
    return value.allocationSize();
  }

  static int write(UserIdentity value, Uint8List buf) {
    return value.write(buf);
  }
}

class OwnUserIdentity extends UserIdentity {
  final String userId;
  final bool trustsOurOwnDevice;
  final String masterKey;
  final String userSigningKey;
  final String selfSigningKey;
  final bool hasVerificationViolation;
  OwnUserIdentity({
    required String this.userId,
    required bool this.trustsOurOwnDevice,
    required String this.masterKey,
    required String this.userSigningKey,
    required String this.selfSigningKey,
    required bool this.hasVerificationViolation,
  });
  OwnUserIdentity._(
    String this.userId,
    bool this.trustsOurOwnDevice,
    String this.masterKey,
    String this.userSigningKey,
    String this.selfSigningKey,
    bool this.hasVerificationViolation,
  );
  static LiftRetVal<OwnUserIdentity> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final userId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final userId = userId_lifted.value;
    new_offset += userId_lifted.bytesRead;
    final trustsOurOwnDevice_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final trustsOurOwnDevice = trustsOurOwnDevice_lifted.value;
    new_offset += trustsOurOwnDevice_lifted.bytesRead;
    final masterKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final masterKey = masterKey_lifted.value;
    new_offset += masterKey_lifted.bytesRead;
    final userSigningKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final userSigningKey = userSigningKey_lifted.value;
    new_offset += userSigningKey_lifted.bytesRead;
    final selfSigningKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final selfSigningKey = selfSigningKey_lifted.value;
    new_offset += selfSigningKey_lifted.bytesRead;
    final hasVerificationViolation_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final hasVerificationViolation = hasVerificationViolation_lifted.value;
    new_offset += hasVerificationViolation_lifted.bytesRead;
    return LiftRetVal(
      OwnUserIdentity._(
        userId,
        trustsOurOwnDevice,
        masterKey,
        userSigningKey,
        selfSigningKey,
        hasVerificationViolation,
      ),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(userId) +
        FfiConverterBool.allocationSize(trustsOurOwnDevice) +
        FfiConverterString.allocationSize(masterKey) +
        FfiConverterString.allocationSize(userSigningKey) +
        FfiConverterString.allocationSize(selfSigningKey) +
        FfiConverterBool.allocationSize(hasVerificationViolation) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 1);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      userId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      trustsOurOwnDevice,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      masterKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      userSigningKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      selfSigningKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      hasVerificationViolation,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class OtherUserIdentity extends UserIdentity {
  final String userId;
  final String masterKey;
  final String selfSigningKey;
  final bool hasVerificationViolation;
  OtherUserIdentity({
    required String this.userId,
    required String this.masterKey,
    required String this.selfSigningKey,
    required bool this.hasVerificationViolation,
  });
  OtherUserIdentity._(
    String this.userId,
    String this.masterKey,
    String this.selfSigningKey,
    bool this.hasVerificationViolation,
  );
  static LiftRetVal<OtherUserIdentity> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final userId_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final userId = userId_lifted.value;
    new_offset += userId_lifted.bytesRead;
    final masterKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final masterKey = masterKey_lifted.value;
    new_offset += masterKey_lifted.bytesRead;
    final selfSigningKey_lifted = FfiConverterString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final selfSigningKey = selfSigningKey_lifted.value;
    new_offset += selfSigningKey_lifted.bytesRead;
    final hasVerificationViolation_lifted = FfiConverterBool.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final hasVerificationViolation = hasVerificationViolation_lifted.value;
    new_offset += hasVerificationViolation_lifted.bytesRead;
    return LiftRetVal(
      OtherUserIdentity._(
        userId,
        masterKey,
        selfSigningKey,
        hasVerificationViolation,
      ),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterString.allocationSize(userId) +
        FfiConverterString.allocationSize(masterKey) +
        FfiConverterString.allocationSize(selfSigningKey) +
        FfiConverterBool.allocationSize(hasVerificationViolation) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 2);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterString.write(
      userId,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      masterKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterString.write(
      selfSigningKey,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterBool.write(
      hasVerificationViolation,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

abstract class VerificationRequestState {
  RustBuffer lower();
  int allocationSize();
  int write(Uint8List buf);
}

class FfiConverterVerificationRequestState {
  static VerificationRequestState lift(RustBuffer buffer) {
    return FfiConverterVerificationRequestState.read(
      buffer.asUint8List(),
    ).value;
  }

  static LiftRetVal<VerificationRequestState> read(Uint8List buf) {
    final index = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final subview = Uint8List.view(buf.buffer, buf.offsetInBytes + 4);
    switch (index) {
      case 1:
        return RequestedVerificationRequestState.read(subview);
      case 2:
        return ReadyVerificationRequestState.read(subview);
      case 3:
        return DoneVerificationRequestState.read(subview);
      case 4:
        return CancelledVerificationRequestState.read(subview);
      default:
        throw UniffiInternalError(
          UniffiInternalError.unexpectedEnumCase,
          "Unable to determine enum variant",
        );
    }
  }

  static RustBuffer lower(VerificationRequestState value) {
    return value.lower();
  }

  static int allocationSize(VerificationRequestState value) {
    return value.allocationSize();
  }

  static int write(VerificationRequestState value, Uint8List buf) {
    return value.write(buf);
  }
}

class RequestedVerificationRequestState extends VerificationRequestState {
  RequestedVerificationRequestState();
  RequestedVerificationRequestState._();
  static LiftRetVal<RequestedVerificationRequestState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(RequestedVerificationRequestState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 1);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class ReadyVerificationRequestState extends VerificationRequestState {
  final List<String> theirMethods;
  final List<String> ourMethods;
  ReadyVerificationRequestState({
    required List<String> this.theirMethods,
    required List<String> this.ourMethods,
  });
  ReadyVerificationRequestState._(
    List<String> this.theirMethods,
    List<String> this.ourMethods,
  );
  static LiftRetVal<ReadyVerificationRequestState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final theirMethods_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final theirMethods = theirMethods_lifted.value;
    new_offset += theirMethods_lifted.bytesRead;
    final ourMethods_lifted = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final ourMethods = ourMethods_lifted.value;
    new_offset += ourMethods_lifted.bytesRead;
    return LiftRetVal(
      ReadyVerificationRequestState._(theirMethods, ourMethods),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterSequenceString.allocationSize(theirMethods) +
        FfiConverterSequenceString.allocationSize(ourMethods) +
        4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 2);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterSequenceString.write(
      theirMethods,
      Uint8List.view(buf.buffer, new_offset),
    );
    new_offset += FfiConverterSequenceString.write(
      ourMethods,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

class DoneVerificationRequestState extends VerificationRequestState {
  DoneVerificationRequestState();
  DoneVerificationRequestState._();
  static LiftRetVal<DoneVerificationRequestState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    return LiftRetVal(DoneVerificationRequestState._(), new_offset);
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
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 3);
    int new_offset = buf.offsetInBytes + 4;
    return new_offset;
  }
}

class CancelledVerificationRequestState extends VerificationRequestState {
  final CancelInfo cancelInfo;
  CancelledVerificationRequestState(CancelInfo this.cancelInfo);
  CancelledVerificationRequestState._(CancelInfo this.cancelInfo);
  static LiftRetVal<CancelledVerificationRequestState> read(Uint8List buf) {
    int new_offset = buf.offsetInBytes;
    final cancelInfo_lifted = FfiConverterCancelInfo.read(
      Uint8List.view(buf.buffer, new_offset),
    );
    final cancelInfo = cancelInfo_lifted.value;
    new_offset += cancelInfo_lifted.bytesRead;
    return LiftRetVal(
      CancelledVerificationRequestState._(cancelInfo),
      new_offset,
    );
  }

  @override
  RustBuffer lower() {
    final buf = Uint8List(allocationSize());
    write(buf);
    return toRustBuffer(buf);
  }

  @override
  int allocationSize() {
    return FfiConverterCancelInfo.allocationSize(cancelInfo) + 4;
  }

  @override
  int write(Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, 4);
    int new_offset = buf.offsetInBytes + 4;
    new_offset += FfiConverterCancelInfo.write(
      cancelInfo,
      Uint8List.view(buf.buffer, new_offset),
    );
    return new_offset;
  }
}

final _BackupKeysFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_free_backupkeys(ptr, status),
  );
});

class BackupKeys {
  late final Pointer<Void> _ptr;
  BackupKeys._(this._ptr) {
    _BackupKeysFinalizer.attach(this, _ptr, detach: this);
  }
  factory BackupKeys.lift(Pointer<Void> ptr) {
    return BackupKeys._(ptr);
  }
  static Pointer<Void> lower(BackupKeys value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_backupkeys(_ptr, status),
    );
  }

  static int allocationSize(BackupKeys value) {
    return 8;
  }

  static LiftRetVal<BackupKeys> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(BackupKeys.lift(pointer), 8);
  }

  static int write(BackupKeys value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _BackupKeysFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_backupkeys(_ptr, status),
    );
  }

  String backupVersion() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_backupkeys_backup_version(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  BackupRecoveryKey recoveryKey() {
    return rustCall(
      (status) => BackupRecoveryKey.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_backupkeys_recovery_key(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }
}

final _BackupRecoveryKeyFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_free_backuprecoverykey(ptr, status),
  );
});

class BackupRecoveryKey {
  late final Pointer<Void> _ptr;
  BackupRecoveryKey._(this._ptr) {
    _BackupRecoveryKeyFinalizer.attach(this, _ptr, detach: this);
  }
  BackupRecoveryKey.fromBase58(String key)
      : _ptr = rustCall(
          (status) => _UniffiLib.instance
              .uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_from_base58(
            FfiConverterString.lower(key),
            status,
          ),
          decodeExceptionErrorHandler,
        ) {
    _BackupRecoveryKeyFinalizer.attach(this, _ptr, detach: this);
  }
  BackupRecoveryKey.fromBase64(String key)
      : _ptr = rustCall(
          (status) => _UniffiLib.instance
              .uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_from_base64(
            FfiConverterString.lower(key),
            status,
          ),
          decodeExceptionErrorHandler,
        ) {
    _BackupRecoveryKeyFinalizer.attach(this, _ptr, detach: this);
  }
  BackupRecoveryKey.fromPassphrase(String passphrase, String salt, int rounds)
      : _ptr = rustCall(
          (status) => _UniffiLib.instance
              .uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_from_passphrase(
            FfiConverterString.lower(passphrase),
            FfiConverterString.lower(salt),
            rounds,
            status,
          ),
          null,
        ) {
    _BackupRecoveryKeyFinalizer.attach(this, _ptr, detach: this);
  }
  BackupRecoveryKey()
      : _ptr = rustCall(
          (status) => _UniffiLib.instance
              .uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_new(
            status,
          ),
          null,
        ) {
    _BackupRecoveryKeyFinalizer.attach(this, _ptr, detach: this);
  }
  BackupRecoveryKey.newFromPassphrase(String passphrase)
      : _ptr = rustCall(
          (status) => _UniffiLib.instance
              .uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_new_from_passphrase(
            FfiConverterString.lower(passphrase),
            status,
          ),
          null,
        ) {
    _BackupRecoveryKeyFinalizer.attach(this, _ptr, detach: this);
  }
  factory BackupRecoveryKey.lift(Pointer<Void> ptr) {
    return BackupRecoveryKey._(ptr);
  }

  static UniffiRustCallStatusErrorHandler? get decodeExceptionErrorHandler =>
      null;
  static UniffiRustCallStatusErrorHandler?
      get pkDecryptionExceptionErrorHandler => null;
  static UniffiRustCallStatusErrorHandler?
      get dehydrationExceptionErrorHandler => null;
  static UniffiRustCallStatusErrorHandler?
      get cryptoStoreExceptionErrorHandler => null;
  static Pointer<Void> lower(BackupRecoveryKey value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_backuprecoverykey(
        _ptr,
        status,
      ),
    );
  }

  static int allocationSize(BackupRecoveryKey value) {
    return 8;
  }

  static LiftRetVal<BackupRecoveryKey> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(BackupRecoveryKey.lift(pointer), 8);
  }

  static int write(BackupRecoveryKey value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _BackupRecoveryKeyFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_backuprecoverykey(_ptr, status),
    );
  }

  String decryptV1(String ephemeralKey, String mac, String ciphertext) {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_decrypt_v1(
          uniffiClonePointer(),
          FfiConverterString.lower(ephemeralKey),
          FfiConverterString.lower(mac),
          FfiConverterString.lower(ciphertext),
          status,
        ),
      ),
      pkDecryptionExceptionErrorHandler,
    );
  }

  MegolmV1BackupKey megolmV1PublicKey() {
    return rustCall(
      (status) => FfiConverterMegolmV1BackupKey.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_megolm_v1_public_key(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String toBase58() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_to_base58(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String toBase64() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_to_base64(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }
}

final _DehydratedDeviceFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_free_dehydrateddevice(ptr, status),
  );
});

class DehydratedDevice {
  late final Pointer<Void> _ptr;
  DehydratedDevice._(this._ptr) {
    _DehydratedDeviceFinalizer.attach(this, _ptr, detach: this);
  }
  factory DehydratedDevice.lift(Pointer<Void> ptr) {
    return DehydratedDevice._(ptr);
  }

  UniffiRustCallStatusErrorHandler? get dehydrationExceptionErrorHandler =>
      null;
  static Pointer<Void> lower(DehydratedDevice value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_dehydrateddevice(_ptr, status),
    );
  }

  static int allocationSize(DehydratedDevice value) {
    return 8;
  }

  static LiftRetVal<DehydratedDevice> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(DehydratedDevice.lift(pointer), 8);
  }

  static int write(DehydratedDevice value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _DehydratedDeviceFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_dehydrateddevice(_ptr, status),
    );
  }

  UploadDehydratedDeviceRequest keysForUpload(
    String deviceDisplayName,
    DehydratedDeviceKey pickleKey,
  ) {
    return rustCall(
      (status) => FfiConverterUploadDehydratedDeviceRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevice_keys_for_upload(
          uniffiClonePointer(),
          FfiConverterString.lower(deviceDisplayName),
          FfiConverterDehydratedDeviceKey.lower(pickleKey),
          status,
        ),
      ),
      dehydrationExceptionErrorHandler,
    );
  }
}

final _DehydratedDevicesFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_free_dehydrateddevices(ptr, status),
  );
});

class DehydratedDevices {
  late final Pointer<Void> _ptr;
  DehydratedDevices._(this._ptr) {
    _DehydratedDevicesFinalizer.attach(this, _ptr, detach: this);
  }
  factory DehydratedDevices.lift(Pointer<Void> ptr) {
    return DehydratedDevices._(ptr);
  }

  UniffiRustCallStatusErrorHandler? get dehydrationExceptionErrorHandler =>
      null;
  static Pointer<Void> lower(DehydratedDevices value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_dehydrateddevices(
        _ptr,
        status,
      ),
    );
  }

  static int allocationSize(DehydratedDevices value) {
    return 8;
  }

  static LiftRetVal<DehydratedDevices> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(DehydratedDevices.lift(pointer), 8);
  }

  static int write(DehydratedDevices value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _DehydratedDevicesFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_dehydrateddevices(_ptr, status),
    );
  }

  DehydratedDevice create() {
    return rustCall(
      (status) => DehydratedDevice.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_create(
          uniffiClonePointer(),
          status,
        ),
      ),
      dehydrationExceptionErrorHandler,
    );
  }

  void deleteDehydratedDeviceKey() {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_delete_dehydrated_device_key(
        uniffiClonePointer(),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  DehydratedDeviceKey? getDehydratedDeviceKey() {
    return rustCall(
      (status) => FfiConverterOptionalDehydratedDeviceKey.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_get_dehydrated_device_key(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  RehydratedDevice rehydrate(
    DehydratedDeviceKey pickleKey,
    String deviceId,
    String deviceData,
  ) {
    return rustCall(
      (status) => RehydratedDevice.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_rehydrate(
          uniffiClonePointer(),
          FfiConverterDehydratedDeviceKey.lower(pickleKey),
          FfiConverterString.lower(deviceId),
          FfiConverterString.lower(deviceData),
          status,
        ),
      ),
      dehydrationExceptionErrorHandler,
    );
  }

  void saveDehydratedDeviceKey(DehydratedDeviceKey pickleKey) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_save_dehydrated_device_key(
        uniffiClonePointer(),
        FfiConverterDehydratedDeviceKey.lower(pickleKey),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }
}

final _OlmMachineFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_free_olmmachine(ptr, status),
  );
});

UniffiRustCallStatusErrorHandler? get cryptoStoreExceptionErrorHandler => null;

class OlmMachine {
  late final Pointer<Void> _ptr;
  OlmMachine._(this._ptr) {
    _OlmMachineFinalizer.attach(this, _ptr, detach: this);
  }
  OlmMachine(String userId, String deviceId, String path, String? passphrase)
      : _ptr = rustCall(
          (status) => _UniffiLib.instance
              .uniffi_matrix_sdk_crypto_ffi_fn_constructor_olmmachine_new(
            FfiConverterString.lower(userId),
            FfiConverterString.lower(deviceId),
            FfiConverterString.lower(path),
            FfiConverterOptionalString.lower(passphrase),
            status,
          ),
          cryptoStoreExceptionErrorHandler,
        ) {
    _OlmMachineFinalizer.attach(this, _ptr, detach: this);
  }
  factory OlmMachine.lift(Pointer<Void> ptr) {
    return OlmMachine._(ptr);
  }

  UniffiRustCallStatusErrorHandler? get decodeExceptionErrorHandler => null;

  UniffiRustCallStatusErrorHandler? get secretImportExceptionErrorHandler =>
      null;

  UniffiRustCallStatusErrorHandler? get keyImportExceptionErrorHandler => null;

  UniffiRustCallStatusErrorHandler? get signatureExceptionErrorHandler => null;

  static Pointer<Void> lower(OlmMachine value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_olmmachine(_ptr, status),
    );
  }

  static int allocationSize(OlmMachine value) {
    return 8;
  }

  static LiftRetVal<OlmMachine> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(OlmMachine.lift(pointer), 8);
  }

  static int write(OlmMachine value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _OlmMachineFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_olmmachine(_ptr, status),
    );
  }

  bool backupEnabled() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_backup_enabled(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  Request? backupRoomKeys() {
    return rustCall(
      (status) => FfiConverterOptionalRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_backup_room_keys(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  BootstrapCrossSigningResult bootstrapCrossSigning() {
    return rustCall(
      (status) => FfiConverterBootstrapCrossSigningResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_bootstrap_cross_signing(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  Request? createEncryptedToDeviceRequest(
    String userId,
    String deviceId,
    String eventType,
    String content,
    CollectStrategy shareStrategy,
  ) {
    return rustCall(
      (status) => FfiConverterOptionalRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_create_encrypted_to_device_request(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          FfiConverterString.lower(deviceId),
          FfiConverterString.lower(eventType),
          FfiConverterString.lower(content),
          matrix_sdk_crypto.FfiConverterCollectStrategy.lower(shareStrategy),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  CrossSigningStatus crossSigningStatus() {
    return rustCall(
      (status) => FfiConverterCrossSigningStatus.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_cross_signing_status(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  DecryptedEvent decryptRoomEvent(
    String event,
    String roomId,
    bool handleVerificationEvents,
    bool strictShields,
    DecryptionSettings decryptionSettings,
  ) {
    return rustCall(
      (status) => FfiConverterDecryptedEvent.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_decrypt_room_event(
          uniffiClonePointer(),
          FfiConverterString.lower(event),
          FfiConverterString.lower(roomId),
          FfiConverterBool.lower(handleVerificationEvents),
          FfiConverterBool.lower(strictShields),
          matrix_sdk_crypto.FfiConverterDecryptionSettings.lower(
              decryptionSettings),
          status,
        ),
      ),
      decryptionExceptionErrorHandler,
    );
  }

  DehydratedDevices dehydratedDevices() {
    return rustCall(
      (status) => DehydratedDevices.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_dehydrated_devices(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String deviceId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_device_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  void disableBackup() {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_disable_backup(
        uniffiClonePointer(),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  void discardRoomKey(String roomId) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_discard_room_key(
        uniffiClonePointer(),
        FfiConverterString.lower(roomId),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  void enableBackupV1(MegolmV1BackupKey key, String version) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_enable_backup_v1(
        uniffiClonePointer(),
        FfiConverterMegolmV1BackupKey.lower(key),
        FfiConverterString.lower(version),
        status,
      );
    }, decodeExceptionErrorHandler);
  }

  String encrypt(String roomId, String eventType, String content) {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_encrypt(
          uniffiClonePointer(),
          FfiConverterString.lower(roomId),
          FfiConverterString.lower(eventType),
          FfiConverterString.lower(content),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  CrossSigningKeyExport? exportCrossSigningKeys() {
    return rustCall(
      (status) => FfiConverterOptionalCrossSigningKeyExport.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_export_cross_signing_keys(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  String exportRoomKeys(String passphrase, int rounds) {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_export_room_keys(
          uniffiClonePointer(),
          FfiConverterString.lower(passphrase),
          rounds,
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  BackupKeys? getBackupKeys() {
    return rustCall(
      (status) => FfiConverterOptionalBackupKeys.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_backup_keys(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  Device? getDevice(String userId, String deviceId, int timeout) {
    return rustCall(
      (status) => FfiConverterOptionalDevice.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_device(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          FfiConverterString.lower(deviceId),
          timeout,
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  UserIdentity? getIdentity(String userId, int timeout) {
    return rustCall(
      (status) => FfiConverterOptionalUserIdentity.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_identity(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          timeout,
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  Request? getMissingSessions(List<String> users) {
    return rustCall(
      (status) => FfiConverterOptionalRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_missing_sessions(
          uniffiClonePointer(),
          FfiConverterSequenceString.lower(users),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  bool getOnlyAllowTrustedDevices() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_only_allow_trusted_devices(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  RoomSettings? getRoomSettings(String roomId) {
    return rustCall(
      (status) => FfiConverterOptionalRoomSettings.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_room_settings(
          uniffiClonePointer(),
          FfiConverterString.lower(roomId),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  List<Device> getUserDevices(String userId, int timeout) {
    return rustCall(
      (status) => FfiConverterSequenceDevice.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_user_devices(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          timeout,
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  Verification? getVerification(String userId, String flowId) {
    return rustCall(
      (status) => FfiConverterOptionalVerification.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_verification(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          FfiConverterString.lower(flowId),
          status,
        ),
      ),
      null,
    );
  }

  VerificationRequest? getVerificationRequest(String userId, String flowId) {
    return rustCall(
      (status) => FfiConverterOptionalVerificationRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_verification_request(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          FfiConverterString.lower(flowId),
          status,
        ),
      ),
      null,
    );
  }

  List<VerificationRequest> getVerificationRequests(String userId) {
    return rustCall(
      (status) => FfiConverterSequenceVerificationRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_verification_requests(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          status,
        ),
      ),
      null,
    );
  }

  Map<String, String> identityKeys() {
    return rustCall(
      (status) => FfiConverterMapStringString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_identity_keys(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  void importCrossSigningKeys(CrossSigningKeyExport export_) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_cross_signing_keys(
        uniffiClonePointer(),
        FfiConverterCrossSigningKeyExport.lower(export_),
        status,
      );
    }, secretImportExceptionErrorHandler);
  }

  KeysImportResult importDecryptedRoomKeys(
    String keys,
    ProgressListener progressListener,
  ) {
    return rustCall(
      (status) => FfiConverterKeysImportResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_decrypted_room_keys(
          uniffiClonePointer(),
          FfiConverterString.lower(keys),
          FfiConverterCallbackInterfaceProgressListener.lower(
            progressListener,
          ),
          status,
        ),
      ),
      keyImportExceptionErrorHandler,
    );
  }

  KeysImportResult importRoomKeys(
    String keys,
    String passphrase,
    ProgressListener progressListener,
  ) {
    return rustCall(
      (status) => FfiConverterKeysImportResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_room_keys(
          uniffiClonePointer(),
          FfiConverterString.lower(keys),
          FfiConverterString.lower(passphrase),
          FfiConverterCallbackInterfaceProgressListener.lower(
            progressListener,
          ),
          status,
        ),
      ),
      keyImportExceptionErrorHandler,
    );
  }

  KeysImportResult importRoomKeysFromBackup(
    String keys,
    String backupVersion,
    ProgressListener progressListener,
  ) {
    return rustCall(
      (status) => FfiConverterKeysImportResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_room_keys_from_backup(
          uniffiClonePointer(),
          FfiConverterString.lower(keys),
          FfiConverterString.lower(backupVersion),
          FfiConverterCallbackInterfaceProgressListener.lower(
            progressListener,
          ),
          status,
        ),
      ),
      keyImportExceptionErrorHandler,
    );
  }

  bool isIdentityVerified(String userId) {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_is_identity_verified(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  bool isUserTracked(String userId) {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_is_user_tracked(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  void markRequestAsSent(
    String requestId,
    RequestType requestType,
    String responseBody,
  ) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_mark_request_as_sent(
        uniffiClonePointer(),
        FfiConverterString.lower(requestId),
        FfiConverterRequestType.lower(requestType),
        FfiConverterString.lower(responseBody),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  List<Request> outgoingRequests() {
    return rustCall(
      (status) => FfiConverterSequenceRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_outgoing_requests(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  bool queryMissingSecretsFromOtherSessions() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_query_missing_secrets_from_other_sessions(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  SyncChangesResult receiveSyncChanges(
    String events,
    DeviceLists deviceChanges,
    Map<String, int> keyCounts,
    List<String>? unusedFallbackKeys,
    String nextBatchToken,
    DecryptionSettings decryptionSettings,
  ) {
    return rustCall(
      (status) => FfiConverterSyncChangesResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_receive_sync_changes(
          uniffiClonePointer(),
          FfiConverterString.lower(events),
          FfiConverterDeviceLists.lower(deviceChanges),
          FfiConverterMapStringInt32.lower(keyCounts),
          FfiConverterOptionalSequenceString.lower(unusedFallbackKeys),
          FfiConverterString.lower(nextBatchToken),
          matrix_sdk_crypto.FfiConverterDecryptionSettings.lower(
              decryptionSettings),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  void receiveUnencryptedVerificationEvent(String event, String roomId) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_receive_unencrypted_verification_event(
        uniffiClonePointer(),
        FfiConverterString.lower(event),
        FfiConverterString.lower(roomId),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  void receiveVerificationEvent(String event, String roomId) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_receive_verification_event(
        uniffiClonePointer(),
        FfiConverterString.lower(event),
        FfiConverterString.lower(roomId),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  KeyRequestPair requestRoomKey(String event, String roomId) {
    return rustCall(
      (status) => FfiConverterKeyRequestPair.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_room_key(
          uniffiClonePointer(),
          FfiConverterString.lower(event),
          FfiConverterString.lower(roomId),
          status,
        ),
      ),
      decryptionExceptionErrorHandler,
    );
  }

  RequestVerificationResult? requestSelfVerification(List<String> methods) {
    return rustCall(
      (status) => FfiConverterOptionalRequestVerificationResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_self_verification(
          uniffiClonePointer(),
          FfiConverterSequenceString.lower(methods),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  VerificationRequest? requestVerification(
    String userId,
    String roomId,
    String eventId,
    List<String> methods,
  ) {
    return rustCall(
      (status) => FfiConverterOptionalVerificationRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_verification(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          FfiConverterString.lower(roomId),
          FfiConverterString.lower(eventId),
          FfiConverterSequenceString.lower(methods),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  RequestVerificationResult? requestVerificationWithDevice(
    String userId,
    String deviceId,
    List<String> methods,
  ) {
    return rustCall(
      (status) => FfiConverterOptionalRequestVerificationResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_verification_with_device(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          FfiConverterString.lower(deviceId),
          FfiConverterSequenceString.lower(methods),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  RoomKeyCounts roomKeyCounts() {
    return rustCall(
      (status) => FfiConverterRoomKeyCounts.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_room_key_counts(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  void saveRecoveryKey(BackupRecoveryKey? key, String? version) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_save_recovery_key(
        uniffiClonePointer(),
        FfiConverterOptionalBackupRecoveryKey.lower(key),
        FfiConverterOptionalString.lower(version),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  void setLocalTrust(String userId, String deviceId, LocalTrust trustState) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_local_trust(
        uniffiClonePointer(),
        FfiConverterString.lower(userId),
        FfiConverterString.lower(deviceId),
        FfiConverterLocalTrust.lower(trustState),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  void setOnlyAllowTrustedDevices(bool onlyAllowTrustedDevices) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_only_allow_trusted_devices(
        uniffiClonePointer(),
        FfiConverterBool.lower(onlyAllowTrustedDevices),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  void setRoomAlgorithm(String roomId, EventEncryptionAlgorithm algorithm) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_room_algorithm(
        uniffiClonePointer(),
        FfiConverterString.lower(roomId),
        FfiConverterEventEncryptionAlgorithm.lower(algorithm),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  void setRoomOnlyAllowTrustedDevices(
    String roomId,
    bool onlyAllowTrustedDevices,
  ) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_room_only_allow_trusted_devices(
        uniffiClonePointer(),
        FfiConverterString.lower(roomId),
        FfiConverterBool.lower(onlyAllowTrustedDevices),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  List<Request> shareRoomKey(
    String roomId,
    List<String> users,
    EncryptionSettings settings,
  ) {
    return rustCall(
      (status) => FfiConverterSequenceRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_share_room_key(
          uniffiClonePointer(),
          FfiConverterString.lower(roomId),
          FfiConverterSequenceString.lower(users),
          FfiConverterEncryptionSettings.lower(settings),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  Map<String, Map<String, String>> sign(String message) {
    return rustCall(
      (status) => FfiConverterMapStringMapStringString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_sign(
          uniffiClonePointer(),
          FfiConverterString.lower(message),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  StartSasResult? startSasWithDevice(String userId, String deviceId) {
    return rustCall(
      (status) => FfiConverterOptionalStartSasResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_start_sas_with_device(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          FfiConverterString.lower(deviceId),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  void updateTrackedUsers(List<String> users) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_update_tracked_users(
        uniffiClonePointer(),
        FfiConverterSequenceString.lower(users),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }

  String userId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_user_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String? verificationRequestContent(String userId, List<String> methods) {
    return rustCall(
      (status) => FfiConverterOptionalString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verification_request_content(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          FfiConverterSequenceString.lower(methods),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  SignatureVerification verifyBackup(String backupInfo) {
    return rustCall(
      (status) => FfiConverterSignatureVerification.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verify_backup(
          uniffiClonePointer(),
          FfiConverterString.lower(backupInfo),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  SignatureUploadRequest verifyDevice(String userId, String deviceId) {
    return rustCall(
      (status) => FfiConverterSignatureUploadRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verify_device(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          FfiConverterString.lower(deviceId),
          status,
        ),
      ),
      signatureExceptionErrorHandler,
    );
  }

  SignatureUploadRequest verifyIdentity(String userId) {
    return rustCall(
      (status) => FfiConverterSignatureUploadRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verify_identity(
          uniffiClonePointer(),
          FfiConverterString.lower(userId),
          status,
        ),
      ),
      signatureExceptionErrorHandler,
    );
  }
}

final _PkEncryptionFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_free_pkencryption(ptr, status),
  );
});

class PkEncryption {
  late final Pointer<Void> _ptr;
  PkEncryption._(this._ptr) {
    _PkEncryptionFinalizer.attach(this, _ptr, detach: this);
  }
  PkEncryption.fromBase64(String key)
      : _ptr = rustCall(
          (status) => _UniffiLib.instance
              .uniffi_matrix_sdk_crypto_ffi_fn_constructor_pkencryption_from_base64(
            FfiConverterString.lower(key),
            status,
          ),
          decodeExceptionErrorHandler,
        ) {
    _PkEncryptionFinalizer.attach(this, _ptr, detach: this);
  }
  factory PkEncryption.lift(Pointer<Void> ptr) {
    return PkEncryption._(ptr);
  }

  static UniffiRustCallStatusErrorHandler? get decodeExceptionErrorHandler =>
      null;
  static Pointer<Void> lower(PkEncryption value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_pkencryption(_ptr, status),
    );
  }

  static int allocationSize(PkEncryption value) {
    return 8;
  }

  static LiftRetVal<PkEncryption> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(PkEncryption.lift(pointer), 8);
  }

  static int write(PkEncryption value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _PkEncryptionFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_pkencryption(_ptr, status),
    );
  }

  PkMessage encrypt(String plaintext) {
    return rustCall(
      (status) => FfiConverterPkMessage.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_pkencryption_encrypt(
          uniffiClonePointer(),
          FfiConverterString.lower(plaintext),
          status,
        ),
      ),
      null,
    );
  }
}

final _QrCodeFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_free_qrcode(
      ptr,
      status,
    ),
  );
});

class QrCode {
  late final Pointer<Void> _ptr;
  QrCode._(this._ptr) {
    _QrCodeFinalizer.attach(this, _ptr, detach: this);
  }
  factory QrCode.lift(Pointer<Void> ptr) {
    return QrCode._(ptr);
  }
  static Pointer<Void> lower(QrCode value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_qrcode(_ptr, status),
    );
  }

  static int allocationSize(QrCode value) {
    return 8;
  }

  static LiftRetVal<QrCode> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(QrCode.lift(pointer), 8);
  }

  static int write(QrCode value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _QrCodeFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_qrcode(_ptr, status),
    );
  }

  OutgoingVerificationRequest? cancel(String cancelCode) {
    return rustCall(
      (status) => FfiConverterOptionalOutgoingVerificationRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_cancel(
          uniffiClonePointer(),
          FfiConverterString.lower(cancelCode),
          status,
        ),
      ),
      null,
    );
  }

  CancelInfo? cancelInfo() {
    return rustCall(
      (status) => FfiConverterOptionalCancelInfo.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_cancel_info(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  ConfirmVerificationResult? confirm() {
    return rustCall(
      (status) => FfiConverterOptionalConfirmVerificationResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_confirm(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String flowId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_flow_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String? generateQrCode() {
    return rustCall(
      (status) => FfiConverterOptionalString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_generate_qr_code(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool hasBeenScanned() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_has_been_scanned(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool isCancelled() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_is_cancelled(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool isDone() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_is_done(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String otherDeviceId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_other_device_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String otherUserId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_other_user_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool reciprocated() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_reciprocated(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String? roomId() {
    return rustCall(
      (status) => FfiConverterOptionalString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_room_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  void setChangesListener(QrCodeListener listener) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_set_changes_listener(
        uniffiClonePointer(),
        FfiConverterCallbackInterfaceQrCodeListener.lower(listener),
        status,
      );
    }, null);
  }

  QrCodeState state() {
    return rustCall(
      (status) => FfiConverterQrCodeState.lift(
        _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_state(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool weStarted() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_we_started(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }
}

final _RehydratedDeviceFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_free_rehydrateddevice(ptr, status),
  );
});

class RehydratedDevice {
  late final Pointer<Void> _ptr;
  RehydratedDevice._(this._ptr) {
    _RehydratedDeviceFinalizer.attach(this, _ptr, detach: this);
  }
  factory RehydratedDevice.lift(Pointer<Void> ptr) {
    return RehydratedDevice._(ptr);
  }
  static Pointer<Void> lower(RehydratedDevice value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_rehydrateddevice(_ptr, status),
    );
  }

  static int allocationSize(RehydratedDevice value) {
    return 8;
  }

  static LiftRetVal<RehydratedDevice> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(RehydratedDevice.lift(pointer), 8);
  }

  static int write(RehydratedDevice value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _RehydratedDeviceFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_rehydrateddevice(_ptr, status),
    );
  }

  void receiveEvents(String events, DecryptionSettings decryptionSettings) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_rehydrateddevice_receive_events(
        uniffiClonePointer(),
        FfiConverterString.lower(events),
        matrix_sdk_crypto.FfiConverterDecryptionSettings.lower(
            decryptionSettings),
        status,
      );
    }, cryptoStoreExceptionErrorHandler);
  }
}

final _SasFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_free_sas(
      ptr,
      status,
    ),
  );
});

class Sas {
  late final Pointer<Void> _ptr;
  Sas._(this._ptr) {
    _SasFinalizer.attach(this, _ptr, detach: this);
  }
  factory Sas.lift(Pointer<Void> ptr) {
    return Sas._(ptr);
  }
  static Pointer<Void> lower(Sas value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_clone_sas(
        _ptr,
        status,
      ),
    );
  }

  static int allocationSize(Sas value) {
    return 8;
  }

  static LiftRetVal<Sas> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(Sas.lift(pointer), 8);
  }

  static int write(Sas value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _SasFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_free_sas(
        _ptr,
        status,
      ),
    );
  }

  OutgoingVerificationRequest? accept() {
    return rustCall(
      (status) => FfiConverterOptionalOutgoingVerificationRequest.lift(
        _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_method_sas_accept(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  OutgoingVerificationRequest? cancel(String cancelCode) {
    return rustCall(
      (status) => FfiConverterOptionalOutgoingVerificationRequest.lift(
        _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_method_sas_cancel(
          uniffiClonePointer(),
          FfiConverterString.lower(cancelCode),
          status,
        ),
      ),
      null,
    );
  }

  ConfirmVerificationResult? confirm() {
    return rustCall(
      (status) => FfiConverterOptionalConfirmVerificationResult.lift(
        _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_method_sas_confirm(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  String flowId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_method_sas_flow_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  List<int>? getDecimals() {
    return rustCall(
      (status) => FfiConverterOptionalSequenceInt32.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_sas_get_decimals(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  List<int>? getEmojiIndices() {
    return rustCall(
      (status) => FfiConverterOptionalSequenceInt32.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_sas_get_emoji_indices(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool isDone() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_method_sas_is_done(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String otherDeviceId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_sas_other_device_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String otherUserId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_sas_other_user_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String? roomId() {
    return rustCall(
      (status) => FfiConverterOptionalString.lift(
        _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_method_sas_room_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  void setChangesListener(SasListener listener) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_sas_set_changes_listener(
        uniffiClonePointer(),
        FfiConverterCallbackInterfaceSasListener.lower(listener),
        status,
      );
    }, null);
  }

  SasState state() {
    return rustCall(
      (status) => FfiConverterSasState.lift(
        _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_method_sas_state(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool weStarted() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_sas_we_started(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }
}

final _VerificationFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_free_verification(ptr, status),
  );
});

class Verification {
  late final Pointer<Void> _ptr;
  Verification._(this._ptr) {
    _VerificationFinalizer.attach(this, _ptr, detach: this);
  }
  factory Verification.lift(Pointer<Void> ptr) {
    return Verification._(ptr);
  }
  static Pointer<Void> lower(Verification value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_verification(_ptr, status),
    );
  }

  static int allocationSize(Verification value) {
    return 8;
  }

  static LiftRetVal<Verification> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(Verification.lift(pointer), 8);
  }

  static int write(Verification value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _VerificationFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_verification(_ptr, status),
    );
  }

  QrCode? asQr() {
    return rustCall(
      (status) => FfiConverterOptionalQrCode.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verification_as_qr(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  Sas? asSas() {
    return rustCall(
      (status) => FfiConverterOptionalSas.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verification_as_sas(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }
}

final _VerificationRequestFinalizer = Finalizer<Pointer<Void>>((ptr) {
  rustCall(
    (status) => _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_free_verificationrequest(ptr, status),
  );
});

class VerificationRequest {
  late final Pointer<Void> _ptr;
  VerificationRequest._(this._ptr) {
    _VerificationRequestFinalizer.attach(this, _ptr, detach: this);
  }
  factory VerificationRequest.lift(Pointer<Void> ptr) {
    return VerificationRequest._(ptr);
  }
  static Pointer<Void> lower(VerificationRequest value) {
    return value.uniffiClonePointer();
  }

  Pointer<Void> uniffiClonePointer() {
    return rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_clone_verificationrequest(
        _ptr,
        status,
      ),
    );
  }

  static int allocationSize(VerificationRequest value) {
    return 8;
  }

  static LiftRetVal<VerificationRequest> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    final pointer = Pointer<Void>.fromAddress(handle);
    return LiftRetVal(VerificationRequest.lift(pointer), 8);
  }

  static int write(VerificationRequest value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle.address);
    return 8;
  }

  void dispose() {
    _VerificationRequestFinalizer.detach(this);
    rustCall(
      (status) => _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_free_verificationrequest(
        _ptr,
        status,
      ),
    );
  }

  OutgoingVerificationRequest? accept(List<String> methods) {
    return rustCall(
      (status) => FfiConverterOptionalOutgoingVerificationRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_accept(
          uniffiClonePointer(),
          FfiConverterSequenceString.lower(methods),
          status,
        ),
      ),
      null,
    );
  }

  OutgoingVerificationRequest? cancel() {
    return rustCall(
      (status) => FfiConverterOptionalOutgoingVerificationRequest.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_cancel(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  CancelInfo? cancelInfo() {
    return rustCall(
      (status) => FfiConverterOptionalCancelInfo.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_cancel_info(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String flowId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_flow_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool isCancelled() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_cancelled(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool isDone() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_done(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool isPassive() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_passive(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool isReady() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_ready(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String? otherDeviceId() {
    return rustCall(
      (status) => FfiConverterOptionalString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_other_device_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String otherUserId() {
    return rustCall(
      (status) => FfiConverterString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_other_user_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  List<String>? ourSupportedMethods() {
    return rustCall(
      (status) => FfiConverterOptionalSequenceString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_our_supported_methods(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  String? roomId() {
    return rustCall(
      (status) => FfiConverterOptionalString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_room_id(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  ScanResult? scanQrCode(String data) {
    return rustCall(
      (status) => FfiConverterOptionalScanResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_scan_qr_code(
          uniffiClonePointer(),
          FfiConverterString.lower(data),
          status,
        ),
      ),
      null,
    );
  }

  void setChangesListener(VerificationRequestListener listener) {
    return rustCall((status) {
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_set_changes_listener(
        uniffiClonePointer(),
        FfiConverterCallbackInterfaceVerificationRequestListener.lower(
          listener,
        ),
        status,
      );
    }, null);
  }

  QrCode? startQrVerification() {
    return rustCall(
      (status) => FfiConverterOptionalQrCode.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_start_qr_verification(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  StartSasResult? startSasVerification() {
    return rustCall(
      (status) => FfiConverterOptionalStartSasResult.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_start_sas_verification(
          uniffiClonePointer(),
          status,
        ),
      ),
      cryptoStoreExceptionErrorHandler,
    );
  }

  VerificationRequestState state() {
    return rustCall(
      (status) => FfiConverterVerificationRequestState.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_state(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  List<String>? theirSupportedMethods() {
    return rustCall(
      (status) => FfiConverterOptionalSequenceString.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_their_supported_methods(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }

  bool weStarted() {
    return rustCall(
      (status) => FfiConverterBool.lift(
        _UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_we_started(
          uniffiClonePointer(),
          status,
        ),
      ),
      null,
    );
  }
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

void checkCallStatus(
  UniffiRustCallStatusErrorHandler errorHandler,
  Pointer<RustCallStatus> status,
) {
  if (status.ref.code == CALL_SUCCESS) {
    return;
  } else if (status.ref.code == CALL_ERROR) {
    throw errorHandler.lift(status.ref.errorBuf);
  } else if (status.ref.code == CALL_UNEXPECTED_ERROR) {
    if (status.ref.errorBuf.len > 0) {
      throw UniffiInternalError.panicked(
        FfiConverterString.lift(status.ref.errorBuf),
      );
    } else {
      throw UniffiInternalError.panicked("Rust panic");
    }
  } else {
    throw UniffiInternalError.panicked(
      "Unexpected RustCallStatus code: \${status.ref.code}",
    );
  }
}

T rustCall<T>(
  T Function(Pointer<RustCallStatus>) callback, [
  UniffiRustCallStatusErrorHandler? errorHandler,
]) {
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
    return rustCall(
      (status) => _UniffiLib.instance
          .ffi_matrix_sdk_crypto_ffi_rustbuffer_alloc(size, status),
    );
  }

  static RustBuffer fromBytes(ForeignBytes bytes) {
    return rustCall(
      (status) => _UniffiLib.instance
          .ffi_matrix_sdk_crypto_ffi_rustbuffer_from_bytes(bytes, status),
    );
  }

  void free() {
    rustCall(
      (status) => _UniffiLib.instance.ffi_matrix_sdk_crypto_ffi_rustbuffer_free(
        this,
        status,
      ),
    );
  }

  RustBuffer reserve(int additionalCapacity) {
    return rustCall(
      (status) =>
          _UniffiLib.instance.ffi_matrix_sdk_crypto_ffi_rustbuffer_reserve(
        this,
        additionalCapacity,
        status,
      ),
    );
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

class FfiConverterSequenceOutgoingVerificationRequest {
  static List<OutgoingVerificationRequest> lift(RustBuffer buf) {
    return FfiConverterSequenceOutgoingVerificationRequest.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<List<OutgoingVerificationRequest>> read(Uint8List buf) {
    List<OutgoingVerificationRequest> res = [];
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final ret = FfiConverterOutgoingVerificationRequest.read(
        Uint8List.view(buf.buffer, offset),
      );
      offset += ret.bytesRead;
      res.add(ret.value);
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(List<OutgoingVerificationRequest> value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset += FfiConverterOutgoingVerificationRequest.write(
        value[i],
        Uint8List.view(buf.buffer, offset),
      );
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(List<OutgoingVerificationRequest> value) {
    return value
            .map(
              (l) => FfiConverterOutgoingVerificationRequest.allocationSize(l),
            )
            .fold(0, (a, b) => a + b) +
        4;
  }

  static RustBuffer lower(List<OutgoingVerificationRequest> value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterOptionalQrCode {
  static QrCode? lift(RustBuffer buf) {
    return FfiConverterOptionalQrCode.read(buf.asUint8List()).value;
  }

  static LiftRetVal<QrCode?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = QrCode.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<QrCode?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([QrCode? value]) {
    if (value == null) {
      return 1;
    }
    return QrCode.allocationSize(value) + 1;
  }

  static RustBuffer lower(QrCode? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalQrCode.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalQrCode.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(QrCode? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return QrCode.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class MapStringMapStringString {
  static Map lift(RustBuffer buf) {
    return MapStringMapStringString.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Map> read(Uint8List buf) {
    Map res = {};
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final k = FfiConverterString.read(Uint8List.view(buf.buffer, offset));
      offset += k.bytesRead;
      final v = FfiConverterMapStringString.read(
        Uint8List.view(buf.buffer, offset),
      );
      offset += v.bytesRead;
      res[k.value] = v.value;
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(Map value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    value.forEach((k, v) {
      offset += FfiConverterString.write(k, Uint8List.view(buf.buffer, offset));
      offset += FfiConverterMapStringString.write(
        v,
        Uint8List.view(buf.buffer, offset),
      );
    });
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(Map value) {
    int total = 4;
    value.forEach((k, v) {
      total += FfiConverterString.allocationSize(k);
      total += FfiConverterMapStringString.allocationSize(v);
    });
    return total;
  }

  static RustBuffer lower(Map value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterMapStringMapStringString {
  static LiftRetVal<Map<String, Map<String, String>>> read(Uint8List buf) {
    final lifted = MapStringMapStringString.read(buf);
    final typed = <String, Map<String, String>>{}
      ..addAll(lifted.value.cast<String, Map<String, String>>());
    return LiftRetVal(typed, lifted.bytesRead);
  }

  static int write(Map<String, Map<String, String>> value, Uint8List buf) {
    return MapStringMapStringString.write(value, buf);
  }

  static int allocationSize(Map<String, Map<String, String>> value) {
    return MapStringMapStringString.allocationSize(value);
  }

  static RustBuffer lower(Map<String, Map<String, String>> value) {
    return MapStringMapStringString.lower(value);
  }

  static Map<String, Map<String, String>> lift(RustBuffer rustBuffer) {
    return FfiConverterMapStringMapStringString.read(rustBuffer.asUint8List())
        .value;
  }
}

class FfiConverterOptionalPassphraseInfo {
  static PassphraseInfo? lift(RustBuffer buf) {
    return FfiConverterOptionalPassphraseInfo.read(buf.asUint8List()).value;
  }

  static LiftRetVal<PassphraseInfo?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterPassphraseInfo.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<PassphraseInfo?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([PassphraseInfo? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterPassphraseInfo.allocationSize(value) + 1;
  }

  static RustBuffer lower(PassphraseInfo? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalPassphraseInfo.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalPassphraseInfo.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(PassphraseInfo? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterPassphraseInfo.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

abstract class ProgressListener {
  void onProgress(int progress, int total);
}

class FfiConverterCallbackInterfaceProgressListener {
  static final _handleMap = UniffiHandleMap<ProgressListener>();
  static bool _vtableInitialized = false;
  static ProgressListener lift(int handle) {
    return _handleMap.get(handle);
  }

  static int lower(ProgressListener value) {
    _ensureVTableInitialized();
    return _handleMap.insert(value);
  }

  static void _ensureVTableInitialized() {
    if (!_vtableInitialized) {
      initProgressListenerVTable();
      _vtableInitialized = true;
    }
  }

  static LiftRetVal<ProgressListener> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    return LiftRetVal(lift(handle), 8);
  }

  static int write(ProgressListener value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle);
    return 8;
  }

  static int allocationSize(ProgressListener value) {
    return 8;
  }
}

typedef UniffiCallbackInterfaceProgressListenerMethod0 = Void Function(
    Uint64, Int32, Int32, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceProgressListenerMethod0Dart = void Function(
    int, int, int, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceProgressListenerFree = Void Function(Uint64);
typedef UniffiCallbackInterfaceProgressListenerFreeDart = void Function(int);

final class UniffiVTableCallbackInterfaceProgressListener extends Struct {
  external Pointer<
          NativeFunction<UniffiCallbackInterfaceProgressListenerMethod0>>
      onProgress;
  external Pointer<NativeFunction<UniffiCallbackInterfaceProgressListenerFree>>
      uniffiFree;
}

void progressListenerOnProgress(
  int uniffiHandle,
  int progress,
  int total,
  Pointer<Void> outReturn,
  Pointer<RustCallStatus> callStatus,
) {
  final status = callStatus.ref;
  try {
    final obj = FfiConverterCallbackInterfaceProgressListener._handleMap.get(
      uniffiHandle,
    );
    final arg0 = FfiConverterInt32.lift(progress);
    final arg1 = FfiConverterInt32.lift(total);
    obj.onProgress(arg0, arg1);
    status.code = CALL_SUCCESS;
  } catch (e) {
    status.code = CALL_UNEXPECTED_ERROR;
    status.errorBuf = FfiConverterString.lower(e.toString());
  }
}

final Pointer<NativeFunction<UniffiCallbackInterfaceProgressListenerMethod0>>
    progressListenerOnProgressPointer =
    Pointer.fromFunction<UniffiCallbackInterfaceProgressListenerMethod0>(
  progressListenerOnProgress,
);
void progressListenerFreeCallback(int handle) {
  try {
    FfiConverterCallbackInterfaceProgressListener._handleMap.remove(handle);
  } catch (e) {}
}

final Pointer<NativeFunction<UniffiCallbackInterfaceProgressListenerFree>>
    progressListenerFreePointer =
    Pointer.fromFunction<UniffiCallbackInterfaceProgressListenerFree>(
  progressListenerFreeCallback,
);
late final Pointer<UniffiVTableCallbackInterfaceProgressListener>
    progressListenerVTable;
void initProgressListenerVTable() {
  if (FfiConverterCallbackInterfaceProgressListener._vtableInitialized) {
    return;
  }
  progressListenerVTable =
      calloc<UniffiVTableCallbackInterfaceProgressListener>();
  progressListenerVTable.ref.onProgress = progressListenerOnProgressPointer;
  progressListenerVTable.ref.uniffiFree = progressListenerFreePointer;
  rustCall((status) {
    _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_progresslistener(
      progressListenerVTable,
    );
    checkCallStatus(NullRustCallStatusErrorHandler(), status);
  });
  FfiConverterCallbackInterfaceProgressListener._vtableInitialized = true;
}

class FfiConverterOptionalSignatureUploadRequest {
  static SignatureUploadRequest? lift(RustBuffer buf) {
    return FfiConverterOptionalSignatureUploadRequest.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<SignatureUploadRequest?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterSignatureUploadRequest.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<SignatureUploadRequest?>(
      result.value,
      result.bytesRead + 1,
    );
  }

  static int allocationSize([SignatureUploadRequest? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterSignatureUploadRequest.allocationSize(value) + 1;
  }

  static RustBuffer lower(SignatureUploadRequest? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalSignatureUploadRequest.allocationSize(
      value,
    );
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalSignatureUploadRequest.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(SignatureUploadRequest? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterSignatureUploadRequest.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalDehydratedDeviceKey {
  static DehydratedDeviceKey? lift(RustBuffer buf) {
    return FfiConverterOptionalDehydratedDeviceKey.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<DehydratedDeviceKey?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterDehydratedDeviceKey.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<DehydratedDeviceKey?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([DehydratedDeviceKey? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterDehydratedDeviceKey.allocationSize(value) + 1;
  }

  static RustBuffer lower(DehydratedDeviceKey? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalDehydratedDeviceKey.allocationSize(
      value,
    );
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalDehydratedDeviceKey.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(DehydratedDeviceKey? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterDehydratedDeviceKey.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterUint8List {
  static Uint8List lift(RustBuffer value) {
    return FfiConverterUint8List.read(value.asUint8List()).value;
  }

  static LiftRetVal<Uint8List> read(Uint8List buf) {
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    final bytes = Uint8List.view(buf.buffer, buf.offsetInBytes + 4, length);
    return LiftRetVal(bytes, length + 4);
  }

  static RustBuffer lower(Uint8List value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }

  static int allocationSize([Uint8List? value]) {
    if (value == null) {
      return 4;
    }
    return 4 + value.length;
  }

  static int write(Uint8List value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    buf.setRange(offset, offset + value.length, value);
    return 4 + value.length;
  }
}

class FfiConverterSequenceVerificationRequest {
  static List<VerificationRequest> lift(RustBuffer buf) {
    return FfiConverterSequenceVerificationRequest.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<List<VerificationRequest>> read(Uint8List buf) {
    List<VerificationRequest> res = [];
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final ret = VerificationRequest.read(Uint8List.view(buf.buffer, offset));
      offset += ret.bytesRead;
      res.add(ret.value);
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(List<VerificationRequest> value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset += VerificationRequest.write(
        value[i],
        Uint8List.view(buf.buffer, offset),
      );
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(List<VerificationRequest> value) {
    return value
            .map((l) => VerificationRequest.allocationSize(l))
            .fold(0, (a, b) => a + b) +
        4;
  }

  static RustBuffer lower(List<VerificationRequest> value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterOptionalBackupRecoveryKey {
  static BackupRecoveryKey? lift(RustBuffer buf) {
    return FfiConverterOptionalBackupRecoveryKey.read(buf.asUint8List()).value;
  }

  static LiftRetVal<BackupRecoveryKey?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = BackupRecoveryKey.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<BackupRecoveryKey?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([BackupRecoveryKey? value]) {
    if (value == null) {
      return 1;
    }
    return BackupRecoveryKey.allocationSize(value) + 1;
  }

  static RustBuffer lower(BackupRecoveryKey? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalBackupRecoveryKey.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalBackupRecoveryKey.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(BackupRecoveryKey? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return BackupRecoveryKey.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalSequenceString {
  static List<String>? lift(RustBuffer buf) {
    return FfiConverterOptionalSequenceString.read(buf.asUint8List()).value;
  }

  static LiftRetVal<List<String>?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterSequenceString.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<List<String>?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([List<String>? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterSequenceString.allocationSize(value) + 1;
  }

  static RustBuffer lower(List<String>? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalSequenceString.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalSequenceString.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(List<String>? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterSequenceString.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

abstract class Logger {
  void log(String logLine);
}

class FfiConverterCallbackInterfaceLogger {
  static final _handleMap = UniffiHandleMap<Logger>();
  static bool _vtableInitialized = false;
  static Logger lift(int handle) {
    return _handleMap.get(handle);
  }

  static int lower(Logger value) {
    _ensureVTableInitialized();
    return _handleMap.insert(value);
  }

  static void _ensureVTableInitialized() {
    if (!_vtableInitialized) {
      initLoggerVTable();
      _vtableInitialized = true;
    }
  }

  static LiftRetVal<Logger> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    return LiftRetVal(lift(handle), 8);
  }

  static int write(Logger value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle);
    return 8;
  }

  static int allocationSize(Logger value) {
    return 8;
  }
}

typedef UniffiCallbackInterfaceLoggerMethod0 = Void Function(
    Uint64, RustBuffer, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceLoggerMethod0Dart = void Function(
    int, RustBuffer, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceLoggerFree = Void Function(Uint64);
typedef UniffiCallbackInterfaceLoggerFreeDart = void Function(int);

final class UniffiVTableCallbackInterfaceLogger extends Struct {
  external Pointer<NativeFunction<UniffiCallbackInterfaceLoggerMethod0>> log;
  external Pointer<NativeFunction<UniffiCallbackInterfaceLoggerFree>>
      uniffiFree;
}

void loggerLog(
  int uniffiHandle,
  RustBuffer logLineBuffer,
  Pointer<Void> outReturn,
  Pointer<RustCallStatus> callStatus,
) {
  final status = callStatus.ref;
  try {
    final obj = FfiConverterCallbackInterfaceLogger._handleMap.get(
      uniffiHandle,
    );
    final arg0 = FfiConverterString.lift(logLineBuffer);
    obj.log(arg0);
    status.code = CALL_SUCCESS;
  } catch (e) {
    status.code = CALL_UNEXPECTED_ERROR;
    status.errorBuf = FfiConverterString.lower(e.toString());
  }
}

final Pointer<NativeFunction<UniffiCallbackInterfaceLoggerMethod0>>
    loggerLogPointer =
    Pointer.fromFunction<UniffiCallbackInterfaceLoggerMethod0>(
  loggerLog,
);
void loggerFreeCallback(int handle) {
  try {
    FfiConverterCallbackInterfaceLogger._handleMap.remove(handle);
  } catch (e) {}
}

final Pointer<NativeFunction<UniffiCallbackInterfaceLoggerFree>>
    loggerFreePointer = Pointer.fromFunction<UniffiCallbackInterfaceLoggerFree>(
  loggerFreeCallback,
);
late final Pointer<UniffiVTableCallbackInterfaceLogger> loggerVTable;
void initLoggerVTable() {
  if (FfiConverterCallbackInterfaceLogger._vtableInitialized) {
    return;
  }
  loggerVTable = calloc<UniffiVTableCallbackInterfaceLogger>();
  loggerVTable.ref.log = loggerLogPointer;
  loggerVTable.ref.uniffiFree = loggerFreePointer;
  rustCall((status) {
    _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_logger(
      loggerVTable,
    );
    checkCallStatus(NullRustCallStatusErrorHandler(), status);
  });
  FfiConverterCallbackInterfaceLogger._vtableInitialized = true;
}

class FfiConverterOptionalConfirmVerificationResult {
  static ConfirmVerificationResult? lift(RustBuffer buf) {
    return FfiConverterOptionalConfirmVerificationResult.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<ConfirmVerificationResult?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterConfirmVerificationResult.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<ConfirmVerificationResult?>(
      result.value,
      result.bytesRead + 1,
    );
  }

  static int allocationSize([ConfirmVerificationResult? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterConfirmVerificationResult.allocationSize(value) + 1;
  }

  static RustBuffer lower(ConfirmVerificationResult? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalConfirmVerificationResult.allocationSize(
      value,
    );
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalConfirmVerificationResult.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(ConfirmVerificationResult? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterConfirmVerificationResult.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterSequenceRequest {
  static List<Request> lift(RustBuffer buf) {
    return FfiConverterSequenceRequest.read(buf.asUint8List()).value;
  }

  static LiftRetVal<List<Request>> read(Uint8List buf) {
    List<Request> res = [];
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final ret = FfiConverterRequest.read(Uint8List.view(buf.buffer, offset));
      offset += ret.bytesRead;
      res.add(ret.value);
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(List<Request> value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset += FfiConverterRequest.write(
        value[i],
        Uint8List.view(buf.buffer, offset),
      );
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(List<Request> value) {
    return value
            .map((l) => FfiConverterRequest.allocationSize(l))
            .fold(0, (a, b) => a + b) +
        4;
  }

  static RustBuffer lower(List<Request> value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterOptionalDevice {
  static Device? lift(RustBuffer buf) {
    return FfiConverterOptionalDevice.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Device?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterDevice.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<Device?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([Device? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterDevice.allocationSize(value) + 1;
  }

  static RustBuffer lower(Device? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalDevice.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalDevice.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(Device? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterDevice.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterInt64 {
  static int lift(int value) => value;
  static LiftRetVal<int> read(Uint8List buf) {
    return LiftRetVal(buf.buffer.asByteData(buf.offsetInBytes).getInt64(0), 8);
  }

  static int lower(int value) => value;
  static int allocationSize([int value = 0]) {
    return 8;
  }

  static int write(int value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, value);
    return FfiConverterInt64.allocationSize();
  }
}

class FfiConverterOptionalUserIdentity {
  static UserIdentity? lift(RustBuffer buf) {
    return FfiConverterOptionalUserIdentity.read(buf.asUint8List()).value;
  }

  static LiftRetVal<UserIdentity?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterUserIdentity.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<UserIdentity?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([UserIdentity? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterUserIdentity.allocationSize(value) + 1;
  }

  static RustBuffer lower(UserIdentity? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalUserIdentity.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalUserIdentity.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(UserIdentity? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterUserIdentity.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalOutgoingVerificationRequest {
  static OutgoingVerificationRequest? lift(RustBuffer buf) {
    return FfiConverterOptionalOutgoingVerificationRequest.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<OutgoingVerificationRequest?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterOutgoingVerificationRequest.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<OutgoingVerificationRequest?>(
      result.value,
      result.bytesRead + 1,
    );
  }

  static int allocationSize([OutgoingVerificationRequest? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterOutgoingVerificationRequest.allocationSize(value) + 1;
  }

  static RustBuffer lower(OutgoingVerificationRequest? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length =
        FfiConverterOptionalOutgoingVerificationRequest.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalOutgoingVerificationRequest.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(OutgoingVerificationRequest? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterOutgoingVerificationRequest.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterSequenceDevice {
  static List<Device> lift(RustBuffer buf) {
    return FfiConverterSequenceDevice.read(buf.asUint8List()).value;
  }

  static LiftRetVal<List<Device>> read(Uint8List buf) {
    List<Device> res = [];
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final ret = FfiConverterDevice.read(Uint8List.view(buf.buffer, offset));
      offset += ret.bytesRead;
      res.add(ret.value);
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(List<Device> value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset += FfiConverterDevice.write(
        value[i],
        Uint8List.view(buf.buffer, offset),
      );
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(List<Device> value) {
    return value
            .map((l) => FfiConverterDevice.allocationSize(l))
            .fold(0, (a, b) => a + b) +
        4;
  }

  static RustBuffer lower(List<Device> value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterOptionalVerificationRequest {
  static VerificationRequest? lift(RustBuffer buf) {
    return FfiConverterOptionalVerificationRequest.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<VerificationRequest?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = VerificationRequest.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<VerificationRequest?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([VerificationRequest? value]) {
    if (value == null) {
      return 1;
    }
    return VerificationRequest.allocationSize(value) + 1;
  }

  static RustBuffer lower(VerificationRequest? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalVerificationRequest.allocationSize(
      value,
    );
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalVerificationRequest.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(VerificationRequest? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return VerificationRequest.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalSas {
  static Sas? lift(RustBuffer buf) {
    return FfiConverterOptionalSas.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Sas?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = Sas.read(Uint8List.view(buf.buffer, buf.offsetInBytes + 1));
    return LiftRetVal<Sas?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([Sas? value]) {
    if (value == null) {
      return 1;
    }
    return Sas.allocationSize(value) + 1;
  }

  static RustBuffer lower(Sas? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalSas.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalSas.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(Sas? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return Sas.write(value, Uint8List.view(buf.buffer, buf.offsetInBytes + 1)) +
        1;
  }
}

class MapStringRoomSettings {
  static Map lift(RustBuffer buf) {
    return MapStringRoomSettings.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Map> read(Uint8List buf) {
    Map res = {};
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final k = FfiConverterString.read(Uint8List.view(buf.buffer, offset));
      offset += k.bytesRead;
      final v = FfiConverterRoomSettings.read(
        Uint8List.view(buf.buffer, offset),
      );
      offset += v.bytesRead;
      res[k.value] = v.value;
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(Map value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    value.forEach((k, v) {
      offset += FfiConverterString.write(k, Uint8List.view(buf.buffer, offset));
      offset += FfiConverterRoomSettings.write(
        v,
        Uint8List.view(buf.buffer, offset),
      );
    });
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(Map value) {
    int total = 4;
    value.forEach((k, v) {
      total += FfiConverterString.allocationSize(k);
      total += FfiConverterRoomSettings.allocationSize(v);
    });
    return total;
  }

  static RustBuffer lower(Map value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterMapStringRoomSettings {
  static LiftRetVal<Map<String, RoomSettings>> read(Uint8List buf) {
    final lifted = MapStringRoomSettings.read(buf);
    final typed = <String, RoomSettings>{}
      ..addAll(lifted.value.cast<String, RoomSettings>());
    return LiftRetVal(typed, lifted.bytesRead);
  }

  static int write(Map<String, RoomSettings> value, Uint8List buf) {
    return MapStringRoomSettings.write(value, buf);
  }

  static int allocationSize(Map<String, RoomSettings> value) {
    return MapStringRoomSettings.allocationSize(value);
  }

  static RustBuffer lower(Map<String, RoomSettings> value) {
    return MapStringRoomSettings.lower(value);
  }
}

class FfiConverterOptionalStartSasResult {
  static StartSasResult? lift(RustBuffer buf) {
    return FfiConverterOptionalStartSasResult.read(buf.asUint8List()).value;
  }

  static LiftRetVal<StartSasResult?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterStartSasResult.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<StartSasResult?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([StartSasResult? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterStartSasResult.allocationSize(value) + 1;
  }

  static RustBuffer lower(StartSasResult? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalStartSasResult.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalStartSasResult.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(StartSasResult? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterStartSasResult.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

abstract class VerificationRequestListener {
  void onChange(VerificationRequestState state);
}

class FfiConverterCallbackInterfaceVerificationRequestListener {
  static final _handleMap = UniffiHandleMap<VerificationRequestListener>();
  static bool _vtableInitialized = false;
  static VerificationRequestListener lift(int handle) {
    return _handleMap.get(handle);
  }

  static int lower(VerificationRequestListener value) {
    _ensureVTableInitialized();
    return _handleMap.insert(value);
  }

  static void _ensureVTableInitialized() {
    if (!_vtableInitialized) {
      initVerificationRequestListenerVTable();
      _vtableInitialized = true;
    }
  }

  static LiftRetVal<VerificationRequestListener> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    return LiftRetVal(lift(handle), 8);
  }

  static int write(VerificationRequestListener value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle);
    return 8;
  }

  static int allocationSize(VerificationRequestListener value) {
    return 8;
  }
}

typedef UniffiCallbackInterfaceVerificationRequestListenerMethod0 = Void
    Function(Uint64, RustBuffer, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceVerificationRequestListenerMethod0Dart = void
    Function(int, int, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceVerificationRequestListenerFree = Void Function(
    Uint64);
typedef UniffiCallbackInterfaceVerificationRequestListenerFreeDart = void
    Function(int);

final class UniffiVTableCallbackInterfaceVerificationRequestListener
    extends Struct {
  external Pointer<
      NativeFunction<
          UniffiCallbackInterfaceVerificationRequestListenerMethod0>> onChange;
  external Pointer<
      NativeFunction<
          UniffiCallbackInterfaceVerificationRequestListenerFree>> uniffiFree;
}

void verificationRequestListenerOnChange(
  int uniffiHandle,
  RustBuffer state,
  Pointer<Void> outReturn,
  Pointer<RustCallStatus> callStatus,
) {
  final status = callStatus.ref;
  try {
    final obj = FfiConverterCallbackInterfaceVerificationRequestListener
        ._handleMap
        .get(uniffiHandle);
    obj.onChange(FfiConverterVerificationRequestState.lift(state));
    status.code = CALL_SUCCESS;
  } catch (e) {
    status.code = CALL_UNEXPECTED_ERROR;
    status.errorBuf = FfiConverterString.lower(e.toString());
  }
}

final Pointer<
        NativeFunction<
            UniffiCallbackInterfaceVerificationRequestListenerMethod0>>
    verificationRequestListenerOnChangePointer = Pointer.fromFunction<
            UniffiCallbackInterfaceVerificationRequestListenerMethod0>(
        verificationRequestListenerOnChange);
void verificationRequestListenerFreeCallback(int handle) {
  try {
    FfiConverterCallbackInterfaceVerificationRequestListener._handleMap.remove(
      handle,
    );
  } catch (e) {}
}

final Pointer<
        NativeFunction<UniffiCallbackInterfaceVerificationRequestListenerFree>>
    verificationRequestListenerFreePointer = Pointer.fromFunction<
            UniffiCallbackInterfaceVerificationRequestListenerFree>(
        verificationRequestListenerFreeCallback);
late final Pointer<UniffiVTableCallbackInterfaceVerificationRequestListener>
    verificationRequestListenerVTable;
void initVerificationRequestListenerVTable() {
  if (FfiConverterCallbackInterfaceVerificationRequestListener
      ._vtableInitialized) {
    return;
  }
  verificationRequestListenerVTable =
      calloc<UniffiVTableCallbackInterfaceVerificationRequestListener>();
  verificationRequestListenerVTable.ref.onChange =
      verificationRequestListenerOnChangePointer;
  verificationRequestListenerVTable.ref.uniffiFree =
      verificationRequestListenerFreePointer;
  rustCall((status) {
    _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_verificationrequestlistener(
      verificationRequestListenerVTable,
    );
    checkCallStatus(NullRustCallStatusErrorHandler(), status);
  });
  FfiConverterCallbackInterfaceVerificationRequestListener._vtableInitialized =
      true;
}

class MapStringSignatureState {
  static Map lift(RustBuffer buf) {
    return MapStringSignatureState.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Map> read(Uint8List buf) {
    Map res = {};
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final k = FfiConverterString.read(Uint8List.view(buf.buffer, offset));
      offset += k.bytesRead;
      final v = FfiConverterSignatureState.read(
        Uint8List.view(buf.buffer, offset),
      );
      offset += v.bytesRead;
      res[k.value] = v.value;
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(Map value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    value.forEach((k, v) {
      offset += FfiConverterString.write(k, Uint8List.view(buf.buffer, offset));
      offset += FfiConverterSignatureState.write(
        v,
        Uint8List.view(buf.buffer, offset),
      );
    });
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(Map value) {
    int total = 4;
    value.forEach((k, v) {
      total += FfiConverterString.allocationSize(k);
      total += FfiConverterSignatureState.allocationSize(v);
    });
    return total;
  }

  static RustBuffer lower(Map value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterMapStringSignatureState {
  static LiftRetVal<Map<String, SignatureState>> read(Uint8List buf) {
    final lifted = MapStringSignatureState.read(buf);
    final typed = <String, SignatureState>{}
      ..addAll(lifted.value.cast<String, SignatureState>());
    return LiftRetVal(typed, lifted.bytesRead);
  }

  static int write(Map<String, SignatureState> value, Uint8List buf) {
    return MapStringSignatureState.write(value, buf);
  }

  static int allocationSize(Map<String, SignatureState> value) {
    return MapStringSignatureState.allocationSize(value);
  }

  static RustBuffer lower(Map<String, SignatureState> value) {
    return MapStringSignatureState.lower(value);
  }
}

class FfiConverterInt32 {
  static int lift(int value) => value;
  static LiftRetVal<int> read(Uint8List buf) {
    return LiftRetVal(buf.buffer.asByteData(buf.offsetInBytes).getInt32(0), 4);
  }

  static int lower(int value) => value;
  static int allocationSize([int value = 0]) {
    return 4;
  }

  static int write(int value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value);
    return FfiConverterInt32.allocationSize();
  }
}

abstract class QrCodeListener {
  void onChange(QrCodeState state);
}

class FfiConverterCallbackInterfaceQrCodeListener {
  static final _handleMap = UniffiHandleMap<QrCodeListener>();
  static bool _vtableInitialized = false;
  static QrCodeListener lift(int handle) {
    return _handleMap.get(handle);
  }

  static int lower(QrCodeListener value) {
    _ensureVTableInitialized();
    return _handleMap.insert(value);
  }

  static void _ensureVTableInitialized() {
    if (!_vtableInitialized) {
      initQrCodeListenerVTable();
      _vtableInitialized = true;
    }
  }

  static LiftRetVal<QrCodeListener> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    return LiftRetVal(lift(handle), 8);
  }

  static int write(QrCodeListener value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle);
    return 8;
  }

  static int allocationSize(QrCodeListener value) {
    return 8;
  }
}

typedef UniffiCallbackInterfaceQrCodeListenerMethod0 = Void Function(
    Uint64, RustBuffer, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceQrCodeListenerMethod0Dart = void Function(
    int, int, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceQrCodeListenerFree = Void Function(Uint64);
typedef UniffiCallbackInterfaceQrCodeListenerFreeDart = void Function(int);

final class UniffiVTableCallbackInterfaceQrCodeListener extends Struct {
  external Pointer<NativeFunction<UniffiCallbackInterfaceQrCodeListenerMethod0>>
      onChange;
  external Pointer<NativeFunction<UniffiCallbackInterfaceQrCodeListenerFree>>
      uniffiFree;
}

void qrCodeListenerOnChange(
  int uniffiHandle,
  RustBuffer state,
  Pointer<Void> outReturn,
  Pointer<RustCallStatus> callStatus,
) {
  final status = callStatus.ref;
  try {
    final obj = FfiConverterCallbackInterfaceQrCodeListener._handleMap.get(
      uniffiHandle,
    );
    final arg0 = FfiConverterQrCodeState.lift(state);
    obj.onChange(arg0);
    status.code = CALL_SUCCESS;
  } catch (e) {
    status.code = CALL_UNEXPECTED_ERROR;
    status.errorBuf = FfiConverterString.lower(e.toString());
  }
}

final Pointer<NativeFunction<UniffiCallbackInterfaceQrCodeListenerMethod0>>
    qrCodeListenerOnChangePointer =
    Pointer.fromFunction<UniffiCallbackInterfaceQrCodeListenerMethod0>(
  qrCodeListenerOnChange,
);
void qrCodeListenerFreeCallback(int handle) {
  try {
    FfiConverterCallbackInterfaceQrCodeListener._handleMap.remove(handle);
  } catch (e) {}
}

final Pointer<NativeFunction<UniffiCallbackInterfaceQrCodeListenerFree>>
    qrCodeListenerFreePointer =
    Pointer.fromFunction<UniffiCallbackInterfaceQrCodeListenerFree>(
  qrCodeListenerFreeCallback,
);
late final Pointer<UniffiVTableCallbackInterfaceQrCodeListener>
    qrCodeListenerVTable;
void initQrCodeListenerVTable() {
  if (FfiConverterCallbackInterfaceQrCodeListener._vtableInitialized) {
    return;
  }
  qrCodeListenerVTable = calloc<UniffiVTableCallbackInterfaceQrCodeListener>();
  qrCodeListenerVTable.ref.onChange = qrCodeListenerOnChangePointer;
  qrCodeListenerVTable.ref.uniffiFree = qrCodeListenerFreePointer;
  rustCall((status) {
    _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_qrcodelistener(
      qrCodeListenerVTable,
    );
    checkCallStatus(NullRustCallStatusErrorHandler(), status);
  });
  FfiConverterCallbackInterfaceQrCodeListener._vtableInitialized = true;
}

class FfiConverterSequenceString {
  static List<String> lift(RustBuffer buf) {
    return FfiConverterSequenceString.read(buf.asUint8List()).value;
  }

  static LiftRetVal<List<String>> read(Uint8List buf) {
    List<String> res = [];
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final ret = FfiConverterString.read(Uint8List.view(buf.buffer, offset));
      offset += ret.bytesRead;
      res.add(ret.value);
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(List<String> value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset += FfiConverterString.write(
        value[i],
        Uint8List.view(buf.buffer, offset),
      );
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(List<String> value) {
    return value
            .map((l) => FfiConverterString.allocationSize(l))
            .fold(0, (a, b) => a + b) +
        4;
  }

  static RustBuffer lower(List<String> value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class MapStringString {
  static Map lift(RustBuffer buf) {
    return MapStringString.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Map> read(Uint8List buf) {
    Map res = {};
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final k = FfiConverterString.read(Uint8List.view(buf.buffer, offset));
      offset += k.bytesRead;
      final v = FfiConverterString.read(Uint8List.view(buf.buffer, offset));
      offset += v.bytesRead;
      res[k.value] = v.value;
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(Map value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    value.forEach((k, v) {
      offset += FfiConverterString.write(k, Uint8List.view(buf.buffer, offset));
      offset += FfiConverterString.write(v, Uint8List.view(buf.buffer, offset));
    });
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(Map value) {
    int total = 4;
    value.forEach((k, v) {
      total += FfiConverterString.allocationSize(k);
      total += FfiConverterString.allocationSize(v);
    });
    return total;
  }

  static RustBuffer lower(Map value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterMapStringString {
  static LiftRetVal<Map<String, String>> read(Uint8List buf) {
    final lifted = MapStringString.read(buf);
    final typed = <String, String>{}
      ..addAll(lifted.value.cast<String, String>());
    return LiftRetVal(typed, lifted.bytesRead);
  }

  static int write(Map<String, String> value, Uint8List buf) {
    return MapStringString.write(value, buf);
  }

  static int allocationSize(Map<String, String> value) {
    return MapStringString.allocationSize(value);
  }

  static RustBuffer lower(Map<String, String> value) {
    return MapStringString.lower(value);
  }

  static Map<String, String> lift(RustBuffer rustBuffer) {
    return FfiConverterMapStringString.read(rustBuffer.asUint8List()).value;
  }
}

class FfiConverterSequenceRoomKeyInfo {
  static List<RoomKeyInfo> lift(RustBuffer buf) {
    return FfiConverterSequenceRoomKeyInfo.read(buf.asUint8List()).value;
  }

  static LiftRetVal<List<RoomKeyInfo>> read(Uint8List buf) {
    List<RoomKeyInfo> res = [];
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final ret = FfiConverterRoomKeyInfo.read(
        Uint8List.view(buf.buffer, offset),
      );
      offset += ret.bytesRead;
      res.add(ret.value);
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(List<RoomKeyInfo> value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset += FfiConverterRoomKeyInfo.write(
        value[i],
        Uint8List.view(buf.buffer, offset),
      );
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(List<RoomKeyInfo> value) {
    return value
            .map((l) => FfiConverterRoomKeyInfo.allocationSize(l))
            .fold(0, (a, b) => a + b) +
        4;
  }

  static RustBuffer lower(List<RoomKeyInfo> value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterOptionalShieldStateCode {
  static ShieldStateCode? lift(RustBuffer buf) {
    return FfiConverterOptionalShieldStateCode.read(buf.asUint8List()).value;
  }

  static LiftRetVal<ShieldStateCode?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterShieldStateCode.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<ShieldStateCode?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([ShieldStateCode? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterShieldStateCode.allocationSize(value) + 1;
  }

  static RustBuffer lower(ShieldStateCode? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalShieldStateCode.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalShieldStateCode.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(ShieldStateCode? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterShieldStateCode.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalBackupKeys {
  static BackupKeys? lift(RustBuffer buf) {
    return FfiConverterOptionalBackupKeys.read(buf.asUint8List()).value;
  }

  static LiftRetVal<BackupKeys?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = BackupKeys.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<BackupKeys?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([BackupKeys? value]) {
    if (value == null) {
      return 1;
    }
    return BackupKeys.allocationSize(value) + 1;
  }

  static RustBuffer lower(BackupKeys? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalBackupKeys.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalBackupKeys.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(BackupKeys? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return BackupKeys.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalRequestVerificationResult {
  static RequestVerificationResult? lift(RustBuffer buf) {
    return FfiConverterOptionalRequestVerificationResult.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<RequestVerificationResult?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterRequestVerificationResult.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<RequestVerificationResult?>(
      result.value,
      result.bytesRead + 1,
    );
  }

  static int allocationSize([RequestVerificationResult? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterRequestVerificationResult.allocationSize(value) + 1;
  }

  static RustBuffer lower(RequestVerificationResult? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalRequestVerificationResult.allocationSize(
      value,
    );
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalRequestVerificationResult.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(RequestVerificationResult? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterRequestVerificationResult.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalScanResult {
  static ScanResult? lift(RustBuffer buf) {
    return FfiConverterOptionalScanResult.read(buf.asUint8List()).value;
  }

  static LiftRetVal<ScanResult?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterScanResult.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<ScanResult?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([ScanResult? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterScanResult.allocationSize(value) + 1;
  }

  static RustBuffer lower(ScanResult? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalScanResult.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalScanResult.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(ScanResult? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterScanResult.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalString {
  static String? lift(RustBuffer buf) {
    return FfiConverterOptionalString.read(buf.asUint8List()).value;
  }

  static LiftRetVal<String?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterString.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<String?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([String? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterString.allocationSize(value) + 1;
  }

  static RustBuffer lower(String? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalString.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalString.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(String? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterString.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalRequest {
  static Request? lift(RustBuffer buf) {
    return FfiConverterOptionalRequest.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Request?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterRequest.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<Request?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([Request? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterRequest.allocationSize(value) + 1;
  }

  static RustBuffer lower(Request? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalRequest.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalRequest.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(Request? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterRequest.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterUInt64 {
  static int lift(int value) => value;
  static LiftRetVal<int> read(Uint8List buf) {
    return LiftRetVal(buf.buffer.asByteData(buf.offsetInBytes).getUint64(0), 8);
  }

  static int lower(int value) => value;
  static int allocationSize([int value = 0]) {
    return 8;
  }

  static int write(int value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setUint64(0, value);
    return FfiConverterUInt64.allocationSize();
  }
}

class FfiConverterSequencePickledSession {
  static List<PickledSession> lift(RustBuffer buf) {
    return FfiConverterSequencePickledSession.read(buf.asUint8List()).value;
  }

  static LiftRetVal<List<PickledSession>> read(Uint8List buf) {
    List<PickledSession> res = [];
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final ret = FfiConverterPickledSession.read(
        Uint8List.view(buf.buffer, offset),
      );
      offset += ret.bytesRead;
      res.add(ret.value);
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(List<PickledSession> value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset += FfiConverterPickledSession.write(
        value[i],
        Uint8List.view(buf.buffer, offset),
      );
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(List<PickledSession> value) {
    return value
            .map((l) => FfiConverterPickledSession.allocationSize(l))
            .fold(0, (a, b) => a + b) +
        4;
  }

  static RustBuffer lower(List<PickledSession> value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class MapStringInt32 {
  static Map lift(RustBuffer buf) {
    return MapStringInt32.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Map> read(Uint8List buf) {
    Map res = {};
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final k = FfiConverterString.read(Uint8List.view(buf.buffer, offset));
      offset += k.bytesRead;
      final v = FfiConverterInt32.read(Uint8List.view(buf.buffer, offset));
      offset += v.bytesRead;
      res[k.value] = v.value;
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(Map value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    value.forEach((k, v) {
      offset += FfiConverterString.write(k, Uint8List.view(buf.buffer, offset));
      offset += FfiConverterInt32.write(v, Uint8List.view(buf.buffer, offset));
    });
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(Map value) {
    int total = 4;
    value.forEach((k, v) {
      total += FfiConverterString.allocationSize(k);
      total += FfiConverterInt32.allocationSize(v);
    });
    return total;
  }

  static RustBuffer lower(Map value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterMapStringInt32 {
  static LiftRetVal<Map<String, int>> read(Uint8List buf) {
    final lifted = MapStringInt32.read(buf);
    final typed = <String, int>{}..addAll(lifted.value.cast<String, int>());
    return LiftRetVal(typed, lifted.bytesRead);
  }

  static int write(Map<String, int> value, Uint8List buf) {
    return MapStringInt32.write(value, buf);
  }

  static int allocationSize(Map<String, int> value) {
    return MapStringInt32.allocationSize(value);
  }

  static RustBuffer lower(Map<String, int> value) {
    return MapStringInt32.lower(value);
  }
}

class FfiConverterSequenceInt32 {
  static List<int> lift(RustBuffer buf) {
    return FfiConverterSequenceInt32.read(buf.asUint8List()).value;
  }

  static LiftRetVal<List<int>> read(Uint8List buf) {
    List<int> res = [];
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final ret = FfiConverterInt32.read(Uint8List.view(buf.buffer, offset));
      offset += ret.bytesRead;
      res.add(ret.value);
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(List<int> value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset += FfiConverterInt32.write(
        value[i],
        Uint8List.view(buf.buffer, offset),
      );
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(List<int> value) {
    return value
            .map((l) => FfiConverterInt32.allocationSize(l))
            .fold(0, (a, b) => a + b) +
        4;
  }

  static RustBuffer lower(List<int> value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterUInt32 {
  static int lift(int value) => value;
  static LiftRetVal<int> read(Uint8List buf) {
    return LiftRetVal(buf.buffer.asByteData(buf.offsetInBytes).getUint32(0), 4);
  }

  static int lower(int value) => value;
  static int allocationSize([int value = 0]) {
    return 4;
  }

  static int write(int value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setUint32(0, value);
    return FfiConverterUInt32.allocationSize();
  }
}

class FfiConverterOptionalVerification {
  static Verification? lift(RustBuffer buf) {
    return FfiConverterOptionalVerification.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Verification?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = Verification.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<Verification?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([Verification? value]) {
    if (value == null) {
      return 1;
    }
    return Verification.allocationSize(value) + 1;
  }

  static RustBuffer lower(Verification? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalVerification.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalVerification.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(Verification? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return Verification.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

abstract class SasListener {
  void onChange(SasState state);
}

class FfiConverterCallbackInterfaceSasListener {
  static final _handleMap = UniffiHandleMap<SasListener>();
  static bool _vtableInitialized = false;
  static SasListener lift(int handle) {
    return _handleMap.get(handle);
  }

  static int lower(SasListener value) {
    _ensureVTableInitialized();
    return _handleMap.insert(value);
  }

  static void _ensureVTableInitialized() {
    if (!_vtableInitialized) {
      initSasListenerVTable();
      _vtableInitialized = true;
    }
  }

  static LiftRetVal<SasListener> read(Uint8List buf) {
    final handle = buf.buffer.asByteData(buf.offsetInBytes).getInt64(0);
    return LiftRetVal(lift(handle), 8);
  }

  static int write(SasListener value, Uint8List buf) {
    final handle = lower(value);
    buf.buffer.asByteData(buf.offsetInBytes).setInt64(0, handle);
    return 8;
  }

  static int allocationSize(SasListener value) {
    return 8;
  }
}

typedef UniffiCallbackInterfaceSasListenerMethod0 = Void Function(
    Uint64, RustBuffer, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceSasListenerMethod0Dart = void Function(
    int, int, Pointer<Void>, Pointer<RustCallStatus>);
typedef UniffiCallbackInterfaceSasListenerFree = Void Function(Uint64);
typedef UniffiCallbackInterfaceSasListenerFreeDart = void Function(int);

final class UniffiVTableCallbackInterfaceSasListener extends Struct {
  external Pointer<NativeFunction<UniffiCallbackInterfaceSasListenerMethod0>>
      onChange;
  external Pointer<NativeFunction<UniffiCallbackInterfaceSasListenerFree>>
      uniffiFree;
}

void sasListenerOnChange(
  int uniffiHandle,
  RustBuffer state,
  Pointer<Void> outReturn,
  Pointer<RustCallStatus> callStatus,
) {
  final status = callStatus.ref;
  try {
    final obj = FfiConverterCallbackInterfaceSasListener._handleMap.get(
      uniffiHandle,
    );
    final arg0 = FfiConverterSasState.lift(state);
    obj.onChange(arg0);
    status.code = CALL_SUCCESS;
  } catch (e) {
    status.code = CALL_UNEXPECTED_ERROR;
    status.errorBuf = FfiConverterString.lower(e.toString());
  }
}

final Pointer<NativeFunction<UniffiCallbackInterfaceSasListenerMethod0>>
    sasListenerOnChangePointer =
    Pointer.fromFunction<UniffiCallbackInterfaceSasListenerMethod0>(
  sasListenerOnChange,
);
void sasListenerFreeCallback(int handle) {
  try {
    FfiConverterCallbackInterfaceSasListener._handleMap.remove(handle);
  } catch (e) {}
}

final Pointer<NativeFunction<UniffiCallbackInterfaceSasListenerFree>>
    sasListenerFreePointer =
    Pointer.fromFunction<UniffiCallbackInterfaceSasListenerFree>(
  sasListenerFreeCallback,
);
late final Pointer<UniffiVTableCallbackInterfaceSasListener> sasListenerVTable;
void initSasListenerVTable() {
  if (FfiConverterCallbackInterfaceSasListener._vtableInitialized) {
    return;
  }
  sasListenerVTable = calloc<UniffiVTableCallbackInterfaceSasListener>();
  sasListenerVTable.ref.onChange = sasListenerOnChangePointer;
  sasListenerVTable.ref.uniffiFree = sasListenerFreePointer;
  rustCall((status) {
    _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_saslistener(
      sasListenerVTable,
    );
    checkCallStatus(NullRustCallStatusErrorHandler(), status);
  });
  FfiConverterCallbackInterfaceSasListener._vtableInitialized = true;
}

class FfiConverterOptionalSequenceInt32 {
  static List<int>? lift(RustBuffer buf) {
    return FfiConverterOptionalSequenceInt32.read(buf.asUint8List()).value;
  }

  static LiftRetVal<List<int>?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterSequenceInt32.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<List<int>?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([List<int>? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterSequenceInt32.allocationSize(value) + 1;
  }

  static RustBuffer lower(List<int>? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalSequenceInt32.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalSequenceInt32.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(List<int>? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterSequenceInt32.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalCrossSigningKeyExport {
  static CrossSigningKeyExport? lift(RustBuffer buf) {
    return FfiConverterOptionalCrossSigningKeyExport.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<CrossSigningKeyExport?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterCrossSigningKeyExport.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<CrossSigningKeyExport?>(
      result.value,
      result.bytesRead + 1,
    );
  }

  static int allocationSize([CrossSigningKeyExport? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterCrossSigningKeyExport.allocationSize(value) + 1;
  }

  static RustBuffer lower(CrossSigningKeyExport? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalCrossSigningKeyExport.allocationSize(
      value,
    );
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalCrossSigningKeyExport.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(CrossSigningKeyExport? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterCrossSigningKeyExport.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterOptionalCancelInfo {
  static CancelInfo? lift(RustBuffer buf) {
    return FfiConverterOptionalCancelInfo.read(buf.asUint8List()).value;
  }

  static LiftRetVal<CancelInfo?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterCancelInfo.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<CancelInfo?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([CancelInfo? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterCancelInfo.allocationSize(value) + 1;
  }

  static RustBuffer lower(CancelInfo? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalCancelInfo.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalCancelInfo.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(CancelInfo? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterCancelInfo.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
}

class FfiConverterSequencePickledInboundGroupSession {
  static List<PickledInboundGroupSession> lift(RustBuffer buf) {
    return FfiConverterSequencePickledInboundGroupSession.read(
      buf.asUint8List(),
    ).value;
  }

  static LiftRetVal<List<PickledInboundGroupSession>> read(Uint8List buf) {
    List<PickledInboundGroupSession> res = [];
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final ret = FfiConverterPickledInboundGroupSession.read(
        Uint8List.view(buf.buffer, offset),
      );
      offset += ret.bytesRead;
      res.add(ret.value);
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(List<PickledInboundGroupSession> value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < value.length; i++) {
      offset += FfiConverterPickledInboundGroupSession.write(
        value[i],
        Uint8List.view(buf.buffer, offset),
      );
    }
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(List<PickledInboundGroupSession> value) {
    return value
            .map(
              (l) => FfiConverterPickledInboundGroupSession.allocationSize(l),
            )
            .fold(0, (a, b) => a + b) +
        4;
  }

  static RustBuffer lower(List<PickledInboundGroupSession> value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterOptionalRoomSettings {
  static RoomSettings? lift(RustBuffer buf) {
    return FfiConverterOptionalRoomSettings.read(buf.asUint8List()).value;
  }

  static LiftRetVal<RoomSettings?> read(Uint8List buf) {
    if (ByteData.view(buf.buffer, buf.offsetInBytes).getInt8(0) == 0) {
      return LiftRetVal(null, 1);
    }
    final result = FfiConverterRoomSettings.read(
      Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
    );
    return LiftRetVal<RoomSettings?>(result.value, result.bytesRead + 1);
  }

  static int allocationSize([RoomSettings? value]) {
    if (value == null) {
      return 1;
    }
    return FfiConverterRoomSettings.allocationSize(value) + 1;
  }

  static RustBuffer lower(RoomSettings? value) {
    if (value == null) {
      return toRustBuffer(Uint8List.fromList([0]));
    }
    final length = FfiConverterOptionalRoomSettings.allocationSize(value);
    final Pointer<Uint8> frameData = calloc<Uint8>(length);
    final buf = frameData.asTypedList(length);
    FfiConverterOptionalRoomSettings.write(value, buf);
    final bytes = calloc<ForeignBytes>();
    bytes.ref.len = length;
    bytes.ref.data = frameData;
    return RustBuffer.fromBytes(bytes.ref);
  }

  static int write(RoomSettings? value, Uint8List buf) {
    if (value == null) {
      buf[0] = 0;
      return 1;
    }
    buf[0] = 1;
    return FfiConverterRoomSettings.write(
          value,
          Uint8List.view(buf.buffer, buf.offsetInBytes + 1),
        ) +
        1;
  }
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

  static int allocationSize([bool value = false]) {
    return 1;
  }

  static int write(bool value, Uint8List buf) {
    buf.setAll(0, [value ? 1 : 0]);
    return allocationSize();
  }
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

class MapStringMapStringSequenceString {
  static Map lift(RustBuffer buf) {
    return MapStringMapStringSequenceString.read(buf.asUint8List()).value;
  }

  static LiftRetVal<Map> read(Uint8List buf) {
    Map res = {};
    final length = buf.buffer.asByteData(buf.offsetInBytes).getInt32(0);
    int offset = buf.offsetInBytes + 4;
    for (var i = 0; i < length; i++) {
      final k = FfiConverterString.read(Uint8List.view(buf.buffer, offset));
      offset += k.bytesRead;
      final v = FfiConverterMapStringSequenceString.read(
        Uint8List.view(buf.buffer, offset),
      );
      offset += v.bytesRead;
      res[k.value] = v.value;
    }
    return LiftRetVal(res, offset - buf.offsetInBytes);
  }

  static int write(Map value, Uint8List buf) {
    buf.buffer.asByteData(buf.offsetInBytes).setInt32(0, value.length);
    int offset = buf.offsetInBytes + 4;
    value.forEach((k, v) {
      offset += FfiConverterString.write(k, Uint8List.view(buf.buffer, offset));
      offset += FfiConverterMapStringSequenceString.write(
        v,
        Uint8List.view(buf.buffer, offset),
      );
    });
    return offset - buf.offsetInBytes;
  }

  static int allocationSize(Map value) {
    int total = 4;
    value.forEach((k, v) {
      total += FfiConverterString.allocationSize(k);
      total += FfiConverterMapStringSequenceString.allocationSize(v);
    });
    return total;
  }

  static RustBuffer lower(Map value) {
    final buf = Uint8List(allocationSize(value));
    write(value, buf);
    return toRustBuffer(buf);
  }
}

class FfiConverterMapStringMapStringSequenceString {
  static LiftRetVal<Map<String, Map<String, List<String>>>> read(
    Uint8List buf,
  ) {
    final lifted = MapStringMapStringSequenceString.read(buf);
    final typed = <String, Map<String, List<String>>>{}
      ..addAll(lifted.value.cast<String, Map<String, List<String>>>());
    return LiftRetVal(typed, lifted.bytesRead);
  }

  static int write(
    Map<String, Map<String, List<String>>> value,
    Uint8List buf,
  ) {
    return MapStringMapStringSequenceString.write(value, buf);
  }

  static int allocationSize(
    Map<String, Map<String, List<String>>> value,
  ) {
    return MapStringMapStringSequenceString.allocationSize(value);
  }

  static RustBuffer lower(Map<String, Map<String, List<String>>> value) {
    return MapStringMapStringSequenceString.lower(value);
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
    Pointer<Void>,
  ) pollFunc,
  F Function(Pointer<Void>, Pointer<RustCallStatus>) completeFunc,
  void Function(Pointer<Void>) freeFunc,
  T Function(F) liftFunc, [
  UniffiRustCallStatusErrorHandler? errorHandler,
]) async {
  final rustFuture = rustFutureFunc();
  final completer = Completer<int>();
  late final NativeCallable<UniffiRustFutureContinuationCallback> callback;
  void poll() {
    pollFunc(rustFuture, callback.nativeFunction, Pointer<Void>.fromAddress(0));
  }

  void onResponse(int _idx, int pollResult) {
    if (pollResult == UNIFFI_RUST_FUTURE_POLL_READY) {
      completer.complete(pollResult);
    } else {
      poll();
    }
  }

  callback = NativeCallable<UniffiRustFutureContinuationCallback>.listener(
    onResponse,
  );
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
        UniffiInternalError.unexpectedStaleHandle,
        "Handle not found",
      );
    }
    return obj;
  }

  void remove(int handle) {
    if (_map.remove(handle) == null) {
      throw UniffiInternalError(
        UniffiInternalError.unexpectedStaleHandle,
        "Handle not found",
      );
    }
  }
}

void migrate(
  MigrationData data,
  String path,
  String? passphrase,
  ProgressListener progressListener,
) {
  return rustCall((status) {
    _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_func_migrate(
      FfiConverterMigrationData.lower(data),
      FfiConverterString.lower(path),
      FfiConverterOptionalString.lower(passphrase),
      FfiConverterCallbackInterfaceProgressListener.lower(progressListener),
      status,
    );
  }, migrationExceptionErrorHandler);
}

void migrateRoomSettings(
  Map<String, RoomSettings> roomSettings,
  String path,
  String? passphrase,
) {
  return rustCall((status) {
    _UniffiLib.instance
        .uniffi_matrix_sdk_crypto_ffi_fn_func_migrate_room_settings(
      FfiConverterMapStringRoomSettings.lower(roomSettings),
      FfiConverterString.lower(path),
      FfiConverterOptionalString.lower(passphrase),
      status,
    );
  }, migrationExceptionErrorHandler);
}

void migrateSessions(
  SessionMigrationData data,
  String path,
  String? passphrase,
  ProgressListener progressListener,
) {
  return rustCall((status) {
    _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_func_migrate_sessions(
      FfiConverterSessionMigrationData.lower(data),
      FfiConverterString.lower(path),
      FfiConverterOptionalString.lower(passphrase),
      FfiConverterCallbackInterfaceProgressListener.lower(progressListener),
      status,
    );
  }, migrationExceptionErrorHandler);
}

void setLogger(Logger logger) {
  return rustCall((status) {
    _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_func_set_logger(
      FfiConverterCallbackInterfaceLogger.lower(logger),
      status,
    );
  }, null);
}

String version() {
  return rustCall(
    (status) => FfiConverterString.lift(
      _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_func_version(status),
    ),
    null,
  );
}

VersionInfo versionInfo() {
  return rustCall(
    (status) => FfiConverterVersionInfo.lift(
      _UniffiLib.instance.uniffi_matrix_sdk_crypto_ffi_fn_func_version_info(
        status,
      ),
    ),
    null,
  );
}

String vodozemacVersion() {
  return rustCall(
    (status) => FfiConverterString.lift(
      _UniffiLib.instance
          .uniffi_matrix_sdk_crypto_ffi_fn_func_vodozemac_version(status),
    ),
    null,
  );
}

class _UniffiLib {
  _UniffiLib._();
  static final DynamicLibrary _dylib = _open();
  static DynamicLibrary _open() {
    if (Platform.isAndroid)
      return DynamicLibrary.open(
        "${Directory.current.path}/libmatrix_sdk_crypto_ffi.so",
      );
    if (Platform.isIOS) return DynamicLibrary.executable();
    if (Platform.isLinux)
      return DynamicLibrary.open(
        "${Directory.current.path}/libmatrix_sdk_crypto_ffi.so",
      );
    if (Platform.isMacOS)
      return DynamicLibrary.open("libmatrix_sdk_crypto_ffi.dylib");
    if (Platform.isWindows)
      return DynamicLibrary.open("matrix_sdk_crypto_ffi.dll");
    throw UnsupportedError(
      "Unsupported platform: \${Platform.operatingSystem}",
    );
  }

  static final _UniffiLib instance = _UniffiLib._();
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_backupkeys = _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_backupkeys");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_backupkeys = _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_backupkeys");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_backupkeys_backup_version =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_backupkeys_backup_version");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_backupkeys_recovery_key =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_backupkeys_recovery_key");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_backuprecoverykey =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_backuprecoverykey");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_backuprecoverykey =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_backuprecoverykey");
  late final Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_from_base58 =
      _dylib.lookupFunction<
          Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>),
          Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_from_base58",
  );
  late final Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_from_base64 =
      _dylib.lookupFunction<
          Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>),
          Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_from_base64",
  );
  late final Pointer<Void> Function(
    RustBuffer,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_from_passphrase =
      _dylib.lookupFunction<
          Pointer<Void> Function(
            RustBuffer,
            RustBuffer,
            Int32,
            Pointer<RustCallStatus>,
          ),
          Pointer<Void> Function(
            RustBuffer,
            RustBuffer,
            int,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_from_passphrase",
  );
  late final Pointer<Void> Function(Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_new =
      _dylib.lookupFunction<Pointer<Void> Function(Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_new");
  late final Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_new_from_passphrase =
      _dylib.lookupFunction<
          Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>),
          Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_constructor_backuprecoverykey_new_from_passphrase",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_decrypt_v1 =
      _dylib.lookupFunction<
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              ),
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_decrypt_v1");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_megolm_v1_public_key =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_megolm_v1_public_key",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_to_base58 =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_to_base58");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_to_base64 =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_backuprecoverykey_to_base64");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_dehydrateddevice =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_dehydrateddevice");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_dehydrateddevice =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_dehydrateddevice");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevice_keys_for_upload =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevice_keys_for_upload",
  );
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_dehydrateddevices =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_dehydrateddevices");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_dehydrateddevices =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_dehydrateddevices");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_create =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_create");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_delete_dehydrated_device_key =
      _dylib.lookupFunction<
          Void Function(Pointer<Void>, Pointer<RustCallStatus>),
          void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_delete_dehydrated_device_key",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_get_dehydrated_device_key =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_get_dehydrated_device_key",
  );
  late final Pointer<Void> Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_rehydrate =
      _dylib.lookupFunction<
              Pointer<Void> Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              ),
              Pointer<Void> Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_rehydrate");
  late final void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_save_dehydrated_device_key =
      _dylib.lookupFunction<
          Void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
          void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_dehydrateddevices_save_dehydrated_device_key",
  );
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_olmmachine = _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_olmmachine");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_olmmachine = _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_olmmachine");
  late final Pointer<Void> Function(
    RustBuffer,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_constructor_olmmachine_new =
      _dylib.lookupFunction<
          Pointer<Void> Function(
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          Pointer<Void> Function(
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>("uniffi_matrix_sdk_crypto_ffi_fn_constructor_olmmachine_new");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_backup_enabled =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_backup_enabled");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_backup_room_keys =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_backup_room_keys");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_bootstrap_cross_signing =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_bootstrap_cross_signing",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    matrix_sdk_crypto.RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_create_encrypted_to_device_request =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            matrix_sdk_crypto.RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            matrix_sdk_crypto.RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_create_encrypted_to_device_request",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_cross_signing_status =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_cross_signing_status",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    int,
    int,
    matrix_sdk_crypto.RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_decrypt_room_event =
      _dylib.lookupFunction<
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Int8,
                Int8,
                matrix_sdk_crypto.RustBuffer,
                Pointer<RustCallStatus>,
              ),
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                int,
                int,
                matrix_sdk_crypto.RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_decrypt_room_event");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_dehydrated_devices =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_dehydrated_devices");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_device_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_device_id");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_disable_backup =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_disable_backup");
  late final void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_discard_room_key =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              void Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_discard_room_key");
  late final void Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_enable_backup_v1 =
      _dylib.lookupFunction<
              Void Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              ),
              void Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_enable_backup_v1");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_encrypt =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>("uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_encrypt");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_export_cross_signing_keys =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_export_cross_signing_keys",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_export_room_keys =
      _dylib.lookupFunction<
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                Int32,
                Pointer<RustCallStatus>,
              ),
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                int,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_export_room_keys");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_backup_keys =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_backup_keys");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_device =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Uint32,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            int,
            Pointer<RustCallStatus>,
          )>("uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_device");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_identity =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            Uint32,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            int,
            Pointer<RustCallStatus>,
          )>("uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_identity");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_missing_sessions =
      _dylib.lookupFunction<
          RustBuffer Function(
              Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
          RustBuffer Function(
              Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_missing_sessions",
  );
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_only_allow_trusted_devices =
      _dylib.lookupFunction<
          Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
          int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_only_allow_trusted_devices",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_room_settings =
      _dylib.lookupFunction<
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_room_settings");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_user_devices =
      _dylib.lookupFunction<
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                Uint32,
                Pointer<RustCallStatus>,
              ),
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                int,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_user_devices");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_verification =
      _dylib.lookupFunction<
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              ),
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_verification");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_verification_request =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_verification_request",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_verification_requests =
      _dylib.lookupFunction<
          RustBuffer Function(
              Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
          RustBuffer Function(
              Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_get_verification_requests",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_identity_keys =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_identity_keys");
  late final void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_cross_signing_keys =
      _dylib.lookupFunction<
          Void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
          void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_cross_signing_keys",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_decrypted_room_keys =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            Uint64,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            int,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_decrypted_room_keys",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_room_keys =
      _dylib.lookupFunction<
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Uint64,
                Pointer<RustCallStatus>,
              ),
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                int,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_room_keys");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_room_keys_from_backup =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Uint64,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            int,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_import_room_keys_from_backup",
  );
  late final int Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_is_identity_verified =
      _dylib.lookupFunction<
          Int8 Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
          int Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_is_identity_verified",
  );
  late final int Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_is_user_tracked =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_is_user_tracked");
  late final void Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_mark_request_as_sent =
      _dylib.lookupFunction<
          Void Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          void Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_mark_request_as_sent",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_outgoing_requests =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_outgoing_requests");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_query_missing_secrets_from_other_sessions =
      _dylib.lookupFunction<
          Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
          int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_query_missing_secrets_from_other_sessions",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    matrix_sdk_crypto.RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_receive_sync_changes =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            matrix_sdk_crypto.RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            matrix_sdk_crypto.RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_receive_sync_changes",
  );
  late final void Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_receive_unencrypted_verification_event =
      _dylib.lookupFunction<
          Void Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          void Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_receive_unencrypted_verification_event",
  );
  late final void Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_receive_verification_event =
      _dylib.lookupFunction<
          Void Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          void Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_receive_verification_event",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_room_key =
      _dylib.lookupFunction<
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              ),
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_room_key");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_self_verification =
      _dylib.lookupFunction<
          RustBuffer Function(
              Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
          RustBuffer Function(
              Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_self_verification",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_verification =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_verification",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_verification_with_device =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_request_verification_with_device",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_room_key_counts =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_room_key_counts");
  late final void Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_save_recovery_key =
      _dylib.lookupFunction<
              Void Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              ),
              void Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_save_recovery_key");
  late final void Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    matrix_sdk_crypto.RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_local_trust =
      _dylib.lookupFunction<
              Void Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                matrix_sdk_crypto.RustBuffer,
                Pointer<RustCallStatus>,
              ),
              void Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                matrix_sdk_crypto.RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_local_trust");
  late final void Function(Pointer<Void>, int, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_only_allow_trusted_devices =
      _dylib.lookupFunction<
          Void Function(Pointer<Void>, Int8, Pointer<RustCallStatus>),
          void Function(Pointer<Void>, int, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_only_allow_trusted_devices",
  );
  late final void Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_room_algorithm =
      _dylib.lookupFunction<
              Void Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              ),
              void Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_room_algorithm");
  late final void Function(
    Pointer<Void>,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_room_only_allow_trusted_devices =
      _dylib.lookupFunction<
          Void Function(
              Pointer<Void>, RustBuffer, Int8, Pointer<RustCallStatus>),
          void Function(
              Pointer<Void>, RustBuffer, int, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_set_room_only_allow_trusted_devices",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_share_room_key =
      _dylib.lookupFunction<
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              ),
              RustBuffer Function(
                Pointer<Void>,
                RustBuffer,
                RustBuffer,
                RustBuffer,
                Pointer<RustCallStatus>,
              )>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_share_room_key");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_sign =
      _dylib.lookupFunction<
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_sign");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_start_sas_with_device =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_start_sas_with_device",
  );
  late final void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_update_tracked_users =
      _dylib.lookupFunction<
          Void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
          void Function(Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_update_tracked_users",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_user_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_user_id");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verification_request_content =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verification_request_content",
  );
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verify_backup =
      _dylib.lookupFunction<
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verify_backup");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verify_device =
      _dylib.lookupFunction<
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          RustBuffer Function(
            Pointer<Void>,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>("uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verify_device");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verify_identity =
      _dylib.lookupFunction<
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_olmmachine_verify_identity");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_pkencryption =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_pkencryption");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_pkencryption = _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_pkencryption");
  late final Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_constructor_pkencryption_from_base64 =
      _dylib.lookupFunction<
              Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>),
              Pointer<Void> Function(RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_constructor_pkencryption_from_base64");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_pkencryption_encrypt =
      _dylib.lookupFunction<
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_pkencryption_encrypt");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_qrcode = _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_qrcode");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_qrcode = _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_qrcode");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_cancel =
      _dylib.lookupFunction<
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_cancel");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_cancel_info =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_cancel_info");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_confirm =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_confirm");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_flow_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_flow_id");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_generate_qr_code =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_generate_qr_code");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_has_been_scanned =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_has_been_scanned");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_is_cancelled =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_is_cancelled");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_is_done =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_is_done");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_other_device_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_other_device_id");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_other_user_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_other_user_id");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_reciprocated =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_reciprocated");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_room_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_room_id");
  late final void Function(Pointer<Void>, int, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_set_changes_listener =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, Uint64, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, int, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_set_changes_listener");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_state =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_state");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_we_started =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_qrcode_we_started");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_rehydrateddevice =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_rehydrateddevice");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_rehydrateddevice =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_rehydrateddevice");
  late final void Function(
    Pointer<Void>,
    RustBuffer,
    matrix_sdk_crypto.RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_rehydrateddevice_receive_events =
      _dylib.lookupFunction<
          Void Function(
            Pointer<Void>,
            RustBuffer,
            matrix_sdk_crypto.RustBuffer,
            Pointer<RustCallStatus>,
          ),
          void Function(
            Pointer<Void>,
            RustBuffer,
            matrix_sdk_crypto.RustBuffer,
            Pointer<RustCallStatus>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_rehydrateddevice_receive_events",
  );
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_sas = _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_sas");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_sas = _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_sas");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_accept = _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_accept");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_sas_cancel =
      _dylib.lookupFunction<
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_cancel");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_confirm =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_confirm");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_flow_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_flow_id");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_get_decimals =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_get_decimals");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_get_emoji_indices =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_get_emoji_indices");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_is_done =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_is_done");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_other_device_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_other_device_id");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_other_user_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_other_user_id");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_room_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_room_id");
  late final void Function(Pointer<Void>, int, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_set_changes_listener =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, Uint64, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, int, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_set_changes_listener");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_state = _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_state");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_sas_we_started =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_sas_we_started");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_verification =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_verification");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_verification = _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_verification");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verification_as_qr =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_verification_as_qr");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verification_as_sas =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_verification_as_sas");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_clone_verificationrequest =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_clone_verificationrequest");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_free_verificationrequest =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_free_verificationrequest");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_accept =
      _dylib.lookupFunction<
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
              RustBuffer Function(
                  Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_accept");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_cancel =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_cancel");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_cancel_info =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_cancel_info",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_flow_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_flow_id");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_cancelled =
      _dylib.lookupFunction<
          Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
          int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_cancelled",
  );
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_done =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_done");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_passive =
      _dylib.lookupFunction<
          Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
          int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_passive",
  );
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_ready =
      _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_is_ready");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_other_device_id =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_other_device_id",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_other_user_id =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_other_user_id",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_our_supported_methods =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_our_supported_methods",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_room_id =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_room_id");
  late final RustBuffer Function(
    Pointer<Void>,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_scan_qr_code =
      _dylib.lookupFunction<
          RustBuffer Function(
              Pointer<Void>, RustBuffer, Pointer<RustCallStatus>),
          RustBuffer Function(
              Pointer<Void>, RustBuffer, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_scan_qr_code",
  );
  late final void Function(Pointer<Void>, int, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_set_changes_listener =
      _dylib.lookupFunction<
          Void Function(Pointer<Void>, Uint64, Pointer<RustCallStatus>),
          void Function(Pointer<Void>, int, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_set_changes_listener",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_start_qr_verification =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_start_qr_verification",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_start_sas_verification =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_start_sas_verification",
  );
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_state =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_state");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_their_supported_methods =
      _dylib.lookupFunction<
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
          RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_their_supported_methods",
  );
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_we_started =
      _dylib.lookupFunction<
          Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
          int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_method_verificationrequest_we_started",
  );
  late final void Function(Pointer<UniffiVTableCallbackInterfaceLogger>)
      uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_logger =
      _dylib.lookupFunction<
              Void Function(Pointer<UniffiVTableCallbackInterfaceLogger>),
              void Function(Pointer<UniffiVTableCallbackInterfaceLogger>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_logger");
  late final void Function(
    Pointer<UniffiVTableCallbackInterfaceProgressListener>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_progresslistener =
      _dylib.lookupFunction<
          Void Function(Pointer<UniffiVTableCallbackInterfaceProgressListener>),
          void Function(
              Pointer<UniffiVTableCallbackInterfaceProgressListener>)>(
    "uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_progresslistener",
  );
  late final void Function(Pointer<UniffiVTableCallbackInterfaceQrCodeListener>)
      uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_qrcodelistener =
      _dylib.lookupFunction<
              Void Function(Pointer<UniffiVTableCallbackInterfaceQrCodeListener>),
              void Function(
                  Pointer<UniffiVTableCallbackInterfaceQrCodeListener>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_qrcodelistener");
  late final void Function(Pointer<UniffiVTableCallbackInterfaceSasListener>)
      uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_saslistener =
      _dylib.lookupFunction<
              Void Function(Pointer<UniffiVTableCallbackInterfaceSasListener>),
              void Function(Pointer<UniffiVTableCallbackInterfaceSasListener>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_saslistener");
  late final void Function(
    Pointer<UniffiVTableCallbackInterfaceVerificationRequestListener>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_verificationrequestlistener =
      _dylib.lookupFunction<
          Void Function(
            Pointer<UniffiVTableCallbackInterfaceVerificationRequestListener>,
          ),
          void Function(
            Pointer<UniffiVTableCallbackInterfaceVerificationRequestListener>,
          )>(
    "uniffi_matrix_sdk_crypto_ffi_fn_init_callback_vtable_verificationrequestlistener",
  );
  late final void Function(
    RustBuffer,
    RustBuffer,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_func_migrate = _dylib.lookupFunction<
      Void Function(
        RustBuffer,
        RustBuffer,
        RustBuffer,
        Uint64,
        Pointer<RustCallStatus>,
      ),
      void Function(
        RustBuffer,
        RustBuffer,
        RustBuffer,
        int,
        Pointer<RustCallStatus>,
      )>("uniffi_matrix_sdk_crypto_ffi_fn_func_migrate");
  late final void Function(
    RustBuffer,
    RustBuffer,
    RustBuffer,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_func_migrate_room_settings =
      _dylib.lookupFunction<
          Void Function(
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          ),
          void Function(
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Pointer<RustCallStatus>,
          )>("uniffi_matrix_sdk_crypto_ffi_fn_func_migrate_room_settings");
  late final void Function(
    RustBuffer,
    RustBuffer,
    RustBuffer,
    int,
    Pointer<RustCallStatus>,
  ) uniffi_matrix_sdk_crypto_ffi_fn_func_migrate_sessions =
      _dylib.lookupFunction<
          Void Function(
            RustBuffer,
            RustBuffer,
            RustBuffer,
            Uint64,
            Pointer<RustCallStatus>,
          ),
          void Function(
            RustBuffer,
            RustBuffer,
            RustBuffer,
            int,
            Pointer<RustCallStatus>,
          )>("uniffi_matrix_sdk_crypto_ffi_fn_func_migrate_sessions");
  late final void Function(int, Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_func_set_logger = _dylib.lookupFunction<
              Void Function(Uint64, Pointer<RustCallStatus>),
              void Function(int, Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_func_set_logger");
  late final RustBuffer Function(Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_func_version = _dylib.lookupFunction<
              RustBuffer Function(Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_func_version");
  late final RustBuffer Function(Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_func_version_info = _dylib.lookupFunction<
              RustBuffer Function(Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_func_version_info");
  late final RustBuffer Function(Pointer<RustCallStatus>)
      uniffi_matrix_sdk_crypto_ffi_fn_func_vodozemac_version =
      _dylib.lookupFunction<RustBuffer Function(Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<RustCallStatus>)>(
          "uniffi_matrix_sdk_crypto_ffi_fn_func_vodozemac_version");
  late final RustBuffer Function(int, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rustbuffer_alloc = _dylib.lookupFunction<
              RustBuffer Function(Uint64, Pointer<RustCallStatus>),
              RustBuffer Function(int, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rustbuffer_alloc");
  late final RustBuffer Function(ForeignBytes, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rustbuffer_from_bytes = _dylib.lookupFunction<
              RustBuffer Function(ForeignBytes, Pointer<RustCallStatus>),
              RustBuffer Function(ForeignBytes, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rustbuffer_from_bytes");
  late final void Function(RustBuffer, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rustbuffer_free = _dylib.lookupFunction<
              Void Function(RustBuffer, Pointer<RustCallStatus>),
              void Function(RustBuffer, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rustbuffer_free");
  late final RustBuffer Function(RustBuffer, int, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rustbuffer_reserve = _dylib.lookupFunction<
              RustBuffer Function(RustBuffer, Uint64, Pointer<RustCallStatus>),
              RustBuffer Function(RustBuffer, int, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rustbuffer_reserve");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_u8 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_u8");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_u8 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_u8");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_u8 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_u8");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_u8 = _dylib.lookupFunction<
              Uint8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_u8");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_i8 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_i8");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_i8 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_i8");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_i8 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_i8");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_i8 = _dylib.lookupFunction<
              Int8 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_i8");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_u16 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_u16");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_u16 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_u16");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_u16 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_u16");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_u16 =
      _dylib.lookupFunction<
              Uint16 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_u16");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_i16 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_i16");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_i16 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_i16");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_i16 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_i16");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_i16 =
      _dylib.lookupFunction<
              Int16 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_i16");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_u32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_u32");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_u32 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_u32");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_u32 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_u32");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_u32 =
      _dylib.lookupFunction<
              Uint32 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_u32");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_i32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_i32");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_i32 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_i32");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_i32 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_i32");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_i32 =
      _dylib.lookupFunction<
              Int32 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_i32");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_u64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_u64");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_u64 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_u64");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_u64 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_u64");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_u64 =
      _dylib.lookupFunction<
              Uint64 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_u64");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_i64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_i64");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_i64 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_i64");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_i64 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_i64");
  late final int Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_i64 =
      _dylib.lookupFunction<
              Int64 Function(Pointer<Void>, Pointer<RustCallStatus>),
              int Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_i64");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_f32 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_f32");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_f32 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_f32");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_f32 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_f32");
  late final double Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_f32 =
      _dylib.lookupFunction<
              Float Function(Pointer<Void>, Pointer<RustCallStatus>),
              double Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_f32");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_f64 = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_f64");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_f64 = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_f64");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_f64 = _dylib.lookupFunction<
          Void Function(Pointer<Void>),
          void Function(
              Pointer<Void>)>("ffi_matrix_sdk_crypto_ffi_rust_future_free_f64");
  late final double Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_f64 =
      _dylib.lookupFunction<
              Double Function(Pointer<Void>, Pointer<RustCallStatus>),
              double Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_f64");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_pointer = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_pointer");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_pointer =
      _dylib.lookupFunction<Void Function(Pointer<Void>),
              void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_pointer");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_pointer =
      _dylib.lookupFunction<Void Function(Pointer<Void>),
              void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_free_pointer");
  late final Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_pointer =
      _dylib.lookupFunction<
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>),
              Pointer<Void> Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_pointer");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_rust_buffer =
      _dylib.lookupFunction<
          Void Function(
            Pointer<Void>,
            Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
            Pointer<Void>,
          ),
          void Function(
            Pointer<Void>,
            Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
            Pointer<Void>,
          )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_rust_buffer");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_rust_buffer =
      _dylib.lookupFunction<Void Function(Pointer<Void>),
              void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_rust_buffer");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_rust_buffer =
      _dylib.lookupFunction<Void Function(Pointer<Void>),
              void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_free_rust_buffer");
  late final RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_rust_buffer =
      _dylib.lookupFunction<
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>),
              RustBuffer Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_rust_buffer");
  late final void Function(
    Pointer<Void>,
    Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
    Pointer<Void>,
  ) ffi_matrix_sdk_crypto_ffi_rust_future_poll_void = _dylib.lookupFunction<
      Void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      ),
      void Function(
        Pointer<Void>,
        Pointer<NativeFunction<UniffiRustFutureContinuationCallback>>,
        Pointer<Void>,
      )>("ffi_matrix_sdk_crypto_ffi_rust_future_poll_void");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_cancel_void = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_cancel_void");
  late final void Function(Pointer<Void>)
      ffi_matrix_sdk_crypto_ffi_rust_future_free_void = _dylib.lookupFunction<
              Void Function(Pointer<Void>), void Function(Pointer<Void>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_free_void");
  late final void Function(Pointer<Void>, Pointer<RustCallStatus>)
      ffi_matrix_sdk_crypto_ffi_rust_future_complete_void =
      _dylib.lookupFunction<
              Void Function(Pointer<Void>, Pointer<RustCallStatus>),
              void Function(Pointer<Void>, Pointer<RustCallStatus>)>(
          "ffi_matrix_sdk_crypto_ffi_rust_future_complete_void");
  late final int Function() uniffi_matrix_sdk_crypto_ffi_checksum_func_migrate =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_func_migrate",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_func_migrate_room_settings =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_func_migrate_room_settings",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_func_migrate_sessions =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_func_migrate_sessions",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_func_set_logger =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_func_set_logger",
  );
  late final int Function() uniffi_matrix_sdk_crypto_ffi_checksum_func_version =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_func_version",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_func_version_info =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_func_version_info",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_func_vodozemac_version =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_func_vodozemac_version",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_backupkeys_backup_version =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_backupkeys_backup_version",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_backupkeys_recovery_key =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_backupkeys_recovery_key",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_decrypt_v1 =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_decrypt_v1",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_megolm_v1_public_key =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_megolm_v1_public_key",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_to_base58 =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_to_base58",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_to_base64 =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_to_base64",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevice_keys_for_upload =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevice_keys_for_upload",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_create =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_create",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_delete_dehydrated_device_key =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_delete_dehydrated_device_key",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_get_dehydrated_device_key =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_get_dehydrated_device_key",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_rehydrate =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_rehydrate",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_save_dehydrated_device_key =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_save_dehydrated_device_key",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_backup_enabled =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_backup_enabled",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_backup_room_keys =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_backup_room_keys",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_bootstrap_cross_signing =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_bootstrap_cross_signing",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_create_encrypted_to_device_request =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_create_encrypted_to_device_request",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_cross_signing_status =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_cross_signing_status",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_decrypt_room_event =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_decrypt_room_event",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_dehydrated_devices =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_dehydrated_devices",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_device_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_device_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_disable_backup =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_disable_backup",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_discard_room_key =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_discard_room_key",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_enable_backup_v1 =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_enable_backup_v1",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_encrypt =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_encrypt",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_export_cross_signing_keys =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_export_cross_signing_keys",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_export_room_keys =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_export_room_keys",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_backup_keys =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_backup_keys",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_device =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_device",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_identity =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_identity",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_missing_sessions =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_missing_sessions",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_only_allow_trusted_devices =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_only_allow_trusted_devices",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_room_settings =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_room_settings",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_user_devices =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_user_devices",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_verification =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_verification",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_verification_request =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_verification_request",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_verification_requests =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_verification_requests",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_identity_keys =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_identity_keys",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_cross_signing_keys =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_cross_signing_keys",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_decrypted_room_keys =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_decrypted_room_keys",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_room_keys =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_room_keys",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_room_keys_from_backup =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_room_keys_from_backup",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_is_identity_verified =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_is_identity_verified",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_is_user_tracked =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_is_user_tracked",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_mark_request_as_sent =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_mark_request_as_sent",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_outgoing_requests =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_outgoing_requests",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_query_missing_secrets_from_other_sessions =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_query_missing_secrets_from_other_sessions",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_receive_sync_changes =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_receive_sync_changes",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_receive_unencrypted_verification_event =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_receive_unencrypted_verification_event",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_receive_verification_event =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_receive_verification_event",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_room_key =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_room_key",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_self_verification =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_self_verification",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_verification =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_verification",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_verification_with_device =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_verification_with_device",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_room_key_counts =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_room_key_counts",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_save_recovery_key =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_save_recovery_key",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_local_trust =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_local_trust",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_only_allow_trusted_devices =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_only_allow_trusted_devices",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_room_algorithm =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_room_algorithm",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_room_only_allow_trusted_devices =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_room_only_allow_trusted_devices",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_share_room_key =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_share_room_key",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_sign =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_sign",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_start_sas_with_device =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_start_sas_with_device",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_update_tracked_users =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_update_tracked_users",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_user_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_user_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verification_request_content =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verification_request_content",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verify_backup =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verify_backup",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verify_device =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verify_device",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verify_identity =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verify_identity",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_pkencryption_encrypt =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_pkencryption_encrypt",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_cancel =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_cancel",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_cancel_info =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_cancel_info",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_confirm =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_confirm",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_flow_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_flow_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_generate_qr_code =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_generate_qr_code",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_has_been_scanned =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_has_been_scanned",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_is_cancelled =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_is_cancelled",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_is_done =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_is_done",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_other_device_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_other_device_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_other_user_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_other_user_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_reciprocated =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_reciprocated",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_room_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_room_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_set_changes_listener =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_set_changes_listener",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_state =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_state",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_we_started =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_we_started",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_rehydrateddevice_receive_events =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_rehydrateddevice_receive_events",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_accept =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_accept",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_cancel =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_cancel",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_confirm =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_confirm",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_flow_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_flow_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_get_decimals =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_get_decimals",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_get_emoji_indices =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_get_emoji_indices",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_is_done =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_is_done",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_other_device_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_other_device_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_other_user_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_other_user_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_room_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_room_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_set_changes_listener =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_set_changes_listener",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_state =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_state",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_we_started =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_we_started",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verification_as_qr =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verification_as_qr",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verification_as_sas =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verification_as_sas",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_accept =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_accept",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_cancel =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_cancel",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_cancel_info =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_cancel_info",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_flow_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_flow_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_cancelled =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_cancelled",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_done =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_done",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_passive =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_passive",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_ready =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_ready",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_other_device_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_other_device_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_other_user_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_other_user_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_our_supported_methods =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_our_supported_methods",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_room_id =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_room_id",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_scan_qr_code =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_scan_qr_code",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_set_changes_listener =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_set_changes_listener",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_start_qr_verification =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_start_qr_verification",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_start_sas_verification =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_start_sas_verification",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_state =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_state",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_their_supported_methods =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_their_supported_methods",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_we_started =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_we_started",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_from_base58 =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_from_base58",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_from_base64 =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_from_base64",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_from_passphrase =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_from_passphrase",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_new =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_new",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_new_from_passphrase =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_new_from_passphrase",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_constructor_olmmachine_new =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_constructor_olmmachine_new",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_constructor_pkencryption_from_base64 =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_constructor_pkencryption_from_base64",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_logger_log =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_logger_log",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_progresslistener_on_progress =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_progresslistener_on_progress",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcodelistener_on_change =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcodelistener_on_change",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_saslistener_on_change =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_saslistener_on_change",
  );
  late final int Function()
      uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequestlistener_on_change =
      _dylib.lookupFunction<Uint16 Function(), int Function()>(
    "uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequestlistener_on_change",
  );
  late final int Function() ffi_matrix_sdk_crypto_ffi_uniffi_contract_version =
      _dylib.lookupFunction<Uint32 Function(), int Function()>(
    "ffi_matrix_sdk_crypto_ffi_uniffi_contract_version",
  );
  static void _checkApiVersion() {
    final bindingsVersion = 29;
    final scaffoldingVersion =
        _UniffiLib.instance.ffi_matrix_sdk_crypto_ffi_uniffi_contract_version();
    if (bindingsVersion != scaffoldingVersion) {
      throw UniffiInternalError.panicked(
        "UniFFI contract version mismatch: bindings version \$bindingsVersion, scaffolding version \$scaffoldingVersion",
      );
    }
  }

  static void _checkApiChecksums() {
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_func_migrate() !=
        42143) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_func_migrate_room_settings() !=
        61541) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_func_migrate_sessions() !=
        34886) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_func_set_logger() !=
        11288) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_func_version() !=
        18282) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_func_version_info() !=
        38713) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_func_vodozemac_version() !=
        31430) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_backupkeys_backup_version() !=
        56634) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_backupkeys_recovery_key() !=
        59286) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_decrypt_v1() !=
        63819) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_megolm_v1_public_key() !=
        54235) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_to_base58() !=
        15954) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_backuprecoverykey_to_base64() !=
        3854) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevice_keys_for_upload() !=
        27279) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_create() !=
        20431) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_delete_dehydrated_device_key() !=
        20976) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_get_dehydrated_device_key() !=
        52976) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_rehydrate() !=
        62661) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_dehydrateddevices_save_dehydrated_device_key() !=
        54923) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_backup_enabled() !=
        55573) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_backup_room_keys() !=
        36224) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_bootstrap_cross_signing() !=
        16272) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_create_encrypted_to_device_request() !=
        5658) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_cross_signing_status() !=
        60700) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_decrypt_room_event() !=
        51124) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_dehydrated_devices() !=
        29352) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_device_id() !=
        8368) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_disable_backup() !=
        41418) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_discard_room_key() !=
        51133) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_enable_backup_v1() !=
        32528) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_encrypt() !=
        30553) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_export_cross_signing_keys() !=
        5979) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_export_room_keys() !=
        20478) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_backup_keys() !=
        32402) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_device() !=
        22502) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_identity() !=
        54772) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_missing_sessions() !=
        24314) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_only_allow_trusted_devices() !=
        41002) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_room_settings() !=
        11972) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_user_devices() !=
        2357) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_verification() !=
        26313) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_verification_request() !=
        52941) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_get_verification_requests() !=
        22986) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_identity_keys() !=
        27954) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_cross_signing_keys() !=
        52001) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_decrypted_room_keys() !=
        14158) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_room_keys() !=
        6715) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_import_room_keys_from_backup() !=
        16588) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_is_identity_verified() !=
        19282) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_is_user_tracked() !=
        38133) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_mark_request_as_sent() !=
        62014) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_outgoing_requests() !=
        60867) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_query_missing_secrets_from_other_sessions() !=
        33649) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_receive_sync_changes() !=
        57857) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_receive_unencrypted_verification_event() !=
        46523) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_receive_verification_event() !=
        40029) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_room_key() !=
        55933) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_self_verification() !=
        47311) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_verification() !=
        38259) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_request_verification_with_device() !=
        2015) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_room_key_counts() !=
        50492) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_save_recovery_key() !=
        43674) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_local_trust() !=
        10978) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_only_allow_trusted_devices() !=
        5049) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_room_algorithm() !=
        47962) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_set_room_only_allow_trusted_devices() !=
        38231) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_share_room_key() !=
        57647) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_sign() !=
        11388) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_start_sas_with_device() !=
        39343) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_update_tracked_users() !=
        47867) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_user_id() !=
        28648) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verification_request_content() !=
        54088) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verify_backup() !=
        2751) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verify_device() !=
        17219) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_olmmachine_verify_identity() !=
        39267) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_pkencryption_encrypt() !=
        50717) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_cancel() !=
        56240) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_cancel_info() !=
        797) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_confirm() !=
        7766) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_flow_id() !=
        38858) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_generate_qr_code() !=
        38303) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_has_been_scanned() !=
        34711) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_is_cancelled() !=
        17076) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_is_done() !=
        64647) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_other_device_id() !=
        18546) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_other_user_id() !=
        32903) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_reciprocated() !=
        29284) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_room_id() !=
        42325) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_set_changes_listener() !=
        42360) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_state() !=
        26065) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcode_we_started() !=
        39359) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_rehydrateddevice_receive_events() !=
        57511) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_accept() !=
        23750) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_cancel() !=
        32584) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_confirm() !=
        2955) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_flow_id() !=
        8039) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_get_decimals() !=
        6633) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_get_emoji_indices() !=
        21471) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_is_done() !=
        23641) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_other_device_id() !=
        55711) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_other_user_id() !=
        5587) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_room_id() !=
        56710) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_set_changes_listener() !=
        45460) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_state() !=
        5148) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_sas_we_started() !=
        20077) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verification_as_qr() !=
        38638) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verification_as_sas() !=
        62612) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_accept() !=
        41324) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_cancel() !=
        45120) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_cancel_info() !=
        58718) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_flow_id() !=
        48899) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_cancelled() !=
        5406) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_done() !=
        6301) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_passive() !=
        29071) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_is_ready() !=
        46804) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_other_device_id() !=
        57800) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_other_user_id() !=
        32763) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_our_supported_methods() !=
        59504) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_room_id() !=
        15921) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_scan_qr_code() !=
        15656) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_set_changes_listener() !=
        44931) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_start_qr_verification() !=
        45448) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_start_sas_verification() !=
        31406) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_state() !=
        50283) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_their_supported_methods() !=
        50334) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequest_we_started() !=
        30926) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_from_base58() !=
        42204) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_from_base64() !=
        3338) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_from_passphrase() !=
        31417) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_new() !=
        6408) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_constructor_backuprecoverykey_new_from_passphrase() !=
        29227) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_constructor_olmmachine_new() !=
        21121) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_constructor_pkencryption_from_base64() !=
        23335) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_logger_log() !=
        3112) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_progresslistener_on_progress() !=
        49805) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_qrcodelistener_on_change() !=
        48097) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_saslistener_on_change() !=
        32441) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
    if (_UniffiLib.instance
            .uniffi_matrix_sdk_crypto_ffi_checksum_method_verificationrequestlistener_on_change() !=
        9094) {
      throw UniffiInternalError.panicked("UniFFI API checksum mismatch");
    }
  }
}

void initialize() {
  _UniffiLib._open();
}

void ensureInitialized() {
  _UniffiLib._checkApiVersion();
  _UniffiLib._checkApiChecksums();
}
