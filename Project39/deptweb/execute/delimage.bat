set test=%output_file%
cd c:\Progra~1\WebSite\cgi-dos\intranet\Image\
if "%1"=="1" goto CONT1
if "%1"=="2" goto CONT2
if "%1"=="3" goto CONT3
if "%1"=="4" goto CONT4
del %6
:CONT4
del %5
:CONT3
del %4
:CONT2
del %3
:CONT1
del %2

echo Location: http://hppc07.ce.kmitl.ac.th/cgi-win/intranet/1/tempfile.exe?%7 >> %test%
echo. >> %test%