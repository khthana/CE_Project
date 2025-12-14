Attribute VB_Name = "ModWebShop"
Option Explicit

' Const number of item in each page
Public Const CutOffNum = 10


Public Function GenHeaderItem(ByVal CategoryType As String, ByVal ShopID As Integer, _
                              ByVal CategoryID As Integer) As String
    GenHeaderItem = "<table width=100% border=0 cellspacing=0 cellpadding=0 bgcolor=#CCCCCC>" & _
                    "<tr><td valign=top><img src=""/ecom/Pic/HomeGreyTL.gif"" width=10 height=10 border=0><br></td>" & _
                        "<td width=100% rowspan=2><font face=""MS Sans Serif"" size=2 color=#000099><a href=""/ecom/shop/ItemList.asp?ShopID=" & ShopID & _
                            "&CategoryID=" & CategoryID & """><b>" & _
                            CategoryType & "</b></a></font></td>" & _
                        "<td valign=top align=right><img src=""/ecom/Pic/HomeGreyTR.gif"" width=10 height=10 border=0><br></td>" & _
                    "</tr>" & _
                    "<tr><td valign=bottom ><img src=""/ecom/Pic/HomeGreyBL.gif"" width=10 height=10 border=0><br></td>" & _
                        "<td valign=bottom align=right><img src=""/ecom/Pic/HomeGreyBR.gif"" width=10 height=10 border=0><br></td>" & _
                    "</tr></table>"

End Function


Public Function GenBodyItem(ByVal ItemName As String, ByVal Description As String, _
                            ByVal ItemID As Integer, ByVal CategoryID As Integer, ByVal ShopID As Integer, _
                            ByVal Price As Single, ByVal Discount As Single, ByVal ImgSrc As String, _
                            ByVal AccountID As Integer) As String
  GenBodyItem = "<table border=0 cellspacing=0 cellpadding=2>" & _
                "<tr><td height=2></td></tr>" & _
                "<tr><td valign=top width=74><a href=""/ecom/ItemDetail/ItemDetail.asp?ItemID=" & _
                ItemID & "&CategoryID=" & CategoryID & "&ShopID=" & ShopID & """><img src=""" & ImgSrc & """ border=0 width=80 height=100></a><br>" & _
                "<center><font face=""MS Sans Serif"" size=""1"" color=""#000099"">Discount&nbsp;" & Discount & "&nbsp;%&nbsp;</font><br>" & _
                "</center></td>" & _
                "<td valign=top><b><font face=""MS Sans Serif"">" & ItemName & "</font></b><br>" & _
                "<font size=""1"" face=""MS Sans Serif""><i>" & ItemName & "</i>&nbsp;&nbsp;&nbsp;" & Description & "</font><br>" & _
                "<font size=""1"" color=""#CC0000"" face=""MS Sans Serif""><b>Only&nbsp;</b></font><font size=""3"" color=""#CC0000"" face=""MS Sans Serif""><b>" & _
                Price & "</b></font><br></td>" & _
                "<td valign=middle align=""center"">" & _
                   "<A href=""https://161.246.6.152/Ecom/ShoppingBag/sb.asp?accountid=" & AccountID & "&itemid=" & ItemID & "&price=" & Price & "&discount=" & Discount & """>" & _
                   "<Img src=""/ecom/pic/shopping-cart.gif"" border=0></a></td></tr>" & _
                "<tr><td valign=top width=74>&nbsp;</td><td valign=top>&nbsp;</td></tr></table>"

End Function


Public Function CCInt(Expression) As Integer
On Error GoTo CCIntError:
    CCInt = CInt(Expression)
Exit Function
CCIntError:
' -- IF Error occur this function return 0
    CCInt = 0
End Function

Public Function NullToEmpty(Expression) As String
    If IsNull(Expression) Then
       NullToEmpty = ""
    Else
       NullToEmpty = Expression
    End If
    
End Function

Public Function CreateRecordset(ByVal rs As Recordset) As Recordset
Dim tmpRs As Recordset

    Set tmpRs = New Recordset

        tmpRs.Fields.Append "ItemID", adInteger
        tmpRs.Fields.Append "ShopID", adInteger
        tmpRs.Fields.Append "CategoryID", adInteger
        tmpRs.Fields.Append "ItemName", adVarChar, 50
        tmpRs.Fields.Append "Price", adSingle
        tmpRs.Fields.Append "Discount", adSingle
        tmpRs.Fields.Append "CreateOn", adDate
        tmpRs.Fields.Append "Description", adVarChar, 1000
        tmpRs.Fields.Append "F1", adSingle
        tmpRs.Fields.Append "F2", adSingle
        tmpRs.Fields.Append "F3", adSingle
        tmpRs.Fields.Append "F4", adSingle
        tmpRs.Fields.Append "F5", adSingle
        tmpRs.Fields.Append "F6", adSingle
        tmpRs.Fields.Append "F7", adSingle
        tmpRs.Fields.Append "F8", adSingle
        tmpRs.Fields.Append "F9", adSingle
        tmpRs.Fields.Append "F10", adSingle
        tmpRs.Fields.Append "F11", adSingle
        tmpRs.Fields.Append "F12", adSingle
        tmpRs.Fields.Append "F13", adSingle
        tmpRs.Fields.Append "F14", adSingle
        tmpRs.Fields.Append "F15", adSingle
        tmpRs.Fields.Append "F16", adSingle
        tmpRs.Fields.Append "F17", adSingle
        tmpRs.Fields.Append "F18", adSingle
        tmpRs.Fields.Append "F19", adSingle
        tmpRs.Fields.Append "F20", adSingle
        tmpRs.Open

 If Not rs.BOF Then rs.MoveFirst
 
Do Until rs.EOF

tmpRs.AddNew
 If IsNumeric(rs!f1) Then tmpRs!f1 = CLng(rs!f1)
 If IsNumeric(rs!f2) Then tmpRs!f2 = CLng(rs!f2)
 If IsNumeric(rs!f3) Then tmpRs!f3 = CLng(rs!f3)
 If IsNumeric(rs!f4) Then tmpRs!f4 = CLng(rs!f4)
 If IsNumeric(rs!f5) Then tmpRs!f5 = CLng(rs!f5)
 If IsNumeric(rs!f6) Then tmpRs!f6 = CLng(rs!f6)
 If IsNumeric(rs!f7) Then tmpRs!f7 = CLng(rs!f7)
 If IsNumeric(rs!f8) Then tmpRs!f8 = CLng(rs!f8)
 If IsNumeric(rs!f9) Then tmpRs!f9 = CLng(rs!f9)
 If IsNumeric(rs!f10) Then tmpRs!f10 = CLng(rs!f10)
 If IsNumeric(rs!f11) Then tmpRs!f11 = CLng(rs!f11)
 If IsNumeric(rs!f12) Then tmpRs!f12 = CLng(rs!f12)
 If IsNumeric(rs!f13) Then tmpRs!f13 = CLng(rs!f13)
 If IsNumeric(rs!f14) Then tmpRs!f14 = CLng(rs!f14)
 If IsNumeric(rs!f15) Then tmpRs!f15 = CLng(rs!f15)
 If IsNumeric(rs!f16) Then tmpRs!f16 = CLng(rs!f16)
 If IsNumeric(rs!f17) Then tmpRs!f17 = CLng(rs!f17)
 If IsNumeric(rs!f18) Then tmpRs!f18 = CLng(rs!f18)
 If IsNumeric(rs!f19) Then tmpRs!f19 = CLng(rs!f19)
 If IsNumeric(rs!f20) Then tmpRs!f20 = CLng(rs!f20)

    tmpRs!ItemID = rs!ItemID
    tmpRs!ShopID = rs!ShopID
    tmpRs!CategoryID = rs!CategoryID
    tmpRs!ItemName = Trim(rs!ItemName)
    tmpRs!Price = rs!Price
    tmpRs!Discount = rs!Discount
    tmpRs!createon = Trim(rs!createon)
    tmpRs!Description = Trim(rs!Description)

    rs.MoveNext
Loop



Set CreateRecordset = tmpRs

End Function


