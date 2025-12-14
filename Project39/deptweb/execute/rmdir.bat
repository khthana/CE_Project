set test=%output_file%
cd c:\Progra~1\website\cgi-win\intranet\
cd %1
del list.exe 
del Result.exe 
del check.exe 
cd ..
rd %1
echo Location: %3/cgi-win/intranet/1/paperin.exe?%2 >> %test%
echo. >> %test%