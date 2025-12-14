# Microsoft Developer Studio Generated NMAKE File, Based on SecureShell.dsp
!IF "$(CFG)" == ""
CFG=SecureShell - Win32 Debug
!MESSAGE No configuration specified. Defaulting to SecureShell - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "SecureShell - Win32 Release" && "$(CFG)" !=\
 "SecureShell - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "SecureShell.mak" CFG="SecureShell - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "SecureShell - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "SecureShell - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "SecureShell - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\SecureShell.exe"

!ELSE 

ALL : "$(OUTDIR)\SecureShell.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\3DES.obj"
	-@erase "$(INTDIR)\BigNumber.obj"
	-@erase "$(INTDIR)\DES.obj"
	-@erase "$(INTDIR)\Emulation.obj"
	-@erase "$(INTDIR)\LoginDlg.obj"
	-@erase "$(INTDIR)\MainFrm.obj"
	-@erase "$(INTDIR)\MD5.obj"
	-@erase "$(INTDIR)\MessageDigest.obj"
	-@erase "$(INTDIR)\SecureCrypto.obj"
	-@erase "$(INTDIR)\SecureMisc.obj"
	-@erase "$(INTDIR)\SecurePacket.obj"
	-@erase "$(INTDIR)\SecureShell.obj"
	-@erase "$(INTDIR)\SecureShell.pch"
	-@erase "$(INTDIR)\SecureShell.res"
	-@erase "$(INTDIR)\SecureShellDoc.obj"
	-@erase "$(INTDIR)\SecureShellIO.obj"
	-@erase "$(INTDIR)\SecureShellSocket.obj"
	-@erase "$(INTDIR)\SecureShellView.obj"
	-@erase "$(INTDIR)\StdAfx.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\VT100.obj"
	-@erase "$(OUTDIR)\SecureShell.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D\
 "_AFXDLL" /Fp"$(INTDIR)\SecureShell.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\"\
 /Fd"$(INTDIR)\\" /FD /c 
CPP_OBJS=.\Release/
CPP_SBRS=.

.c{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

MTL=midl.exe
MTL_PROJ=/nologo /D "NDEBUG" /mktyplib203 /o NUL /win32 
RSC=rc.exe
RSC_PROJ=/l 0x41e /fo"$(INTDIR)\SecureShell.res" /d "NDEBUG" /d "_AFXDLL" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\SecureShell.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=/nologo /subsystem:windows /incremental:no\
 /pdb:"$(OUTDIR)\SecureShell.pdb" /machine:I386 /out:"$(OUTDIR)\SecureShell.exe"\
 
LINK32_OBJS= \
	"$(INTDIR)\3DES.obj" \
	"$(INTDIR)\BigNumber.obj" \
	"$(INTDIR)\DES.obj" \
	"$(INTDIR)\Emulation.obj" \
	"$(INTDIR)\LoginDlg.obj" \
	"$(INTDIR)\MainFrm.obj" \
	"$(INTDIR)\MD5.obj" \
	"$(INTDIR)\MessageDigest.obj" \
	"$(INTDIR)\SecureCrypto.obj" \
	"$(INTDIR)\SecureMisc.obj" \
	"$(INTDIR)\SecurePacket.obj" \
	"$(INTDIR)\SecureShell.obj" \
	"$(INTDIR)\SecureShell.res" \
	"$(INTDIR)\SecureShellDoc.obj" \
	"$(INTDIR)\SecureShellIO.obj" \
	"$(INTDIR)\SecureShellSocket.obj" \
	"$(INTDIR)\SecureShellView.obj" \
	"$(INTDIR)\StdAfx.obj" \
	"$(INTDIR)\VT100.obj"

"$(OUTDIR)\SecureShell.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "SecureShell - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

!IF "$(RECURSE)" == "0" 

ALL : "$(OUTDIR)\SecureShell.exe"

!ELSE 

ALL : "$(OUTDIR)\SecureShell.exe"

!ENDIF 

CLEAN :
	-@erase "$(INTDIR)\3DES.obj"
	-@erase "$(INTDIR)\BigNumber.obj"
	-@erase "$(INTDIR)\DES.obj"
	-@erase "$(INTDIR)\Emulation.obj"
	-@erase "$(INTDIR)\LoginDlg.obj"
	-@erase "$(INTDIR)\MainFrm.obj"
	-@erase "$(INTDIR)\MD5.obj"
	-@erase "$(INTDIR)\MessageDigest.obj"
	-@erase "$(INTDIR)\SecureCrypto.obj"
	-@erase "$(INTDIR)\SecureMisc.obj"
	-@erase "$(INTDIR)\SecurePacket.obj"
	-@erase "$(INTDIR)\SecureShell.obj"
	-@erase "$(INTDIR)\SecureShell.pch"
	-@erase "$(INTDIR)\SecureShell.res"
	-@erase "$(INTDIR)\SecureShellDoc.obj"
	-@erase "$(INTDIR)\SecureShellIO.obj"
	-@erase "$(INTDIR)\SecureShellSocket.obj"
	-@erase "$(INTDIR)\SecureShellView.obj"
	-@erase "$(INTDIR)\StdAfx.obj"
	-@erase "$(INTDIR)\vc50.idb"
	-@erase "$(INTDIR)\vc50.pdb"
	-@erase "$(INTDIR)\VT100.obj"
	-@erase "$(OUTDIR)\SecureShell.exe"
	-@erase "$(OUTDIR)\SecureShell.ilk"
	-@erase "$(OUTDIR)\SecureShell.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)\SecureShell.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\"\
 /FD /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.

.c{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_OBJS)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(CPP_SBRS)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

MTL=midl.exe
MTL_PROJ=/nologo /D "_DEBUG" /mktyplib203 /o NUL /win32 
RSC=rc.exe
RSC_PROJ=/l 0x41e /fo"$(INTDIR)\SecureShell.res" /d "_DEBUG" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\SecureShell.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=/nologo /subsystem:windows /incremental:yes\
 /pdb:"$(OUTDIR)\SecureShell.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\SecureShell.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\3DES.obj" \
	"$(INTDIR)\BigNumber.obj" \
	"$(INTDIR)\DES.obj" \
	"$(INTDIR)\Emulation.obj" \
	"$(INTDIR)\LoginDlg.obj" \
	"$(INTDIR)\MainFrm.obj" \
	"$(INTDIR)\MD5.obj" \
	"$(INTDIR)\MessageDigest.obj" \
	"$(INTDIR)\SecureCrypto.obj" \
	"$(INTDIR)\SecureMisc.obj" \
	"$(INTDIR)\SecurePacket.obj" \
	"$(INTDIR)\SecureShell.obj" \
	"$(INTDIR)\SecureShell.res" \
	"$(INTDIR)\SecureShellDoc.obj" \
	"$(INTDIR)\SecureShellIO.obj" \
	"$(INTDIR)\SecureShellSocket.obj" \
	"$(INTDIR)\SecureShellView.obj" \
	"$(INTDIR)\StdAfx.obj" \
	"$(INTDIR)\VT100.obj"

"$(OUTDIR)\SecureShell.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(CFG)" == "SecureShell - Win32 Release" || "$(CFG)" ==\
 "SecureShell - Win32 Debug"
SOURCE=.\3DES.cpp
DEP_CPP_3DES_=\
	".\3DES.h"\
	".\DES.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\3DES.obj" : $(SOURCE) $(DEP_CPP_3DES_) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\BigNumber.cpp
DEP_CPP_BIGNU=\
	".\BigNumber.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\BigNumber.obj" : $(SOURCE) $(DEP_CPP_BIGNU) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\DES.cpp
DEP_CPP_DES_C=\
	".\DES.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\DES.obj" : $(SOURCE) $(DEP_CPP_DES_C) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\Emulation.cpp

!IF  "$(CFG)" == "SecureShell - Win32 Release"

DEP_CPP_EMULA=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\SecureCrypto.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\StdAfx.h"\
	".\VT100.h"\
	

"$(INTDIR)\Emulation.obj" : $(SOURCE) $(DEP_CPP_EMULA) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ELSEIF  "$(CFG)" == "SecureShell - Win32 Debug"

DEP_CPP_EMULA=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\SecureCrypto.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\VT100.h"\
	

"$(INTDIR)\Emulation.obj" : $(SOURCE) $(DEP_CPP_EMULA) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ENDIF 

SOURCE=.\LoginDlg.cpp

!IF  "$(CFG)" == "SecureShell - Win32 Release"

DEP_CPP_LOGIN=\
	".\LoginDlg.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\LoginDlg.obj" : $(SOURCE) $(DEP_CPP_LOGIN) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ELSEIF  "$(CFG)" == "SecureShell - Win32 Debug"

DEP_CPP_LOGIN=\
	".\LoginDlg.h"\
	".\SecureShell.h"\
	

"$(INTDIR)\LoginDlg.obj" : $(SOURCE) $(DEP_CPP_LOGIN) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ENDIF 

SOURCE=.\MainFrm.cpp
DEP_CPP_MAINF=\
	".\MainFrm.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\MainFrm.obj" : $(SOURCE) $(DEP_CPP_MAINF) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\MD5.cpp
DEP_CPP_MD5_C=\
	".\MD5.h"\
	".\MessageDigest.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\MD5.obj" : $(SOURCE) $(DEP_CPP_MD5_C) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\MessageDigest.cpp
DEP_CPP_MESSA=\
	".\MessageDigest.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\MessageDigest.obj" : $(SOURCE) $(DEP_CPP_MESSA) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\SecureCrypto.cpp
DEP_CPP_SECUR=\
	".\3DES.h"\
	".\BigNumber.h"\
	".\DES.h"\
	".\SecureCrypto.h"\
	".\SecureMisc.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\SecureCrypto.obj" : $(SOURCE) $(DEP_CPP_SECUR) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\SecureMisc.cpp
DEP_CPP_SECURE=\
	".\MD5.h"\
	".\MessageDigest.h"\
	".\SecureMisc.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\SecureMisc.obj" : $(SOURCE) $(DEP_CPP_SECURE) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\SecurePacket.cpp
DEP_CPP_SECUREP=\
	".\3DES.h"\
	".\DES.h"\
	".\SecureCrypto.h"\
	".\SecureMisc.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\SecurePacket.obj" : $(SOURCE) $(DEP_CPP_SECUREP) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\SecureShell.cpp
DEP_CPP_SECURES=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\MainFrm.h"\
	".\SecureCrypto.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellDoc.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\StdAfx.h"\
	".\VT100.h"\
	

"$(INTDIR)\SecureShell.obj" : $(SOURCE) $(DEP_CPP_SECURES) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\SecureShell.rc
DEP_RSC_SECURESH=\
	".\res\SecureShell.ico"\
	".\res\SecureShell.rc2"\
	".\res\SecureShellDoc.ico"\
	".\res\Toolbar.bmp"\
	

"$(INTDIR)\SecureShell.res" : $(SOURCE) $(DEP_RSC_SECURESH) "$(INTDIR)"
	$(RSC) $(RSC_PROJ) $(SOURCE)


SOURCE=.\SecureShellDoc.cpp
DEP_CPP_SECURESHE=\
	".\SecureShell.h"\
	".\SecureShellDoc.h"\
	".\StdAfx.h"\
	

"$(INTDIR)\SecureShellDoc.obj" : $(SOURCE) $(DEP_CPP_SECURESHE) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


SOURCE=.\SecureShellIO.cpp

!IF  "$(CFG)" == "SecureShell - Win32 Release"

DEP_CPP_SECURESHEL=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\MD5.h"\
	".\MessageDigest.h"\
	".\SecureCrypto.h"\
	".\SecureMisc.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\StdAfx.h"\
	".\VT100.h"\
	

"$(INTDIR)\SecureShellIO.obj" : $(SOURCE) $(DEP_CPP_SECURESHEL) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ELSEIF  "$(CFG)" == "SecureShell - Win32 Debug"

DEP_CPP_SECURESHEL=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\MD5.h"\
	".\MessageDigest.h"\
	".\SecureCrypto.h"\
	".\SecureMisc.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\VT100.h"\
	

"$(INTDIR)\SecureShellIO.obj" : $(SOURCE) $(DEP_CPP_SECURESHEL) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ENDIF 

SOURCE=.\SecureShellSocket.cpp
DEP_CPP_SECURESHELL=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\SecureCrypto.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\StdAfx.h"\
	".\VT100.h"\
	

"$(INTDIR)\SecureShellSocket.obj" : $(SOURCE) $(DEP_CPP_SECURESHELL)\
 "$(INTDIR)" "$(INTDIR)\SecureShell.pch"


SOURCE=.\SecureShellView.cpp

!IF  "$(CFG)" == "SecureShell - Win32 Release"

DEP_CPP_SECURESHELLV=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\LoginDlg.h"\
	".\SecureCrypto.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellDoc.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\StdAfx.h"\
	".\VT100.h"\
	

"$(INTDIR)\SecureShellView.obj" : $(SOURCE) $(DEP_CPP_SECURESHELLV) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ELSEIF  "$(CFG)" == "SecureShell - Win32 Debug"

DEP_CPP_SECURESHELLV=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\LoginDlg.h"\
	".\SecureCrypto.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellDoc.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\VT100.h"\
	

"$(INTDIR)\SecureShellView.obj" : $(SOURCE) $(DEP_CPP_SECURESHELLV) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ENDIF 

SOURCE=.\StdAfx.cpp
DEP_CPP_STDAF=\
	".\StdAfx.h"\
	

!IF  "$(CFG)" == "SecureShell - Win32 Release"

CPP_SWITCHES=/nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D\
 "_AFXDLL" /Fp"$(INTDIR)\SecureShell.pch" /Yc"stdafx.h" /Fo"$(INTDIR)\\"\
 /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\StdAfx.obj"	"$(INTDIR)\SecureShell.pch" : $(SOURCE) $(DEP_CPP_STDAF)\
 "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "SecureShell - Win32 Debug"

CPP_SWITCHES=/nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D\
 "_WINDOWS" /Fp"$(INTDIR)\SecureShell.pch" /Yc"stdafx.h" /Fo"$(INTDIR)\\"\
 /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\StdAfx.obj"	"$(INTDIR)\SecureShell.pch" : $(SOURCE) $(DEP_CPP_STDAF)\
 "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\VT100.cpp

!IF  "$(CFG)" == "SecureShell - Win32 Release"

DEP_CPP_VT100=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\SecureCrypto.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\StdAfx.h"\
	".\VT100.h"\
	

"$(INTDIR)\VT100.obj" : $(SOURCE) $(DEP_CPP_VT100) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ELSEIF  "$(CFG)" == "SecureShell - Win32 Debug"

DEP_CPP_VT100=\
	".\3DES.h"\
	".\DES.h"\
	".\Emulation.h"\
	".\SecureCrypto.h"\
	".\SecurePacket.h"\
	".\SecureShell.h"\
	".\SecureShellIO.h"\
	".\SecureShellSocket.h"\
	".\SecureShellView.h"\
	".\VT100.h"\
	

"$(INTDIR)\VT100.obj" : $(SOURCE) $(DEP_CPP_VT100) "$(INTDIR)"\
 "$(INTDIR)\SecureShell.pch"


!ENDIF 


!ENDIF 

