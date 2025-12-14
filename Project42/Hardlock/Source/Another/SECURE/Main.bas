Attribute VB_Name = "Main"
Public Function SecureFile(InputFile As String, OutputFile As String, Encrypting As Boolean, Optional Password As String = "Default", Optional ForceIntegrity As Boolean = True) As Boolean
'Copyright 1999, Kenneth Gilbert Jr.  All rights reserved

'USAGE:  File Encryption via Visual Basic.  Offers a quick solution to security
'issues where certain data files need encryption.

'CALL:  SecureFile "C:\WINDOWS\Program.exe", "C:\WINDOWS\Program.exe", False, _
'        "HelloWorld", True

'NOTE:  By making input and output file the same, you will overwrite the old
'       file with the new encrypted / decrypted file.

'SPEED:  This code takes about 2 minutes a meg to Read, Encrypt, and ReWrite File
'        which seems a bit slow.  It's slower if you have Ensure Integrity Checked.
Dim strTime As String
strTime = Time

'         Setup error control
    On Error GoTo Err_Function
    If Trim(InputFile) = "" Or Trim(OutputFile) = "" Then
        Err.Raise 1, "SecureFX v1.0.0", "Input / Output File Not Present"
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
    
    'The Position where we are in the password
    Dim Password_Position As Long
    frmMain.lblStatus.Caption = Int(7 / 24 * 100) & "%"
    
    'Set the Password Position
    Password_Position = Int(Len(Password_Position) / 3)
    
    frmMain.lblStatus.Caption = Int(8 / 24 * 100) & "%"
    
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
    'Easy.  Just switch arround the values with XOR operator.
    frmMain.lblWork2.Caption = "Cryting..."
    
    For i = 1 To Length_Of_File
        'NOTE:  If you are opening a huge file and system does not respond here,
        '       you may want to add a DoEvents statement.  For now, I leave
        '       DoEvents out so it will go as fast as posssible
        
        'Add a little security by using password
        Password_Position = Password_Position + 1
        frmMain.lblStatus.Caption = Int(i / Length_Of_File * 100) & "%"

        'Repeat through password
        If Password_Position > Len(Password) Then Password_Position = 1
        'Finally, take a letter at Password_Position and encrypt current byte of
        'our file with XOR character value
        MyArray(i) = MyArray(i) Xor Asc(Mid(Password, Password_Position, 1))
        
        
        If ForceIntegrity Then DoEvents
    Next

    'Windows may have some catching up to do
    DoEvents
    
    frmMain.lblWork2.Caption = "Working..."
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
