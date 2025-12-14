VERSION 5.00
Begin {17016CEE-E118-11D0-94B8-00A0C91110ED} SENDQ 
   ClientHeight    =   4665
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5985
   _ExtentX        =   10557
   _ExtentY        =   8229
   MajorVersion    =   0
   MinorVersion    =   8
   StateManagementType=   1
   ASPFileName     =   "D:\Project\EComm\webshoppingbag\SENDQ.ASP"
   DIID_WebClass   =   "{A567FACD-D09F-11D3-83D5-00E02944B1CD}"
   DIID_WebClassEvents=   "{A567FACC-D09F-11D3-83D5-00E02944B1CD}"
   TypeInfoCookie  =   28
   BeginProperty WebItems {193556CD-4486-11D1-9C70-00C04FB987DF} 
      WebItemCount    =   1
      BeginProperty WebItem1 {FA6A55FE-458A-11D1-9C71-00C04FB987DF} 
         MajorVersion    =   0
         MinorVersion    =   8
         Name            =   "Template1"
         DISPID          =   1280
         Template        =   "SENDQUERY1.htm"
         Token           =   "WC@"
         DIID_WebItemEvents=   "{A567FB35-D09F-11D3-83D5-00E02944B1CD}"
         ParseReplacements=   0   'False
         AppendedParams  =   ""
         HasTempTemplate =   0   'False
         UsesRelativePath=   -1  'True
         OriginalTemplate=   "D:\Tong\webclass\ShoppingBag\SENDQUERY.htm"
         TagPrefixInfo   =   2
         BeginProperty Events {193556D1-4486-11D1-9C70-00C04FB987DF} 
            EventCount      =   1
            BeginProperty Event0 {193556D3-4486-11D1-9C70-00C04FB987DF} 
               Name            =   "AddItem"
               DISPID          =   1280
               Type            =   1
               OriginalHREF    =   ""
               TagType         =   6619241
               BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
                  AttribCount     =   1
                  BeginProperty Attrib0 {FA6A55FC-458A-11D1-9C71-00C04FB987DF} 
                     TagType         =   1
                     Attribute       =   "ACTION"
                     State           =   3
                     TagName         =   "AddItem"
                     OriginalURL     =   ""
                     Parent          =   ""
                     Template        =   "Template1"
                     BoundEvent      =   "AddItem"
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
   EndProperty
   NameInURL       =   "SENDQ"
End
Attribute VB_Name = "SENDQ"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit


Private Sub Template1_AddItem()
    Dim AccountID As String
    Dim ItemId As String
    Dim Price As String
    Dim Discount As String
    
    AccountID = Request.Form("AccountID")
    ItemId = Request.Form("ItemID")
    Price = Request.Form("Price")
    Discount = Request.Form("Discount")
    
    Response.Redirect ("sb.asp?AccountID=" & AccountID & "&ItemID=" & ItemId & "&Price=" & Price & "&Discount=" & Discount)
        

End Sub

Private Sub WebClass_Start()
    Template1.WriteTemplate
End Sub
