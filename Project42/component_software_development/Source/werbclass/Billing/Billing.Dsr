VERSION 5.00
Begin {17016CEE-E118-11D0-94B8-00A0C91110ED} Billing 
   ClientHeight    =   5445
   ClientLeft      =   750
   ClientTop       =   1425
   ClientWidth     =   7320
   _ExtentX        =   12912
   _ExtentY        =   9604
   MajorVersion    =   0
   MinorVersion    =   8
   StateManagementType=   1
   ASPFileName     =   ""
   DIID_WebClass   =   "{12CBA1F6-9056-11D1-8544-00A024A55AB0}"
   DIID_WebClassEvents=   "{12CBA1F5-9056-11D1-8544-00A024A55AB0}"
   TypeInfoCookie  =   76
   BeginProperty WebItems {193556CD-4486-11D1-9C70-00C04FB987DF} 
      WebItemCount    =   3
      BeginProperty WebItem1 {FA6A55FE-458A-11D1-9C71-00C04FB987DF} 
         MajorVersion    =   0
         MinorVersion    =   8
         Name            =   "CheckOutDetail"
         DISPID          =   1280
         Template        =   "CheckOutDetail.htm"
         Token           =   "WC@"
         DIID_WebItemEvents=   "{644FA8FF-D64C-11D3-B41A-34CE6C000000}"
         ParseReplacements=   0   'False
         AppendedParams  =   ""
         HasTempTemplate =   0   'False
         UsesRelativePath=   -1  'True
         OriginalTemplate=   "E:\PROJECT\EComm\Template\CheckOutDetail.htm"
         TagPrefixInfo   =   2
         BeginProperty Events {193556D1-4486-11D1-9C70-00C04FB987DF} 
            EventCount      =   1
            BeginProperty Event0 {193556D3-4486-11D1-9C70-00C04FB987DF} 
               Name            =   "formInvoiceDetail"
               DISPID          =   1280
               Type            =   1
               OriginalHREF    =   ""
               TagType         =   0
               BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
                  AttribCount     =   1
                  BeginProperty Attrib0 {FA6A55FC-458A-11D1-9C71-00C04FB987DF} 
                     TagType         =   1
                     Attribute       =   "ACTION"
                     State           =   3
                     TagName         =   "formInvoiceDetail"
                     OriginalURL     =   "Billing.ASP"
                     Parent          =   ""
                     Template        =   "CheckOutDetail"
                     BoundEvent      =   "formInvoiceDetail"
                     BoundItem       =   ""
                     Suffix          =   ""
                     UsesAnonymousName=   0
                     TagNumber       =   0
                  EndProperty
               EndProperty
            EndProperty
         EndProperty
         BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
            AttribCount     =   0
         EndProperty
      EndProperty
      BeginProperty WebItem2 {FA6A55FE-458A-11D1-9C71-00C04FB987DF} 
         MajorVersion    =   0
         MinorVersion    =   8
         Name            =   "CheckOutProcess"
         DISPID          =   1281
         Template        =   "CheckOutProcess.htm"
         Token           =   "WC@"
         DIID_WebItemEvents=   "{8482A05C-D650-11D3-B41A-34CE6C000000}"
         ParseReplacements=   0   'False
         AppendedParams  =   ""
         HasTempTemplate =   0   'False
         UsesRelativePath=   -1  'True
         OriginalTemplate=   "E:\PROJECT\EComm\Template\CheckOutProcess.htm"
         TagPrefixInfo   =   2
         BeginProperty Events {193556D1-4486-11D1-9C70-00C04FB987DF} 
            EventCount      =   1
            BeginProperty Event0 {193556D3-4486-11D1-9C70-00C04FB987DF} 
               Name            =   "formAddBilling"
               DISPID          =   1280
               Type            =   1
               OriginalHREF    =   ""
               TagType         =   7536755
               BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
                  AttribCount     =   1
                  BeginProperty Attrib0 {FA6A55FC-458A-11D1-9C71-00C04FB987DF} 
                     TagType         =   1
                     Attribute       =   "ACTION"
                     State           =   3
                     TagName         =   "formAddBilling"
                     OriginalURL     =   "Billing.ASP"
                     Parent          =   ""
                     Template        =   "CheckOutProcess"
                     BoundEvent      =   "formAddBilling"
                     BoundItem       =   ""
                     Suffix          =   ""
                     UsesAnonymousName=   0
                     TagNumber       =   0
                  EndProperty
               EndProperty
            EndProperty
         EndProperty
         BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
            AttribCount     =   0
         EndProperty
      EndProperty
      BeginProperty WebItem3 {FA6A55FE-458A-11D1-9C71-00C04FB987DF} 
         MajorVersion    =   0
         MinorVersion    =   8
         Name            =   "ResultCheckOut"
         DISPID          =   1282
         Template        =   "ShowResultCheckOut.htm"
         Token           =   "WC@"
         DIID_WebItemEvents=   "{8845184D-D65A-11D3-B41A-34CE6C000000}"
         ParseReplacements=   0   'False
         AppendedParams  =   ""
         HasTempTemplate =   0   'False
         UsesRelativePath=   -1  'True
         OriginalTemplate=   "E:\PROJECT\EComm\Template\ShowResultCheckOut.htm"
         TagPrefixInfo   =   2
         BeginProperty Events {193556D1-4486-11D1-9C70-00C04FB987DF} 
            EventCount      =   0
         EndProperty
         BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
            AttribCount     =   0
         EndProperty
      EndProperty
   EndProperty
   NameInURL       =   "Billing"
End
Attribute VB_Name = "Billing"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Option Compare Text

' session("AccountID")
' Session("ShoppingBag") pass data from shoppingbag page
' Session("RsBilling") hold billing data
' Session("RsBillingDetail") hold billingDetail data
' session("CusBillingContent") keep billing information for
'                              mail to customer
' Session("GrandTotal") keep total money for pay
' Session("TotalTax")


Private intAccountID As Integer
' -- For result check out
Private strTitle As String
Private strContent As String

' -- For CheckOutDetail
Private strBillingName As String
Private strBillingAddress As String
Private strTel As String
Private strFax As String
Private strEmail As String
Private strShipTo As String
Private strItemList As String
Private strTotal As String
Private strTax As String
Private strFrieght As String
Private strGrandTotal As String

' -- For mail to customer
Private CusName As String, CusEmail As String, CusBillingContent As String



Private Sub MailToCus(ByVal CusName As String, _
                      ByVal CusEmail As String, _
                      ByVal CusBillingContent As String)
Dim ObjMail As MailSender

Set ObjMail = New MailSender

ObjMail.Host = "chaokhun"
ObjMail.Port = 25 ' Optional. Port is 25 by default

ObjMail.From = "Shop2000@hotmail.com"
ObjMail.FromName = "Shop 2000" ' Optional

ObjMail.AddAddress CusEmail, CusName

ObjMail.Subject = "Confirm your billing from shop 2000"
ObjMail.Body = CusBillingContent

ObjMail.IsHTML = True

On Error Resume Next
ObjMail.Send
If Err <> 0 Then
    strTitle = "<font color=""#FF0000""><h3>Mail confirm error</h3></font>"
    strContent = "An error occurred: " & Err.Description
    ResultCheckOut.WriteTemplate
End If


End Sub


Private Sub CheckOutDetail_formInvoiceDetail()
Dim ObjBilling As Object, ObjPager As Object
Dim RsBilling As Recordset, RsBillingDetail As Recordset
Dim intAccountID As Integer, intBillingID As Integer
Dim CusName As String, CusEmail As String, CusBillingContent As String
Dim ObjCreditCard As Object
Dim StrPager As String


Set RsBilling = Session("RsBilling")
intAccountID = CCInt(Session("AccountID"))

' ---- Check ValidCreditCard --

If Trim(Request.Form("paytype")) = "CreditCard" Then
Set ObjCreditCard = CreateObject("BankingCOM.Banking")

With ObjCreditCard
    .CreditcardNumber = Trim(Request.Form("txtCardNum"))
    .BankName = LCase(Trim(Request.Form("RdoCreditCard")))
    .Money = Session("GrandTotal")
    
    If Not .CheckValid Then
        strContent = "Invalid Creditcard number <BR>" & _
                     "Creditcard number : " & Trim(Request.Form("txtCardNum")) & "<br>" & _
                     "Bank name : " & LCase(Trim(Request.Form("RdoCreditCard"))) & "<br>" & _
                     "Money : " & Session("GrandTotal")
        ResultCheckOut.WriteTemplate
        Exit Sub
    End If
End With

    Set ObjCreditCard = Nothing
End If
' -------------------------
On Error GoTo AddBillingDetailError

    strTitle = "<font color=""#FF0000"">Error while add billing</font>"
Set ObjBilling = CreateObject("Ecomm.Billing")
' ---- Add billing -----
    With ObjBilling
    .accountid = intAccountID
' -- About Billing
    .billingdate = Trim(RsBilling!billingdate)
    .reqdate = Trim(RsBilling!reqdate)
    .BillingName = Trim(RsBilling!BillingName)
    .BillingSurname = Trim(RsBilling!BillingSurname)
    .BillingAddress = Trim(RsBilling!BillingAddress)
    .BillingCity = Trim(RsBilling!BillingCity)
    .BillingState = Trim(RsBilling!BillingState)
    .BillingPostcode = Trim(RsBilling!BillingPostcode)
    .BillingCountry = Trim(RsBilling!BillingCountry)

' -- About Ship
    .ShipName = Trim(RsBilling!ShipName)
'    .ShipDate
    .ShipAddress = Trim(RsBilling!ShipAddress)
    .ShipVia = Trim(RsBilling!ShipVia)
    .frieght = Trim(RsBilling!frieght)
    .ShipCity = Trim(RsBilling!ShipCity)
    .ShipRegion = Trim(RsBilling!ShipRegion)
    .ShipPostcode = Trim(RsBilling!ShipPostcode)
    .ShipCountry = Trim(RsBilling!ShipCountry)
'    .Status
    .TotalTax = Session("TotalTax")
    .TotalPrice = Session("GrandTotal")
    
' --- About contact information
    .BillingTel = Trim(RsBilling!BillingTel)
    .billingemail = Trim(RsBilling!billingemail)
    .billingfax = Trim(RsBilling!billingfax)
    .pagernumber = Trim(RsBilling!pagernumber)
    .pagerpassword = Trim(RsBilling!pagerpassword)
    .pagerType = Trim(RsBilling!pagerType)
    
' ---- About Payment ---
    .PayType = Trim(Request.Form("paytype"))
 ' ----------------------------------
 
    intBillingID = .addbilling
    End With

' ------ Add billing detail -----
Set RsBillingDetail = Session("RsBillingDetail")

    strTitle = "<font color=""#FF0000"">Error while add billing detial</font>"
    
    If Not RsBillingDetail.BOF Then RsBillingDetail.MoveFirst
    With ObjBilling.billingdetail
    
    Do Until RsBillingDetail.EOF
       .billingid = intBillingID
       .itemid = Trim(RsBillingDetail!itemid)
'       .Status = RsBillingDetail!Status
       .amount = Trim(RsBillingDetail!amount)
       .discount = Trim(RsBillingDetail!discount)
       .taxvalue = Trim(RsBillingDetail!taxvalue)
       .price = Trim(RsBillingDetail!price)
       
       .addbillingdetail
       
       
       RsBillingDetail.MoveNext
    Loop
    
    End With
    
' ----- Send Email to customer
    CusName = Trim(RsBilling!BillingName) & " " & Trim(RsBilling!BillingSurname)
    CusEmail = Trim(RsBilling!billingemail)
    CusBillingContent = Session("CusBillingContent")
'    Response.Write CusBillingContent  'DEBUG
On Error Resume Next
    MailToCus CusName, CusEmail, CusBillingContent
'    If Err <> 0 Then
'       Exit Sub
'    End If
    
' ---- Send Pager -----
    Set ObjPager = CreateObject("PagerCom.Pager")
    
    ObjPager.Message = "Your billing process in shop2000 complete " & _
                       "you can see detail at your email : " & Trim(RsBilling!billingemail)
    ObjPager.pagerType = Trim(RsBilling!pagerType)
    ObjPager.pagernumber = Trim(RsBilling!pagernumber)
    ObjPager.pagerpassword = Trim(RsBilling!pagerpassword)
    ObjPager.Username = Trim(RsBilling!Username)
    ObjPager.Password = Trim(RsBilling!Password)
    
    StrPager = ObjPager.Send

    
' ------ Prepare for write result
    Session("ShoppingBag") = 0
    strTitle = "Check out process complete"
    strContent = "<font face=""MS Sans Serif"" color=""#000099"">Thank you</font><br>" & StrPager
    
    ResultCheckOut.WriteTemplate
    
Exit Sub
AddBillingDetailError:
' ---- Handler simple transaction rollback addBilling
    If intBillingID > 0 Then
  ' --- Add Billing complete --
    Set ObjBilling = CreateObject("Ecomm.Billing")
    ObjBilling.deletebilling "BillingID = " & CStr(intBillingID)
    End If

    strContent = Err.Description
    ResultCheckOut.WriteTemplate

End Sub

Private Sub CheckOutDetail_ProcessTag(ByVal TagName As String, TagContents As String, SendTags As Boolean)
    TagContents = Replace(TagContents, vbCrLf, "")
    TagContents = Replace(TagContents, " ", "")
    
    Select Case TagContents
     Case "strBillingName"
       TagContents = strBillingName
     Case "strBillingAddress"
       TagContents = strBillingAddress
     Case "strTel"
       TagContents = strTel
     Case "strFax"
       TagContents = strFax
     Case "strEmail"
       TagContents = strEmail
     Case "strShipTo"
       TagContents = strShipTo
     Case "strItemList"
       TagContents = strItemList
     Case "strTotal"
       TagContents = strTotal
     Case "strTax"
       TagContents = strTax
     Case "strFrieght"
       TagContents = strFrieght
     Case "strGrandTotal"
       TagContents = strGrandTotal
       
     End Select
    
    
End Sub

Private Sub CheckOutProcess_formAddBilling()
Dim ObjShipment As Object
Dim ObjItem As Object
Dim strSetItemID As String
Dim rsItem As Recordset
Dim RsBilling As Recordset, RsBillingDetail As Recordset
Dim intNo As Integer
Dim tmpPrice As Single, tmpTax As Single
Dim strBillingTo As String
Dim strSumary As String


  intAccountID = Session("AccountID")

On Error GoTo AddBillingError
  Set ObjShipment = CreateObject("Ship.Shipment")
  ObjShipment.retrieve
      
Set RsBilling = Session("RsBilling")
RsBilling.AddNew
    RsBilling!accountid = intAccountID
' -- About Billing
    RsBilling!billingdate = Date
    RsBilling!reqdate = CDate(Date + ObjShipment.ShipPeriod)
    RsBilling!BillingName = Trim(Request.Form("txtBillingName"))
    RsBilling!BillingSurname = Trim(Request.Form("txtBillingSurname"))
    RsBilling!BillingAddress = Trim(Request.Form("txtBillingAddress"))
    RsBilling!BillingCity = Trim(Request.Form("txtBillingCity"))
    RsBilling!BillingState = Trim(Request.Form("txtBillingState"))
    RsBilling!BillingPostcode = Trim(Request.Form("txtBillingPostcode"))
    RsBilling!BillingCountry = Trim(Request.Form("txtBillingCountry"))

' -- About Ship
    RsBilling!ShipName = Trim(Request.Form("txtShipName"))
'    .ShipDate = Fill when receive money form customer
    RsBilling!ShipAddress = Trim(Request.Form("txtshipaddress"))
    RsBilling!ShipVia = Trim(ObjShipment.ShipVia)
    RsBilling!frieght = Trim(ObjShipment.frieght)
    RsBilling!ShipCity = Trim(Request.Form("txtShipCity"))
    RsBilling!ShipRegion = Trim(Request.Form("txtShipRegion"))
    RsBilling!ShipPostcode = Trim(Request.Form("txtShipPostcode"))
    RsBilling!ShipCountry = Trim(Request.Form("txtShipCountry"))
'    .Status = TxtStatus.Text
'    .TotalTax = Calculate from Billing.CalTotalTax
'    .TotalPrice = Calculate from Billing.CalTotalPrice
    
' --- About contact information
    RsBilling!BillingTel = Trim(Request.Form("txtPhone"))
    RsBilling!billingemail = Trim(Request.Form("txtEmail"))
    RsBilling!billingfax = Trim(Request.Form("txtFax"))
    RsBilling!pagernumber = Trim(Request.Form("txtPagerNumber"))
    RsBilling!pagerpassword = Trim(Request.Form("txtPagerPassword"))
    RsBilling!pagerType = Trim(Request.Form("Service"))
    RsBilling!Username = Trim(Request.Form("txtUsername"))
    RsBilling!Password = Trim(Request.Form("txtPassword"))
    
 Set Session("RsBilling") = RsBilling

' ------ Write result Billing to and Ship to-----

    strBillingName = Request.Form("txtBillingName") & _
                     " " & Request.Form("txtBillingSurname")
    strBillingAddress = Request.Form("txtBillingAddress")
    strTel = Request.Form("txtPhone")
    strFax = Request.Form("txtFax")
    strEmail = Request.Form("txtEmail")
    strShipTo = Request.Form("txtShipName") & _
                " " & Request.Form("txtShipAddress") & _
                " " & Request.Form("txtShipRegion") & _
                " " & Request.Form("txtShipCity") & _
                " " & Request.Form("txtShipCountry") & _
                " " & Request.Form("txtShipPostcode")
                
' ------ Write result selected item -------
 Set RsBillingDetail = Session("RsBillingDetail")

   RsBillingDetail.MoveFirst
 Do
   strSetItemID = RsBillingDetail!itemid & "," & strSetItemID
   RsBillingDetail.MoveNext
 Loop Until RsBillingDetail.EOF
 
 strSetItemID = Left(strSetItemID, Len(strSetItemID) - 1)
  
Set ObjItem = CreateObject("Ecomm.item")
 
strSetItemID = "Select ItemID, ItemName, status " & _
               "From Vitem " & _
               "Where ItemID in (" & strSetItemID & ")"
 Set rsItem = ObjItem.Find(strSetItemID)
 
   RsBillingDetail.MoveFirst
   intNo = 1
 Do
    rsItem.Find "ItemID=" & RsBillingDetail!itemid

' -- Sum price
    tmpPrice = tmpPrice + RsBillingDetail!price
' -- Sum Tax
    tmpTax = tmpTax + RsBillingDetail!taxvalue

' -- Print item list
    strItemList = strItemList & _
                  "<tr><td width=""5%""><div align=""center"">" & _
                                intNo & "</div></td>" & _
                  "<td width=""37%"">" & rsItem!ItemName & "</td>" & _
                  "<td width=""6%""><div align=""center"">" & _
                                RsBillingDetail!amount & "</div></td>" & _
                  "<td width=""14%""><div align=""center"">" & _
                                RsBillingDetail!price & "</div></td>" & _
                  "<td width=""38%"">" & rsItem!Status & "</td></tr>" & vbCrLf
    
    CusBillingContent = CusBillingContent & _
                        intNo & " | Item name : " & rsItem!ItemName & " | Amount : " & _
                        RsBillingDetail!amount & " | Price : " & _
                                RsBillingDetail!price & "</div></td>" & _
                  "<td width=""38%"">" & rsItem!Status & "</td></tr>"

    
    RsBillingDetail.MoveNext
    intNo = intNo + 1
 Loop Until RsBillingDetail.EOF

' ----------- Calculate price ----------------
    strTotal = tmpPrice
    strTax = tmpTax
    strFrieght = ObjShipment.frieght
    strGrandTotal = tmpPrice + CSng(strFrieght)
    Session("GrandTotal") = CSng(strGrandTotal)
    Session("TotalTax") = CSng(strTax)

' -- Add billing information to session("CusBillingContent")

    strBillingTo = strBillingName & ", Address : " & strBillingAddress & ", Tel : " & _
                   strTel & ", Fax : " & strFax
    strSumary = "<p>Total : " & strTotal & "</p>" & _
                "<p>Tax : " & strTax & "</p>" & _
                "<p>Frieght : " & strFrieght & "</p>" & _
                "<p>Grand Total : " & strGrandTotal & "</p>" & _
                "<p>Create by Shop 2000, " & Date & "</p>"
    Session("CusBillingContent") = GenMailContent(strBillingTo, strShipTo, strItemList, strSumary)

' --------------------

    CheckOutDetail.WriteTemplate
Exit Sub
AddBillingError:
    strTitle = "<font color=""#FF0000"">Error while add billing</font>"
    strContent = Err.Description
    ResultCheckOut.WriteTemplate

End Sub

Private Sub ResultCheckOut_ProcessTag(ByVal TagName As String, TagContents As String, SendTags As Boolean)
    TagContents = Replace(TagContents, vbCrLf, "")
    TagContents = Replace(TagContents, " ", "")
    
    Select Case TagContents
      Case "strTitle"
        TagContents = strTitle
      Case "strContent"
        TagContents = strContent
    End Select
    
End Sub

Private Sub WebClass_Start()
Dim rsBag As Recordset
Dim RsBilling As Recordset, RsBillingDetail As Recordset

' -- Create recordset to hold billing and billingDetail data
   Set RsBilling = New Recordset
   
   With RsBilling.Fields
    .Append "BillingID", adInteger
    .Append "Accountid", adInteger
    .Append "billingdate", adDate
    .Append "reqdate", adDate
    .Append "PayType", adChar, 20
    .Append "ShipName", adChar, 30
    .Append "shipdate", adChar, 30
    .Append "ShipAddress", adChar, 30
    .Append "ShipVia", adChar, 20
    .Append "frieght", adSingle
    .Append "ShipCity", adChar, 30
    .Append "ShipRegion", adChar, 30
    .Append "ShipPostcode", adChar, 20
    .Append "ShipCountry", adChar, 30
    .Append "Status", adChar, 30
    .Append "TotalTax", adSingle
    .Append "TotalPrice", adSingle
    .Append "BillingAddress", adChar, 30
    .Append "BillingName", adChar, 30
    .Append "BillingSurname", adChar, 30
    .Append "BillingCity", adChar, 30
    .Append "BillingState", adChar, 30
    .Append "BillingPostcode", adChar, 20
    .Append "BillingCountry", adChar, 30
    .Append "BillingTel", adChar, 30
    .Append "BillingEmail", adChar, 30
    .Append "billingfax", adChar, 30
    .Append "PagerNumber", adChar, 10
    .Append "PagerPassword", adChar, 20
    .Append "PagerType", adChar, 10
    .Append "Username", adChar, 20
    .Append "Password", adChar, 20
    
    
   End With
   RsBilling.Open

Set RsBillingDetail = New Recordset

   With RsBillingDetail.Fields
    .Append "BillingID", adInteger
    .Append "ItemID", adInteger
    .Append "Status", adChar, 30
    .Append "Discount", adSingle
    .Append "Amount", adInteger
    .Append "TaxValue", adSingle
    .Append "Price", adSingle
   End With
   RsBillingDetail.Open
   
' ---- Pack itemlist passed from shoppingbag
' --- DEBUG ---
'Set rsBag = New Recordset
'  rsBag.Fields.Append "ItemID", adInteger
'  rsBag.Fields.Append "AccountID", adInteger
'  rsBag.Fields.Append "Amount", adInteger
'  rsBag.Fields.Append "Discount", adSingle
'  rsBag.Fields.Append "TaxValue", adSingle
'  rsBag.Fields.Append "Price", adSingle
'  rsBag.Open
  
'  rsBag.AddNew
'    rsBag!itemid = 2
'    rsBag!accountid = 3
'    rsBag!amount = 3
'    rsBag!discount = 10
'    rsBag!taxvalue = 30
'    rsBag!price = 100

'  rsBag.AddNew
'    rsBag!itemid = 2
'    rsBag!accountid = 3
'    rsBag!amount = 3
'    rsBag!discount = 10
'    rsBag!taxvalue = 60
'    rsBag!price = 200
'-------------
 
'If IsEmpty(Session("ShoppingBag")) Then
'     strTitle = "Error"
'     strContent = "No Item in your shopping bag that " & _
                  "cause can not Billing process"
'     ResultCheckOut.WriteTemplate
'     Exit Sub
'End If
 
 
 Set rsBag = Session("ShoppingBag")

' --- Error if no item in shoppingBag
  If rsBag.BOF And rsBag.EOF Then
     strTitle = "Error"
     strContent = "No Item in your shopping bag that " & _
                  "cause can not Billing process"
     ResultCheckOut.WriteTemplate
     Exit Sub
  End If
  
' -- Copy rsBag to RsBillingDetail
  rsBag.MoveFirst
  Do
    RsBillingDetail.AddNew
'    rsbillingdetail!BillingID  skip until add billing complete
     RsBillingDetail!itemid = rsBag!itemid
     RsBillingDetail!amount = rsBag!amount
     RsBillingDetail!discount = (rsBag!discount * rsBag!amount)
     RsBillingDetail!taxvalue = (rsBag!price - rsBag!discount) * rsBag!amount * (rsBag!taxvalue / 100)
     RsBillingDetail!price = (rsBag!price - rsBag!discount) * rsBag!amount * (1 + (rsBag!taxvalue / 100))
  
     rsBag.MoveNext
  Loop Until rsBag.EOF
   

intAccountID = CCInt(Session("AccountID"))
If intAccountID = 0 Then
    rsBag.MoveFirst
    intAccountID = rsBag!accountid
    Session("AccountID") = intAccountID
End If

' Save recordset to session
Set Session("RsBilling") = RsBilling
Set Session("RsBillingDetail") = RsBillingDetail

    CheckOutProcess.WriteTemplate
End Sub

