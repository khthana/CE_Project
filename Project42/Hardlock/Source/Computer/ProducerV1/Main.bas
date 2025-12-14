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


Public Function SecureFile(InputFile As String, OutputFile As String, Encrypting As Boolean, Optional ForceIntegrity As Boolean = True) As Boolean
Dim strTime As String
strTime = Time
frmMain.Timer1.Enabled = False
frmMain.Enabled = False

'         Setup error control
    On Error GoTo Err_Function
    If Trim(InputFile) = "" Or Trim(OutputFile) = "" Then
        Err.Raise 1, "Hardlock", "Input / Output File Not Present"
    End If
    'Prompt for overwrite
    If InputFile = OutputFile Then
        Beep
        If MsgBox("Overwrite '" & InputFile & "'", vbQuestion + vbYesNo, "Overwrite") = vbNo Then
             frmMain.Enabled = True
            Exit Function
        End If
    End If
        
    'Warn them about system integrify
    If ForceIntegrity = False Then
        If MsgBox("If you don't Ensure Integrity on large files, your system may freeze.  Continue Operation?", vbYesNo + vbExclamation, "Warning") = vbYes Then
            'Continue on
        Else
            MsgBox "Aborted Operation", vbInformation, "Abort"
            Exit Function
        End If
    End If
    
    
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
    frmMain.lblWork2.Caption = "Reading..."
    ReDim MyArray(LOF(Free_File)) As Byte
    
    'Store the length of the file
    Length_Of_File = UBound(MyArray)
    
    'Load the contnets of the file into the byte array
    DoEvents
    For i = 1 To Length_Of_File
        'Write out old file
        frmMain.PBar(0).Value = Int(i / Length_Of_File * 100)
  
        If ForceIntegrity Then
            frmMain.PBar(0).Value = Int(i / Length_Of_File * 100)
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
        
        CheckHL = True
        
        frmMain.Timer1.Enabled = True
'====================================================
'=====================================================
        
    'Windows may have some catching up to do
    DoEvents
    
    'Get a new free file number
    Free_File = FreeFile
    
    'Now that is crypted, lets write it back to our file
    frmMain.lblWork2.Caption = "Writing..."
    Open OutputFile For Binary Access Write As Free_File
    
    'Write the array of bytes to our file
    For i = 1 To Length_Of_File
        'Write out old file
         frmMain.PBar(0).Value = Int(i / Length_Of_File * 100)

        Put #Free_File, i, MyArray(i)
        If ForceIntegrity Then DoEvents
    Next
    
    Close Free_File
   frmMain.Enabled = True
Exit_Function:
   
    frmMain.lblWork2.Caption = " "
    'Windows may have some catching up to do
    DoEvents
    
    frmMain.fraWork.Visible = False
    
    If Encrypting Then
        MsgBox "Encryption Complete (" & DateDiff("s", strTime, Time) & " seconds)", vbInformation, "Done"
    Else
        MsgBox "Decryption Complete (" & DateDiff("s", strTime, Time) & " seconds)", vbInformation, "Done"
    End If
    Exit Function
    
Err_Function:
    'Print "real" error to vb screen
    Debug.Print Err.Source & " error [" & Err.Description & "]"
    
    MsgBox "[" & Err.Description & "]" & vbNewLine & vbNewLine & "Could not encrypt file", vbExclamation, "Error"
    'Windows may have some catching up to do
    DoEvents
    frmMain.fraWork.Visible = False
End Function
