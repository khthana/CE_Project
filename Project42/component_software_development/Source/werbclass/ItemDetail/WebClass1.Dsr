VERSION 5.00
Begin {17016CEE-E118-11D0-94B8-00A0C91110ED} itemdetail 
   ClientHeight    =   5640
   ClientLeft      =   750
   ClientTop       =   1425
   ClientWidth     =   8235
   _ExtentX        =   14526
   _ExtentY        =   9948
   MajorVersion    =   0
   MinorVersion    =   8
   StateManagementType=   1
   ASPFileName     =   ""
   DIID_WebClass   =   "{12CBA1F6-9056-11D1-8544-00A024A55AB0}"
   DIID_WebClassEvents=   "{12CBA1F5-9056-11D1-8544-00A024A55AB0}"
   TypeInfoCookie  =   101
   BeginProperty WebItems {193556CD-4486-11D1-9C70-00C04FB987DF} 
      WebItemCount    =   2
      BeginProperty WebItem1 {FA6A55FE-458A-11D1-9C71-00C04FB987DF} 
         MajorVersion    =   0
         MinorVersion    =   8
         Name            =   "gdetail"
         DISPID          =   1280
         Template        =   "goods1.htm"
         Token           =   "WC@"
         DIID_WebItemEvents=   "{5DB10ADF-D092-11D3-AD6E-0080C8E1A44E}"
         ParseReplacements=   0   'False
         AppendedParams  =   ""
         HasTempTemplate =   0   'False
         UsesRelativePath=   -1  'True
         OriginalTemplate=   "D:\cen\Web\goods.htm"
         TagPrefixInfo   =   2
         BeginProperty Events {193556D1-4486-11D1-9C70-00C04FB987DF} 
            EventCount      =   1
            BeginProperty Event0 {193556D3-4486-11D1-9C70-00C04FB987DF} 
               Name            =   "shoppingbag"
               DISPID          =   1280
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
      BeginProperty WebItem2 {FA6A55FE-458A-11D1-9C71-00C04FB987DF} 
         MajorVersion    =   0
         MinorVersion    =   8
         Name            =   "shopbagerr"
         DISPID          =   1281
         Template        =   "GoShopBagerror.htm"
         Token           =   "WC@"
         DIID_WebItemEvents=   "{852459CD-D9F8-11D3-BDE5-0080C8E1A44E}"
         ParseReplacements=   0   'False
         AppendedParams  =   ""
         HasTempTemplate =   0   'False
         UsesRelativePath=   -1  'True
         OriginalTemplate=   "D:\cen\Web\GoShopBagerror.htm"
         TagPrefixInfo   =   2
         BeginProperty Events {193556D1-4486-11D1-9C70-00C04FB987DF} 
            EventCount      =   2
            BeginProperty Event0 {193556D3-4486-11D1-9C70-00C04FB987DF} 
               Name            =   "Back"
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
                     TagName         =   "Back"
                     OriginalURL     =   ""
                     Parent          =   ""
                     Template        =   "shopbagerr"
                     BoundEvent      =   "Back"
                     BoundItem       =   ""
                     Suffix          =   ""
                     UsesAnonymousName=   0
                     TagNumber       =   0
                  EndProperty
               EndProperty
            EndProperty
            BeginProperty Event1 {193556D3-4486-11D1-9C70-00C04FB987DF} 
               Name            =   "Form1"
               DISPID          =   1281
               Type            =   1
               OriginalHREF    =   ""
               TagType         =   6619241
               BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
                  AttribCount     =   1
                  BeginProperty Attrib0 {FA6A55FC-458A-11D1-9C71-00C04FB987DF} 
                     TagType         =   1
                     Attribute       =   "ACTION"
                     State           =   3
                     TagName         =   "Form1"
                     OriginalURL     =   "itemdetail.ASP"
                     Parent          =   ""
                     Template        =   "shopbagerr"
                     BoundEvent      =   "Form1"
                     BoundItem       =   ""
                     Suffix          =   ""
                     UsesAnonymousName=   0
                     TagNumber       =   1
                  EndProperty
               EndProperty
            EndProperty
         EndProperty
         BeginProperty BoundTags {FA6A55FA-458A-11D1-9C71-00C04FB987DF} 
            AttribCount     =   0
         EndProperty
      EndProperty
   EndProperty
   NameInURL       =   "itemdetail"
End
Attribute VB_Name = "itemdetail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Option Compare Text

' --- session("rsItem") keep record set of item detail

Dim rsItem As Recordset
Dim rsschema As Recordset
Dim Shopid As Integer
Dim CatId As Integer
Dim ItemID As Integer

Private Sub gdetail_ProcessTag(ByVal TagName As String, TagContents As String, SendTags As Boolean)
        TagContents = Trim(TagContents)
        TagContents = Replace(TagContents, vbCrLf, "")

        Select Case TagContents
            Case "F1:": TagContents = NullToEmpty(rsschema!f1)
            Case "F2:": TagContents = NullToEmpty(rsschema!f2)
            Case "F3:": TagContents = NullToEmpty(rsschema!f3)
            Case "F4:": TagContents = NullToEmpty(rsschema!f4)
            Case "F5:": TagContents = NullToEmpty(rsschema!f5)
            Case "F6:": TagContents = NullToEmpty(rsschema!f6)
            Case "F7:": TagContents = NullToEmpty(rsschema!f7)
            Case "F8:": TagContents = NullToEmpty(rsschema!f8)
            Case "F9:": TagContents = NullToEmpty(rsschema!f9)
            Case "F10:": TagContents = NullToEmpty(rsschema!f10)
            Case "F11:": TagContents = NullToEmpty(rsschema!f11)
            Case "F12:": TagContents = NullToEmpty(rsschema!f12)
            Case "F13:": TagContents = NullToEmpty(rsschema!f13)
            Case "F14:": TagContents = NullToEmpty(rsschema!f14)
            Case "F15:": TagContents = NullToEmpty(rsschema!f15)
            Case "F16:": TagContents = NullToEmpty(rsschema!f16)
            Case "F17:": TagContents = NullToEmpty(rsschema!f17)
            Case "F18:": TagContents = NullToEmpty(rsschema!f18)
            Case "F19:": TagContents = NullToEmpty(rsschema!f19)
            Case "F20:": TagContents = NullToEmpty(rsschema!f20)
            '-----------------------------------------------------------
            Case "V1": TagContents = NullToEmpty(rsItem!ItemID)
            Case "V2": TagContents = NullToEmpty(rsItem!itemname)
            Case "V3": TagContents = NullToEmpty(rsItem!categoryID)
            Case "V4": TagContents = NullToEmpty(rsItem!Shopid)
            Case "V5": TagContents = NullToEmpty(rsItem!discount)
            Case "V6": TagContents = NullToEmpty(rsItem!barcode)
            Case "V7": TagContents = NullToEmpty(rsItem!Status)
            Case "V8": TagContents = NullToEmpty(rsItem!price)
            Case "V9": TagContents = NullToEmpty(rsItem!Description)
            Case "V10": TagContents = NullToEmpty(rsItem!unitonorder)
            Case "V11": TagContents = NullToEmpty(rsItem!f1)
            Case "V12": TagContents = NullToEmpty(rsItem!f2)
            Case "V13": TagContents = NullToEmpty(rsItem!f3)
            Case "V14": TagContents = NullToEmpty(rsItem!f4)
            Case "V15": TagContents = NullToEmpty(rsItem!f5)
            Case "V16": TagContents = NullToEmpty(rsItem!f6)
            Case "V17": TagContents = NullToEmpty(rsItem!f7)
            Case "V18": TagContents = NullToEmpty(rsItem!f8)
            Case "V19": TagContents = NullToEmpty(rsItem!f9)
            Case "V20": TagContents = NullToEmpty(rsItem!f10)
            Case "V21": TagContents = NullToEmpty(rsItem!f11)
            Case "V22": TagContents = NullToEmpty(rsItem!f12)
            Case "V23": TagContents = NullToEmpty(rsItem!f13)
            Case "V24": TagContents = NullToEmpty(rsItem!f14)
            Case "V25": TagContents = NullToEmpty(rsItem!f15)
            Case "V26": TagContents = NullToEmpty(rsItem!f16)
            Case "V27": TagContents = NullToEmpty(rsItem!f17)
            Case "V28": TagContents = NullToEmpty(rsItem!f18)
            Case "V29": TagContents = NullToEmpty(rsItem!f19)
            Case "V30": TagContents = NullToEmpty(rsItem!f20)
            Case "videostream": TagContents = NullToEmpty(rsItem!video)
            Case "soundsite": TagContents = NullToEmpty(rsItem!sound)
            Case "picturefile": TagContents = "\asfroot\picture\" & rsItem!ItemID & ".tmp"
            Case "sound:"
                            If IsNull(rsItem!sound) Then
                                TagContents = "Sound : NO"
                            Else
                                TagContents = "Sound : YES"
                            End If
            Case "video:"
                            If IsNull(rsItem!video) Then
                                TagContents = "Video : NO"
                            Else
                                TagContents = "Video : YES"
                            End If
        End Select
   
End Sub

Private Sub gdetail_shoppingbag()
Dim strweb As String
Dim AccountId As Integer
Dim rsItem As Recordset

    If (Not IsEmpty(Session("rsItem"))) Then
        Set rsItem = Session("rsItem")
        AccountId = Session("AccountID")
        strweb = "https://161.246.6.152/ecom/shoppingBag/sb.asp?accountid=" & NullToEmpty(AccountId) & "&itemid=" & NullToEmpty(rsItem!ItemID) & _
                 "&price=" & NullToEmpty(rsItem!price) & "&discount=" & NullToEmpty(rsItem!discount)
        
        Response.Redirect strweb
    Else
        Response.Write "Error session(""rsItem"") not value"
    End If
    
End Sub

Private Sub shopbagerr_Back()
    'back to login
    Response.Redirect "https://161.246.6.152/ecom/login.htm"
    
End Sub

Private Sub shopbagerr_Form1()
    'back to register
    Response.Redirect "https://161.246.6.152/ecom/register.htm"
End Sub

Private Sub WebClass_Start()
Dim ItemObj As Object
Dim schemaobj As Object
Dim multimediaObj As Object

On Error GoTo RetrieveDataError
    'Write a reply to the user
    Shopid = CInt(Request.QueryString("ShopID"))
    CatId = CInt(Request.QueryString("CategoryID"))
    ItemID = CInt(Request.QueryString("ItemID"))
   
'    Shopid = 1  'DEBUG
'    CatId = 1
 '   ItemID = 1
       
    Set ItemObj = CreateObject("Findcomponent.find")
    Set rsItem = ItemObj.FindItemDetail(ItemID)
    
    Set Session("rsItem") = rsItem
    
    Set schemaobj = CreateObject("Findcomponent.find")
    Set rsschema = schemaobj.FindTableSchema(Shopid, CatId)
    Set multimediaObj = CreateObject("multimedia.picture")

On Error Resume Next
    multimediaObj.play ItemID
    gdetail.WriteTemplate
    Exit Sub
    
RetrieveDataError:
    Response.Write Err.Number & " : " & Err.Description

End Sub
