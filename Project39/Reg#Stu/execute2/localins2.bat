md c:\register

copy a:\regsvr32.exe c:\windows

copy a:\logonmgr.dll c:\register
copy a:\Curricumgr.exe c:\register
copy a:\Currisumgr.exe c:\register
copy a:\Currisbmgr.exe c:\register
copy a:\Depmgr.exe c:\register
copy a:\Facmgr.exe c:\register
copy a:\Subjmgr.exe c:\register
copy a:\SubGpmgr.exe c:\register
copy a:\allmgr.exe c:\register

xcopy a:\Currmntc.exe c:\register
 
regsvr32.exe c:\register\logonmgr.dll

c:\register\Curricumgr.exe /regsvr32
c:\register\Currisumgr.exe /regsvr32
c:\register\Currisbmgr.exe /regsvr32
c:\register\Depmgr.exe /regsvr32
c:\register\Facmgr.exe /regsvr32
c:\register\Subjmgr.exe /regsvr32
c:\register\SubGpmgr.exe /regsvr32
c:\register\allmgr.exe /regsvr32

Currmntc.exe
