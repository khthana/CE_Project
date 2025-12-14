VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   375
      Left            =   360
      TabIndex        =   0
      Top             =   840
      Width           =   2295
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
    (ByVal hwnd As Long, ByVal lpOperation As String, _
    ByVal lpFile As String, ByVal lpParameters As String, _
    ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private Declare Function GetActiveWindow Lib "user32" () As Long

Public Sub Command1_Click()
    Const MB_ICONSTOP = 16
    Dim temp, Msg As String
    Dim x As Integer

    temp = GetActiveWindow()
    x = ShellExecute(temp, "open", "cttex.exe", "[0] <bee.htm> bbb.txt", _
                        "c:\temp\cttex\", 1)

    If x < 32 Then
        Select Case x
            Case 0
                Msg = "The file could not be run due to insufficient system memory or a corrupt program file"
            Case 2
                Msg = "File Not Found"
            Case 3
                Msg = "Invalid Path"
            Case 5
                Msg = "Sharing or protection error"
            Case 6
                Msg = "Separate data segments are required for each task "
            Case 8
                Msg = "Insufficient memory to run the program"
            Case 10
                Msg = "Incorrect Windows version"
            Case 11
                Msg = "Invalid Program File"
            Case 12
                Msg = "Program file requires a different operating System "
            Case 13
                Msg = "Program requires MS-DOS 4.0"
            Case 14
                Msg = "Unknown program file type"
            Case 15
                Msg = "Windows prgram does not support protected memory mode"
            Case 16
                Msg = "Invalid use of data segments when loading a second instance of a program"
            Case 19
                Msg = "Attempt to run a compressed program file"
            Case 20
                Msg = "Invalid dynamic link library"
            Case 21
                Msg = "Program requires Windows 32-bit extensions"
            Case 31
                Msg = "No application found for this file"
        End Select
    End If
End Sub

