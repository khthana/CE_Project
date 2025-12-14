md c:\register

copy a:\logonmgr.dll c:\register
xcopy a:\stdmntc.exe c:\register

regsvr32.exe c:\register\logonmgr.dll
