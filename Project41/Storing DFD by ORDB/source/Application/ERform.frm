VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form ERform 
   BackColor       =   &H80000005&
   Caption         =   "ER Design"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   213
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   312
   WindowState     =   2  'Maximized
   Begin ComctlLib.ImageList ImageList1 
      Left            =   4080
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ERform.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ERform.frx":07BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ERform.frx":0F7C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "ERform.frx":173A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4680
      _ExtentX        =   8255
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "entity"
            Object.ToolTipText     =   "entity"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "one to one"
            Object.ToolTipText     =   "one to one"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "one to many"
            Object.ToolTipText     =   "one to many"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "many to many"
            Object.ToolTipText     =   "many to many"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin VB.Line relation 
      Index           =   0
      Visible         =   0   'False
      X1              =   152
      X2              =   232
      Y1              =   96
      Y2              =   96
   End
End
Attribute VB_Name = "ERform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private drawEntityClick As Boolean
Private drawOTOclick As Boolean
Private drawOTMclick As Boolean
Private drawMTMclick As Boolean
Private sourceFlag As Boolean

' variables use for dragging and dropping Object
Private ItemMoved As Boolean
Private ItemToMove As Integer
Private InitialX As Single
Private InitialY As Single



Private Sub entityBox_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
  If Button = vbLeftButton Then
        Screen.MousePointer = 5
        ItemMoved = True
        ItemToMove = Index
        InitialX = X
        InitialY = Y
  End If
End Sub

Private Sub entityBox_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If ItemMoved Then
        entityBox(ItemToMove).Left = entityBox(ItemToMove).Left - (InitialX - X)
        entityBox(ItemToMove).Top = entityBox(ItemToMove).Top - (InitialY - Y)
    End If
End Sub

Private Sub entityBox_MouseUp(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    ItemMoved = False
    ItemToMove = 0
    Screen.MousePointer = 0
End Sub

Private Sub Form_Click()
    If (drawEntityClick = True) Then
        Call setEntityBox
        drawEntityClick = False
        Exit Sub
    End If
    
    If (drawOTOclick = True) Then
        
        drawOTOclick = False
        Exit Sub
    End If
    
    If (drawOTMclick = True) Then
        
        drawOTMclick = False
        Exit Sub
    End If
    
    If (drawMTMclick = True) Then
        MsgBox "Click source and destination"
        drawMTMclick = False
     
        Exit Sub
    End If
    
End Sub

Private Sub Form_Load()
    ReDim entityState(1)
    entityState(1).Deleted = True
End Sub

Private Sub Image1_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Key
        Case "entity"
            drawEntityClick = True
            drawOTOclick = False
            drawOTMclick = False
            drawMTMclick = False
            MsgBox ("entity button click")
        
        Case "one to one"
            drawOTOclick = True
            drawEntityClick = False
            drawOTMclick = False
            drawMTMclick = False
            MsgBox ("1-1 button click")
            Exit Sub
            
        Case "one to many"
            drawOTMclick = True
            drawEntityClick = False
            drawOTOclick = False
            drawMTMclick = False
            MsgBox ("1-m button click")
            Exit Sub
            
        Case "many to many"
            drawMTMclick = True
            drawEntityClick = False
            drawOTOclick = False
            drawOTMclick = False
            MsgBox ("m-m button click")
            
            sourceFlag = False
            Exit Sub
    End Select
End Sub

Private Sub setEntityBox()

Dim Index As Integer
    
    Index = FindFreeIndex("entity")
    Load entityBox(Index)
    entityState(Index).Deleted = False
    entityState(Index).name = "name"
    
    entityBox(Index).Visible = True
    entityBox(Index).tag = "external"
    
    Load EtNameBox(Index)
    
    EtNameBox(Index).Caption = "name"
    EtNameBox(Index).Left = 14
    EtNameBox(Index).Top = 22
    EtNameBox(Index).Visible = True
    
    Set EtNameBox(Index).Container = entityBox(Index)

End Sub
