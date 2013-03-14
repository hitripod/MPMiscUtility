@echo off

set WINRAR_EXE="C:\Program Files\WinRAR\winrar.exe"
set OPT_LEVEL=3
set FILE_E="PCIE"
set FILE_U="USB"
set FILE_S="SDIO"

set IC=8812A
set PCIE=MP_Kit_RTL11ac_%IC%_PCIE
set USB=MP_Kit_RTL11ac_%IC%_USB
set SDIO=MP_Kit_RTL11ac_%IC%_SDIO

chgcolor E0
echo Packaging...
chgcolor 07
%WINRAR_EXE% a -afzip -ag_yyyyMMdd -m%OPT_LEVEL% -ed ..\%PCIE%_v%1.zip "..\%PCIE%
%WINRAR_EXE% a -afzip -ag_yyyyMMdd -m%OPT_LEVEL% -ed ..\%USB%_v%2.zip "..\%USB%
::%WINRAR_EXE% a -afzip -ag_yyyyMMdd -m%OPT_LEVEL% -ed -p%SDIO% ..\%SDIO%_v%3.zip "..\%SDIO%
