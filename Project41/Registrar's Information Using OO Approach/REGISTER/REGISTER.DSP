# Microsoft Developer Studio Project File - Name="register" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=register - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "register.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "register.mak" CFG="register - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "register - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "register - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE "register - Win32 Final" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "register - Win32 Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x41e /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x41e /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 /nologo /subsystem:windows /machine:I386

!ELSEIF  "$(CFG)" == "register - Win32 Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x41e /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x41e /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept

!ELSEIF  "$(CFG)" == "register - Win32 Final"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "register___Win32_Final"
# PROP BASE Intermediate_Dir "register___Win32_Final"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "register___Win32_Final"
# PROP Intermediate_Dir "register___Win32_Final"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x41e /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x41e /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 /nologo /subsystem:windows /machine:I386

!ENDIF 

# Begin Target

# Name "register - Win32 Release"
# Name "register - Win32 Debug"
# Name "register - Win32 Final"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\CurriculumDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\Department.cpp
# End Source File
# Begin Source File

SOURCE=.\DepartmentAddDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\DepartmentDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\DepartmentfnDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\Faculty.cpp
# End Source File
# Begin Source File

SOURCE=.\FacultyAddDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\FacultyDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\FacultyfnDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\MainDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\msflexgrid.cpp
# End Source File
# Begin Source File

SOURCE=.\OtherinfoDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\register.cpp
# End Source File
# Begin Source File

SOURCE=.\register.rc
# End Source File
# Begin Source File

SOURCE=.\registerDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\RegisterInfoDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\RoomDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectStdIdDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAddDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# Begin Source File

SOURCE=.\StdEditDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\StdinfoDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\StdSelectDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\Stdset.cpp
# End Source File
# Begin Source File

SOURCE=.\Subject.cpp
# End Source File
# Begin Source File

SOURCE=.\SubjectAddDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\SubjectDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\SubjectInfoDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\SubjectSelDlg.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\CurriculumDlg.h
# End Source File
# Begin Source File

SOURCE=.\Department.h
# End Source File
# Begin Source File

SOURCE=.\DepartmentAddDlg.h
# End Source File
# Begin Source File

SOURCE=.\DepartmentDlg.h
# End Source File
# Begin Source File

SOURCE=.\DepartmentfnDlg.h
# End Source File
# Begin Source File

SOURCE=.\Faculty.h
# End Source File
# Begin Source File

SOURCE=.\FacultyAddDlg.h
# End Source File
# Begin Source File

SOURCE=.\FacultyDlg.h
# End Source File
# Begin Source File

SOURCE=.\FacultyfnDlg.h
# End Source File
# Begin Source File

SOURCE=.\MainDlg.h
# End Source File
# Begin Source File

SOURCE=.\msflexgrid.h
# End Source File
# Begin Source File

SOURCE=.\OtherinfoDlg.h
# End Source File
# Begin Source File

SOURCE=.\register.h
# End Source File
# Begin Source File

SOURCE=.\registerDlg.h
# End Source File
# Begin Source File

SOURCE=.\RegisterInfoDlg.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\RoomDlg.h
# End Source File
# Begin Source File

SOURCE=.\SelectStdIdDlg.h
# End Source File
# Begin Source File

SOURCE=.\StdAddDlg.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# Begin Source File

SOURCE=.\StdEditDlg.h
# End Source File
# Begin Source File

SOURCE=.\StdinfoDlg.h
# End Source File
# Begin Source File

SOURCE=.\StdSelectDlg.h
# End Source File
# Begin Source File

SOURCE=.\Stdset.h
# End Source File
# Begin Source File

SOURCE=.\Subject.h
# End Source File
# Begin Source File

SOURCE=.\SubjectAddDlg.h
# End Source File
# Begin Source File

SOURCE=.\SubjectDlg.h
# End Source File
# Begin Source File

SOURCE=.\SubjectInfoDlg.h
# End Source File
# Begin Source File

SOURCE=.\SubjectSelDlg.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\register.ico
# End Source File
# Begin Source File

SOURCE=.\res\register.rc2
# End Source File
# End Group
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# End Target
# End Project
# Section register : {B8180C82-F837-11D2-95AB-00E029377C4C}
# 	1:18:IDD_SUBJECT_DIALOG:103
# 	2:16:Resource Include:resource.h
# 	2:12:SubjectDlg.h:SubjectDlg.h
# 	2:18:CLASS: CSubjectDlg:CSubjectDlg
# 	2:18:IDD_SUBJECT_DIALOG:IDD_SUBJECT_DIALOG
# 	2:10:ENUM: enum:enum
# 	2:14:SubjectDlg.cpp:SubjectDlg.cpp
# 	2:19:Application Include:register.h
# End Section
# Section register : {5F4DF280-531B-11CF-91F6-C2863C385E30}
# 	2:5:Class:CMSFlexGrid
# 	2:10:HeaderFile:msflexgrid.h
# 	2:8:ImplFile:msflexgrid.cpp
# End Section
# Section register : {0A7D94F1-FCA9-11D2-95C8-00E029377C4C}
# 	1:16:IDD_INFORMATIONS:105
# 	2:16:Resource Include:resource.h
# 	2:14:OtherinfoDlg.h:OtherinfoDlg.h
# 	2:16:IDD_INFORMATIONS:IDD_INFORMATIONS
# 	2:10:ENUM: enum:enum
# 	2:20:CLASS: COtherinfoDlg:COtherinfoDlg
# 	2:19:Application Include:register.h
# 	2:16:OtherinfoDlg.cpp:OtherinfoDlg.cpp
# End Section
# Section register : {6262D3A0-531B-11CF-91F6-C2863C385E30}
# 	2:21:DefaultSinkHeaderFile:msflexgrid.h
# 	2:16:DefaultSinkClass:CMSFlexGrid
# End Section
# Section register : {B8180C87-F837-11D2-95AB-00E029377C4C}
# 	1:21:IDD_CURRICULUM_DIALOG:104
# 	2:16:Resource Include:resource.h
# 	2:21:CLASS: CCurriculumDlg:CCurriculumDlg
# 	2:17:CurriculumDlg.cpp:CurriculumDlg.cpp
# 	2:21:IDD_CURRICULUM_DIALOG:IDD_CURRICULUM_DIALOG
# 	2:10:ENUM: enum:enum
# 	2:19:Application Include:register.h
# 	2:15:CurriculumDlg.h:CurriculumDlg.h
# End Section
