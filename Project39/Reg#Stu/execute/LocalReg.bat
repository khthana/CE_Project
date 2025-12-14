copy a:\regsvr32.exe c:\windows

copy a:\logonmgr.dll c:\register
copy a:\stdmgr.exe c:\register
copy a:\stdmgrs.exe c:\register
copy a:\allmgr.exe c:\register
 
regsvr32 c:\register\logonmgr.dll
c:\register\stdmgr.exe /regsvr32
c:\register\stdmgrs.exe /regsvr32
c:\register\allmgr.exe /regsvr32
