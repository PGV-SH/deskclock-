#!/bin/bash
# 构建 iOS 未签名 ipa（安装时用 Sideloadly / AltStore / ESign 自行签名）
set -e
cd "$(dirname "$0")"

export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer
SDK=$(xcrun --sdk iphoneos --show-sdk-path)
SWIFTC="$DEVELOPER_DIR/Toolchains/XcodeDefault.xctoolchain/usr/bin/swiftc"
OUT=build
APP="$OUT/DeskClock.app"
IPA="$(cd .. && pwd)/DeskClock-1.0.0-unsigned.ipa"

rm -rf "$OUT"
mkdir -p "$APP"

echo "==> 编译 Swift (arm64, iOS 15+)"
"$SWIFTC" \
  -sdk "$SDK" \
  -target arm64-apple-ios15.0 \
  -swift-version 5 \
  -module-name DeskClock \
  -O \
  -framework UIKit -framework WebKit \
  src/main.swift \
  -o "$APP/DeskClock"

echo "==> 组装 .app"
cp Info.plist "$APP/Info.plist"
cp ../index.html "$APP/index.html"
sips -z 120 120 ../build-mac/icon-1024.png --out "$APP/AppIcon60x60@2x.png" >/dev/null
sips -z 180 180 ../build-mac/icon-1024.png --out "$APP/AppIcon60x60@3x.png" >/dev/null

echo "==> 打包 ipa"
rm -rf "$OUT/Payload"
mkdir -p "$OUT/Payload"
cp -R "$APP" "$OUT/Payload/"
rm -f "$IPA"
(cd "$OUT" && zip -qry "$IPA" Payload)

echo "==> 完成: $(cd .. && pwd)/$(basename "$IPA")"
ls -lh "$IPA"
lipo -info "$APP/DeskClock" 2>/dev/null || true
