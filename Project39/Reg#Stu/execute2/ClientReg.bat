md c:\register

copy a:\regsvr32.exe c:\windows
copy a:\logonmgr.dll c:\register

xcopy a:\Currmntc.exe c:\register

regsvr32.exe c:\register\logonmgr.dll
