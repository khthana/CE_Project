VERSION 5.00
Begin {17016CEE-E118-11D0-94B8-00A0C91110ED} ClsShowSearchResult 
   ClientHeight    =   4785
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6915
   _ExtentX        =   12197
   _ExtentY        =   8440
   MajorVersion    =   0
   MinorVersion    =   8
   StateManagementType=   1
   ASPFileName     =   ""
   DIID_WebClass   =   "{3C436BCE-CFA5-11D3-B410-B2E3D0000000}"
   DIID_WebClassEvents=   "{3C436BCD-CFA5-11D3-B410-B2E3D0000000}"
   TypeInfoCookie  =   15
   BeginProperty WebItems {193556CD-4486-11D1-9C70-00C04FB987DF} 
      WebItemCount    =   1
      BeginProperty WebItem1 {FA6A55FE-458A-11D1-9C71-00C04FB987DF} 
         MajorVersion    =   0
         MinorVersion    =   8
         Name            =   "SearchResult"
         DISPID          =   1280
         Template        =   "TemplateSearchResult1.htm"
         Token           =   "WC@"
         DIID_WebItemEvents=   "{3C436BDB-CFA5-11D3-B410-B2E3D0000000}"
         ParseReplacements=   0   'False
         AppendedParams  =   ""
         HasTempTemplate =   0   'False
         UsesRelativePath=   -1  'True
         OriginalTemplate=   "E:\PROJECT\EComm\WebClass\TemplateSearchResult.htm"
         TagPrefixInfo   =   2
         BeginProperty Events {193556D1-4486-11D1-9C70-00C04FB987DF} 
            EventCount      =   0
         EndProperty
         BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
            AttribCount     =   0
         EndProperty
      EndProperty
   EndProperty
   NameInURL       =   "SearchResult"
End
Attribute VB_Name = "ClsShowSearchResult"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit

Private strItemRow As String, strNextPage As String

Private Sub SearchResult_ProcessTag(ByVal TagName As String, TagContents As String, SendTags As Boolean)
  TagContents = Replace(TagContents, vbCrLf, "")
  TagContents = Replace(TagContents, " ", "")

  Select Case TagContents
   Case "strItemRow"
       TagContents = strItemRow
   Case "strNextPage"
       TagContents = strNextPage
  End Select

End Sub

Private Sub WebClass_Start()
' --- Input
'   Receive recordset packed in session("RsSearchResult")
' --- Operation
'   Print data of item (ItemID, ItemName, Price, CreateOn, Description)
' in tag <tr>[(<td>...</td>)*6]</tr>
' and cut off exceed item to next page

Dim rs As Recordset
Dim i As Integer, intTmp As Integer
Dim currentPage As Integer
Dim lngMoveRs As Long

Set rs = Session("RsSearchResult")
rs.Filter = Session("Filter")


 If Not rs.BOF Then rs.MoveFirst
currentPage = CCInt(Request.QueryString("NextPage"))

If currentPage = 0 Then currentPage = 1


lngMoveRs = CLng((currentPage - 1) * CutOffNum)
If lngMoveRs > 0 Then rs.Move lngMoveRs

' --- Write table of item ----
     Do Until rs.EOF Or rs.AbsolutePosition > (CutOffNum * currentPage)
    strItemRow = strItemRow & _
               "<tr><td bgcolor=""#ffffce"" width=""3%""><div align=""center""><font face=""MS Sans Serif"" size=""2"">" & CStr(rs.AbsolutePosition) & "</font></div></td>" & _
               "<td bgcolor=""#ffffce"" width=""25%"" valign=middle><div align=""center""><font face=""MS Sans Serif"" size=""2"">" & _
                    "<A href=""/ecom/itemdetail/ItemDetail.asp?ItemID=" & rs!ItemID & "&CategoryID=" & rs!CategoryID & "&ShopID=" & rs!ShopID & """>" & _
                    "<Img src=""http://161.246.6.152/asfroot/picture/" & rs!ItemID & ".tmp"" width=80 height=100 border=0 align=middle><br>" & rs!ItemName & "</a></font></div></td>" & _
               "<td bgcolor=""#ffffce"" width=""10%"">" & _
                    "<div align=""center""><font face=""MS Sans Serif"" size=""2"">&nbsp;&nbsp;" & rs!Price & "</font></div></td>" & _
               "<td bgcolor=""#ffffce"" width=""15%"">" & _
                    "<div align=""center""><font face=""MS Sans Serif"" size=""2"">" & rs!createon & "</font></div></td>" & _
               "<td bgcolor=""#ffffce"" width=""35%""><font face=""MS Sans Serif"" size=""2"">" & rs!Description & "</font></td>" & _
               "<td bgcolor=""#ffffce"" width=""9%"" align=""center"">" & _
                    "<A href=""https://161.246.6.152/Ecom/ShoppingBag/sb.asp?accountid=" & Session("AccountID") & "&itemid=" & rs!ItemID & "&price=" & rs!Price & "&discount=" & rs!Discount & """>" & _
                    "<Img src=""/ecom/pic/shopping-cart.gif"" border=0></a></td>" & _
               "</tr>"
  rs.MoveNext
 Loop

' ---- Write next page if available
    i = 1
    intTmp = rs.RecordCount
    Do Until intTmp <= 0
      intTmp = intTmp - CutOffNum
      If i = currentPage Then
        strNextPage = strNextPage & "| " & currentPage & " |"
      Else
        strNextPage = strNextPage & " | " & _
                      "<a href=""SearchResult.asp?NextPage=" & CStr(i) & """>" & _
                      CStr(i) & "</A> | "
      End If
      i = i + 1
    Loop

    SearchResult.WriteTemplate
End Sub
