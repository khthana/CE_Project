# Microsoft Developer Studio Generated NMAKE File, Format Version 4.20
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

!IF "$(CFG)" == ""
CFG=dblogic - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to dblogic - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "dblogic - Win32 Release" && "$(CFG)" != "dblogic - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "dblogic.mak" CFG="dblogic - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "dblogic - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "dblogic - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 
################################################################################
# Begin Project
# PROP Target_Last_Scanned "dblogic - Win32 Debug"
CPP=cl.exe
RSC=rc.exe
MTL=mktyplib.exe

!IF  "$(CFG)" == "dblogic - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
OUTDIR=.\Release
INTDIR=.\Release

ALL : "$(OUTDIR)\dblogic.bld"

CLEAN : 
	-@erase "$(INTDIR)\dblogic.obj"
	-@erase "$(OUTDIR)\dblogic.bld"
	-@erase "$(OUTDIR)\dblogic.exp"
	-@erase "$(OUTDIR)\dblogic.lib"
	-@erase "$(OUTDIR)\dblogic.map"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /MT /W3  /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /MT /W3  /GX /O2 /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "MI_SERVBUILD" /D "NT" /D "GL_NT_STATIC" /D "NT_MI_SAPI" /YX /c
CPP_PROJ=/nologo /MT /W3  /GX /O2 \
 /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "MI_SERVBUILD"\
 /D "NT" /D "GL_NT_STATIC" /D "NT_MI_SAPI" /Fp"$(INTDIR)/dblogic.pch" /YX\
 /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\Release/
CPP_SBRS=.\.
# ADD BASE MTL /nologo /D "NDEBUG" /win32
# ADD MTL /nologo /D "NDEBUG" /win32
MTL_PROJ=/nologo /D "NDEBUG" /win32 
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/dblogic.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib sapi.lib msvcrt.lib /nologo /subsystem:windows /dll /map /machine:I386 /nodefaultlib:"libcmt.lib" /nodefaultlib /out:"Release/dblogic.bld"
# SUBTRACT LINK32 /incremental:yes /debug
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib sapi.lib msvcrt.lib /nologo /subsystem:windows /dll\
 /incremental:no /pdb:"$(OUTDIR)/dblogic.pdb" /map:"$(INTDIR)/dblogic.map"\
 /machine:I386 /nodefaultlib:"libcmt.lib" /nodefaultlib /def:".\dblogic.def"\
 /out:"$(OUTDIR)/dblogic.bld" /implib:"$(OUTDIR)/dblogic.lib" 
DEF_FILE= \
	".\dblogic.def"
LINK32_OBJS= \
	"$(INTDIR)\dblogic.obj"

"$(OUTDIR)\dblogic.bld" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "dblogic - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
OUTDIR=.\Debug
INTDIR=.\Debug

ALL : "$(OUTDIR)\dblogic.bld"

CLEAN : 
	-@erase "$(INTDIR)\dblogic.obj"
	-@erase "$(OUTDIR)\dblogic.bld"
	-@erase "$(OUTDIR)\dblogic.exp"
	-@erase "$(OUTDIR)\dblogic.lib"
	-@erase "$(OUTDIR)\dblogic.map"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /MTd /W3 /Gm  /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /MTd /W3  /GX /Z7 /Od /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "MI_SERVBUILD" /D "NT" /D "GL_NT_STATIC" /D "NT_MI_SAPI" /YX /c
# SUBTRACT CPP /Fr
CPP_PROJ=/nologo /MTd /W3  /GX /Z7 /Od \
/D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "MI_SERVBUILD"\
 /D "NT" /D "GL_NT_STATIC" /D "NT_MI_SAPI" /Fp"$(INTDIR)/dblogic.pch" /YX\
 /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\Debug/
CPP_SBRS=.\.
# ADD BASE MTL /nologo /D "_DEBUG" /win32
# ADD MTL /nologo /D "_DEBUG" /win32
MTL_PROJ=/nologo /D "_DEBUG" /win32 
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/dblogic.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /debug /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib sapi.lib msvcrt.lib /nologo /subsystem:windows /dll /pdb:none /map /debug /machine:I386 /nodefaultlib:"libcmt.lib" /nodefaultlib /out:"Debug/dblogic.bld"
# SUBTRACT LINK32 /nodefaultlib
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib sapi.lib msvcrt.lib /nologo /subsystem:windows /dll /pdb:none\
 /map:"$(INTDIR)/dblogic.map" /debug /machine:I386 /nodefaultlib:"libcmt.lib"\
 /nodefaultlib /def:".\dblogic.def" /out:"$(OUTDIR)/dblogic.bld" /implib:"$(OUTDIR)/dblogic.lib" 
DEF_FILE= \
	".\dblogic.def"
LINK32_OBJS= \
	"$(INTDIR)\dblogic.obj"

"$(OUTDIR)\dblogic.bld" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.c{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Target

# Name "dblogic - Win32 Release"
# Name "dblogic - Win32 Debug"

!IF  "$(CFG)" == "dblogic - Win32 Release"

!ELSEIF  "$(CFG)" == "dblogic - Win32 Debug"

!ENDIF 

################################################################################
# Begin Source File

SOURCE=.\dblogic.c
DEP_CPP_dblogic=\
	".\dblogic.h"\
	"blob.h"\
	"collct.h"\
	"datetime.h"\
	"decimal.h"\
	"gls.h"\
	"ifxgls.h"\
	"int8.h"\
	"locator.h"\
	"memdur.h"\
	"mi.h"\
	"miback.h"\
	"miconv.h"\
	"milib.h"\
	"milo.h"\
	"miloback.h"\
	"mitrace.h"\
	"mitypes.h"\
	"sqlca.h"\
	"sqlda.h"\
	"sqlhdr.h"\
	"value.h"\
	{$(INCLUDE)}"\sys\types.h"\
	

"$(INTDIR)\dblogic.obj" : $(SOURCE) $(DEP_CPP_dblogic) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\dblogic.txt

!IF  "$(CFG)" == "dblogic - Win32 Release"

!ELSEIF  "$(CFG)" == "dblogic - Win32 Debug"

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\dblogic.def

!IF  "$(CFG)" == "dblogic - Win32 Release"

!ELSEIF  "$(CFG)" == "dblogic - Win32 Debug"

!ENDIF 

# End Source File
# End Target
# End Project
################################################################################
