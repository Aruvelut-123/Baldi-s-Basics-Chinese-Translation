!pragma warning error all

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Properly display all languages (Installer will not work on Windows 95, 98 or ME!)
  Unicode true

  ;Name and file
  Name "BB+������"

  BrandingText "���ߣ�Baymaxawa��MEMZSystem32"

  ;Default installation folder
  InstallDir "C:\Program Files (x86)\Steam\steamapps\common\Baldi's Basics Plus"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\BBPlusSChinese" ""

  OutFile "installer.exe"

  DirText "ѡ��BALDI.exe�������ڵ��ļ��У�·�����������ģ�������" "Steam���Ҽ����Ե����������������ļ�����" "���..." "ѡ��BALDI.exe�����ļ��У�·�����������ģ�������"

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
  !define MUI_ICON "icon.ico"
  !define MUI_UNICON "icon.ico"
  !define MUI_WELCOMEFINISHPAGE_BITMAP "left.bmp"
  !define MUI_UNWELCOMEFINISHPAGE_BITMAP "unleft.bmp"
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP "header.bmp"
  !define MUI_HEADERIMAGE_UNBITMAP "unheader.bmp"
  !define MUI_WELCOMEPAGE_TITLE "$\r��л��ѡ��BB+������"
  !define MUI_WELCOMEPAGE_TEXT "�˺�������Baymaxawa��MEMZSystem32����$\n$\n�������ʿɼ�Ⱥ��873338741$\n$\n$_CLICK"
  !define MUI_FINISHPAGE_SHOWREADME
  !define MUI_FINISHPAGE_SHOWREADME_Function StartGame
  !define MUI_FINISHPAGE_SHOWREADME_TEXT "��ɺ�������Ϸ"
  ;Show all languages, despite user's codepage
  !define MUI_LANGDLL_ALLLANGUAGES

;--------------------------------
;Language Selection Dialog Settings

  ;Remember the installer language
  !define MUI_LANGDLL_REGISTRY_ROOT "HKCU" 
  !define MUI_LANGDLL_REGISTRY_KEY "Software\BBPlusSChinese" 
  !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "License.txt"
  ## Enable When Beta out
  Page Custom PasswordPageShow PasswordPageLeave
  !define MUI_PAGE_CUSTOMFUNCTION_SHOW ComponentsPageShow
  ## Password is
  !define Password "2bHlx8QnDO7L35SF"
  ## Control ID's
  !define IDC_PASSWORD 123
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_LICENSE "License.txt"
  !insertmacro MUI_UNPAGE_COMPONENTS
  !insertmacro MUI_UNPAGE_DIRECTORY
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "SimpChinese"

;--------------------------------
;Reserve Files
  
  ;If you are using solid compression, files that are required before
  ;the actual installation should be stored first in the data block,
  ;because this will make your installer start faster.
  
  !insertmacro MUI_RESERVEFILE_LANGDLL

;--------------------------------
;Installer Sections

Section "BB+������" BBPlusschinese

  SetOutPath "$INSTDIR"
  DetailPrint "Extracting Files"
  File icon.ico
  File 7z.exe
  File 7z.dll
  File pack.zip
  File pack2.7z
  ExecWait "7z.exe x pack.zip -y"
  ExecWait "7z.exe x pack2.zip -y"
  Delete $INSTDIR\7z.exe
  Delete $INSTDIR\7z.dll
  Delete $INSTDIR\pack.zip
  WriteRegStr HKCU "Software\BBPlusSChinese" "" $INSTDIR
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "DisplayName" "BB+����"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "UninstallString" "$INSTDIR\Uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "DisplayIcon" "$INSTDIR\icon.ico"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "Publisher" "MEMZSystem32&Baymaxawa"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "Readme" "$INSTDIR\readme.txt"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "DisplayVersion" "1.9.1 Beta 1"
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "NoModify" 0x00000001
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "NoRepair" 0x00000001
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese" "EstimatedSize" 0x00010240
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

Section /o "���ǰ�װ�빴ѡ����" OverwriteInstallation

  SetOutPath "$INSTDIR"
  Delete $INSTDIR\BepInEx\config\BaldisBasicsPlus99ChinesePlugin.cfg

SectionEnd

SectionGroup "����ģ�飨��ѡ��"

Section /o "ģ��API������ģ���ǰ�ã�" BBPlusModdingAPI
   
   SetOutPath "$INSTDIR\BepInEx\plugins"
   
   DetailPrint "Installing..."
   File mods\MTM101BaldAPI.dll
   File mods\Newtonsoft.Json.dll
   File mods\MTM101BaldAPI.xml
   
SectionEnd

SectionGroupEnd

SectionGroup "-���ʰ�����ѡ��"

SectionGroupEnd

;--------------------------------
;Installer Functions

## Displays the password dialog Enable when beta out
Function PasswordPageShow

  !insertmacro MUI_HEADER_TEXT "��������" "������Ҫһ����ȷ�İ�װ������ܼ�����"

  PassDialog::InitDialog /NOUNLOAD Password /HEADINGTEXT "���Ⱥ873338741��ȡ���룡" /GROUPTEXT "���������"
  Pop $R0 # Page HWND

  GetDlgItem $R1 $R0 ${IDC_PASSWORD}
  SendMessage $R1 ${EM_SETPASSWORDCHAR} 178 0

  PassDialog::Show

FunctionEnd

## Validate password
Function PasswordPageLeave

  ## Pop password from stack
  Pop $R0

  ## A bit of validation
  StrCmp $R0 '${Password}' +3
   MessageBox MB_OK|MB_ICONEXCLAMATION "���������������ȷ�İ�װ���룡"
   Abort

FunctionEnd

Function ComponentsPageShow

 ## Disable the Back button
 GetDlgItem $R0 $HWNDPARENT 3
 EnableWindow $R0 0

FunctionEnd

Function StartGame
  Exec "explorer steam://run/1275890"
FunctionEnd

Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

Function .onSelChange
  SectionGetFlags ${BBPlusschinese} $R0
  IntOp $0 $R0 | ${SF_SELECTED}
  SectionSetFlags ${BBPlusschinese} $0
FunctionEnd


;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...
  SetOutPath $INSTDIR
  DetailPrint "Deleting files..."
  File 7z.exe
  File 7z.dll
  File uninstallpack.zip
  ExecWait "7z.exe x uninstallpack.zip -y"
  Delete $INSTDIR\7z.exe
  Delete $INSTDIR\7z.dll
  Delete $INSTDIR\uninstallpack.zip
  DeleteRegKey /ifempty HKCU "Software\BBPlusSChinese"
  Delete $INSTDIR\arialuni_sdf_u2018
  Delete $INSTDIR\arialuni_sdf_u2019
  Delete $INSTDIR\doorstop_config.ini
  Delete $INSTDIR\readme.txt
  Delete $INSTDIR\winhttp.dll
  RMDir /r $INSTDIR\BepInEx
  RMDir /r $INSTDIR\BALDI_Data\StreamingAssets\Modded
  Delete $INSTDIR\icon.ico
  Delete $INSTDIR\.doorstop_version
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\bbpchinese"
  DetailPrint "Deleting uninstaller..."
  Delete "$INSTDIR\Uninstall.exe"

SectionEnd

;--------------------------------
;Uninstaller Functions

Function un.onInit

  !insertmacro MUI_UNGETLANGUAGE
  
FunctionEnd