#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SDK="$ROOT/sdk"
BT="$SDK/build-tools/34.0.0"
PLATFORM="$SDK/platforms/android-34/android.jar"
APP="$ROOT/app"
BUILD="$ROOT/build"
OUT="$ROOT/../DeskClock-1.0.0.apk"

rm -rf "$BUILD"
mkdir -p "$BUILD/res" "$BUILD/gen" "$BUILD/classes" "$BUILD/dex"

echo "[1/6] compile resources"
"$BT/aapt2" compile --dir "$APP/res" -o "$BUILD/res/compiled.zip"

echo "[2/6] link resources + assets"
"$BT/aapt2" link -o "$BUILD/app-unsigned.apk" \
  -I "$PLATFORM" \
  --manifest "$APP/AndroidManifest.xml" \
  -R "$BUILD/res/compiled.zip" \
  --java "$BUILD/gen" \
  -A "$APP/assets" \
  --auto-add-overlay

echo "[3/6] compile java"
javac -source 8 -target 8 -classpath "$PLATFORM" -d "$BUILD/classes" \
  $(find "$BUILD/gen" "$APP/src" -name "*.java")

echo "[4/6] dex"
"$BT/d8" --release --min-api 26 --lib "$PLATFORM" --output "$BUILD/dex" \
  $(find "$BUILD/classes" -name "*.class")

( cd "$BUILD" && zip -q -j app-unsigned.apk dex/classes.dex )

echo "[5/6] align"
"$BT/zipalign" -f 4 "$BUILD/app-unsigned.apk" "$BUILD/app-aligned.apk"

echo "[6/6] sign"
if [ ! -f "$ROOT/keystore.jks" ]; then
  keytool -genkeypair -keystore "$ROOT/keystore.jks" -alias deskclock \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -storepass deskclock123 -keypass deskclock123 \
    -dname "CN=DeskClock, OU=Home, O=DeskClock, L=Shanghai, ST=Shanghai, C=CN"
fi
"$BT/apksigner" sign --ks "$ROOT/keystore.jks" \
  --ks-pass pass:deskclock123 --key-pass pass:deskclock123 \
  --out "$OUT" "$BUILD/app-aligned.apk"

"$BT/apksigner" verify "$OUT"
ls -lh "$OUT"
