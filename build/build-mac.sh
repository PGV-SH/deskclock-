#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

export ELECTRON_MIRROR="https://npmmirror.com/mirrors/electron/"
export ELECTRON_CUSTOM_DIR="{{ version }}"

IGNORE=(
  --ignore='^/node_modules'
  --ignore='^/nsis'
  --ignore='^/nsis-3\.10-src'
  --ignore='^/\.venv-scons'
  --ignore='^/\.udata'
  --ignore='^/dist'
  --ignore='^/make-icon\.js$'
  --ignore='^/set-icon\.js$'
  --ignore='^/installer\.nsi$'
  --ignore='^/icon\.png$'
  --ignore='^/package-lock\.json$'
  --ignore='\.exe$'
)

rm -rf dist dmg-x64 dmg-arm64

for a in x64 arm64; do
  echo "== packaging $a =="
  npx @electron/packager ../build-win DeskClock \
    --platform=darwin --arch=$a --out=dist \
    --icon=icon.icns --app-bundle-id=com.deskclock.clock --app-version=1.0.0 \
    --overwrite --prune=true "${IGNORE[@]}"

  APP="dist/DeskClock-darwin-$a/DeskClock.app"
  PB=/usr/libexec/PlistBuddy
  cp icon.icns "$APP/Contents/Resources/icon.icns"
  $PB -c "Set :CFBundleIconFile icon.icns" "$APP/Contents/Info.plist" 2>/dev/null \
    || $PB -c "Add :CFBundleIconFile string icon.icns" "$APP/Contents/Info.plist"
  # Only the display name is localised; the bundle and helper names must stay
  # in sync or Electron aborts with "Unable to find helper app".
  $PB -c "Set :CFBundleDisplayName 极简时钟" "$APP/Contents/Info.plist" 2>/dev/null \
    || $PB -c "Add :CFBundleDisplayName string 极简时钟" "$APP/Contents/Info.plist"
  $PB -c "Set :NSHumanReadableCopyright © 2026 Zohan" "$APP/Contents/Info.plist" 2>/dev/null \
    || $PB -c "Add :NSHumanReadableCopyright string © 2026 Zohan" "$APP/Contents/Info.plist"

  # Helpers and frameworks are unsigned after repackaging, so sign the whole
  # bundle recursively with the JIT/library-validation entitlements.
  codesign --force --deep --sign - --entitlements entitlements.plist "$APP"
  codesign --verify --deep --strict "$APP"

  echo "== creating dmg $a =="
  mkdir "dmg-$a"
  cp -R "$APP" "dmg-$a/"
  ln -s /Applications "dmg-$a/Applications"
  hdiutil create -quiet -volname "极简时钟 1.0.0" -srcfolder "dmg-$a" \
    -ov -format UDZO "$ROOT/../DeskClock-1.0.0-$a.dmg"
  rm -rf "dmg-$a"
  ls -lh "$ROOT/../DeskClock-1.0.0-$a.dmg"
done
