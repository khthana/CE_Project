set test=%output_file%
cd c:\Progra~1\website\cgi-win\intranet\
md %1
copy list.exe %1
copy Result.exe %1
copy check.exe %1
echo Location: %2/cgi-win/intranet/1/paperout.exe >> %test%
echo. >> %test%
