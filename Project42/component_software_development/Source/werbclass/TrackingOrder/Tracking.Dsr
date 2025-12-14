VERSION 5.00
Begin {17016CEE-E118-11D0-94B8-00A0C91110ED} Tracking 
   ClientHeight    =   5595
   ClientLeft      =   750
   ClientTop       =   1425
   ClientWidth     =   7830
   _ExtentX        =   13811
   _ExtentY        =   9869
   MajorVersion    =   0
   MinorVersion    =   8
   StateManagementType=   1
   ASPFileName     =   "D:\cen\IIS\TrackingOrder\Tracking.ASP"
   DIID_WebClass   =   "{12CBA1F6-9056-11D1-8544-00A024A55AB0}"
   DIID_WebClassEvents=   "{12CBA1F5-9056-11D1-8544-00A024A55AB0}"
   TypeInfoCookie  =   48
   BeginProperty WebItems {193556CD-4486-11D1-9C70-00C04FB987DF} 
      WebItemCount    =   1
      BeginProperty WebItem1 {FA6A55FE-458A-11D1-9C71-00C04FB987DF} 
         MajorVersion    =   0
         MinorVersion    =   8
         Name            =   "Template1"
         DISPID          =   1280
         Template        =   "Tracking.htm"
         Token           =   "WC@"
         DIID_WebItemEvents=   "{06FE93BD-DD24-11D3-8403-00E02944B1CD}"
         ParseReplacements=   0   'False
         AppendedParams  =   ""
         HasTempTemplate =   0   'False
         UsesRelativePath=   -1  'True
         OriginalTemplate=   "D:\Project\EComm\Tracking\Tracking.html"
         TagPrefixInfo   =   2
         BeginProperty Events {193556D1-4486-11D1-9C70-00C04FB987DF} 
            EventCount      =   2
            BeginProperty Event0 {193556D3-4486-11D1-9C70-00C04FB987DF} 
               Name            =   "Form1"
               DISPID          =   1280
               Type            =   1
               OriginalHREF    =   ""
               TagType         =   6619241
               BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
                  AttribCount     =   0
               EndProperty
            EndProperty
            BeginProperty Event1 {193556D3-4486-11D1-9C70-00C04FB987DF} 
               Name            =   "Form2"
               DISPID          =   1281
               Type            =   1
               OriginalHREF    =   ""
               TagType         =   7536755
               BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
                  AttribCount     =   0
               EndProperty
            EndProperty
         EndProperty
         BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
            AttribCount     =   0
         EndProperty
      EndProperty
   EndProperty
   NameInURL       =   "Tracking"
End
Attribute VB_Name = "Tracking"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Option Compare Text

' Session("BillingList")  keep billing list

' -- For processtag
Private BillingList As String
Private strBilling As String
Private strBillingDetail As String
   

Private Sub Template1_Form1()
' --- List BillingID

    Dim strUsername As String
    Dim strPassword As String
    Dim ObjSecurity As Object
    Dim ObjBilling As Object
    Dim ObjBillingDetail As Object
    Dim strSQL As String
    Dim RsBilling As Recordset
    Dim BCheck As Boolean

    Dim intAccountID As Integer
    
    
    strUsername = Request.Form("textusername")
    strPassword = Request.Form("textpassword")
    
    '---Verify Account Name In Table account
      Set ObjSecurity = CreateObject("Frontecomm.Esecure")
        ObjSecurity.CusUserName = strUsername
        ObjSecurity.CusPassword = strPassword
        BCheck = ObjSecurity.Login 'check useraccount
      
    ' -- Pass Account ID back ---
      intAccountID = ObjSecurity.AccountID
      Set ObjSecurity = Nothing

' DEBUG
'        intAccountID = 1
'        BCheck = True
    '---------------------------------------
    
    '---Retrieve Billing data---------------
    If BCheck = True Then
        Set ObjBilling = CreateObject("ecomm.billing")
        
        Set RsBilling = New Recordset
        strSQL = "select * from vbilling where accountid ='" & CStr(intAccountID) & "'"
        Set RsBilling = ObjBilling.findbilling(strSQL)
        
        If Not (RsBilling.BOF And RsBilling.EOF) Then
            Do
               BillingList = BillingList & _
                             "<option value=""" & RsBilling!billingid & """>" & CStr(RsBilling!billingid)
               
               RsBilling.MoveNext
            Loop Until RsBilling.EOF
            
            Session("BillingList") = BillingList
        End If
        
        Template1.WriteTemplate
    Else
        Response.Write "<H3>Invalid user name, Try again!</H3><BR>" & _
                       "<A Href="""" OnClick=""history.back()"">Back</A>"
        
    End If
    
End Sub

Private Sub Template1_Form2()
' -- List Detail
Dim intBillingID As Integer
Dim ObjBilling As Object
Dim rs As Recordset
Dim strSQL As String

    BillingList = Session("BillingList")
    
    intBillingID = CCInt(Request.Form("lstBilling"))
    If intBillingID > 0 Then
        
  ' --- List Billing status
      strSQL = "Select billingid, accountid, shipdate, status " & _
               "From VBilling " & _
               "Where BillingID = " & CStr(intBillingID)
      Set ObjBilling = CreateObject("Ecomm.Billing")
      Set rs = ObjBilling.findbilling(strSQL)
      
      Do Until rs.EOF
        strBilling = strBilling & "<tr><td width=""25%"">" & _
                          "<div align=""center""><font face=""MS Sans Serif"">" & rs!billingid & "</font></div></td>" & _
                     "<td width=""25%"">" & _
                          "<div align=""center""><font face=""MS Sans Serif"">" & rs!AccountID & "</font></div></td>" & _
                     "<td width=""25%"">" & _
                          "<div align=""center""><font face=""MS Sans Serif"">" & rs!shipdate & "</font></div></td>" & _
                     "<td width=""25%"">" & _
                          "<div align=""center""><font face=""MS Sans Serif"">" & rs!Status & "</font></div></td></tr>"
      
        rs.MoveNext
      Loop
      
  ' ---- List Billingdetail
      strSQL = "Select ItemName, T2.Amount, T2.Discount, TaxValue, T2.Price, T2.Status " & _
               "From VBillingDetail T2, Vitem T1 " & _
               "Where T1.itemid =  T2.itemid And " & _
                     "BillingID = " & intBillingID
                     
      
      Set rs = ObjBilling.BillingDetail.findbillingdetail(strSQL)
      
      Do Until rs.EOF
      strBillingDetail = strBillingDetail & _
                         "<tr><td><div align=""center""><font face=""MS Sans Serif"" color=""#CC6600"">" & rs!itemname & "</font></div></td>" & _
                         "<td><div align=""center""><font face=""MS Sans Serif"" color=""#CC6600"">" & rs!amount & "</font></div></td>" & _
                         "<td><div align=""center""><font face=""MS Sans Serif"" color=""#CC6600"">" & rs!discount & "</font></div></td>" & _
                         "<td><div align=""center""><font face=""MS Sans Serif"" color=""#CC6600"">" & CSng(rs!taxvalue) & "</font></div></td>" & _
                         "<td><div align=""center""><font face=""MS Sans Serif"" color=""#CC6600"">" & rs!price & "</font></div></td>" & _
                         "<td><div align=""center""><font face=""MS Sans Serif"" color=""#CC6600"">" & rs!Status & "</font></font></div></td></tr>"
      rs.MoveNext
      Loop
  
      Set ObjBilling = Nothing
    Else
        strBilling = "<tr><td><h2><font face=""MS Sans Serif"" color=""#FF0000"">Selected Billingid first</font></h2></td></tr>"
        strBillingDetail = "<tr><td><h2><font face=""MS Sans Serif"" color=""#FF0000"">Selected Billingid first</font></h2></td></tr>"
        
    End If

        Template1.WriteTemplate

End Sub

Private Sub Template1_ProcessTag(ByVal TagName As String, TagContents As String, SendTags As Boolean)
    
    
    TagContents = Replace(TagContents, vbCrLf, "")
    TagContents = Replace(TagContents, " ", "")
    
    Select Case TagContents
            
        Case "billinglist"
            TagContents = BillingList
        
        Case "strBilling"
            TagContents = strBilling
        
        Case "strBillingDetail"
            TagContents = strBillingDetail
    End Select
    
End Sub

Private Sub WebClass_Start()
    Template1.WriteTemplate
End Sub
