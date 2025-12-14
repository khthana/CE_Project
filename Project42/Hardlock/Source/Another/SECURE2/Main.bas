Attribute VB_Name = "Main"
Public Senddata(3) As Byte
Public Receivedata(3) As Byte
Public Enterkey As String
Public Datanum As Integer
Public Receiveflag As Boolean


Public Function SecureFile(InputFile As String, OutputFile As String, Encrypting As Boolean, Optional ForceIntegrity As Boolean = True) As Boolean
Dim strTime As String
strTime = Time

'         Setup error control
    On Error GoTo Err_Function
    If Trim(InputFile) = "" Or Trim(OutputFile) = "" Then
        Err.Raise 1, "Hardlock", "Input / Output File Not Present"
    End If
    'Prompt for overwrite
    If InputFile = OutputFile Then
        Beep
        If MsgBox("Overwrite '" & InputFile & "'", vbQuestion + vbYesNo, "Overwrite") = vbNo Then
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
    
    frmMain.lblWork2.Caption = "Initiating...."
    frmMain.lblStatus.Caption = Int(2 / 24 * 100) & "%"
    
    'Our File number variable
    Dim Free_File As Long
    frmMain.lblStatus.Caption = Int(3 / 24 * 100) & "%"
    
    'Length is bytes of our InputFile
    Dim Length_Of_File As Long
    frmMain.lblStatus.Caption = Int(4 / 24 * 100) & "%"
    
    'An array of the files bytes
    Dim MyArray() As Byte
    frmMain.lblStatus.Caption = Int(5 / 24 * 100) & "%"
    
    'Selects a number for the free file
    Free_File = FreeFile
    frmMain.lblStatus.Caption = Int(6 / 24 * 100) & "%"
    
    
    'Ok, lets open our input file
    frmMain.lblWork2.Caption = "Reading..."
    Open InputFile For Binary Access Read As Free_File
    frmMain.lblStatus.Caption = Int(9 / 24 * 100) & "%"
    
    'Recreate the array of the files bytes with lenght of file as upper bound
    frmMain.lblWork2.Caption = "Reading..."
    ReDim MyArray(LOF(Free_File)) As Byte
    frmMain.lblStatus.Caption = Int(10 / 24 * 100) & "%"
    
    'Store the length of the file
    Length_Of_File = UBound(MyArray)
    
    frmMain.lblStatus.Caption = Int(11 / 24 * 100) & "%"
    'Load the contnets of the file into the byte array
    DoEvents
    For i = 1 To Length_Of_File
        'Write out old file
        frmMain.lblStatus.Caption = Int(i / Length_Of_File * 100) & "%"
  
        If ForceIntegrity Then
            frmMain.lblStatus.Caption = Int(i / Length_Of_File * 100) & "%"
            DoEvents
        End If
        Get #Free_File, i, MyArray(i)
    Next
    
    frmMain.lblStatus.Caption = Int(12 / 24 * 100) & "%"
    
    'We no longer need the input file, so lets close it
    Close Free_File
    frmMain.lblStatus.Caption = Int(13 / 24 * 100) & "%"
    
    'Encrypt / Decrypt the bytes
    frmMain.lblWork2.Caption = "Cryting..."
    
'====================================================
'=====================================================
    
        Senddata(0) = 49
        Senddata(1) = 180
        Senddata(2) = 0
        Senddata(3) = 254
        
        
    'frmMain.Senddes
    'frmMain.Rundes
    'frmMain.Receivedes
    
       
     
        
        'MyArray(0) = receivedata(0)
        'MyArray(1) = receivedata(1)
        'MyArray(2) = receivedata(2)
        'MyArray(3) = receivedata(3)
        
'====================================================
'=====================================================
        
        frmMain.Label4.Caption = Receivedata(0)

    'Windows may have some catching up to do
    DoEvents
    
    frmMain.lblWork2.Caption = "Encode ..."
    frmMain.lblStatus.Caption = Int(17 / 24 * 100) & "%"
    
    'Get a new free file number
    Free_File = FreeFile
    frmMain.lblStatus.Caption = Int(18 / 24 * 100) & "%"
    
    'Now that is crypted, lets write it back to our file
    frmMain.lblWork2.Caption = "Writing..."
    Open OutputFile For Binary Access Write As Free_File
    frmMain.lblStatus.Caption = Int(19 / 24 * 100) & "%"
    
    'Write the array of bytes to our file
    For i = 1 To Length_Of_File
        'Write out old file
         frmMain.lblStatus.Caption = Int(i / Length_Of_File * 100) & "%"

        Put #Free_File, i, MyArray(i)
        If ForceIntegrity Then DoEvents
    Next
    
    frmMain.lblWork2.Caption = "Working..."
    frmMain.lblStatus.Caption = Int(20 / 24 * 100) & "%"
    Close Free_File
Exit_Function:
    frmMain.lblWork2.Caption = "Idle"
    frmMain.lblStatus.Caption = "X%"
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
