# Microsoft Developer Studio Generated NMAKE File, Format Version 4.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

!IF "$(CFG)" == ""
CFG=CDX - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to CDX - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "CDX - Win32 Release" && "$(CFG)" != "CDX - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "CDX.mak" CFG="CDX - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "CDX - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "CDX - Win32 Debug" (based on "Win32 (x86) Static Library")
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
# PROP Target_Last_Scanned "CDX - Win32 Debug"
CPP=cl.exe

!IF  "$(CFG)" == "CDX - Win32 Release"

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

ALL : "$(OUTDIR)\CDX.lib"

CLEAN : 
	-@erase ".\Release\CDX.lib"
	-@erase ".\Release\CDXSoundBuffer.obj"
	-@erase ".\Release\CDXSurface.obj"
	-@erase ".\Release\CDXMusicCd.obj"
	-@erase ".\Release\CDXSprite.obj"
	-@erase ".\Release\CDXResource.obj"
	-@erase ".\Release\CDXSpriteList.obj"
	-@erase ".\Release\CDXMusic.obj"
	-@erase ".\Release\DXErrors.obj"
	-@erase ".\Release\DDUtils.obj"
	-@erase ".\Release\CDXLink.obj"
	-@erase ".\Release\CDXMap.obj"
	-@erase ".\Release\CDXScreen.obj"
	-@erase ".\Release\CDXSound.obj"
	-@erase ".\Release\CDXInput.obj"
	-@erase ".\Release\CDXTile.obj"
	-@erase ".\Release\CDXLayer.obj"
	-@erase ".\Release\CDXAvi.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /W3 /GX /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /W3 /GX /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
CPP_PROJ=/nologo /ML /W3 /GX /D "WIN32" /D "NDEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)/CDX.pch" /YX /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\Release/
CPP_SBRS=
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/CDX.bsc" 
BSC32_SBRS=
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo
LIB32_FLAGS=/nologo /out:"$(OUTDIR)/CDX.lib" 
LIB32_OBJS= \
	"$(INTDIR)/CDXSoundBuffer.obj" \
	"$(INTDIR)/CDXSurface.obj" \
	"$(INTDIR)/CDXMusicCd.obj" \
	"$(INTDIR)/CDXSprite.obj" \
	"$(INTDIR)/CDXResource.obj" \
	"$(INTDIR)/CDXSpriteList.obj" \
	"$(INTDIR)/CDXMusic.obj" \
	"$(INTDIR)/DXErrors.obj" \
	"$(INTDIR)/DDUtils.obj" \
	"$(INTDIR)/CDXLink.obj" \
	"$(INTDIR)/CDXMap.obj" \
	"$(INTDIR)/CDXScreen.obj" \
	"$(INTDIR)/CDXSound.obj" \
	"$(INTDIR)/CDXInput.obj" \
	"$(INTDIR)/CDXTile.obj" \
	"$(INTDIR)/CDXLayer.obj" \
	"$(INTDIR)/CDXAvi.obj"

"$(OUTDIR)\CDX.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
<<

!ELSEIF  "$(CFG)" == "CDX - Win32 Debug"

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

ALL : "$(OUTDIR)\CDX.lib"

CLEAN : 
	-@erase ".\Debug\CDX.lib"
	-@erase ".\Debug\CDXSurface.obj"
	-@erase ".\Debug\CDXSprite.obj"
	-@erase ".\Debug\CDXMusicCd.obj"
	-@erase ".\Debug\CDXResource.obj"
	-@erase ".\Debug\CDXSound.obj"
	-@erase ".\Debug\CDXInput.obj"
	-@erase ".\Debug\CDXMusic.obj"
	-@erase ".\Debug\CDXLayer.obj"
	-@erase ".\Debug\CDXSoundBuffer.obj"
	-@erase ".\Debug\CDXMap.obj"
	-@erase ".\Debug\DDUtils.obj"
	-@erase ".\Debug\CDXLink.obj"
	-@erase ".\Debug\CDXSpriteList.obj"
	-@erase ".\Debug\CDXAvi.obj"
	-@erase ".\Debug\CDXScreen.obj"
	-@erase ".\Debug\CDXTile.obj"
	-@erase ".\Debug\DXErrors.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /c
CPP_PROJ=/nologo /MLd /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)/CDX.pch" /YX /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\Debug/
CPP_SBRS=
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/CDX.bsc" 
BSC32_SBRS=
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo
LIB32_FLAGS=/nologo /out:"$(OUTDIR)/CDX.lib" 
LIB32_OBJS= \
	"$(INTDIR)/CDXSurface.obj" \
	"$(INTDIR)/CDXSprite.obj" \
	"$(INTDIR)/CDXMusicCd.obj" \
	"$(INTDIR)/CDXResource.obj" \
	"$(INTDIR)/CDXSound.obj" \
	"$(INTDIR)/CDXInput.obj" \
	"$(INTDIR)/CDXMusic.obj" \
	"$(INTDIR)/CDXLayer.obj" \
	"$(INTDIR)/CDXSoundBuffer.obj" \
	"$(INTDIR)/CDXMap.obj" \
	"$(INTDIR)/DDUtils.obj" \
	"$(INTDIR)/CDXLink.obj" \
	"$(INTDIR)/CDXSpriteList.obj" \
	"$(INTDIR)/CDXAvi.obj" \
	"$(INTDIR)/CDXScreen.obj" \
	"$(INTDIR)/CDXTile.obj" \
	"$(INTDIR)/DXErrors.obj"

"$(OUTDIR)\CDX.lib" : "$(OUTDIR)" $(DEF_FILE) $(LIB32_OBJS)
    $(LIB32) @<<
  $(LIB32_FLAGS) $(DEF_FLAGS) $(LIB32_OBJS)
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

# Name "CDX - Win32 Release"
# Name "CDX - Win32 Debug"

!IF  "$(CFG)" == "CDX - Win32 Release"

!ELSEIF  "$(CFG)" == "CDX - Win32 Debug"

!ENDIF 

################################################################################
# Begin Source File

SOURCE=.\DDUtils.cpp
DEP_CPP_DDUTI=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_DDUTI=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\DDUtils.obj" : $(SOURCE) $(DEP_CPP_DDUTI) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXLayer.cpp
DEP_CPP_CDXLA=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXLA=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXLayer.obj" : $(SOURCE) $(DEP_CPP_CDXLA) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXMap.cpp
DEP_CPP_CDXMA=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXMA=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXMap.obj" : $(SOURCE) $(DEP_CPP_CDXMA) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXMusic.cpp
DEP_CPP_CDXMU=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXMU=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXMusic.obj" : $(SOURCE) $(DEP_CPP_CDXMU) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXScreen.cpp
DEP_CPP_CDXSC=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXSC=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXScreen.obj" : $(SOURCE) $(DEP_CPP_CDXSC) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXSound.cpp
DEP_CPP_CDXSO=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXSO=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXSound.obj" : $(SOURCE) $(DEP_CPP_CDXSO) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXSoundBuffer.cpp
DEP_CPP_CDXSOU=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXSOU=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXSoundBuffer.obj" : $(SOURCE) $(DEP_CPP_CDXSOU) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXSprite.cpp
DEP_CPP_CDXSP=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXSP=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXSprite.obj" : $(SOURCE) $(DEP_CPP_CDXSP) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXSurface.cpp
DEP_CPP_CDXSU=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXSU=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXSurface.obj" : $(SOURCE) $(DEP_CPP_CDXSU) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXTile.cpp
DEP_CPP_CDXTI=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXTI=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXTile.obj" : $(SOURCE) $(DEP_CPP_CDXTI) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXInput.cpp
DEP_CPP_CDXIN=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXIN=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXInput.obj" : $(SOURCE) $(DEP_CPP_CDXIN) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\DXErrors.cpp
DEP_CPP_DXERR=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_DXERR=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\DXErrors.obj" : $(SOURCE) $(DEP_CPP_DXERR) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXSpriteList.cpp
DEP_CPP_CDXSPR=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXSPR=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXSpriteList.obj" : $(SOURCE) $(DEP_CPP_CDXSPR) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXLink.cpp
DEP_CPP_CDXLI=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXLI=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXLink.obj" : $(SOURCE) $(DEP_CPP_CDXLI) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXResource.cpp
DEP_CPP_CDXRE=\
	".\CDX.h"\
	{$(INCLUDE)}"\sys\Stat.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	{$(INCLUDE)}"\sys\Types.h"\
	
NODEP_CPP_CDXRE=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXResource.obj" : $(SOURCE) $(DEP_CPP_CDXRE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXAvi.cpp
DEP_CPP_CDXAV=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXAV=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXAvi.obj" : $(SOURCE) $(DEP_CPP_CDXAV) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CDXMusicCd.cpp
DEP_CPP_CDXMUS=\
	".\CDX.h"\
	{$(INCLUDE)}"\ddraw.h"\
	{$(INCLUDE)}"\dinput.h"\
	{$(INCLUDE)}"\dsound.h"\
	{$(INCLUDE)}"\dplay.h"\
	{$(INCLUDE)}"\dplobby.h"\
	{$(INCLUDE)}"\d3dtypes.h"\
	".\..\..\DXSDK\sdk\inc\d3dvec.inl"\
	
NODEP_CPP_CDXMUS=\
	".\..\..\DXSDK\sdk\inc\subwtype.h"\
	

"$(INTDIR)\CDXMusicCd.obj" : $(SOURCE) $(DEP_CPP_CDXMUS) "$(INTDIR)"


# End Source File
# End Target
# End Project
################################################################################
