set test=%output_file%
cd c:\Progra~1\Website\cgi-dos\intranet\image\
if "%1"=="1" goto CONT1
if "%1"=="2" goto CONT2
if "%1"=="3" goto CONT3
if "%1"=="4" goto CONT4
cjpeg %6
del %6
:CONT4
cjpeg %5
del %5
:CONT3
cjpeg %4
del %4
:CONT2
cjpeg %3
del %3
:CONT1
cjpeg %2
del %2
echo Location: %8/cgi-win/intranet/1/paperin.exe?%7 >> %test%
echo. >> %test%
