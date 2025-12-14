VERSION 5.00
Begin VB.Form Form2 
   Caption         =   "Pregled"
   ClientHeight    =   6270
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7005
   Icon            =   "Form2.frx":0000
   LinkTopic       =   "Form2"
   MinButton       =   0   'False
   ScaleHeight     =   6270
   ScaleWidth      =   7005
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      Height          =   5895
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   0
      Width           =   6975
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Unload Me

End Sub

Private Sub Form_Paint()
On Error GoTo greska
Form1.Hide
Open Form1.Dir1.Path + "\" + Form1.Label1.Caption For Input As 1
Text1.Text = StrConv(InputB(LOF(1), 1), vbUnicode)
Close #1
Form2.Caption = Form1.Label1.Caption
GoTo kraj
greska:
MsgBox "Ne mogu da otvorim fajl. Verovatno je veci od 64K.", , "Greska"
Close #1
End
kraj:
End Sub


Private Sub Form_Resize()
Text1.Height = Form2.Height - 400
Text1.Width = Form2.Width - 100

End Sub


Private Sub Form_Terminate()
Form1.Show

End Sub


Private Sub Form_Unload(Cancel As Integer)
Form1.Show

End Sub


