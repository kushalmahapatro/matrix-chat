# matrix

Flutter app integrating Matrix Rust SDK via Dart FFI generated with UniFFI.

## Prerequisites

- Rust toolchain (stable)
- Cargo
- Dart SDK and Flutter (stable)

## Repo Layout

- `../matrix-rust-sdk`: Rust workspace with Matrix SDK crates and UniFFI FFI crates
- `packages/matrix_sdk_ffi`: Dart package where generated bindings are placed

## Generate Dart bindings (UniFFI)

1) Build the UniFFI Dart generator CLI

```bash
cargo build --manifest-path uniffi-dart/Cargo.toml --features binary
```

2) Build the Rust FFI crate to produce a library for metadata extraction

```bash
cargo build -p matrix-sdk-ffi --manifest-path matrix-rust-sdk/Cargo.toml --features rustls-tls 
```

3) Generate Dart bindings into `packages/matrix_sdk_ffi/lib`

```bash
uniffi-dart/target/debug/uniffi_bindgen_dart \
  --udl matrix-rust-sdk/bindings/matrix-sdk-ffi/src/api.udl \
  --out-dir matrix/packages/matrix_sdk_full/lib \
  --library matrix-rust-sdk/target/debug/libmatrix_sdk_ffi.a
```

Notes:
- The generator also supports `--library` pointing to a dynamic library; the static `.a` works for metadata.
- The generator will run `dart format` on the output if available.

## Using the generated package

Add a path dependency in your Flutter app `pubspec.yaml` (if not already under the same workspace):

```yaml
dependencies:
  matrix_sdk_ffi:
    path: packages/matrix_sdk_ffi
```

Then import from `matrix_sdk_ffi` in your Dart code.

## Troubleshooting

- If you see missing symbols at runtime, ensure the native library is built for the target platform and loaded correctly.
- Regenerate bindings after changing `api.udl` or Rust types exported via UniFFI.
