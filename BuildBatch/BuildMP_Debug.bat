set MPDriverPath="C:\Users\Kordan\Desktop\RTK\RTL8812_MPTest"

set DDK_CHECKED_X86=C:\WINDDK\3790~1.183\bin\setenv.bat C:\WINDDK\3790~1.183 chk WXP
set DDK_CHECKED_X64=^&^& C:\WINDDK\3790~1.183\bin\setenv.bat C:\WINDDK\3790~1.183 chk AMD64 WNET
set CHDIR=^&^&      cd %MPDriverPath%
set CLEANALL=^&^&   buildcleanall
set BUILDALL=^&^&   mpbuild all
set CHECKALL=^&^&   mpbuild check

set BUILD_CHECKED="%DDK_CHECKED_X86%%CHDIR%%CLEANALL%%BUILDALL%%DDK_CHECKED_X64%%CHDIR%%BUILDALL%%CHECKALL%"

C:\Windows\System32\cmd.exe /k %BUILD_CHECKED%
pause
