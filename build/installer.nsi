Unicode true
SetCompressor /SOLID lzma
SetCompressorDictSize 32

Name "极简时钟"
Caption "极简时钟 安装程序"
OutFile "DeskClock-Setup-1.0.0.exe"
InstallDir "$PROGRAMFILES64\DeskClock"
InstallDirRegKey HKLM "Software\DeskClock" "InstallDir"
RequestExecutionLevel admin
BrandingText "DeskClock"

VIProductVersion "1.0.0.0"
VIAddVersionKey /LANG=2052 "ProductName" "极简时钟"
VIAddVersionKey /LANG=2052 "FileDescription" "极简时钟 安装程序"
VIAddVersionKey /LANG=2052 "CompanyName" "Zohan"
VIAddVersionKey /LANG=2052 "FileVersion" "1.0.0.0"
VIAddVersionKey /LANG=2052 "ProductVersion" "1.0.0.0"
VIAddVersionKey /LANG=2052 "LegalCopyright" "© 2026 Zohan"

!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "icon.ico"
!define MUI_UNICON "icon.ico"
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

Section "极简时钟" SecMain
  SectionIn RO
  SetShellVarContext all
  SetOutPath "$INSTDIR"
  File /r "..\DeskClock-Windows\*.*"
  WriteUninstaller "$INSTDIR\uninstall.exe"

  CreateShortcut "$DESKTOP\极简时钟.lnk" "$INSTDIR\DeskClock.exe" "" "$INSTDIR\DeskClock.exe" 0
  CreateDirectory "$SMPROGRAMS\极简时钟"
  CreateShortcut "$SMPROGRAMS\极简时钟\极简时钟.lnk" "$INSTDIR\DeskClock.exe" "" "$INSTDIR\DeskClock.exe" 0
  CreateShortcut "$SMPROGRAMS\极简时钟\卸载极简时钟.lnk" "$INSTDIR\uninstall.exe"

  WriteRegStr HKLM "Software\DeskClock" "InstallDir" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock" "DisplayName" "极简时钟"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock" "DisplayIcon" "$INSTDIR\DeskClock.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock" "DisplayVersion" "1.0.0"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock" "Publisher" "Zohan"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock" "QuietUninstallString" '"$INSTDIR\uninstall.exe" /S'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock" "NoRepair" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock" "EstimatedSize" 365000
SectionEnd

Section "Uninstall"
  SetShellVarContext all
  Delete "$DESKTOP\极简时钟.lnk"
  Delete "$SMPROGRAMS\极简时钟\极简时钟.lnk"
  Delete "$SMPROGRAMS\极简时钟\卸载极简时钟.lnk"
  RMDir "$SMPROGRAMS\极简时钟"
  RMDir /r "$INSTDIR"
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\DeskClock"
  DeleteRegKey HKLM "Software\DeskClock"
SectionEnd
