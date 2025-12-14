@echo off
cls
echo;
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³                    *****  NOTE  *****                     ³
echo ³                                                           ³
echo ³     Before executing MAKEALL, consult the README.TXT file ³
echo ³ in this diskette for a detailed explanation & information ³
echo ³ about our recent upgrade.                                 ³
echo ³                                                           ³
echo ³  Press Ctrl-C to Exit                  anykey to continue ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
echo;
echo Calling Microsoft C to make *.OBJ & *.EXE files.
pause
cls
set include=c:\vm\mc\include
set lib=c:\vm\mc\lib
set tmp=c:\vm\mc
@echo on
make -fDEVC.DES
make -fVIDO.DES
make -fSTOR.DES
make -fSTOR1.DES
make -fVMEM.DES
@echo off
echo;
echo Calling LIB to make *.LIB files.
pause
call makelib.bat
