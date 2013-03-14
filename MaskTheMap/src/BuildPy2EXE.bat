:: MODULE doesn't contain the extension name.
@echo off
:: if "%1%" == "" goto Usage
set MODULE=MaskTheMap
echo from distutils.core import setup   > setup.py
echo import py2exe                      >>setup.py
echo setup(console=['%MODULE%.py'])        >>setup.py
echo setup(console=['%MODULE%.py'])        
python setup.py py2exe
copy dist\* ..\%MODULE%\

goto End

:Usage
echo Usage: BuildPy2EXE MODULE

:End
pause
