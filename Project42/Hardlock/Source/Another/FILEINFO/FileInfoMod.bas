Attribute VB_Name = "FileInfoMod"
'For contacting infomations, see other module

'Declarations:
Declare Function FindFirstFile Lib "kernel32" Alias "FindFirstFileA" (ByVal lpFileName As String, lpFindFileData As WIN32_FIND_DATA) As Long
Declare Function FindClose Lib "kernel32" (ByVal hFindFile As Long) As Long

Public Const FILE_ATTRIBUTE_READONLY = &H1
Public Const FILE_ATTRIBUTE_HIDDEN = &H2
Public Const FILE_ATTRIBUTE_SYSTEM = &H4
Public Const FILE_ATTRIBUTE_DIRECTORY = &H10
Public Const FILE_ATTRIBUTE_ARCHIVE = &H20
Public Const FILE_ATTRIBUTE_NORMAL = &H80
Public Const FILE_ATTRIBUTE_TEMPORARY = &H100
Public Const FILE_ATTRIBUTE_COMPRESSED = &H800

Type FILETIME
  LowDateTime          As Long
  HighDateTime         As Long
End Type
Type WIN32_FIND_DATA
  dwFileAttributes     As Long
  ftCreationTime       As FILETIME
  ftLastAccessTime     As FILETIME
  ftLastWriteTime      As FILETIME
  nFileSizeHigh        As Long
  nFileSizeLow         As Long
  dwReserved0          As Long
  dwReserved1          As Long
  cFileName            As String * 260  'MUST be set to 260
  cAlternate           As String * 14
End Type

Declare Function FileTimeToSystemTime Lib "kernel32" (lpFileTime As FILETIME, lpSystemTime As SYSTEMTIME) As Long

Type SYSTEMTIME
  wYear As Integer
  wMonth As Integer
  wDayOfWeek As Integer
  wDay As Integer
  wHour As Integer
  wMinute As Integer
  wSecond As Integer
  wMilliseconds As Integer
End Type
Public Function Findfile(strfilename As String) As WIN32_FIND_DATA
Dim Win32Data As WIN32_FIND_DATA
Dim plngFirstFileHwnd As Long
Dim plngRtn As Long

plngFirstFileHwnd = FindFirstFile(strfilename, Win32Data)   ' Get information of file using API call
If plngFirstFileHwnd = 0 Then
  Findfile.cFileName = "Error"                              ' If file was not found, return error as name
Else
  Findfile = Win32Data                                      ' Else return results
End If
plngRtn = FindClose(plngFirstFileHwnd)                      ' It is important that you close the handle for FindFirstFile
End Function

