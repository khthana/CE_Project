Attribute VB_Name = "Main"
Public Senddata(3) As Byte
Public Receivedata(3) As Byte
Public Enterkey As String
Public Datanum As Integer
Public Receiveflag As Boolean
Public DEEN As Boolean
Public Continue As Boolean
Public Checkcon As Boolean
Public CheckHL As Boolean
Public FoundHL As Boolean
Public Delaynum As Long
Public Maxsize As Long
Public Ranpos(3) As Long

'===================================================
Option Explicit


' Declare For Disable Close Menu and Close Button
'
Const MF_BYPOSITION = &H400&

Declare Function GetSystemMenu Lib "user32" (ByVal hWnd As Long, ByVal bRevert As Long) As Long

Declare Function RemoveMenu Lib "user32" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long) As Long


' Declare For Kill Application
'
Const MAX_PATH& = 260

Declare Function TerminateProcess Lib "kernel32" (ByVal ApphProcess As Long, ByVal uExitCode As Long) As Long


Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal blnheritHandle As Long, ByVal dwAppProcessId As Long) As Long


Declare Function ProcessFirst Lib "kernel32" Alias "Process32First" (ByVal hSnapshot As Long, uProcess As PROCESSENTRY32) As Long


Declare Function ProcessNext Lib "kernel32" Alias "Process32Next" (ByVal hSnapshot As Long, uProcess As PROCESSENTRY32) As Long


Declare Function CreateToolhelpSnapshot Lib "kernel32" Alias "CreateToolhelp32Snapshot" (ByVal lFlags As Long, lProcessID As Long) As Long


Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long


Type PROCESSENTRY32
    dwSize As Long
    cntUsage As Long
    th32ProcessID As Long
    th32DefaultHeapID As Long
    th32ModuleID As Long
    cntThreads As Long
    th32ParentProcessID As Long
    pcPriClassBase As Long
    dwFlags As Long
    szexeFile As String * MAX_PATH
    End Type
    
    
'Declare For Kill File
'
Private Enum ShowWindowType

' Define the User-Defined type
'
'SW_HIDE = 0
SW_NORMAL = 1
'SW_MINIMIZED = 2
'SW_MAXIMIZED = 3

End Enum

Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As ShowWindowType) As Long


Public Sub Runfile(sFileName As String, Optional sParams As String = "", Optional sDefaultDir As String = "")

' Declare the Needed Variables
'
Dim lrc As Long
        
        
' Parameters passed to ShellExecute
' hWnd - active form
' lpOperation - "Open" or "Print" (vbNullString defaults to "Open")
' lpFile - Program name or name of a for to print or open using the associated program
' lpParameters - Command line if lpFile is a program to run
' lpDirectory - Default directory to use
' nShowCmd - Constant specifying how to show the launched program (maximized, minimized, normal)
'
lrc = ShellExecute(frmMain.hWnd, "Open", sFileName, sParams, sDefaultDir, SW_NORMAL)
    
    
End Sub

Public Sub DestroyFile(sFileName As String)
  '  Dim Block1 As String, Block2 As String, Blocks As Long
  '  Dim hFileHandle As Integer, iLoop As Long, offset As Long
  '  'Create two buffers with a specified 'wi
  '  '     pe-out' characters
  '  Const BLOCKSIZE = 4096
  '  Block1 = String(BLOCKSIZE, "X")
  '  Block2 = String(BLOCKSIZE, " ")
  '  'Overwrite the file contents with the wi
  '  '     pe-out characters
  '  hFileHandle = FreeFile
  '  Open sFileName For Binary As hFileHandle
  '  Blocks = (LOF(hFileHandle) \ BLOCKSIZE) + 1 '


  ' For iLoop = 1 To Blocks
  '      offset = Seek(hFileHandle)
  '      Put hFileHandle, , Block1
  '      Put hFileHandle, offset, Block2
  '  Next iLoop
  '  Close hFileHandle
  ' 'Now you can delete the file, which cont
  ' '     ains no sensitive data
    
   '  Dim fss
   '  Set fss = CreateObject("scripting.filesystemobject")
   '  fss.DeleteFile (sFileName)
    Kill sFileName
    
End Sub

Public Function KillApp(myName As String) As Boolean
    
    Const PROCESS_ALL_ACCESS = 0
    Dim uProcess As PROCESSENTRY32
    Dim rProcessFound As Long
    Dim hSnapshot As Long
    Dim szExename As String
    Dim exitCode As Long
    Dim myProcess As Long
    Dim AppKill As Boolean
    Dim appCount As Integer
    Dim i As Integer
    On Local Error GoTo Finish
    appCount = 0
    
    Const TH32CS_SNAPPROCESS As Long = 2&
    
    uProcess.dwSize = Len(uProcess)
    hSnapshot = CreateToolhelpSnapshot(TH32CS_SNAPPROCESS, 0&)
    rProcessFound = ProcessFirst(hSnapshot, uProcess)


    Do While rProcessFound
        i = InStr(1, uProcess.szexeFile, Chr(0))
        szExename = LCase$(Left$(uProcess.szexeFile, i - 1))

        If Right$(szExename, Len(myName)) = LCase$(myName) Then
            KillApp = True
            appCount = appCount + 1
            myProcess = OpenProcess(PROCESS_ALL_ACCESS, False, uProcess.th32ProcessID)
            AppKill = TerminateProcess(myProcess, exitCode)
            Call CloseHandle(myProcess)
        End If
        rProcessFound = ProcessNext(hSnapshot, uProcess)
    Loop
    Call CloseHandle(hSnapshot)
Finish:
End Function
Public Sub rmvMnuClose(frm As Form)
Dim mnuHandle As Long

' Read Window Handle Value of Argument frm that User send it
'
mnuHandle = GetSystemMenu(frm.hWnd, 0)


' Remove the Sixth Menu
'
Call RemoveMenu(mnuHandle, 6, MF_BYPOSITION)


' Remove the Fifth Menu
'
Call RemoveMenu(mnuHandle, 5, MF_BYPOSITION)

End Sub

'=================================================
Public Function SecureFile(InputFile As String, OutputFile As String, Encrypting As Boolean, Optional ForceIntegrity As Boolean = True) As Boolean
Dim strTime As String
Dim i As Long
strTime = Time
frmMain.Timer1.Enabled = False
frmMain.cmdInput.Enabled = False
frmMain.Cmdexit.Enabled = False
frmMain.mexit(2).Enabled = False
frmMain.cmdrun.Enabled = False
Datanum = 0

'         Setup error control
    On Error GoTo Err_Function
    
    'Prompt for overwrite
            
    'Warn them about system integrify
        
    'Our File number variable
    Dim Free_File As Long
    
    'Length is bytes of our InputFile
    Dim Length_Of_File As Long
    
    'An array of the files bytes
    Dim MyArray() As Byte
    
    'Selects a number for the free file
    Free_File = FreeFile
    
    
    'Ok, lets open our input file
    frmMain.lblWork2.Caption = "Reading..."
    Open InputFile For Binary Access Read As Free_File
    
    'Recreate the array of the files bytes with lenght of file as upper bound
    frmMain.lblWork2.Caption = "Reading and Decoding ..."
    ReDim MyArray(LOF(Free_File)) As Byte
    
    'Store the length of the file
    Length_Of_File = UBound(MyArray)
    Maxsize = UBound(MyArray)
    
    'Load the contnets of the file into the byte array
    DoEvents
    For i = 1 To Length_Of_File
        'Write out old file
        frmMain.PBar(0).Value = Int(i / Length_Of_File * 100 / 2)
  
        If ForceIntegrity Then
            frmMain.PBar(0).Value = Int(i / Length_Of_File * 100 / 2)
            DoEvents
        End If
        Get #Free_File, i, MyArray(i)
    Next
    
    
    'We no longer need the input file, so lets close it
    Close Free_File
    
    'Encrypt / Decrypt the bytes
    
'====================================================
'=====================================================
    
        Senddata(0) = MyArray(1)
        Senddata(1) = MyArray(2)
        Senddata(2) = MyArray(3)
        Senddata(3) = MyArray(4)
        
        CheckHL = False
    frmMain.Senddes
    
        If DEEN Then
            frmMain.Decode
        Else
            frmMain.Encode
        End If
        
    frmMain.Cdelay
    frmMain.Receivedes
    
        Do While Not Continue
            DoEvents
        Loop
    
        MyArray(1) = Receivedata(0)
        MyArray(2) = Receivedata(1)
        MyArray(3) = Receivedata(2)
        MyArray(4) = Receivedata(3)
          
      Continue = False
      Datanum = 0
'====================================================
   'Select Random Position Of File
'=====================================================
        
        Ranpos(0) = Int(Maxsize / 2) + 1
        Ranpos(1) = Int(Maxsize / 3) + 1
        Ranpos(2) = Int(Maxsize / 10) + 1
        Ranpos(3) = Int(Maxsize / 50) + 1
        
'====================================================
'=====================================================
    
        Senddata(0) = MyArray(Ranpos(0))
        Senddata(1) = MyArray(Ranpos(1))
        Senddata(2) = MyArray(Ranpos(2))
        Senddata(3) = MyArray(Ranpos(3))
        
        CheckHL = False
    frmMain.Senddes
    
        If DEEN Then
            frmMain.Decode
        Else
            frmMain.Encode
        End If
        
    frmMain.Cdelay
    frmMain.Receivedes
    
        Do While Not Continue
            DoEvents
        Loop
    
        MyArray(Ranpos(0)) = Receivedata(0)
        MyArray(Ranpos(1)) = Receivedata(1)
        MyArray(Ranpos(2)) = Receivedata(2)
        MyArray(Ranpos(3)) = Receivedata(3)
        
          Continue = False
'====================================================
  
'=====================================================
        
    'Windows may have some catching up to do
    DoEvents
    
    'Get a new free file number
    Free_File = FreeFile
    
    'Now that is crypted, lets write it back to our file
    Open OutputFile For Binary Access Write As Free_File
    
    'Write the array of bytes to our file
    For i = 1 To Length_Of_File
        'Write out old file
         frmMain.PBar(0).Value = 50 + Int(i / Length_Of_File * 100 / 2)

        Put #Free_File, i, MyArray(i)
        If ForceIntegrity Then DoEvents
    Next
    
    Close Free_File
        CheckHL = True
        frmMain.Timer1.Enabled = True
        
    frmMain.cmdInput.Enabled = True
    frmMain.Cmdexit.Enabled = True
    frmMain.mexit(2).Enabled = True
    frmMain.cmdrun.Enabled = True
Exit_Function:
   
    frmMain.lblWork2.Caption = " "
    'Windows may have some catching up to do
    DoEvents
    
    frmMain.fraWork.Visible = False
    
       Exit Function
    
Err_Function:
    frmMain.Cmdexit.Enabled = True
    frmMain.mexit(2).Enabled = True
    'Print "real" error to vb screen
    Debug.Print Err.Source & " error [" & Err.Description & "]"
    
    MsgBox "[" & Err.Description & "]" & vbNewLine & vbNewLine & "Could not encrypt file", vbExclamation, "Error"
    'Windows may have some catching up to do
    DoEvents
    frmMain.fraWork.Visible = False
End Function

'==================================================
