Attribute VB_Name = "modAssociated"
Option Explicit

' ------------------------------------------------------------------------
'
'                       BulletSoft Solutions
'
'  You have a royalty-free right to use, modify, reproduce and distribute
'  this file (and/or any modified version) in any way you find useful,
'  provided that you agree that BulletSoft Solutions has no
'  warranty, obligation or liability for its contents.
'  Refer to the http://www.bulletsoftsolutions.com for more project
'  examples like this one.
'
' ------------------------------------------------------------------------
Private Enum ShowWindowType
    SW_HIDE = 0
    SW_NORMAL = 1
    SW_MINIMIZED = 2
    SW_MAXIMIZED = 3
End Enum

Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As ShowWindowType) As Long

Public Sub RunAssociated(sFileName As String, Optional sParams As String = "", Optional sDefaultDir As String = "")

    Dim lrc As Long
    
    'Parameters passed to ShellExecute
    'hWnd - active form
    'lpOperation - "Open" or "Print" (vbNullString defaults to "Open"
    'lpFile - Program name or name of a for to print or open using the associated program
    'lpParameters - Command line if lpFile is a program to run
    'lpDirectory - Default directory to use
    'nShowCmd - Constant specifying how to show the launched program (maximized, minimized, normal)
    
    lrc = ShellExecute(frmAssociated.hwnd, "Open", sFileName, sParams, sDefaultDir, SW_NORMAL)
    
    
End Sub
