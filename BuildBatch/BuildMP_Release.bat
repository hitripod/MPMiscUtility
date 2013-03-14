set MPDriverPath="C:\Users\Kordan\Desktop\RTK\RTL8812_MPTest"

set DDK_FREE_X86=C:\WINDDK\3790~1.183\bin\setenv.bat C:\WINDDK\3790~1.183 fre WXP
set DDK_FREE_X64=^&^& C:\WINDDK\3790~1.183\bin\setenv.bat C:\WINDDK\3790~1.183 fre AMD64 WNET
set CHDIR=^&^&      cd %MPDriverPath%
set CLEANALL=^&^&   buildcleanall
set BUILDALL=^&^&   mpbuild all

set BUILD_FREE="%DDK_FREE_X86%%CHDIR%%CLEANALL%%BUILDALL%%DDK_FREE_X64%%CHDIR%%BUILDALL%"

C:\Windows\System32\cmd.exe /k %BUILD_FREE%
pause
