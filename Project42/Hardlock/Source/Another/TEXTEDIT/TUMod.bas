Attribute VB_Name = "TUMod"
Global DoCancel As Boolean

Public Sub Graph1(Total As Integer, Pos As Integer)
PrgFrm.GraphF.Width = PrgFrm.GraphB.Width * (Pos / Total)
End Sub

Public Sub Graph2(Total As Integer, Pos As Integer)
PrgFrm.GraphF2.Width = PrgFrm.GraphB2.Width * (Pos / Total)
End Sub

Public Sub Graph3(Total As Single, Pos As Single)
PrgFrm.GraphF.Width = PrgFrm.GraphB.Width * (Pos / Total)
End Sub

Function Encrypt(NK As ListBox, TK As ListBox, SK As ListBox, TextT As String)
DoCancel = False
Dim i As Integer
Dim e As Integer
Dim e2 As Integer
Dim c As Integer
Dim NC(32765) As Integer
Dim kT(32765) As Integer
Dim kN As Integer
Dim kS As Integer
kS = 0
kN = 0
For i = 0 To TK.ListCount - 1
kT(i) = 1
NC(i) = NK.List(i)
Next i
Dim curkey As Integer
Dim endstr As String
For i = 1 To Len(TextT$)
DoEvents
If DoCancel = True Then
Exit Function
End If
c = Asc(Mid$(TextT$, i, 1))
  For e = 0 To TK.ListCount - 1
  c = c + Asc(Mid$(TK.List(e), kT(e), 1))
    If c > 255 Then
    c = c - 255
    End If
  kT(e) = kT(e) + 1
    If kT(e) > Len(TK.List(e)) Then
    kT(e) = 1
    End If
  Graph2 TK.ListCount + NK.ListCount + 1, e + 1
  Next e
  c = c + Val(NC(kN))
    If c > 255 Then
    c = c - 255
    End If
  kN = kN + 1
    If kN > NK.ListCount - 1 Then
    kN = 0
    End If
  Graph2 TK.ListCount + NK.ListCount + 1, TK.ListCount
  c = c + Val(SK.List(kS))
    If c > 255 Then
    c = c - 255
    End If
  kS = kS + 1
    If kS > SK.ListCount - 1 Then
    kS = 0
    End If
  Graph2 TK.ListCount + NK.ListCount + 1, TK.ListCount + 1
  If Not i = 1 Then
  c = Val(c) + Val(Asc(Mid$(endstr$, i - 1, 1)))
  End If
    Do While c > 255
    c = c - 255
    Loop
      For e = 0 To NK.ListCount - 1
        For e2 = 0 To SK.ListCount - 1
        NC(e) = NC(e) + Val(SK.List(e2))
          If NC(e) > 255 Then
          NC(e) = NC(e) - 255
          End If
        Next e2
      If DoCancel = True Then
      Exit Function
      End If
      Graph2 TK.ListCount + NK.ListCount + 1, TK.ListCount + e + 2
      Next e
    endstr$ = endstr$ & Chr$(c)
Graph1 Len(TextT$), i
If DoCancel = True Then
Exit Function
End If
Next i
PrgFrm.Caption = "Progress"
Encrypt = endstr$
End Function

Function Decrypt(NK As ListBox, TK As ListBox, SK As ListBox, TextT As String)
DoCancel = False
Dim i As Integer
Dim e As Integer
Dim e2 As Integer
Dim c As Integer
Dim NC(32765) As Integer
Dim kT(32765) As Integer
Dim kN As Integer
Dim kS As Integer
Dim curkey As Integer
Dim endstr As String
kS = 0
kN = 0
For i = 0 To TK.ListCount - 1
kT(i) = 1
NC(i) = NK.List(i)
Next i
PrgFrm.Caption = "Progress"
For i = 1 To Len(TextT$)
DoEvents
If DoCancel = True Then
Exit Function
End If
c = Asc(Mid$(TextT$, i, 1))
  For e = 0 To TK.ListCount - 1
  c = c - Asc(Mid$(TK.List(e), kT(e), 1))
    If c < 1 Then
    c = c + 255
    End If
  kT(e) = kT(e) + 1
    If kT(e) > Len(TK.List(e)) Then
    kT(e) = 1
    End If
  Graph2 TK.ListCount + NK.ListCount + 1, e + 1
  Next e
  c = c - Val(NC(kN))
    If c < 1 Then
    c = c + 255
    End If
  kN = kN + 1
    If kN > NK.ListCount - 1 Then
    kN = 0
    End If
  Graph2 TK.ListCount + NK.ListCount + 1, TK.ListCount
  c = c - Val(SK.List(kS))
    If c < 1 Then
    c = c + 255
    End If
  kS = kS + 1
    If kS > SK.ListCount - 1 Then
    kS = 0
    End If
  Graph2 TK.ListCount + NK.ListCount + 1, TK.ListCount + 1
  If Not i = 1 Then
  c = c - Asc(Mid$(TextT$, i - 1, 1))
  End If
    Do While c < 1
    c = c + 255
    Loop
      For e = 0 To NK.ListCount - 1
        For e2 = 0 To SK.ListCount - 1
        NC(e) = NC(e) + Val(SK.List(e2))
          If NC(e) > 255 Then
          NC(e) = NC(e) - 255
          End If
        Next e2
        If DoCancel = True Then
        Exit Function
        End If
      Graph2 TK.ListCount + NK.ListCount + 1, TK.ListCount + e + 2
      Next e
    endstr$ = endstr$ & Chr$(c)
Graph1 Len(TextT$), i
If DoCancel = True Then
Exit Function
End If
Next i
Decrypt = endstr$
End Function
