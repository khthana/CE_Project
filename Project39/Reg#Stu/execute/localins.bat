md c:\register

copy a:\regsvr32.exe c:\windows

copy a:\logonmgr.dll c:\register
copy a:\stdmgr.exe c:\register
copy a:\std2mgr.exe c:\register
copy a:\allmgr.exe c:\register

xcopy a:\stdmntc.exe c:\register
 
regsvr32.exe c:\register\logonmgr.dll
c:\register\stdmgr.exe /regsvr32
c:\register\std2mgr.exe /regsvr32
c:\register\allmgr.exe /regsvr32
stdmntc.exe
