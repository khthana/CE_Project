; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CResultDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "diblook.h"

ClassCount=8
Class1=CDibDoc
Class2=CDibLookApp
Class3=CAboutDlg
Class4=CDibView
Class5=CMainFrame

ResourceCount=10
Resource1=IDR_DIBTYPE
Resource2=IDR_MAINFRAME
Resource3=IDD_ABOUTBOX
Resource4=IDD_DIALOGBAR (English (U.S.))
Resource5=IDD_ABOUTBOX (English (U.S.))
Resource6=IDD_DATADIALOG
Resource7=IDD_THERSBOX
Resource8=IDR_DIBTYPE (English (U.S.))
Class6=CDataDialog
Class7=CResultDlg
Resource9=IDD_DIALOG (English (U.S.))
Class8=CThreshold
Resource10=IDR_MAINFRAME (English (U.S.))

[CLS:CDibDoc]
Type=0
HeaderFile=dibdoc.h
ImplementationFile=dibdoc.cpp
LastObject=CDibDoc

[CLS:CDibLookApp]
Type=0
HeaderFile=diblook.h
ImplementationFile=diblook.cpp
LastObject=CDibLookApp
Filter=N

[CLS:CAboutDlg]
Type=0
HeaderFile=diblook.cpp
ImplementationFile=diblook.cpp
LastObject=CAboutDlg

[CLS:CDibView]
Type=0
HeaderFile=dibview.h
ImplementationFile=dibview.cpp
LastObject=CDibView
Filter=C
BaseClass=CScrollView
VirtualFilter=VWC

[CLS:CMainFrame]
Type=0
HeaderFile=mainfrm.h
ImplementationFile=mainfrm.cpp
LastObject=CMainFrame
Filter=T
BaseClass=CMDIFrameWnd
VirtualFilter=fWC

[MNU:IDR_MAINFRAME]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_PRINT_SETUP
Command4=ID_FILE_MRU_FILE1
Command5=ID_APP_EXIT
Command6=ID_VIEW_TOOLBAR
Command7=ID_VIEW_STATUS_BAR
Command8=ID_APP_ABOUT
CommandCount=8

[MNU:IDR_DIBTYPE]
Type=1
Class=CDibView
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_CLOSE
Command4=ID_FILE_SAVE
Command5=ID_FILE_SAVE_AS
Command6=ID_FILE_PRINT
Command7=ID_FILE_PRINT_PREVIEW
Command8=ID_FILE_PRINT_SETUP
Command9=ID_FILE_MRU_FILE1
Command10=ID_APP_EXIT
Command11=ID_EDIT_UNDO
Command12=ID_EDIT_CUT
Command13=ID_EDIT_COPY
Command14=ID_EDIT_PASTE
Command15=ID_VIEW_TOOLBAR
Command16=ID_VIEW_STATUS_BAR
Command17=ID_WINDOW_NEW
Command18=ID_WINDOW_CASCADE
Command19=ID_WINDOW_TILE_HORZ
Command20=ID_WINDOW_ARRANGE
Command21=ID_APP_ABOUT
CommandCount=21

[ACL:IDR_MAINFRAME]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_PRINT
Command5=ID_EDIT_UNDO
Command6=ID_EDIT_CUT
Command7=ID_EDIT_COPY
Command8=ID_EDIT_PASTE
Command9=ID_EDIT_UNDO
Command10=ID_EDIT_CUT
Command11=ID_EDIT_COPY
Command12=ID_EDIT_PASTE
Command13=ID_NEXT_PANE
Command14=ID_PREV_PANE
CommandCount=14

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308352
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[MNU:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_FILE_OPEN
Command2=ID_FILE_PRINT_SETUP
Command3=ID_FILE_MRU_FILE1
Command4=ID_APP_EXIT
Command5=ID_VIEW_TOOLBAR
Command6=ID_VIEW_STATUS_BAR
Command7=ID_OPTION_SETBOXCOLOR
Command8=ID_TOOL_MATCHING
Command9=ID_TOOL_DATABASE
Command10=ID_WINDOW_CASCADE
Command11=ID_WINDOW_TILE_HORZ
Command12=ID_WINDOW_ARRANGE
Command13=ID_APP_ABOUT
CommandCount=13

[MNU:IDR_DIBTYPE (English (U.S.))]
Type=1
Class=CDibView
Command1=ID_FILE_OPEN
Command2=ID_FILE_CLOSE
Command3=ID_FILE_PRINT
Command4=ID_FILE_PRINT_PREVIEW
Command5=ID_FILE_PRINT_SETUP
Command6=ID_FILE_MRU_FILE1
Command7=ID_APP_EXIT
Command8=ID_VIEW_TOOLBAR
Command9=ID_VIEW_STATUS_BAR
Command10=ID_OPTION_SETBOXCOLOR
Command11=ID_TOOL_MATCHING
Command12=ID_TOOL_DATABASE
Command13=ID_WINDOW_CASCADE
Command14=ID_WINDOW_TILE_HORZ
Command15=ID_WINDOW_ARRANGE
Command16=ID_APP_ABOUT
CommandCount=16

[ACL:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_TOOL_MATCHING
Command2=ID_FILE_OPEN
Command3=ID_FILE_PRINT
Command4=ID_NEXT_PANE
Command5=ID_PREV_PANE
CommandCount=5

[DLG:IDD_ABOUTBOX (English (U.S.))]
Type=1
Class=CAboutDlg
ControlCount=9
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308352
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889
Control5=IDC_STATIC,static,1342308352
Control6=IDC_STATIC,static,1342308352
Control7=IDC_STATIC,static,1342308352
Control8=IDC_STATIC,static,1342308352
Control9=IDC_STATIC,static,1342308352

[TB:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_BUTTON32773
Command2=ID_BUTTON32778
Command3=ID_OPTION_SETBOXCOLOR
Command4=ID_BUTTON32779
CommandCount=4

[DLG:IDD_DIALOGBAR (English (U.S.))]
Type=1
Class=?
ControlCount=1
Control1=IDC_STATIC,static,1342308352

[DLG:IDD_DIALOG (English (U.S.))]
Type=1
Class=CResultDlg
ControlCount=22
Control1=IDC_name1,static,1342308352
Control2=IDC_STATIC,static,1342308352
Control3=IDC_SIMVALUE1,static,1342308352
Control4=IDC_STATIC,static,1342308352
Control5=IDC_STATIC,static,1342308352
Control6=IDC_STATIC,static,1342308352
Control7=IDC_STATIC,static,1342308352
Control8=IDC_name2,static,1342308352
Control9=IDC_name3,static,1342308352
Control10=IDC_name4,static,1342308352
Control11=IDC_name5,static,1342308352
Control12=IDC_SIMVALUE2,static,1342308352
Control13=IDC_SIMVALUE3,static,1342308352
Control14=IDC_SIMVALUE4,static,1342308352
Control15=IDC_SIMVALUE5,static,1342308352
Control16=IDC_DATA,static,1350696960
Control17=IDC_DATA2,static,1350696960
Control18=IDC_DATA3,static,1350696960
Control19=IDC_DATA4,static,1350696960
Control20=IDC_DATA5,static,1350696960
Control21=IDCANCEL,button,1342242817
Control22=IDOK,button,1342242817

[DLG:IDD_DATADIALOG]
Type=1
Class=CDataDialog
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352
Control4=IDC_DATA,edit,1350631428

[CLS:CDataDialog]
Type=0
HeaderFile=DataDialog.h
ImplementationFile=DataDialog.cpp
BaseClass=CDialog
Filter=D
LastObject=CDataDialog
VirtualFilter=dWC

[CLS:CResultDlg]
Type=0
HeaderFile=resultdlg.h
ImplementationFile=resultdlg.cpp
BaseClass=CDialog
LastObject=CResultDlg
Filter=D
VirtualFilter=dWC

[DLG:IDD_THERSBOX]
Type=1
Class=CThreshold
ControlCount=4
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,static,1342308352
Control4=IDC_TRESHOLD,edit,1350639744

[CLS:CThreshold]
Type=0
HeaderFile=Threshold.h
ImplementationFile=Threshold.cpp
BaseClass=CDialog
Filter=D
LastObject=CThreshold
VirtualFilter=dWC

