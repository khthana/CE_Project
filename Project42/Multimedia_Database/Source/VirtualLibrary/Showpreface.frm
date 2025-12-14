VERSION 5.00
Begin VB.Form Showpreface 
   AutoRedraw      =   -1  'True
   BorderStyle     =   0  'None
   Caption         =   "Preface"
   ClientHeight    =   8655
   ClientLeft      =   2100
   ClientTop       =   180
   ClientWidth     =   8325
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   ScaleHeight     =   8655
   ScaleMode       =   0  'User
   ScaleWidth      =   8325
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Image Image1 
      Height          =   8595
      Left            =   0
      Stretch         =   -1  'True
      Top             =   0
      Width           =   8295
   End
End
Attribute VB_Name = "Showpreface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()
Image1.Picture = LoadPicture(DetailBook.Filepreface)
End Sub
Private Sub Image1_Click()
Unload Me
DetailBook.Show
End Sub
