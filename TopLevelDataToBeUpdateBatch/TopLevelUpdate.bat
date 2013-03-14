@echo off
set IC_11n=SingleChip_9xC,8723A,8188E
set IC_11ac=8812A,8821A
set IC_SupportNewMP=8812A,8821A
set IC_SupportNewUI=RTL11n_8723A,RTL11n_8188E,RTL11ac_8812A,RTL11ac_8821A

chgcolor 70
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Start <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
chgcolor 07
if exist mp819xbd.dll (
    chgcolor E0
    echo DLL\mp819xbd.dll
    chgcolor 07
    FOR %%i IN (%IC_11n%) DO cp -v  mp819xbd.dll ..\InstallShield\MP_Kit_RTL11n_%i%_PCIE%\DLL\mp819xbd.dll 
    FOR %%i IN (%IC_11n%) DO cp -v  mp819xbd.dll  ..\InstallShield\MP_Kit_RTL11n_%i%_USB%\DLL\mp819xbd.dll 
    FOR %%i IN (%IC_11n%) DO cp -v  mp819xbd.dll ..\InstallShield\MP_Kit_RTL11n_%i%_SDIO%\DLL\mp819xbd.dll 
    FOR %%i IN (%IC_11ac%) DO cp -v mp819xbd.dll ..\InstallShield\MP_Kit_RTL11ac_%i%_PCIE%\DLL\mp819xbd.dll 
    FOR %%i IN (%IC_11ac%) DO cp -v mp819xbd.dll  ..\InstallShield\MP_Kit_RTL11ac_%i%_USB%\DLL\mp819xbd.dll 
    FOR %%i IN (%IC_11ac%) DO cp -v mp819xbd.dll ..\InstallShield\MP_Kit_RTL11ac_%i%_SDIO%\DLL\mp819xbd.dll 
)
if exist mp819xbd.lib (
    chgcolor E0
    echo DLL\mp819xbd.lib
    chgcolor 07
    FOR %%i IN (%IC_11n%) DO cp -v  mp819xbd.lib ..\InstallShield\MP_Kit_RTL11n_%i%_PCIE%\DLL\mp819xbd.lib 
    FOR %%i IN (%IC_11n%) DO cp -v  mp819xbd.lib  ..\InstallShield\MP_Kit_RTL11n_%i%_USB%\DLL\mp819xbd.lib 
    FOR %%i IN (%IC_11n%) DO cp -v  mp819xbd.lib ..\InstallShield\MP_Kit_RTL11n_%i%_SDIO%\DLL\mp819xbd.lib 
    FOR %%i IN (%IC_11ac%) DO cp -v mp819xbd.lib ..\InstallShield\MP_Kit_RTL11ac_%i%_PCIE%\DLL\mp819xbd.lib 
    FOR %%i IN (%IC_11ac%) DO cp -v mp819xbd.lib  ..\InstallShield\MP_Kit_RTL11ac_%i%_USB%\DLL\mp819xbd.lib 
    FOR %%i IN (%IC_11ac%) DO cp -v mp819xbd.lib ..\InstallShield\MP_Kit_RTL11ac_%i%_SDIO%\DLL\mp819xbd.lib 
)
if exist packet32.h (
    chgcolor E0
    echo DLL\packet32.h
    chgcolor 07
    FOR %%i IN (%IC_11n%) DO cp -v  packet32.h ..\InstallShield\MP_Kit_RTL11n_%i%_PCIE%\DLL\packet32.h
    FOR %%i IN (%IC_11n%) DO cp -v  packet32.h  ..\InstallShield\MP_Kit_RTL11n_%i%_USB%\DLL\packet32.h
    FOR %%i IN (%IC_11n%) DO cp -v  packet32.h ..\InstallShield\MP_Kit_RTL11n_%i%_SDIO%\DLL\packet32.h
    FOR %%i IN (%IC_11ac%) DO cp -v packet32.h ..\InstallShield\MP_Kit_RTL11ac_%i%_PCIE%\DLL\packet32.h
    FOR %%i IN (%IC_11ac%) DO cp -v packet32.h  ..\InstallShield\MP_Kit_RTL11ac_%i%_USB%\DLL\packet32.h
    FOR %%i IN (%IC_11ac%) DO cp -v packet32.h ..\InstallShield\MP_Kit_RTL11ac_%i%_SDIO%\DLL\packet32.h
)

if exist MP819xVC.exe (
    chgcolor E0
    echo UI\MP819xVC.exe
    chgcolor 07
    
    FOR %%i IN (%IC_SupportNewUI%) DO cp -v MP819xVC.exe ..\InstallShield\MP_Kit_%i%_PCIE\MpUtility\MP819xVC.exe
    FOR %%i IN (%IC_SupportNewUI%) DO cp -v MP819xVC.exe ..\InstallShield\MP_Kit_%i%_PCIE\MpUtility\MP819xVC.exe
    FOR %%i IN (%IC_SupportNewUI%) DO cp -v MP819xVC.exe ..\InstallShield\MP_Kit_%i%_PCIE\MpUtility\MP819xVC.exe
)        

if exist RTL819xVC.zip (
    chgcolor E0
    echo UI Sample Code
    chgcolor 07
    cp -v RTL819xVC.zip ..\InstallShield\MP_Kit_%PROTOCOL%_%ICE_DIR%\UI_Sample_Code\RTL819xVC.zip
    cp -v RTL819xVC.zip ..\InstallShield\MP_Kit_%PROTOCOL%_%ICS_DIR%\UI_Sample_Code\RTL819xVC.zip
    cp -v RTL819xVC.zip ..\InstallShield\MP_Kit_%PROTOCOL%_%ICU_DIR%\UI_Sample_Code\RTL819xVC.zip
)
