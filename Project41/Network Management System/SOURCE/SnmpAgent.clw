; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CSnmpAgentView
LastTemplate=CAsyncSocket
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "SnmpAgent.h"
LastPage=0

ClassCount=7
Class1=CSnmpAgentApp
Class2=CSnmpAgentDoc
Class3=CSnmpAgentView
Class4=CMainFrame

ResourceCount=4
Resource1=IDD_ABOUTBOX
Resource2=IDR_MAINFRAME
Resource3=IDR_MAINFRAME (English (U.S.))
Class5=CAboutDlg
Class6=InitServer
Class7=TestSock
Resource4=IDD_ABOUTBOX (English (U.S.))

[CLS:CSnmpAgentApp]
Type=0
HeaderFile=SnmpAgent.h
ImplementationFile=SnmpAgent.cpp
Filter=N
LastObject=CSnmpAgentApp

[CLS:CSnmpAgentDoc]
Type=0
HeaderFile=SnmpAgentDoc.h
ImplementationFile=SnmpAgentDoc.cpp
Filter=N
LastObject=CSnmpAgentDoc

[CLS:CSnmpAgentView]
Type=0
HeaderFile=SnmpAgentView.h
ImplementationFile=SnmpAgentView.cpp
Filter=C
LastObject=CSnmpAgentView

[CLS:CMainFrame]
Type=0
HeaderFile=MainFrm.h
ImplementationFile=MainFrm.cpp
Filter=T
LastObject=CMainFrame



[CLS:CAboutDlg]
Type=0
HeaderFile=SnmpAgent.cpp
ImplementationFile=SnmpAgent.cpp
Filter=D
LastObject=CAboutDlg

[DLG:IDD_ABOUTBOX]
Type=1
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308352
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889
Class=CAboutDlg

[MNU:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command3=ID_FILE_SAVE
Command4=ID_FILE_SAVE_AS
Command5=ID_FILE_MRU_FILE1
Command6=ID_APP_EXIT
Command10=ID_EDIT_PASTE
Command11=ID_APP_ABOUT
CommandCount=11
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command7=ID_EDIT_UNDO
Command8=ID_EDIT_CUT
Command9=ID_EDIT_COPY

[ACL:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command5=ID_EDIT_CUT
Command6=ID_EDIT_COPY
Command7=ID_EDIT_PASTE
Command8=ID_EDIT_UNDO
Command9=ID_EDIT_CUT
Command10=ID_EDIT_COPY
Command11=ID_EDIT_PASTE
Command12=ID_NEXT_PANE
CommandCount=13
Command4=ID_EDIT_UNDO
Command13=ID_PREV_PANE


[MNU:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_APP_EXIT
Command2=ID_APP_ABOUT
CommandCount=2

[ACL:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_EDIT_UNDO
Command5=ID_EDIT_CUT
Command6=ID_EDIT_COPY
Command7=ID_EDIT_PASTE
Command8=ID_EDIT_UNDO
Command9=ID_EDIT_CUT
Command10=ID_EDIT_COPY
Command11=ID_EDIT_PASTE
Command12=ID_NEXT_PANE
Command13=ID_PREV_PANE
CommandCount=13

[DLG:IDD_ABOUTBOX (English (U.S.))]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[CLS:InitServer]
Type=0
HeaderFile=InitServer.h
ImplementationFile=InitServer.cpp
BaseClass=CSocket
Filter=N
LastObject=InitServer
VirtualFilter=uq

[CLS:TestSock]
Type=0
HeaderFile=TestSock.h
ImplementationFile=TestSock.cpp
BaseClass=CAsyncSocket
Filter=N
LastObject=TestSock

