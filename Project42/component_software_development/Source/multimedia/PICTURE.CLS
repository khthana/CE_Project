VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "picture"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Public Sub play(ByVal itemid As Integer)
    Dim ByteData() As Byte   'Byte array for picture file.
    Dim DestFileNum As Integer, id As Integer
    Dim DiskFile As String
    Dim cn As ADODB.Connection
    Dim rs As ADODB.Recordset
    Dim strConn As String
    Dim strSQL As String
    Dim FileLength As Long
    Dim Numblocks As Integer
    Dim LeftOver As Long
    Dim i As Integer
    Const BlockSize = 100000 'This size can be experimented with for
                                'performance and reliability.
    On Error GoTo PlayError
    

   ' Remove any existing destination file.
   
   DiskFile = "c:\asfroot\picture\" & CStr(itemid) & ".tmp"
   If Len(Dir$(DiskFile)) > 0 Then
         Kill DiskFile
   End If


      DestFileNum = FreeFile
      Open DiskFile For Binary As DestFileNum

   'Make Connection
   Set cn = New ADODB.Connection

   strConn = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=ecomm;PWD=public;"
   
   cn.Open strConn
    ' -- Open recordset --
      strSQL = "SELECT itemid, picture FROM vitempicture WHERE itemid =" & itemid
      Set rs = New ADODB.Recordset
      rs.LockType = adLockReadOnly
      rs.CursorLocation = adUseClient
      rs.Open strSQL, cn
    
      FileLength = rs.Fields(1).ActualSize
    ' -- Start Retreive --
      Numblocks = FileLength / BlockSize
      LeftOver = FileLength Mod BlockSize
      
      ByteData() = rs(1).GetChunk(LeftOver)
      Put DestFileNum, , ByteData()

      For i = 1 To Numblocks
          ByteData() = rs(1).GetChunk(BlockSize)
          Put DestFileNum, , ByteData()
      Next i

      rs.Close
      Close DestFileNum

Exit Sub
PlayError:
      Err.Raise Err.Number, , Err.Description

End Sub

