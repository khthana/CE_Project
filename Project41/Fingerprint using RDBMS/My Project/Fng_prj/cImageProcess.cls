VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "CImageProcess"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Class cImageProcessc
Option Explicit

Private Type SAFEARRAYBOUND
    cElements As Long
    lLbound As Long
End Type

Private Type SAFEARRAY1D
    cDims As Integer
    fFeatures As Integer
    cbElements As Long
    cLocks As Long
    pvData As Long
    Bounds(0 To 0) As SAFEARRAYBOUND
End Type

Private Type SAFEARRAY2D
    cDims As Integer
    fFeatures As Integer
    cbElements As Long
    cLocks As Long
    pvData As Long
    Bounds(0 To 1) As SAFEARRAYBOUND
End Type

Private Declare Function VarPtrArray Lib "msvbvm50.dll" Alias "VarPtr" (Ptr() As Any) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (pDst As Any, pSrc As Any, ByVal ByteLen As Long)
Private Type BITMAP
    bmType As Long
    bmWidth As Long
    bmHeight As Long
    bmWidthBytes As Long
    bmPlanes As Integer
    bmBitsPixel As Integer
    bmBits As Long
End Type

Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Const SRCCOPY = &HCC0020 ' (DWORD) dest = source

Private Declare Function GetObjectAPI Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long
Private Declare Function timeGetTime Lib "winmm.dll" () As Long


Public Enum EFilterTypes
    eSmooth
    eBinary
    eThin
    eExtract
    eOriented
End Enum

Public Enum eFilterError
    eeFilterErrorBase = vbObjectError Or 1048 Or &H500
End Enum

Private m_eFilterType As EFilterTypes
Private hist(256) As Long
Private Const pi As Double = 3.14159265358979
Private Const L As Integer = 256
Private Const initial As Integer = 2
Private Const dynamics As Integer = 1
Private Const statics As Integer = 0
Public xMax, yMax As Long
Private curl_x(256, 256) As Long
Private curl_y(256, 256) As Long
Private curl_x_2(256, 256) As Long
Private curl_y_2(256, 256) As Long
Private zeta(16, 16) As Integer
Private extracted(256, 256) As Integer
Private Save_extract(256, 256) As Integer
Private thined(256, 256) As Integer
Private Const EP As Integer = 123
Private Const BP As Integer = 456
Public RideWidth As Integer

Public Property Let FilterType(ByVal eType As EFilterTypes)
    m_eFilterType = eType
End Property

' select the case of image processing
Public Function ProcessImage( _
    ByRef picImage As PictureBox) As Boolean
    
    Select Case m_eFilterType
    Case eSmooth
        ProcessImage = SmoothFilter(picImage)

    Case eThin
        ProcessImage = ThinFilter(picImage)
        
    Case eBinary
        ProcessImage = BinaryFilter(picImage)
    
    Case eExtract
        ProcessImage = ExtractFilter(picImage)
    
    Case eOriented
        ProcessImage = OrientedFilter(picImage)
    End Select
End Function

Public Function Feature(ByVal x As Integer, ByVal y As Integer) As Integer
    Feature = extracted(x, y)
End Function

Public Function OrientedField(ByVal x As Integer, ByVal y As Integer) As Integer
    OrientedField = zeta(x, y)
End Function

'--------------- Gradiant image -----------------
Private Sub gradiant(ByRef pict() As Byte)
Dim x, y As Integer
    For x = 1 To xMax - 1
        For y = 1 To yMax - 1
        'curl_y(x, y) = (pict(x + 1, y + 1) + (2 * pict(x + 1, y)) + pict(x + 1, y - 1) _
         '            - pict(x - 1, y + 1) - (2 * pict(x - 1, y)) - pict(x - 1, y - 1))
        'curl_x(x, y) = (pict(x + 1, y + 1) + (2 * pict(x, y + 1)) + pict(x - 1, y + 1) _
         '            - pict(x - 1, y - 1) - (2 * pict(x, y - 1)) - pict(x + 1, y - 1))
         curl_y(x, y) = pict(x - 1, y - 1) + (2 * pict(x, y - 1)) + pict(x + 1, y - 1) _
                                - pict(x + 1, y + 1) - (2 * pict(x, y + 1)) - pict(x - 1, y + 1)
         curl_x(x, y) = pict(x - 1, y + 1) + (2 * pict(x - 1, y)) + pict(x - 1, y - 1) _
                                - pict(x + 1, y + 1) - (2 * pict(x + 1, y)) - pict(x + 1, y - 1)
        Next y
    Next x
' use sobel operator 3*3 mask
End Sub

Private Sub gradiant2()
Dim i, j As Integer
For i = 0 To xMax
    For j = 0 To yMax
    curl_x_2(i, j) = curl_x(i + 1, j) - curl_x(i, j)
    curl_y_2(i, j) = curl_y(i, j + 1) - curl_y(i, j)
    Next j
Next i
End Sub

Private Function block(ByVal x As Integer, ByVal y As Integer) As Integer
Dim sum1, sum2, temp1, temp2 As Double
Dim i, j As Integer

sum1 = 0: sum2 = 0
    For i = (x - 1) * 16 To x * 16
        For j = (y - 1) * 16 To y * 16
            sum1 = sum1 + (2 * curl_x(i, j) * curl_y(i, j))
            sum2 = sum2 + (curl_x_2(i, j) - curl_y_2(i, j) ^ 2)
       Next j
    Next i

'case divide by 0
If sum2 <> 0 Then
    temp1 = 0.5 * Atn(sum1 / sum2)  ' -90 .... 90
    temp2 = temp1 * 180 / pi ' convert radiant to degree
    If temp2 < 0 Then
        block = 180 + Int(temp2) ' return integer degree value
    Else
        block = Int(temp2)
    End If
Else
    block = 90
End If
End Function
Private Sub orientation()
Dim i, j As Integer
    For i = 1 To 16
        For j = 1 To 16
        zeta(i, j) = block(i, j) 'find x,y location * 8
        Next j
    Next i
End Sub

Public Function OrientedFilter(ByRef picImage As PictureBox) As Boolean
' these are used to address the pixel using matrices
Dim pict() As Byte
Dim sa As SAFEARRAY2D, bmp As BITMAP
Dim x As Long, y As Long
Dim i As Long, j As Long
Dim fraction As Long, sum As Long
    xMax = 0: yMax = 0
    ' get bitmap info
    GetObjectAPI picImage.Picture, Len(bmp), bmp 'dest
        
    ' exit if not a supported bitmap
    If bmp.bmBitsPixel <> 8 Then
        MsgBox " 8-bit bitmaps only", vbCritical
        Exit Function
    End If
       
    ' have the local matrix point to bitmap pixels
    With sa
        .cbElements = 1
        .cDims = 2
        .Bounds(0).lLbound = 0
        .Bounds(0).cElements = bmp.bmHeight
        .Bounds(1).lLbound = 0
        .Bounds(1).cElements = bmp.bmWidthBytes
        .pvData = bmp.bmBits
    End With
    CopyMemory ByVal VarPtrArray(pict), VarPtr(sa), 4
    yMax = UBound(pict, 2)
    xMax = UBound(pict, 1)
      
    Call gradiant(pict)
    Call gradiant2
    Call orientation
    
    CopyMemory ByVal VarPtrArray(pict), 0&, 4
    OrientedFilter = True
End Function

'--------------- Use for Smooth image ---------------
Private Function Top(ByVal y As Long) As Long
    If (y < 0) Then
        Top = 1
    Else
        Top = 0
    End If
End Function
Private Function bottom(ByVal y As Long) As Long
    If (y > yMax) Then
        bottom = 1
    Else
        bottom = 0
    End If
End Function
Private Function Right(ByVal x As Long) As Long
    If (x > xMax) Then
        Right = 1
    Else
        Right = 0
    End If
End Function
Private Function Left(ByVal x As Long) As Long
    If (x < 0) Then
        Left = 1
    Else
        Left = 0
    End If
End Function
Private Function X_sum(ByVal i As Integer, ByVal x As Long, ByVal y As Long, ByRef pict() As Byte) As Long
Dim xx As Long
Select Case i
    Case 0
        X_sum = Val(pict(x, y))
    
    Case 1
    If (Right(x + 1)) Then          'R(x+1)=1
        X_sum = 255
    Else
        X_sum = Val(pict(x + 1, y))
    End If
    Case 2
    If (Right(x + 1) Or Top(y - 1)) Then
        X_sum = 255
    Else
        X_sum = Val(pict(x + 1, y - 1))
    End If
    Case 3
    If (Top(y - 1)) Then
        X_sum = 255
    Else
        X_sum = Val(pict(x, y - 1))
    End If
    Case 4
    If (Top(y - 1) Or Left(x - 1)) Then
        X_sum = 255
    Else
        X_sum = Val(pict(x - 1, y - 1))
    End If
    Case 5
    If (Left(x - 1)) Then
        X_sum = 255
    Else
        X_sum = Val(pict(x - 1, y))
    End If
    Case 6
    If (Left(x - 1) Or bottom(y + 1)) Then
        X_sum = 255
    Else
        X_sum = Val(pict(x - 1, y + 1))
    End If
    Case 7
    If (bottom(y + 1)) Then
        X_sum = 255
    Else
        X_sum = Val(pict(x, y + 1))
    End If
    Case 8
    If (bottom(y + 1) Or Right(x + 1)) Then
        X_sum = 255
    Else
        X_sum = Val(pict(x + 1, y + 1))
    End If
End Select

End Function

Public Function SmoothFilter( _
        ByRef picImage As PictureBox) As Boolean
' these are used to address the pixel using matrices
Dim pict() As Byte
Dim sa As SAFEARRAY2D, bmp As BITMAP
Dim x As Long, y As Long
Dim i As Long, j As Long
Dim fraction As Long, sum As Long
    xMax = 0: yMax = 0
    ' get bitmap info
    GetObjectAPI picImage.Picture, Len(bmp), bmp 'dest
        
    ' exit if not a supported bitmap
    If bmp.bmBitsPixel <> 8 Then
        MsgBox " 8-bit bitmaps only", vbCritical
        Exit Function
    End If
       
    ' have the local matrix point to bitmap pixels
    With sa
        .cbElements = 1
        .cDims = 2
        .Bounds(0).lLbound = 0
        .Bounds(0).cElements = bmp.bmHeight
        .Bounds(1).lLbound = 0
        .Bounds(1).cElements = bmp.bmWidthBytes
        .pvData = bmp.bmBits
    End With
    CopyMemory ByVal VarPtrArray(pict), VarPtr(sa), 4
        
    ' Do filter on pict into pict2
    
    yMax = UBound(pict, 2)
    xMax = UBound(pict, 1)
    For x = 0 To xMax
        For y = 0 To yMax
        sum = 0: fraction = 0
        sum = sum + X_sum(0, x, y, pict)
        sum = sum + X_sum(1, x, y, pict)
        sum = sum + X_sum(2, x, y, pict)
        sum = sum + X_sum(3, x, y, pict)
        sum = sum + X_sum(4, x, y, pict)
        sum = sum + X_sum(5, x, y, pict)
        sum = sum + X_sum(6, x, y, pict)
        sum = sum + X_sum(7, x, y, pict)
        sum = sum + X_sum(8, x, y, pict)
        
        fraction = sum \ 9
        pict(x, y) = Str(fraction)
             
        Next y
    Next x
            
    ' clear the temporary array descriptor
    ' without destroying the local temporary array
    CopyMemory ByVal VarPtrArray(pict), 0&, 4
    SmoothFilter = True
    
End Function

'--------------- Use for Binary image ---------------

Private Sub read_frequency(ByRef pict() As Byte, ByRef hist() As Long, ByVal L As Integer)
Dim x, y As Integer
Dim i, j As Integer
    For i = 0 To L - 1
        hist(i) = 0
    Next i
    
    For x = 0 To xMax
        For y = 0 To yMax
            i = Val(pict(x, y))
            hist(i) = hist(i) + 1
        Next y
    Next x

End Sub
Static Function Log10(ByVal x As Double) As Double
Log10 = (Log(x) / Log(10#))
End Function
Private Function Ps(ByRef h() As Long, ByVal S As Integer, ByVal lower_bound As Integer, status As Integer) _
    As Double
Static sum As Double
Dim i As Integer

If (status = initial) Then
    i = lower_bound
    sum = h(i)
    Ps = 0
    Exit Function
Else
    If status = dynamics Then
        i = S
        sum = sum + h(i)
        Ps = 0
        Exit Function
    End If
End If
Ps = sum
End Function
Private Function iPs(ByRef h() As Long, ByVal S As Integer, ByVal lower_bound As Integer, status As Integer) _
    As Double
Static sum As Double
Dim i As Integer

If (status = initial) Then
    i = lower_bound
    sum = lower_bound * h(i)
    iPs = 0
    Exit Function
Else
    If status = dynamics Then
        i = S
        sum = sum + (S * h(i))
        iPs = 0
        Exit Function
    End If
End If
iPs = sum
End Function
Private Function Ps_inv(ByRef h() As Long, ByVal S As Integer, ByVal lower_bound As Integer, status As Integer) _
    As Double
Static sum As Double
Dim i, j As Integer
Dim xMax, yMax As Double
xMax = 256: yMax = 256
If (status = initial) Then
    i = lower_bound
    sum = (xMax * yMax) - h(i)
    Ps_inv = 0
    Exit Function
Else
    If status = dynamics Then
        i = S
        sum = sum - h(i)
        Ps_inv = 0
        Exit Function
    End If
End If
Ps_inv = sum
End Function
Private Function iPs_inv(ByRef h() As Long, ByVal S As Integer, ByVal lower_bound As Integer, _
ByVal upper_bound As Integer, ByVal status As Integer) As Double
    
Static sum As Double
Dim i As Integer

If (status = initial) Then
    sum = 0
    For i = lower_bound To upper_bound
        sum = sum + (i * h(i))
    Next i
    sum = sum - (lower_bound * h(lower_bound))
    iPs_inv = 0
    Exit Function
Else
    If status = dynamics Then
        i = S
        sum = sum - (S * h(i))
        iPs_inv = 0
        Exit Function
    End If
End If
iPs_inv = sum
End Function
  
Private Function POi(ByRef h() As Long, ByVal i As Integer, ByVal S As Integer, ByVal lower_bound As Integer, _
ByVal status As Integer) As Double
Static buffer As Double
Dim temp As Double

If (status = initial) Then
    buffer = Ps(h, S, lower_bound, statics)
Else
    temp = h(i) / buffer
    POi = temp
    Exit Function
End If
POi = 0
End Function
Private Function PBi(ByRef h() As Long, ByVal i As Integer, ByVal S As Integer, ByVal lower_bound As Integer, _
ByVal status As Integer) As Double
Static buffer As Double
Dim temp As Double

If (status = initial) Then
    buffer = Ps_inv(h, S, lower_bound, statics)
Else
    temp = h(i) / buffer
    PBi = temp
    Exit Function
End If
PBi = 0
End Function
Private Function lambdaO(ByRef h() As Long, ByVal S As Integer, ByVal lower_bound As Integer, ByVal status As Integer) _
    As Double
Static buffer As Double
Dim temp1, temp2 As Double

If (status = initial) Then
    temp1 = iPs(h, S, lower_bound, statics)
    temp2 = Ps(h, S, lower_bound, statics)
    buffer = temp1 / temp2
Else
    lambdaO = buffer
    Exit Function
End If
    lambdaO = 0
End Function
Private Function lambdaB(ByRef h() As Long, ByVal S As Integer, ByVal lower_bound As Integer, _
ByVal upper_bound As Integer, ByVal status As Integer) As Double

Static buffer As Double
Dim temp1, temp2 As Double

If (status = initial) Then
    temp1 = iPs_inv(h, S, lower_bound, upper_bound, statics)
    temp2 = Ps_inv(h, S, lower_bound, statics)
    buffer = temp1 / temp2
Else
    lambdaB = buffer
    Exit Function
End If
    lambdaB = 0
End Function
      
Private Function qOi(ByRef h() As Long, ByVal i As Integer, ByVal S As Integer, ByVal lower_bound As Integer, _
ByVal status As Integer) As Double

Static lambdaObuffer As Double
Dim product, temp1 As Double
Dim j As Integer

If (status = initial) Then
    lambdaObuffer = lambdaO(h, S, lower_bound, statics)
    qOi = 0
    Exit Function
Else
    If i = 0 Then
        temp1 = Exp(-1 * lambdaObuffer)
        qOi = temp1
        Exit Function
    Else
        product = Exp(-1 * lambdaObuffer)
        For j = 1 To i
        product = product * (lambdaObuffer / j)
        Next j
    End If
End If
qOi = product
End Function
 
Private Function qBi(ByRef h() As Long, ByVal i As Integer, ByVal S As Integer, ByVal lower_bound As Integer, _
ByVal upper_bound As Integer, ByVal status As Integer) As Double

Static lambdaBbuffer As Double
Dim product, temp1 As Double
Dim j As Integer

If (status = initial) Then
    lambdaBbuffer = lambdaB(h, S, lower_bound, upper_bound, statics)
    qBi = 0
    Exit Function
Else
    If i = 0 Then
        temp1 = Exp(-1 * lambdaBbuffer)
        qBi = temp1
        Exit Function
    Else
        product = Exp(-1 * lambdaBbuffer)
        For j = 1 To i
        product = product * (lambdaBbuffer / j)
        Next j
    End If
End If
qBi = product
End Function
Private Function DO_O(ByRef h() As Long, ByVal S As Integer, ByVal lower_bound As Integer) _
    As Double

Dim buffer1, buffer2 As Double
Dim sum1, sum2 As Double
Dim i As Integer
Dim temp1, temp2 As Double

sum1 = 0: sum2 = 0:
temp1 = POi(h, i, S, lower_bound, initial)
temp2 = qOi(h, i, S, lower_bound, initial)

For i = lower_bound To S
    buffer1 = POi(h, i, S, lower_bound, statics)
    buffer2 = qOi(h, i, S, lower_bound, statics)
    If (buffer1 <> 0) And (buffer2 <> 0) Then
        If (buffer1 / buffer2 = 0) Or (buffer2 / buffer1 = 0) Then
        Else
        temp1 = Log10(buffer1 / buffer2)
        temp2 = Log10(buffer2 / buffer1)
        sum1 = sum1 + (buffer1 * temp1)
        sum2 = sum2 + (buffer2 * temp2)
        End If
    End If
Next i
DO_O = sum1 + sum2

End Function
Private Function DB_B(ByRef h() As Long, ByVal S As Integer, ByVal lower_bound As Integer, _
ByVal upper_bound As Integer) As Double

Dim buffer1, buffer2 As Double
Dim sum1, sum2 As Double
Dim i As Integer
Dim temp1, temp2 As Double

sum1 = 0: sum2 = 0:
temp1 = PBi(h, i, S, lower_bound, initial)
temp2 = qBi(h, i, S, lower_bound, upper_bound, initial)

For i = S + 1 To upper_bound
    buffer1 = PBi(h, i, S, lower_bound, statics)
    buffer2 = qBi(h, i, S, lower_bound, upper_bound, statics)
    If (buffer1 <> 0) And (buffer2 <> 0) Then
        If (buffer1 / buffer2 = 0) Or (buffer2 / buffer1 = 0) Then
        Else
        temp1 = Log10(buffer1 / buffer2)
        temp2 = Log10(buffer2 / buffer1)
        sum1 = sum1 + (buffer1 * temp1)
        sum2 = sum2 + (buffer2 * temp2)
        End If
    End If
Next i
DB_B = sum1 + sum2

End Function
Private Function DD(ByRef h() As Long, ByVal S As Integer, ByVal lower_bound As Integer, _
ByVal upper_bound As Integer) As Double

Dim temp As Double

temp = DO_O(h, S, lower_bound) + DB_B(h, S, lower_bound, upper_bound)
DD = temp
End Function

Private Function thresholding(ByRef h() As Long, ByVal L As Integer) As Integer
Dim i, upper_bound, lower_bound As Integer
Dim S, threshold As Integer
Dim mindiv, buffer As Double
Dim temp1, temp2, temp3, temp4 As Double
Dim temp5, temp6 As Double

i = 0: mindiv = 1000
Do While h(i) = 0
    i = i + 1
Loop
lower_bound = i
i = L - 1
Do While h(i) = 0
    i = i - 1
Loop
upper_bound = i
' initial value

 
temp1 = Ps(h, S, lower_bound, initial)
temp2 = iPs(h, S, lower_bound, initial)
temp3 = Ps_inv(h, S, lower_bound, initial)
temp4 = iPs_inv(h, S, lower_bound, upper_bound, initial)

For S = lower_bound + 1 To upper_bound - 1
    temp1 = Ps(h, S, lower_bound, dynamics)
    temp2 = iPs(h, S, lower_bound, dynamics)
    temp3 = Ps_inv(h, S, lower_bound, dynamics)
    temp4 = iPs_inv(h, S, lower_bound, upper_bound, dynamics)
    temp5 = lambdaO(h, S, lower_bound, initial)
    temp6 = lambdaB(h, S, lower_bound, upper_bound, initial)
    buffer = DD(h, S, lower_bound, upper_bound)
    If (mindiv > buffer) Then
        mindiv = buffer
        threshold = S
    End If
Next S

thresholding = threshold
End Function
Public Function BinaryFilter( _
        ByRef picImage As PictureBox) As Boolean
' these are used to address the pixel using matrices
Dim pict() As Byte
Dim temp_image(256, 256) As Byte
Dim sa As SAFEARRAY2D, bmp As BITMAP
Dim i, j As Integer
Dim x, y As Integer
Dim threshold As Integer
    xMax = 0: yMax = 0
    ' get bitmap info
    GetObjectAPI picImage.Picture, Len(bmp), bmp 'dest
    
    ' exit if not a supported bitmap
    If bmp.bmBitsPixel <> 8 Then
        MsgBox " 8-bit bitmaps only", vbCritical
        Exit Function
    End If
       
    ' have the local matrix point to bitmap pixels
    With sa
        .cbElements = 1
        .cDims = 2
        .Bounds(0).lLbound = 0
        .Bounds(0).cElements = bmp.bmHeight
        .Bounds(1).lLbound = 0
        .Bounds(1).cElements = bmp.bmWidthBytes
        .pvData = bmp.bmBits
    End With
    CopyMemory ByVal VarPtrArray(pict), VarPtr(sa), 4
        
    yMax = UBound(pict, 2)
    xMax = UBound(pict, 1)
    Call read_frequency(pict, hist, L)
    threshold = thresholding(hist, L)

' Do Binary 254 = white, 0 = black
    For x = 0 To xMax
       For y = 0 To yMax
       If Val(pict(x, y)) > threshold Then
            pict(x, y) = 254
       Else
            pict(x, y) = 0
       End If
       Next y
    Next x
   
    ' clear the temporary array descriptor
    ' without destroying the local temporary array
    CopyMemory ByVal VarPtrArray(pict), 0&, 4
    BinaryFilter = True
    
End Function

'--------------- use for Thinning image ---------------

Private Function restorage(ByRef pict() As Byte, ByRef temp_image() As Byte) As Integer
Dim x, y, z As Integer
z = 1
For x = 0 To xMax
    For y = 0 To yMax
    If temp_image(x, y) <> 254 Then
        If pict(x, y) = 254 Then
        pict(x, y) = 0
        z = 0
        End If
    End If
    Next y
Next x

restorage = z

End Function

Private Function condition_1(ByVal x As Integer, ByVal y As Integer, ByRef pict() As Byte) As Integer
' input positon of x,y of image
' output result of condition_1 thinning
Dim a, b, c, d As Long
a = 0: b = 0: c = 0: d = 0
'condition 1 A()
If (pict(x - 1, y - 1) = 0) And (pict(x, y - 1) = 254) Then a = a + 1
If (pict(x, y - 1) = 0) And (pict(x + 1, y - 1) = 254) Then a = a + 1
If (pict(x + 1, y - 1) = 0) And (pict(x + 1, y) = 254) Then a = a + 1
If (pict(x + 1, y) = 0) And (pict(x + 1, y + 1) = 254) Then a = a + 1
If (pict(x + 1, y + 1) = 0) And (pict(x, y + 1) = 254) Then a = a + 1
If (pict(x, y + 1) = 0) And (pict(x - 1, y + 1) = 254) Then a = a + 1
If (pict(x - 1, y + 1) = 0) And (pict(x - 1, y) = 254) Then a = a + 1
If (pict(x - 1, y) = 0) And (pict(x - 1, y - 1) = 254) Then a = a + 1
    
'condition 2 B()

'FrmImage.Print pict(x - 1, y - 1)
b = Val(pict(x - 1, y - 1)) + Val(pict(x, y - 1)) + Val(pict(x + 1, y - 1)) + Val(pict(x + 1, y)) _
  + Val(pict(x + 1, y + 1)) + Val(pict(x, y + 1)) + Val(pict(x - 1, y + 1)) + Val(pict(x - 1, y))
  
'condition 3 //P2*P4*P6
c = Val(pict(x, y - 1)) * Val(pict(x + 1, y)) * Val(pict(x, y + 1))

'condition 4 //P4*P6*P8
d = Val(pict(x + 1, y)) * Val(pict(x, y + 1)) * Val(pict(x - 1, y))

'decision
    If (a = 1) And (254 < b) And (b < 2032) And (c = 0) And (d = 0) Then
        condition_1 = 0 'delete
    Else
        condition_1 = 254 'undelete
    End If
    
End Function

Private Function condition_2(ByVal x As Integer, ByVal y As Integer, ByRef pict() As Byte) As Integer
' input positon of x,y of image
' output result of condition_2 thinning
Dim a, b, c, d As Long
a = 0: b = 0: c = 0: d = 0
'condition 1 A()
If (pict(x - 1, y - 1) = 0) And (pict(x, y - 1) = 254) Then a = a + 1
If (pict(x, y - 1) = 0) And (pict(x + 1, y - 1) = 254) Then a = a + 1
If (pict(x + 1, y - 1) = 0) And (pict(x + 1, y) = 254) Then a = a + 1
If (pict(x + 1, y) = 0) And (pict(x + 1, y + 1) = 254) Then a = a + 1
If (pict(x + 1, y + 1) = 0) And (pict(x, y + 1) = 254) Then a = a + 1
If (pict(x, y + 1) = 0) And (pict(x - 1, y + 1) = 254) Then a = a + 1
If (pict(x - 1, y + 1) = 0) And (pict(x - 1, y) = 254) Then a = a + 1
If (pict(x - 1, y) = 0) And (pict(x - 1, y - 1) = 254) Then a = a + 1
    
'condition 2 B()
b = Val(pict(x - 1, y - 1)) + Val(pict(x, y - 1)) + Val(pict(x + 1, y - 1)) + Val(pict(x + 1, y)) _
  + Val(pict(x + 1, y + 1)) + Val(pict(x, y + 1)) + Val(pict(x - 1, y + 1)) + Val(pict(x - 1, y))
  
'condition 3 //P2*P4*P8
c = Val(pict(x, y - 1)) * Val(pict(x + 1, y)) * Val(pict(x - 1, y))

'condition 4 //P2*P6*P8
d = Val(pict(x, y - 1)) * Val(pict(x, y + 1)) * Val(pict(x - 1, y))

'decision
    If (a = 1) And (254 < b) And (b < 2032) And (c = 0) And (d = 0) Then
        condition_2 = 0 'delete
    Else
        condition_2 = 254 'undelete
    End If
    
End Function


Public Function ThinFilter( _
        ByRef picImage As PictureBox) As Boolean
' these are used to address the pixel using matrices
Dim pict() As Byte
Dim temp_image(256, 256) As Byte
Dim sa As SAFEARRAY2D, bmp As BITMAP
Dim fraction As Long, sum As Long
Dim a, b As Integer
Dim x, y As Integer

    xMax = 0: yMax = 0
    ' get bitmap info
    GetObjectAPI picImage.Picture, Len(bmp), bmp 'dest
     
    ' exit if not a supported bitmap
    If bmp.bmBitsPixel <> 8 Then
        MsgBox " 8-bit bitmaps only", vbCritical
        Exit Function
    End If
       
    ' have the local matrix point to bitmap pixels
    With sa
        .cbElements = 1
        .cDims = 2
        .Bounds(0).lLbound = 0
        .Bounds(0).cElements = bmp.bmHeight
        .Bounds(1).lLbound = 0
        .Bounds(1).cElements = bmp.bmWidthBytes
        .pvData = bmp.bmBits
    End With
    CopyMemory ByVal VarPtrArray(pict), VarPtr(sa), 4
        
   ' Do Thinning 254 = white, 0 = black
 
    yMax = UBound(pict, 2)
    xMax = UBound(pict, 1)
   ' set top and buttom to 0
    For x = 0 To xMax
       pict(x, 0) = 0
       pict(x, yMax) = 0
    Next x
    ' set left and right to 0
    For y = 0 To yMax
        pict(0, y) = 0
        pict(xMax, y) = 0
    Next y
   
    a = 0: b = 0
    
     Do While (a = 0) And (b = 0)
        For x = 1 To xMax
           For y = 1 To yMax
           If pict(x, y) = 254 Then
                temp_image(x, y) = 254
                temp_image(x, y) = Str(condition_1(x, y, pict))
             End If
             Next y
        Next x
        
     a = restorage(pict, temp_image)
     
         For x = 1 To xMax
            For y = 1 To yMax
            If pict(x, y) = 254 Then
                 temp_image(x, y) = 254
                 temp_image(x, y) = Str(condition_2(x, y, pict))
             End If
             Next y
        Next x
        
     b = restorage(pict, temp_image)
    
     Loop
     ' End while loop
    
    ' clear the temporary array descriptor
    ' without destroying the local temporary array
    CopyMemory ByVal VarPtrArray(pict), 0&, 4
  
    ThinFilter = True

End Function

'--------------- Extracting image ---------------
Public Sub Post_Pro(ByVal rule As Integer)
Dim x, y As Integer
Dim NumX_block, NumY_block, j, i, EPCount, BPCount As Integer

'Rule:1 เอาจุด BP และ EP ที่อยู่ใน block  ริมขอบรูปออกก่อน
If rule = 1 Then
    For x = 0 To xMax
        For y = 0 To 4
            extracted(x, y) = 0
        Next y
    Next x
    For x = 0 To xMax
        For y = yMax - 4 To yMax
            extracted(x, y) = 0
        Next y
    Next x
    For x = 0 To 4
        For y = 0 To yMax
            extracted(x, y) = 0
        Next y
    Next x
    For x = xMax - 4 To xMax
        For y = 0 To yMax
            extracted(x, y) = 0
        Next y
    Next x
'End If

'If RideWidth >= 5 And rule <> 1 Then
'Rule 2: EP อยู่ในขอบเขต RideWidth ที่ กำหนด ให้ลบออก ให้หมด
ElseIf rule = 2 Then
    For x = RideWidth To xMax - RideWidth
        For y = RideWidth To yMax - RideWidth
        EPCount = 0
            If extracted(x, y) = EP Then
                For i = x To x + (RideWidth)
                    For j = y + 1 To y + (RideWidth)
                        If extracted(i, j) = EP Then
                            EPCount = EPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                For i = x To x - (RideWidth) Step -1
                    For j = y - 1 To y - (RideWidth) Step -1
                        If extracted(i, j) = EP Then
                            EPCount = EPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                For i = x - 1 To x - (RideWidth) Step -1
                    For j = y To y + (RideWidth)
                        If extracted(i, j) = EP Then
                            EPCount = EPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                For i = x + 1 To x + (RideWidth)
                    For j = y To y - (RideWidth) Step -1
                        If extracted(i, j) = EP Then
                            EPCount = EPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                If EPCount > 0 Then
                    extracted(x, y) = 0
                End If
            End If
        Next y
    Next x
'End If

'Rule 3:ถ้า BP อยู่ในขอบเขต RideWidth เดียวกัน  ก็ให้ลบ BP นั้นทิ้งออกไป
ElseIf rule = 3 Then
    For x = RideWidth To xMax - RideWidth
        For y = RideWidth To yMax - RideWidth
        BPCount = 0
            If extracted(x, y) = BP Then
                For i = x To x + (RideWidth)
                    For j = y + 1 To y + (RideWidth)
                        If BP = extracted(i, j) Then
                            BPCount = BPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                For i = x To x - (RideWidth) Step -1
                    For j = y - 1 To y - (RideWidth) Step -1
                        If BP = extracted(i, j) Then
                            BPCount = BPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                For i = x - 1 To x - (RideWidth) Step -1
                    For j = y To y + (RideWidth)
                        If BP = extracted(i, j) Then
                            BPCount = BPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                For i = x + 1 To x + (RideWidth)
                    For j = y To y - (RideWidth) Step -1
                        If BP = extracted(i, j) Then
                            BPCount = BPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                If BPCount > 0 Then
                    extracted(x, y) = 0
                End If
            End If
        Next y
    Next x
'End If

'Rule 4:จุด BP และ EP ใด ๆ ที่อยู่ในขอบเขตเดียวกัน ก็ให้ตัดทิ้งไปทั้งคู่
ElseIf rule = 4 Then
    For x = RideWidth To xMax - RideWidth
        For y = RideWidth To yMax - RideWidth
        EPCount = 0
            If extracted(x, y) = BP Then
                For i = x To x + (RideWidth)
                    For j = y + 1 To y + (RideWidth)
                        If extracted(i, j) = EP Then
                            EPCount = EPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                For i = x To x - (RideWidth) Step -1
                    For j = y - 1 To y - (RideWidth) Step -1
                        If extracted(i, j) = EP Then
                            EPCount = EPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                For i = x - 1 To x - (RideWidth) Step -1
                    For j = y To y + (RideWidth)
                        If extracted(i, j) = EP Then
                            EPCount = EPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                For i = x + 1 To x + (RideWidth)
                    For j = y To y - (RideWidth) Step -1
                        If extracted(i, j) = EP Then
                            EPCount = EPCount + 1
                            extracted(i, j) = 0
                        End If
                    Next j
                Next i
                
                If EPCount > 0 Then
                    extracted(x, y) = 0
                End If
            End If
        Next y
    Next x
End If
'Else
'   EPCount = MsgBox("ค่าต้องมากกว่าหรือเท่ากับ 5 ขึ้นไป", vbInformation, "ค่าผิด")
'End If
End Sub

Private Sub extraction(ByRef bit_thin() As Integer)
Dim x, y As Integer
Dim Cn, sum As Integer
'Dim ending(256) As Byte
'Dim temp1, temp2 As Integer
'temp1 = 0: temp2 = 0
For x = 1 To xMax - 1
    For y = 1 To yMax - 1
        If bit_thin(x, y) = 1 Then
        sum = 0
        sum = sum _
            + Abs(bit_thin(x + 1, y + 1) - bit_thin(x + 1, y)) _
            + Abs(bit_thin(x + 1, y) - bit_thin(x + 1, y - 1)) _
            + Abs(bit_thin(x + 1, y - 1) - bit_thin(x, y - 1)) _
            + Abs(bit_thin(x, y - 1) - bit_thin(x - 1, y - 1)) _
            + Abs(bit_thin(x - 1, y - 1) - bit_thin(x - 1, y)) _
            + Abs(bit_thin(x - 1, y) - bit_thin(x - 1, y + 1)) _
            + Abs(bit_thin(x - 1, y + 1) - bit_thin(x, y + 1)) _
            + Abs(bit_thin(x, y + 1) - bit_thin(x + 1, y + 1))
   
        If sum = 2 Then
            extracted(x, y) = EP
        ElseIf sum = 6 Then
            extracted(x, y) = BP
        Else
            extracted(x, y) = 0
        End If
        End If
    Next y
Next x
End Sub

Public Function ExtractFilter( _
        ByRef picImage As PictureBox) As Boolean
' these are used to address the pixel using matrices
Dim pict() As Byte
Dim sa As SAFEARRAY2D, bmp As BITMAP
Dim x, y As Integer
Dim i, j As Integer
    
    xMax = 0: yMax = 0
    ' get bitmap info
    GetObjectAPI picImage.Picture, Len(bmp), bmp 'dest
    
    ' exit if not a supported bitmap
    If bmp.bmBitsPixel <> 8 Then
        MsgBox " 8-bit bitmaps only", vbCritical
        Exit Function
    End If
       
    ' have the local matrix point to bitmap pixels
    With sa
        .cbElements = 1
        .cDims = 2
        .Bounds(0).lLbound = 0
        .Bounds(0).cElements = bmp.bmHeight
        .Bounds(1).lLbound = 0
        .Bounds(1).cElements = bmp.bmWidthBytes
        .pvData = bmp.bmBits
    End With
    CopyMemory ByVal VarPtrArray(pict), VarPtr(sa), 4
        
    yMax = UBound(pict, 2)
    xMax = UBound(pict, 1)
    ' Do Extract 254 = white, 0 = black
    ' Convert image from 254 to 1
    For x = 0 To xMax
        For y = 0 To yMax
        If pict(x, y) = 254 Then
            thined(x, y) = 1
        Else
            thined(x, y) = 0
        End If
        Next y
    Next x
    
    ' Do extract algorithm
    Call extraction(thined)
    Call Post_Pro(1)
    For x = 0 To 256
        For y = 0 To 256
            Save_extract(x, y) = extracted(x, y)
        Next y
    Next x
    ' clear the temporary array descriptor
    ' without destroying the local temporary array
    CopyMemory ByVal VarPtrArray(pict), 0&, 4
    ExtractFilter = True
End Function


Public Function RideCount() As Integer
Dim counter As Integer
Dim i, j As Integer
counter = 0
    For i = 0 To xMax
        For j = 0 To yMax
            If (extracted(i, j) = EP) Or (extracted(i, j) = BP) Then
                counter = counter + 1
            End If
        Next j
    Next i
    RideCount = counter
End Function

Public Function AddFeature(ByVal x As Integer, ByVal y As Integer) As Boolean
Dim i, j, Xtmp, Ytmp As Integer
Dim Found As Boolean
Dim xNearest, yNearest As Integer
Dim counterX, counterY As Integer

xNearest = 7        ' for error +- 7 pixel
yNearest = 7
Found = False
Xtmp = x - 7
Ytmp = y - 7
For counterX = 0 To 14
For counterY = 0 To 14
    i = Xtmp + counterX
    j = Ytmp + counterY
    If i >= 0 And j >= 0 And i <= xMax And j <= yMax Then
        If i <> x Or j <> y Then
                If Save_extract(i, j) = EP Or Save_extract(i, j) = BP Then
                    Found = True
                    If Abs(i - x) <= xNearest Or Abs(j - y) <= yNearest Then ' for Nearest x,y point
                        xNearest = i
                        yNearest = j
                    End If
                End If
        End If
    End If
Next counterY
Next counterX
If Found Then
    extracted(xNearest, yNearest) = Save_extract(xNearest, yNearest)
End If
AddFeature = Found
End Function

Public Function SubFeature(ByVal x As Integer, ByVal y As Integer) As Boolean
Dim i, j, Xtmp, Ytmp As Integer
Dim Found As Boolean
Dim xNearest, yNearest As Integer
Dim counterX, counterY As Integer

xNearest = 7        ' for error +- 7 pixel
yNearest = 7
Found = False
Xtmp = x - 7
Ytmp = y - 7
For counterX = 0 To 14
For counterY = 0 To 14
i = Xtmp + counterX
j = Ytmp + counterY
    If i >= 0 And j >= 0 And i <= xMax And j <= yMax Then
           If i <> x Or j <> y Then
                If extracted(i, j) = EP Or extracted(i, j) = BP Then
                    Found = True
                    If Abs(i - x) <= xNearest Or Abs(j - y) <= yNearest Then ' for Nearest x,y point
                        xNearest = i
                        yNearest = j
                    End If
                End If
           End If
    End If
Next counterY
Next counterX
If Found Then
        extracted(xNearest, yNearest) = 0
End If
SubFeature = Found
End Function

Public Sub Undoextracted()
Dim i, j As Integer
    For i = 0 To xMax
        For j = 0 To yMax
            extracted(i, j) = Save_extract(i, j)
        Next j
    Next i
End Sub
