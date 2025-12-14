Attribute VB_Name = "ModWebAdmin"
Option Explicit

' Const number of item in each page
Public Const CutOffNum = 10
Public intShopID As Integer
Public intCategoryID As Integer

' ---- Varable for update category ----
Public strCategoryList As String
Public strF1 As String, strF2 As String, strF3 As String, strF4 As String
Public strF5 As String, strF6 As String, strF7 As String, strF8 As String
Public strF9 As String, strF10 As String, strF11 As String, strF12 As String
Public strF13 As String, strF14 As String, strF15 As String, strF16 As String
Public strF17 As String, strF18 As String, strF19 As String, strF20 As String

' --- Varable for Show result -----
Public strTitle As String
Public strContent As String


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

Public Function CheckCanUpdate(Expression) As String
    If IsNull(Expression) Or Expression = "" Then
       CheckCanUpdate = "Not update"
    Else
       CheckCanUpdate = Expression
    End If
    
End Function

Public Sub UpdateCategoryPageStart()
' --- Input
' intShopID
' --- Output
' strCategorylist, strF1 - strF20

Dim ObjFind As Object
Dim rs As Recordset

   
   Set ObjFind = CreateObject("Findcomponent.find")
 ' Find categoryType
   Set rs = ObjFind.FindCategory(intShopID)
       
   strCategoryList = ""     ' Initial varable
   
   Do Until rs.EOF
      strCategoryList = strCategoryList & "<option value=""" & rs!CategoryID & """>" & _
                        rs!CategoryType
      rs.MoveNext
   Loop
   
   strF1 = ""
   strF2 = ""
   strF3 = ""
   strF4 = ""
   strF5 = ""
   strF6 = ""
   strF7 = ""
   strF8 = ""
   strF9 = ""
   strF10 = ""
   strF11 = ""
   strF12 = ""
   strF13 = ""
   strF14 = ""
   strF15 = ""
   strF16 = ""
   strF17 = ""
   strF18 = ""
   strF19 = ""
   strF20 = ""

End Sub


Public Sub DeleteCategoryPageStart()
' --- Input
' intShopID
' --- Output
' strCategoryList


Dim ObjFind As Object
Dim rs As Recordset

   
   Set ObjFind = CreateObject("Findcomponent.find")
 ' Find categoryType
   Set rs = ObjFind.FindCategory(intShopID)
       
   strCategoryList = ""     ' Initial varable
   
   Do Until rs.EOF
      strCategoryList = strCategoryList & "<option value=""" & rs!CategoryID & """>" & _
                        rs!CategoryType
      rs.MoveNext
   Loop

End Sub

Public Function GenHeaderItem(ByVal CategoryType As String, ByVal ShopID As Integer, _
                              ByVal CategoryID As Integer) As String
    GenHeaderItem = "<table width=100% border=0 cellspacing=0 cellpadding=0 bgcolor=#CCCCCC>" & _
                    "<tr><td valign=top><img src=""./Pic/HomeGreyTL.gif"" width=10 height=10 border=0><br></td>" & _
                        "<td width=100% rowspan=2><font face=""MS Sans Serif"" size=2 color=#000099><a href=""/ecom/shop/ItemList.asp?ShopID=" & ShopID & _
                            "&CategoryID=" & CategoryID & """><b>" & _
                            CategoryType & "</b></a></font></td>" & _
                        "<td valign=top align=right><img src=""./Pic/HomeGreyTR.gif"" width=10 height=10 border=0><br></td>" & _
                    "</tr>" & _
                    "<tr><td valign=bottom ><img src=""./Pic/HomeGreyBL.gif"" width=10 height=10 border=0><br></td>" & _
                        "<td valign=bottom align=right><img src=""./Pic/HomeGreyBR.gif"" width=10 height=10 border=0><br></td>" & _
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
                "<td valign=middle>" & _
                   "<A href=""https://161.246.6.152/Ecom/ShoppingBag/sb.asp?accountid=" & AccountID & "&itemid=" & ItemID & "&price=" & Price & "&discount=" & Discount & """>" & _
                   "<Img src=""/ecom/pic/shopping-cart.gif"" border=0></a></td></tr>" & _
                "<tr><td valign=top width=74>&nbsp;</td><td valign=top>&nbsp;</td></tr></table>"

End Function

