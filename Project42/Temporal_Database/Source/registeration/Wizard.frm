VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Wizard 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   " Sql Builder Wizard"
   ClientHeight    =   5295
   ClientLeft      =   2160
   ClientTop       =   1980
   ClientWidth     =   9120
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5295
   ScaleWidth      =   9120
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Height          =   4815
      Index           =   0
      Left            =   2280
      TabIndex        =   2
      Top             =   360
      Width           =   6735
      Begin VB.CommandButton RemAll 
         Caption         =   "<<Rem.. All"
         Height          =   375
         Left            =   2760
         TabIndex        =   33
         Top             =   2280
         Width           =   1095
      End
      Begin VB.ListBox TempList 
         Height          =   450
         Left            =   4320
         TabIndex        =   30
         Top             =   1560
         Visible         =   0   'False
         Width           =   1695
      End
      Begin VB.ComboBox Combo5 
         Height          =   315
         ItemData        =   "Wizard.frx":0000
         Left            =   840
         List            =   "Wizard.frx":000D
         Style           =   2  'Dropdown List
         TabIndex        =   28
         Top             =   4200
         Width           =   1455
      End
      Begin RichTextLib.RichTextBox Temp 
         Height          =   375
         Left            =   4320
         TabIndex        =   22
         Top             =   1080
         Visible         =   0   'False
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   661
         _Version        =   393217
         TextRTF         =   $"Wizard.frx":0032
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Temporal"
         Height          =   255
         Left            =   2760
         TabIndex        =   21
         Top             =   3600
         Width           =   1455
      End
      Begin VB.ComboBox Combo1 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "Wizard.frx":0156
         Left            =   2760
         List            =   "Wizard.frx":0163
         TabIndex        =   20
         Text            =   "Combo1"
         Top             =   4200
         Width           =   1575
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   360
         Top             =   1680
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Wizard.frx":0189
               Key             =   "key1"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Wizard.frx":05DB
               Key             =   "key2"
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Wizard.frx":0A2D
               Key             =   "key3"
            EndProperty
         EndProperty
      End
      Begin VB.Data Data1 
         Caption         =   "Data1"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   375
         Left            =   4320
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   1  'Dynaset
         RecordSource    =   ""
         Top             =   600
         Visible         =   0   'False
         Width           =   1695
      End
      Begin VB.ComboBox Combo2 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "Wizard.frx":0E7F
         Left            =   4920
         List            =   "Wizard.frx":0E8C
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   4200
         Width           =   1695
      End
      Begin VB.ListBox List1 
         Height          =   2790
         ItemData        =   "Wizard.frx":0EB2
         Left            =   4080
         List            =   "Wizard.frx":0EB4
         TabIndex        =   5
         Top             =   360
         Width           =   2535
      End
      Begin VB.CommandButton Add 
         Caption         =   "Add >"
         Height          =   375
         Left            =   2760
         TabIndex        =   4
         Top             =   840
         Width           =   1095
      End
      Begin VB.CommandButton Remove 
         Caption         =   "< Remove"
         Height          =   375
         Left            =   2760
         TabIndex        =   3
         Top             =   1560
         Width           =   1095
      End
      Begin MSComctlLib.TreeView TreeView1 
         Height          =   2835
         Left            =   120
         TabIndex        =   6
         Top             =   360
         Width           =   2535
         _ExtentX        =   4471
         _ExtentY        =   5001
         _Version        =   393217
         Indentation     =   353
         LineStyle       =   1
         Style           =   7
         ImageList       =   "ImageList1"
         BorderStyle     =   1
         Appearance      =   1
      End
      Begin VB.Label Label4 
         Caption         =   "Sorting"
         Height          =   255
         Left            =   120
         TabIndex        =   29
         Top             =   4200
         Width           =   855
      End
      Begin VB.Label Label5 
         Caption         =   "Style"
         Height          =   255
         Left            =   4920
         TabIndex        =   19
         Top             =   3960
         Width           =   1575
      End
      Begin VB.Label Label1 
         Caption         =   "Temporal Time"
         Height          =   255
         Left            =   2760
         TabIndex        =   18
         Top             =   3960
         Width           =   1575
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4815
      Index           =   1
      Left            =   2280
      TabIndex        =   8
      Top             =   360
      Width           =   6735
      Begin VB.TextBox Text1 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   240
         TabIndex        =   27
         Text            =   "Text1"
         Top             =   2640
         Width           =   1575
      End
      Begin RichTextLib.RichTextBox RichTextBox3 
         Height          =   1455
         Left            =   240
         TabIndex        =   26
         Top             =   3120
         Width           =   6255
         _ExtentX        =   11033
         _ExtentY        =   2566
         _Version        =   393217
         Enabled         =   -1  'True
         TextRTF         =   $"Wizard.frx":0EB6
      End
      Begin VB.CommandButton Deletecon 
         Caption         =   "Or Condition"
         Height          =   375
         Left            =   4320
         TabIndex        =   25
         Top             =   2640
         Width           =   1455
      End
      Begin VB.CommandButton Addcon 
         Caption         =   "And Condition"
         Height          =   375
         Left            =   1920
         TabIndex        =   24
         Top             =   2640
         Width           =   1455
      End
      Begin MSComctlLib.TreeView TreeView2 
         DragIcon        =   "Wizard.frx":0FCE
         Height          =   2175
         Left            =   240
         TabIndex        =   23
         Top             =   360
         Width           =   3135
         _ExtentX        =   5530
         _ExtentY        =   3836
         _Version        =   393217
         HideSelection   =   0   'False
         Indentation     =   353
         LineStyle       =   1
         Style           =   7
         ImageList       =   "ImageList1"
         Appearance      =   1
      End
      Begin VB.ComboBox Combo4 
         Height          =   315
         ItemData        =   "Wizard.frx":1410
         Left            =   4800
         List            =   "Wizard.frx":141A
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1560
         Width           =   1455
      End
      Begin VB.ComboBox Combo3 
         Height          =   315
         ItemData        =   "Wizard.frx":1429
         Left            =   4800
         List            =   "Wizard.frx":143F
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   480
         Width           =   1455
      End
      Begin VB.Label Label3 
         Caption         =   "Match Case"
         Height          =   255
         Left            =   3600
         TabIndex        =   13
         Top             =   1680
         Width           =   1095
      End
      Begin VB.Label Label2 
         Caption         =   "Condition"
         Height          =   255
         Left            =   3600
         TabIndex        =   12
         Top             =   600
         Width           =   975
      End
   End
   Begin VB.CommandButton Buildcmd 
      Caption         =   "Build"
      Height          =   375
      Left            =   1080
      TabIndex        =   14
      Top             =   4920
      Width           =   975
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   5295
      Left            =   2160
      TabIndex        =   11
      Top             =   0
      Width           =   6975
      _ExtentX        =   12303
      _ExtentY        =   9340
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   3
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Column Display"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Add Condition"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Select Statement"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin VB.Frame DescriptionFrame 
      Caption         =   "Description"
      Height          =   2655
      Left            =   0
      TabIndex        =   1
      Top             =   2160
      Width           =   2055
      Begin RichTextLib.RichTextBox RichTextBox1 
         Height          =   2295
         Left            =   120
         TabIndex        =   16
         Top             =   240
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   4048
         _Version        =   393217
         BackColor       =   12632256
         TextRTF         =   $"Wizard.frx":1458
      End
   End
   Begin VB.CommandButton CancelCmd 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   4920
      Width           =   975
   End
   Begin VB.Frame Frame1 
      Height          =   4815
      Index           =   2
      Left            =   2280
      TabIndex        =   15
      Top             =   360
      Width           =   6735
      Begin VB.CommandButton SendtoEdit 
         Caption         =   "Send to Sql Editor"
         Height          =   375
         Left            =   2400
         TabIndex        =   32
         Top             =   4320
         Width           =   1815
      End
      Begin RichTextLib.RichTextBox RichTextBox2 
         Height          =   3855
         Left            =   120
         TabIndex        =   17
         Top             =   240
         Width           =   6495
         _ExtentX        =   11456
         _ExtentY        =   6800
         _Version        =   393217
         TextRTF         =   $"Wizard.frx":157C
      End
   End
   Begin RichTextLib.RichTextBox temp2 
      Height          =   375
      Left            =   720
      TabIndex        =   31
      Top             =   960
      Visible         =   0   'False
      Width           =   975
      _ExtentX        =   1720
      _ExtentY        =   661
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"Wizard.frx":1694
   End
   Begin VB.Image Image1 
      Height          =   2100
      Left            =   0
      Picture         =   "Wizard.frx":17B8
      Stretch         =   -1  'True
      Top             =   0
      Width           =   2115
   End
End
Attribute VB_Name = "Wizard"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private mNode As Node
Dim keylist As Integer
Dim KeyIn As Integer
Dim IsAddTree As Boolean
Public Newline As String
Private help1 As String
Private help2 As String
Private help3 As String

'Cutdot will Cut pure TableName from x
Private Function CutDot(X As String) As String
 Dim start_pos, end_pos As Long
        CutDot = X
        Temp.Text = X
              start_pos = Temp.Find(".") + 1
              Temp.SelStart = start_pos
              end_pos = 1000
              Temp.SelLength = end_pos - start_pos
              CutDot = Temp.SelText
              Temp.SelLength = Temp.SelLength - 2
              CutDot = Temp.SelText
 
End Function
'Cutdot will Cut pure Columnname from x
Private Function cutdotpost(X As String) As String
 Dim start_pos, end_pos As Long
        cutdotpost = X
        Temp.Text = X
              end_pos = Temp.Find(".")
              start_pos = 0
              Temp.SelStart = start_pos
              Temp.SelLength = end_pos - start_pos
              cutdotpost = Temp.SelText
End Function
'CutSpacepost will return prestring with no space
Private Function CutSpacepost(X As String) As String
 Dim start_pos, end_pos As Long
 Dim Y As String
        CutSpacepost = X
        'If x <> "" Then
        Temp.Text = X
              end_pos = Temp.Find(" ")
              If end_pos <> -1 Then
              start_pos = 0
              Temp.SelStart = start_pos
              Temp.SelLength = end_pos - start_pos
              Y = Temp.SelText
              CutSpacepost = Temp.SelText
              End If
        'End If
End Function
Private Function FromTable() As String
 Dim i As Integer
 Dim j As Integer
 Dim string1, string2 As String
 
 Dim Is_Add As Boolean
 TempList.Clear
    For i = 0 To List1.ListCount - 1
        If TempList.ListCount > 0 Then
           ' string1 = List1.List(i)
            Is_Add = True
            For j = 0 To TempList.ListCount - 1
                If (TempList.List(j) = cutdotpost(List1.List(i))) Then
                    Is_Add = False
                End If
            Next j
            If Is_Add Then
                TempList.AddItem (cutdotpost(List1.List(i)))
                             
            End If
        Else:
            TempList.AddItem (cutdotpost(List1.List(i)))
        End If
    Next i
    string2 = " "
    For i = 0 To TempList.ListCount - 1
        If i < TempList.ListCount - 1 Then
           string2 = string2 & TempList.List(i) & ", "
        Else: string2 = string2 & TempList.List(i)
        End If
    Next i
     FromTable = string2
End Function
Private Function add_order_by(X As String) As String
Dim i, end_pos, start_pos As Long
Dim is_orderby As Boolean
Dim SortStr As String

temp2.Text = ""

    is_orderby = False
    For i = 0 To List1.ListCount - 1

        temp2.Text = List1.List(i)
              start_pos = temp2.Find(" ")
            
              If start_pos <> -1 Then
                start_pos = start_pos + 1
              temp2.SelStart = start_pos
              temp2.SelLength = 4
                If ((temp2.SelText = " Asc") Or (temp2.SelText = " Des")) Then
                    SortStr = temp2.SelText
                    If is_orderby = False Then
                        is_orderby = True
                        X = X & "ORDER BY" & " " & _
                        CutSpacepost(List1.List(i)) & " " & SortStr
                    Else:
                        X = X & ", " & CutSpacepost(List1.List(i)) & " " & SortStr
                    End If

                End If

              End If
    Next i
    X = X
    add_order_by = X
End Function
Private Sub AddTree1()
Dim i As Integer
Dim j As Integer
    TreeView1.Nodes.Clear
    Set mNode = TreeView1.Nodes.Add()
    mNode.Text = "DATABASE"
    mNode.Key = "Root1"
    mNode.Image = "key1"
Dim nodX As Node
Dim nodY As Node
Dim keyj As String
Dim FieldName As String
    For j = 0 To Data1.Database.TableDefs.Count - 1
    If (Data1.Database.TableDefs(j).Attributes And _
       (dbSystemObject + dbHiddenObject)) = 0 Then
    If (Check1.Value = 0) Or (j Mod 2 = 1) Then
    Set nodX = TreeView1.Nodes.Add("Root1", tvwChild)
    keyj = j
    
    nodX.Text = CutDot(Data1.Database.TableDefs(j).Name)
    nodX.Key = keyj & " Table $%@#" & nodX.Text
    nodX.Image = "key" & 1
        For i = o To Data1.Database.TableDefs(j).Fields.Count - 1
            
            FieldName = Data1.Database.TableDefs(j).Fields(i).Name
            If (FieldName <> "valid_from") And (FieldName <> "valid_to") And _
             (FieldName <> "txstart") And (FieldName <> "txstop") Then
                Set nodY = TreeView1.Nodes.Add(nodX.Key, tvwChild)
                keyi = i
                nodY.Key = "child" & keyi & keyj & nodX.Text
                nodY.Text = Data1.Database.TableDefs(j).Fields(i).Name
                nodY.Image = "key" & 2
            End If
        Next i
    End If
    End If
    Next j

End Sub

Private Sub AddTree2()
Dim i As Integer

Dim j As Integer
    TreeView2.Nodes.Clear
    Set mNode = TreeView2.Nodes.Add()
    mNode.Text = "DATABASE"
    mNode.Key = "Root1"
    mNode.Image = "key1"
Dim nodX As Node
Dim nodY As Node
Dim keyj As String
    For j = 0 To Data1.Database.TableDefs.Count - 1
    If (Data1.Database.TableDefs(j).Attributes And _
       (dbSystemObject + dbHiddenObject)) = 0 Then
    If (Check1.Value = 0) Or (j Mod 2 = 1) Then
    
    Set nodX = TreeView2.Nodes.Add("Root1", tvwChild)
    keyj = j
    
    nodX.Text = CutDot(Data1.Database.TableDefs(j).Name)
    nodX.Key = keyj & " Table $%@#" & nodX.Text
    nodX.Image = "key" & 1
        For i = o To Data1.Database.TableDefs(j).Fields.Count - 1
            Set nodY = TreeView2.Nodes.Add(nodX.Key, tvwChild)
            keyi = i
            nodY.Key = "child $%@#" & keyi & keyj & nodX.Text
            nodY.Text = Data1.Database.TableDefs(j).Fields(i).Name
            nodY.Image = "key" & 2
        Next i
    End If
    End If
    Next j

End Sub
Private Sub Add_Click()
On Error Resume Next
Dim i As Integer
Dim have_list As Boolean
Dim last_node As Node
Dim temp_node As Node
Dim temp_node2 As Node
have_data = False
Temp.Text = TreeView1.SelectedItem.Key

If Temp.Find(" Table $%@#") = -1 Then

 For i = o To List1.ListCount
  If TreeView1.SelectedItem.Parent.Text & "." & TreeView1.SelectedItem.Text = _
  CutSpacepost(List1.List(i)) Then
     have_list = True
  End If
 Next i
 If Not have_list Then
    
   List1.AddItem TreeView1.SelectedItem.Parent.Text & "." & TreeView1.SelectedItem.Text
 End If

Else:
  Set last_node = TreeView1.SelectedItem.Child.LastSibling
  Set temp_node = TreeView1.SelectedItem.Child.FirstSibling
  'Label6.Caption = last_node.Text
  Do While temp_node.Key <> last_node.Key
      have_list = False
      For i = 0 To List1.ListCount
      If TreeView1.SelectedItem.Text & "." & temp_node.Text = _
      CutSpacepost(List1.List(i)) Then
        have_list = True
      End If
      Next i
      If Not have_list Then
       List1.AddItem TreeView1.SelectedItem.Text & "." & temp_node.Text
      End If
       
      Set temp_node2 = temp_node.Next
      Set temp_node = temp_node2
  Loop
   
End If
  
  'Label6.Caption = TreeView1.SelectedItem.Child.FirstSibling.Text
End Sub
Private Sub Addcondition(strin As String)
   Dim str As String
On Error Resume Next
Temp = TreeView2.SelectedItem.Key
If Temp.Find("child $%@#") <> -1 Then
  str = Combo4.List(Combo4.ListIndex) & "  "
  If str = "Same  " Then str = ""
    If RichTextBox3.Text <> "" Then
        RichTextBox3.Text = RichTextBox3.Text & " " & strin & " ("
    Else:
        RichTextBox3.Text = "(" & RichTextBox3.Text
    End If
    RichTextBox3.Text = RichTextBox3.Text & str & TreeView2.SelectedItem.Parent.Text & "." _
    & TreeView2.SelectedItem.Text & " " & Combo3.List(Combo3.ListIndex) _
         & "   ) "
 End If
End Sub
Private Sub Addcon_Click()
 Addcondition ("AND")
End Sub

Private Sub Buildcmd_Click()
Dim Space, Comma As String
Dim i As Integer
Dim Xstr As String

Space = "  "
    RichTextBox2.Text = "SELECT" & Space
    For i = 0 To List1.ListCount - 1
    Comma = ""
    If (i < (List1.ListCount - 1)) Then
        Comma = ","
    End If
    RichTextBox2.Text = RichTextBox2.Text & Space & CutSpacepost(List1.List(i)) & Comma
    Next i
    
    If Combo1.Enabled Then
        'If Combo1.List(Combo1.ListIndex) <> "None" Then
        '    RichTextBox2.Text = Combo1.List(Combo1.ListIndex) & NewLine & RichTextBox2.Text
        'End If
        If Combo1.List(Combo1.ListIndex) = "ValidTime" Then
            If Combo2.List(Combo2.ListIndex) = "Current" Then
            ElseIf Combo2.List(Combo2.ListIndex) = "Sequenced" Then
                RichTextBox2.Text = RichTextBox2.Text & ", " & cutdotpost(List1.List(0)) & "." _
                & "valid_from" & ", " & cutdotpost(List1.List(0)) & "." & "valid_to"
            ElseIf Combo2.List(Combo2.ListIndex) = "NonSequenced" Then
            End If
        ElseIf Combo1.List(Combo1.ListIndex) = "TransactionTime" Then
            If Combo2.List(Combo2.ListIndex) = "Current" Then
            ElseIf Combo2.List(Combo2.ListIndex) = "Sequenced" Then
                RichTextBox2.Text = RichTextBox2.Text & ", " & cutdotpost(List1.List(0)) & "." _
                & "txstart" & ", " & cutdotpost(List1.List(0)) & "." & "txstop"
            ElseIf Combo2.List(Combo2.ListIndex) = "NonSequenced" Then
            End If
        End If
    End If

    RichTextBox2.Text = RichTextBox2.Text & Newline & _
    "FROM" & Space & FromTable() & Newline
    If RichTextBox3.Text <> "" Then
    RichTextBox2.Text = RichTextBox2.Text & "WHERE " & RichTextBox3.Text
        
        If Combo1.Enabled Then
        If Combo1.List(Combo1.ListIndex) = "ValidTime" Then
            If Combo2.List(Combo2.ListIndex) = "Current" Then
                RichTextBox2.Text = RichTextBox2.Text & "AND (valid_to = #12/31/9456# )"
            ElseIf Combo2.List(Combo2.ListIndex) = "Sequenced" Then
            ElseIf Combo2.List(Combo2.ListIndex) = "NonSequenced" Then
            End If
        ElseIf Combo1.List(Combo1.ListIndex) = "TransactionTime" Then
            If Combo2.List(Combo2.ListIndex) = "Current" Then
                RichTextBox2.Text = RichTextBox2.Text & "AND (txstop = #12/31/9456# )"
            ElseIf Combo2.List(Combo2.ListIndex) = "Sequenced" Then
            ElseIf Combo2.List(Combo2.ListIndex) = "NonSequenced" Then
            End If
        End If
        End If
    Else:
        
        If Combo1.Enabled Then
        If Combo1.List(Combo1.ListIndex) = "ValidTime" Then
            If Combo2.List(Combo2.ListIndex) = "Current" Then
                RichTextBox2.Text = RichTextBox2.Text & "WHERE " & _
                "(valid_to = #12/31/9456# )"
            ElseIf Combo2.List(Combo2.ListIndex) = "Sequenced" Then
            ElseIf Combo2.List(Combo2.ListIndex) = "NonSequenced" Then
            End If
        ElseIf Combo1.List(Combo1.ListIndex) = "TransactionTime" Then
            If Combo2.List(Combo2.ListIndex) = "Current" Then
                RichTextBox2.Text = RichTextBox2.Text & "WHERE " & _
                "(txstop = #12/31/9456# )"
            ElseIf Combo2.List(Combo2.ListIndex) = "Sequenced" Then
            ElseIf Combo2.List(Combo2.ListIndex) = "NonSequenced" Then
            End If
        End If
        End If
    End If
    Xstr = RichTextBox2.Text
    RichTextBox2.Text = add_order_by(Xstr)
    
    
    TabStrip1.Tabs(3).Selected = True
    Frame1(2).ZOrder 0
End Sub

Private Sub CancelCmd_Click()
    Wizard.Hide
End Sub

Private Sub Check1_Click()
    AddTree1
    AddTree2
    
    If Check1.Value = 1 Then
    Combo1.Enabled = True
    Combo2.Enabled = True
    Else
    Combo1.Enabled = False
    Combo2.Enabled = False
    End If
End Sub

Private Sub Combo5_Click()
Dim start_pos, end_pos As Integer
If List1.List(List1.ListIndex) <> "" Then
Temp = List1.List(List1.ListIndex)
  If (Temp.Find("Unsorted") = -1) And (Temp.Find("Ascending") = -1) And _
  (Temp.Find("Descending") = -1) Then
    If Combo5.List(Combo5.ListIndex) <> "Unsorted" Then
    List1.List(List1.ListIndex) = List1.List(List1.ListIndex) & "  " & Combo5.List(Combo5.ListIndex)
    End If
  Else:
    If Combo5.List(Combo5.ListIndex) <> "Unsorted" Then
    List1.List(List1.ListIndex) = CutSpacepost(List1.List(List1.ListIndex)) & "  " & Combo5.List(Combo5.ListIndex)
    Else:
    List1.List(List1.ListIndex) = CutSpacepost(List1.List(List1.ListIndex))
    End If
  
  End If
End If
End Sub

Private Sub DBGrid1_Click()

End Sub

Private Sub Deletecon_Click()
 Addcondition ("OR")
End Sub

Private Sub Form_Activate()
On Error GoTo Err_Handler

If IsAddTree <> False Then
Check1.Value = 1
'AddTree1
'AddTree2
End If
IsAddTree = False
Err_Handler:
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    KeyIn = Shift
End Sub


Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
    KeyIn = 0

End Sub

Private Sub Form_Load()
Dim i As Integer
Newline = Chr(10)

help1 = "  -HighLight the Treeview and Click Add Button to Display the Column" & Newline _
        & "  -Select the Listbox and Choose Sorting method" & Newline _
        & "  -Enable Temporal method and Choose Time Variance to  "
help2 = "  -HighLight the Treeview ,Select condition and match case then Click AND or OR to add condition to textbox"
help3 = "  -"
  
   
   For i = 0 To Frame1.Count - 1
   With Frame1(i)
      .Move TabStrip1.ClientLeft, _
      TabStrip1.ClientTop, _
      TabStrip1.ClientWidth, _
      TabStrip1.ClientHeight
   End With
   Next i
   Frame1(0).ZOrder 0
   
 Data1.Connect = "ODBC;DSN=student_data;" & _
"UID=" & LoginForm.User.Text & ";PWD=" & LoginForm.Passwprd.Text & ";"

Combo1.ListIndex = 0
Combo2.ListIndex = 0
Combo3.ListIndex = 0
Combo4.ListIndex = 0
Combo5.ListIndex = 0
  
    If TabStrip1.SelectedItem.Index = 1 Then
        RichTextBox1.Text = help1
    End If
  keylist = 0
  IsAddTree = True

End Sub

Private Sub RemAll_Click()
    List1.Clear
End Sub

Private Sub Remove_Click()
On Error Resume Next
    List1.RemoveItem (List1.ListIndex)
End Sub

Private Sub RichTextBox3_DragDrop(Source As Control, X As Single, Y As Single)
    If Source.Name = "TreeView2" Then
        RichTextBox3.Text = RichTextBox3.Text & " " & TreeView2.SelectedItem.Text
        TreeView2.Drag vbCancel
        TreeView2.SelectedItem = TreeView2.SelectedItem.Parent
    End If
End Sub

Private Sub SendtoEdit_Click()
    EditForm.TabStrip1.Tabs(2).Selected = True
    EditForm.Frame1(1).ZOrder 0
    
    EditForm.OutputSql.Text = RichTextBox2.Text
    Wizard.Hide
End Sub

Private Sub TabStrip1_Click()

    If TabStrip1.SelectedItem.Index = 1 Then
        RichTextBox1.Text = help1
    ElseIf TabStrip1.SelectedItem.Index = 2 Then
        RichTextBox1.Text = help2
    ElseIf TabStrip1.SelectedItem.Index = 3 Then
        RichTextBox1.Text = help3
    End If
    Frame1(TabStrip1.SelectedItem.Index - 1).ZOrder 0
End Sub


Private Sub TreeView1_Collapse(ByVal Node As MSComctlLib.Node)
    Node.Image = "key" & 1
End Sub

Private Sub TreeView1_Expand(ByVal Node As MSComctlLib.Node)
    Node.Image = "key" & 3
End Sub


Private Sub TreeView2_DblClick()
'    RichTextBox3.Text = RichTextBox3.Text & " " & TreeView2.SelectedItem.Text

End Sub

Private Sub TreeView2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
   If KeyIn = 2 Then
    Temp.Text = TreeView2.SelectedItem.Key
    If Temp.Find("child $%@#") <> -1 Then
       TreeView2.Drag vbBeginDrag
    Else:
       TreeView2.Drag vbCancel
    End If
   End If
End Sub

Private Sub TreeView2_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If KeyIn = 2 Then
        TreeView2.SelectedItem = TreeView2.HitTest(X, Y)
    End If
End Sub

Private Sub TreeView2_NodeClick(ByVal Node As MSComctlLib.Node)
 '  If KeyIn = 2 Then
 '   Temp.Text = TreeView2.SelectedItem.Key
 '   If Temp.Find("child $%@#") <> -1 Then
 '      TreeView2.Drag vbBeginDrag
 '   Else:
 '      TreeView2.Drag vbCancel
 '   End If
 '  End If
End Sub
