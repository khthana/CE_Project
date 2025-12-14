VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Find"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarShopID As Integer 'local copy
Private mvarCategoryID As Integer 'local copy
Private mvarItemID As Integer 'local copy
Private mvarTextSearch As String 'local copy

Public Function FindTopProductFollowShop(shopid As Integer) As Recordset
' Retrieve top product for each shop that pass in shopid
' result all you want to know about item

Dim Objitem As Object
Dim strsql As String
Dim rs As Recordset
    Set Objitem = CreateObject("EComm.Item")
    strsql = "Select * from Vitem t1,VShop t2,(Select * from NCategory) t3 where t1.shopid=t2.shopid and t1.categoryId=t3.categoryId and " & _
             " T1.shopID= " & CInt(shopid) & " and 5>(select count(*) from vitem t4 where t4.unitonorder>t1.unitonorder) order by t1.itemid asc"
    Set rs = Objitem.Find(strsql)
    Set FindTopProductFollowShop = rs
End Function


Public Function FindItemName(ByVal shopid As Integer, ByVal categoryID As Integer) As Recordset

    Dim objitemname As Object
    Dim rs As Recordset
    Set objitemname = CreateObject("Ecomm.item")
    If shopid = 0 Then
        Set rs = objitemname.Find("select * from vitem ")
    ElseIf categoryID = 0 And shopid <> 0 Then
        Set rs = objitemname.Find("select * from vitem where shopid=" & CStr(shopid))
    ElseIf categoryID <> 0 And shopid <> 0 Then
        Set rs = objitemname.Find("select * from vitem where shopid= " & CStr(shopid) & " and categoryid = " & CStr(categoryID))
    End If
    Set FindItemName = rs
End Function

Public Function FindItemDetail(ByVal itemid As Integer) As Recordset
    Dim objitemdetail As Object
    Dim rs As Recordset
    Set objitemdetail = CreateObject("Ecomm.item")
    Set rs = objitemdetail.Find("select * from vitem where  itemid=" & CStr(itemid))
    Set FindItemDetail = rs
End Function

Public Function FindShopName(Optional ByVal shopid As Integer) As Recordset
    Dim objshopname As Object
    Dim rs As Recordset
    Set objshopname = CreateObject("Ecomm.shop")
    If shopid = 0 Then
        Set rs = objshopname.Find("select shopid,shopname from vshop ")
    Else
        Set rs = objshopname.Find("select * from vshop where shopid=" & CStr(shopid))
    End If
    Set FindShopName = rs
End Function

Public Function FindCategory(ByVal shopid As Integer) As Recordset
Dim objcat As Object
Dim rs As Recordset
    Set objcat = CreateObject("Ecomm.Category")
    Set rs = objcat.Find(shopid)
    Set FindCategory = rs
End Function

Public Function FindTableSchema(ByVal shopid As Integer, ByVal categoryID As Integer) As Recordset
Dim ObjSchema As Object
Dim rs As Recordset
    Set ObjSchema = CreateObject("Ecomm.shop")
    Set rs = ObjSchema.category.Find(shopid, "categoryid=" & CStr(categoryID))
    Set FindTableSchema = rs
End Function

Public Function FindFollowCategory() As Recordset
Dim Objitem As Object
Dim rs As Recordset
    Set Objitem = CreateObject("Ecomm.Item")
    
    Set rs = Objitem.Find(mvarTextSearch)
    Set FindFollowCategory = rs
End Function

Public Function FindDownload() As Recordset
Dim ObjDownload As Recordset
Dim rs As Recordset
'============================Not Complete========================

    Set FindDownload = rs
End Function

Public Function FindTodayLink() As Recordset
Dim ObjTodayLink As Recordset
Dim rs As Recordset
'============================Not Complete========================

    Set FindTodayLink = rs
End Function

Public Function FindTopProduct() As Recordset
Dim Objitem As Object
Dim rs As Recordset
    Set Objitem = CreateObject("EComm.Item")
    Set rs = Objitem.Find("Select * from Vitem t1,VShop t2,(Select * from NCategory) t3 where t1.shopid=t2.shopid and t1.categoryId=t3.categoryId and" & _
    " 5>(select count(*) from vitem t4 where t4.UnitOnorder>t1.UnitOnOrder) order by t1.unitonorder desc")
    Set FindTopProduct = rs
End Function

Public Function FindNewShop() As Recordset
Dim Objitem As Object
Dim rs As Recordset
    Set Objitem = CreateObject("EComm.Shop")
    Set rs = Objitem.Find("Select * from vshop t1 where 5>(select count(*) from vshop t2 where t2.shopid>t1.shopid ) order by t1.shopid desc")
    Set FindNewShop = rs
End Function

Public Function FindNewGoods(Optional ByVal shopid As Integer) As Recordset
Dim Objitem As Object
Dim rs As Recordset
    Set Objitem = CreateObject("EComm.Item")
    Set rs = Objitem.Find("Select * from Vitem t1,VShop t2,(Select * from NCategory) t3 where t1.shopid=t2.shopid and t1.categoryId=t3.categoryId and " & _
                 "5>(select count(*) from vitem t4 where t4.itemid>t1.itemid) and t2.shopid=" & CStr(shopid))
    Set FindNewGoods = rs
End Function

Public Property Let TextSearch(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.TextSearch = 5
    mvarTextSearch = vData
End Property


Public Property Get TextSearch() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.TextSearch
    TextSearch = mvarTextSearch
End Property



Public Property Let itemid(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ItemID = 5
    mvarItemID = vData
End Property


Public Property Get itemid() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ItemID
    itemid = mvarItemID
End Property



Public Property Let categoryID(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CategoryID = 5
    mvarCategoryID = vData
End Property


Public Property Get categoryID() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CategoryID
    categoryID = mvarCategoryID
End Property



Public Property Let shopid(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShopID = 5
    mvarShopID = vData
End Property


Public Property Get shopid() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShopID
    shopid = mvarShopID
End Property



