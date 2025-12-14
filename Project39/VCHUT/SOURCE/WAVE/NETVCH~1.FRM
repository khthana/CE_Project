VERSION 4.00
Begin VB.Form Form1 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "NetWork Voice Chat "
   ClientHeight    =   4050
   ClientLeft      =   2400
   ClientTop       =   2415
   ClientWidth     =   3630
   Height          =   4740
   Icon            =   "NetVChat2.frx":0000
   Left            =   2340
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4050
   ScaleWidth      =   3630
   Top             =   1785
   Width           =   3750
   Begin VB.Frame Frame4 
      BeginProperty Font 
         name            =   "Arial"
         charset         =   0
         weight          =   700
         size            =   14.25
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   855
      Left            =   120
      TabIndex        =   5
      Top             =   0
      Width           =   3375
      Begin VB.TextBox txtServer 
         Height          =   315
         Left            =   120
         TabIndex        =   6
         Top             =   360
         Width           =   3135
      End
   End
   Begin VB.CommandButton btnDial 
      Caption         =   "Dial"
      BeginProperty Font 
         name            =   "Arial"
         charset         =   0
         weight          =   700
         size            =   11.25
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   1320
      TabIndex        =   2
      Top             =   1200
      Width           =   1935
   End
   Begin VB.ListBox connectionlist 
      Height          =   480
      Left            =   4080
      TabIndex        =   1
      Top             =   2160
      Width           =   1815
   End
   Begin VB.CommandButton btnTalk 
      Caption         =   "Talk"
      Enabled         =   0   'False
      BeginProperty Font 
         name            =   "Arial"
         charset         =   0
         weight          =   700
         size            =   11.25
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   1320
      TabIndex        =   0
      Tag             =   "g"
      Top             =   1920
      Width           =   1935
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         name            =   "Arial"
         charset         =   0
         weight          =   700
         size            =   14.25
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   2655
      Left            =   120
      TabIndex        =   3
      Top             =   840
      Width           =   3375
      Begin VB.CommandButton btnHang 
         Caption         =   "Hangup"
         BeginProperty Font 
            name            =   "Arial"
            charset         =   0
            weight          =   700
            size            =   11.25
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   1200
         TabIndex        =   4
         Top             =   1920
         Width           =   1935
      End
      Begin VB.Image Image4 
         Height          =   480
         Left            =   360
         Picture         =   "NetVChat2.frx":27A2
         Top             =   1920
         Width           =   480
      End
      Begin VB.Image Image3 
         Height          =   480
         Left            =   360
         Picture         =   "NetVChat2.frx":2BE4
         Top             =   1080
         Width           =   480
      End
      Begin VB.Image Image2 
         Height          =   480
         Left            =   360
         Picture         =   "NetVChat2.frx":3026
         Top             =   360
         Width           =   480
      End
   End
   Begin VB.PictureBox TCPSocket 
      Height          =   480
      Index           =   0
      Left            =   2400
      ScaleHeight     =   420
      ScaleWidth      =   1140
      TabIndex        =   8
      Top             =   1800
      Width           =   1200
   End
   Begin ComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   330
      Left            =   0
      TabIndex        =   7
      Top             =   3720
      Width           =   3630
      _ExtentX        =   6403
      _ExtentY        =   582
      SimpleText      =   ""
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.Tag             =   ""
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         name            =   "MS Sans Serif"
         charset         =   222
         weight          =   400
         size            =   8.25
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      MouseIcon       =   "NetVChat2.frx":3468
   End
   Begin VB.Menu menFile 
      Caption         =   "&File"
      Begin VB.Menu menExit 
         Caption         =   "&Exit"
      End
   End
   Begin VB.Menu menAbout 
      Caption         =   "&About"
   End
End
Attribute VB_Name = "Form1"
Attribute VB_Creatable = False
Attribute VB_Exposed = False

Option Explicit
Public wStream As Object
Public CLOSINGAPPLICATION As Boolean



Private Sub btnDial_Click()
Dim idx As Long
Dim status As String
        btnDial.Enabled = False
 idx = InstanceTCP(TCPSocket)                        ' Instance TCP Control...
        status = "Waiting For Connecting To " & txtServer.Text
        StatusBar1.Panels(1).Text = status
        Screen.MousePointer = vbHourglass
           
        If (idx > 0) Then                                   ' Did control instance get created???

           connectionlist.Enabled = False                  ' Disable connection list box
           txtServer.Enabled = False
            On Error Resume Next
            If Not Connect(TCPSocket(idx), txtServer.Text, VOICEPORT) Then ' Attempt to connect
                 Unload TCPSocket(idx)                       ' Connect failed unload control instance
                 txtServer.Enabled = True
                 MsgBox ("Your IP Host not Find or Don't Run Program")
                 btnDial.Enabled = True
                 Screen.MousePointer = vbDefault
                 StatusBar1.Panels(1).Text = "Ready To Connection"
                 
            Else
                Screen.MousePointer = vbDefault
                status = "Connecting To " & txtServer.Text
                StatusBar1.Panels(1).Text = status
                StatusBar1.Refresh
                btnHang.Enabled = True
                Image2 = LoadPicture(App.Path & "\phone13.ico")
                Image4 = LoadPicture(App.Path & "\phone07.ico")
                connectionlist.Enabled = True
            End If
        End If
End Sub



Private Sub btnHang_Click()
    Dim idx As Integer
   
    idx = 1
    Call RemoveConnectionFromList(TCPSocket(idx), connectionlist) ' Clear ListBox Entry(s)...
    Call Disconnect(TCPSocket(idx))                     ' Disconnect Socket Connection
    Unload TCPSocket(idx)                               ' Destroy socket instance

    btnTalk.Enabled = (connectionlist.ListCount > 0)    ' Enable/Disable Talk Button...
     txtServer.Enabled = True
     Image2 = LoadPicture(App.Path & "\key04.ico")
     Image4 = LoadPicture(App.Path & "\phone08.ico")
 
     
     btnHang.Enabled = False
     btnDial.Enabled = True
     StatusBar1.Panels(1).Text = "Ready To Connection"

End Sub

Private Sub Form_Load()
    Dim rc As Long                                      ' Return Code Variable
    Dim idx As Long                                     ' Current TCP idx variable
    Dim TCPidx As Long                                  ' Newly created TCP idx value
'--------------------------------------------------------------
    CLOSINGAPPLICATION = False                          ' Set status to not closing
    Move (Screen.Width - Width) / 2, (Screen.Height - Height) / 2
    Image2 = LoadPicture(App.Path & "\key04.ico")

    StatusBar1.Panels(1).Width = Me.Width
    StatusBar1.Panels(1).Text = "Ready to connection"
    txtServer.Text = "203.151.148.22"
    Set wStream = CreateObject("WaveStreaming.WaveStream")
    Call wStream.InitACMCodec(WAVE_FORMAT_GSM610, TIMESLICE)
'   Call wStream.InitACMCodec(WAVE_FORMAT_ADPCM, TIMESLICE)
'   Call wStream.InitACMCodec(WAVE_FORMAT_MSN_AUDIO, TIMESLICE)
'   Call wStream.InitACMCodec(WAVE_FORMAT_PCM, TIMESLICE)

    btnTalk.Enabled = False                             ' Disable Until Connect
    btnHang.Enabled = False                             ' Disable Until Connect
   
    Call Listen(TCPSocket(0))                           ' Listen For TCP Connection
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Private Sub Form_Unload(Cancel As Integer)
'--------------------------------------------------------------
    Dim idx As Long                                     ' TCP socket index
    Dim Socket As TCP                                   ' TCP socket control
'--------------------------------------------------------------
    CLOSINGAPPLICATION = True                           ' Set status flag to closing...
    For Each Socket In TCPSocket                        ' For each socket instance
        Call Disconnect(Socket)                         ' Close connection/listen
    Next                                                ' Next Cntl
    Set wStream = Nothing
    End
End Sub




Private Sub menAbout_Click()
Load Form2
Form2.Show
End Sub

Private Sub menExit_Click()
 Dim idx As Long                                     ' TCP socket index
    Dim Socket As TCP                                   ' TCP socket control
'--------------------------------------------------------------
    CLOSINGAPPLICATION = True                           ' Set status flag to closing...
    For Each Socket In TCPSocket                        ' For each socket instance
        Call Disconnect(Socket)                         ' Close connection/listen
    Next                                                ' Next Cntl
    Set wStream = Nothing
    Unload Form1
End Sub


Private Sub TCPSocket_Close(Index As Integer)
' Closing Current TCP Connection...
'--------------------------------------------------------------
    Call RemoveConnectionFromList(TCPSocket(Index), connectionlist) ' Remove Connection From List
    Call Disconnect(TCPSocket(Index))                           ' Close Port Connection...
    Image4 = LoadPicture(App.Path & "\phone08.ico")
    Image2 = LoadPicture(App.Path & "\key04.ico")

    btnTalk.Enabled = (connectionlist.ListCount > 0)            ' Enable/Disable Talk Button...
   
    Unload TCPSocket(Index)
            btnDial.Enabled = True
            btnHang.Enabled = False
            btnTalk.Enabled = False
            StatusBar1.Panels(1).Text = "Ready To Connection"
            
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Private Sub TCPSocket_Connect(Index As Integer)
' TCP Connection Has Been Accepted And Is Open...
'--------------------------------------------------------------
    Call AddConnectionToList(TCPSocket(Index), connectionlist) ' Add New Connection To List
 
    Call ResPlaySound(RingOutId)
    btnTalk.Enabled = True                                  ' Enabled For Connection...
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Private Sub TCPSocket_ConnectionRequest(Index As Integer, ByVal requestID As Long)
' Accepting Inbound TCP Connection Request...
'--------------------------------------------------------------
    Dim rc As Long
    Dim idx As Long
    Dim RemHost As String
    Dim status As String
'--------------------------------------------------------------
   If (Form1.WindowState <> 0) Then
        Form1.WindowState = 0
   End If
   status = "Reguest Connecting From " & txtServer.Text
   StatusBar1.Panels(1).Text = status
    
    If (TCPSocket(Index).RemoteHost <> "") Then
        RemHost = UCase(TCPSocket(Index).RemoteHost)
    Else
        RemHost = UCase(TCPSocket(Index).RemoteHostIP)
        status = "Reguest Connecting From " & RemHost
        StatusBar1.Panels(1).Text = status
   
    End If
     StatusBar1.Panels(1).Text = ""
    
        idx = InstanceTCP(TCPSocket)                            ' Instance TCP Control...
        If (idx > 0) Then                                       ' Validate that control instance was created...
            TCPSocket(idx).LocalPort = 0                        ' Set local port to 0, in order to get next available port.
            Call TCPSocket(idx).Accept(requestID)               ' Accept connection
            Call AddConnectionToList(TCPSocket(idx), connectionlist) ' Add New Connection To List
            
            Call ResPlaySound(RingInId)
            StatusBar1.Panels(1).Text = "Connection To " & RemHost

            btnDial.Enabled = False
            btnHang.Enabled = True
            btnTalk.Enabled = True
        End If
        Image4 = LoadPicture(App.Path & "\phone07.ico")
        Image2 = LoadPicture(App.Path & "\phone13.ico")


'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Private Sub TCPSocket_DataArrival(Index As Integer, ByVal BytesTotal As Long)
' Incomming Buffer On...
'--------------------------------------------------------------
    Dim rc As Long                                      ' Return Code Variable
    Dim WaveData() As Byte                              ' Byte array of wave data
    Static ExBytes(MAXTCP) As Long                      ' Extra bytes in frame buffer
    Static ExData(MAXTCP) As Variant                    ' Extra bytes from frame buffer
'--------------------------------------------------------------
With wStream
    If (TCPSocket(Index).BytesReceived > 0) Then        ' Validate that bytes where actually received
        Do While (TCPSocket(Index).BytesReceived > 0)   ' While data available...
            If (ExBytes(Index) = 0) Then                ' Was there leftover data from last time
                If (.waveChunkSize <= TCPSocket(Index).BytesReceived) Then ' Can we get and entire wave buffer of data
                    Call TCPSocket(Index).GetData(WaveData, vbByte + vbArray, .waveChunkSize) ' Get 1 wave buffer of data
                    Call .SaveStreamBuffer(Index, WaveData) ' Save wave data to buffer
                    Call .AddStreamToQueue(Index)       ' Queue current stream for playback
                Else
                    ExBytes(Index) = TCPSocket(Index).BytesReceived ' Save Extra bytes
                    Call TCPSocket(Index).GetData(ExData(Index), vbByte + vbArray, ExBytes(Index)) ' Get Extra data
                End If
            Else
                Call TCPSocket(Index).GetData(WaveData, vbByte + vbArray, .waveChunkSize - ExBytes(Index)) ' Get leftover bits
                ExData(Index) = MidB(ExData(Index), 1) & MidB(WaveData, 1) ' Sync wave bits...
                Call .SaveStreamBuffer(Index, ExData(Index)) ' Save the current wave data to the wave buffer
                Call .AddStreamToQueue(Index)           ' Queue the current wave stream
                ExBytes(Index) = 0                      ' Clear Extra byte count
                ExData(Index) = ""                      ' Clear Extra data buffer
            End If
        Loop                                            ' Look for next Data Chunk

        If (Not .Playing And .PlayDeviceFree And _
            Not .Recording And .RecDeviceFree) Then     ' Check Audio Device Status
            Call btnTalk_Click                          ' Start PlayBack...
        End If
    End If
End With
End Sub

Private Sub btnTalk_Click()                             ' Activates Audio PlayBack
'--------------------------------------------------------------
    Dim rc As Long                                      ' Return Code Variable
    Dim iPort As Integer                                ' Local Port
    Dim itm As Integer                                  ' Current listitem
'--------------------------------------------------------------
    Image3 = LoadPicture(App.Path & "\lighton.ico")
    Call wStream.InitACMCodec(WAVE_FORMAT_GSM610, TIMESLICE)
    If (Not wStream.Playing And wStream.PlayDeviceFree And _
        Not wStream.Recording And wStream.RecDeviceFree) Then ' Validate Audio Device Status
        wStream.Playing = True                          ' Turn Playing Status On
        btnTalk.Caption = "&Playing"                    ' Modify Button Status Caption
        Screen.MousePointer = vbHourglass               ' Set Pointer To HourGlass
        
        iPort = wStream.StreamInQueue
        Do While (iPort <> NULLPORTID)                  ' While socket ports have data to playback
            
            For itm = 0 To connectionlist.ListCount - 1 ' Search for listitem currently playing sound data
                If (connectionlist.ItemData(itm) = iPort) Then ' If a match is found...
                    connectionlist.TopIndex = itm       ' Set that listitem to top of listbox
                    connectionlist.Selected(itm) = True ' Select listitem to show who is currently talking...
                    Exit For                            ' Quit listitem search
                End If
            Next                                        ' Check next listitem
            
            rc = wStream.PlayWave(Me.hWnd, iPort)       ' Play wave data in iPort...
            Call wStream.RemoveStreamFromQueue(iPort)   ' Remove PortID From PlayWave Queue
            iPort = wStream.StreamInQueue
            
        Loop                                            ' Search for next socket in playback queue
        
        connectionlist.TopIndex = 0                     ' Reset top image...
        If (connectionlist.ListCount > 0) Then
            connectionlist.Selected(0) = True           ' Deselect previously listitem
            connectionlist.Selected(0) = False          ' Deselect currently selected listitem
        End If
        Screen.MousePointer = vbDefault                 ' Set Pointer To Normal
        btnTalk.Caption = "&Talk"                       ' Modify Button Status Caption
        wStream.Playing = False                         ' Turn Playing Status Off
    End If
    Image3 = LoadPicture(App.Path & "\lightoff.ico")

'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Private Sub btnTalk_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
' Activates Audio Recording...
'--------------------------------------------------------------
    Dim rc As Long                                      ' Return Code Variable
'--------------------------------------------------------------
    Image3 = LoadPicture(App.Path & "\lighton.ico")
 
    If (Not wStream.Playing And Not wStream.Recording And wStream.RecDeviceFree And wStream.PlayDeviceFree) Then          ' Check Audio Device Status
        wStream.Recording = True                                ' Set Recording Flag
        btnTalk.Caption = "&Talking"                    ' Update Button Status To "Talking"
        Screen.MousePointer = vbHourglass               ' Set Hourglass
        rc = wStream.RecordWave(Me.hWnd, TCPSocket)     ' Record voice and send to all connected sockets
        Screen.MousePointer = vbDefault                 ' Reset Mouse Pointer
        btnTalk.Caption = "&Talk"                       ' Reset Button Status
        Image3 = LoadPicture(App.Path & "\lighton.ico")
        If Not wStream.Playing And _
               wStream.PlayDeviceFree And _
               wStream.RecDeviceFree Then               ' Is Audio Device Free?
            Call btnTalk_Click                          ' Active Playback Of Any Inbound Messages...
        End If
    End If
    Image3 = LoadPicture(App.Path & "\lightoff.ico")

'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

Private Sub btntalk_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    wStream.Recording = False                           ' Stop Recording
    Image3 = LoadPicture(App.Path & "\lightoff.ico")

End Sub


Private Sub ConnectionList_DblClick()
'--------------------------------------------------------------
    Dim MemberID As String                              ' (Server)(TCPidx)(RemoteIP)
    Dim idx As Long                                     ' TCP idx
'--------------------------------------------------------------
    If (connectionlist.Text = "") Then Exit Sub
    MemberID = connectionlist.List(connectionlist.ListIndex) ' Get The Conversation MemberID String From List Box
    
    Call GetIdxFromMemberID(TCPSocket, MemberID, idx)  ' Get TCP idx From Member ID
    Debug.Print idx
    Call RemoveConnectionFromList(TCPSocket(idx), connectionlist) ' Clear ListBox Entry(s)...
    Call Disconnect(TCPSocket(idx))                     ' Disconnect Socket Connection
    Unload TCPSocket(idx)                               ' Destroy socket instance

    btnTalk.Enabled = (connectionlist.ListCount > 0)    ' Enable/Disable Talk Button...
'--------------------------------------------------------------
End Sub




