Attribute VB_Name = "Utilities"
'===================================================================
'     Name: UTILS.BAS
'  Purpose: Library of utility functions for creating
'           Windows CGI programs
'    Notes: This library assumes that CGI32.BAS library is also
'           loaded with the project.
'
'        Date     Initials    Description
'      07/18/96     GSK       Author of this library
'
'===================================================================
Option Explicit

'---------------------------------------------------------------
'The following declarations are mainly associated with
'the template file (TF) processing portion of this library
'---------------------------------------------------------------

Const UTILS_MAX_RECORDSETS = 5  'Max# of recordsets a TF can use
Global UTILS_rsarray(1 To UTILS_MAX_RECORDSETS) As Recordset

'This library uses a database called UTILS.MDB whose path
'is specified through the following constant. The UTILS.MDB
'should be on the same disk drive on which the CGI program
'resides.

Const UTILS_DB_PATH = "\WEBSITE\LIB\UTILS.MDB"

Global UTILS_Error As Integer   'For returning error codes

Dim UTILS_db As Database        'Database object for UTILS.MDB

'===================================================================
' Sub UTILS_AddKeywordsToTempTable(rsSource As Recordset, KeywordDelimiters, rsDest As Recordset)
'
' Purpose: Creates a record in the given temp table (rsDest) for each
' keyword in the description field of the current record of the
' source recordset (rsSource)
'
' Inputs
' ------
' rsSource: A recordset containing an ID field and a text field named
'           KeywordField
' KeywordDelimiters: String containing the set of delimiter characters
' rsDest: Recordset representing the temp table, which must have two
'         fields named ID and Keyword
'
' Usage
' -------
' See: UTILS_IndexField procedure
'
' Notes
' -----
' - The data type of the ID field of the rsSource recordset must be
'   compatible with the ID field of the rsDest recordset.
' - The newline characters are automatically added to the set of
'   delimiter characters.
'
' Example:
' Inputs:
'   Current record of rsSource:
'      ID: 123
'      KeywordField: "Create Web-based applications using Windows-CGI."
'   KeywordDelimiters: ",.:;'""!#$[]{}()+-_"
' Results:
'   The following 7 new records added to the rsDest table:
'       ID         Keyword
'      ----        -------
'      123         Create
'      123         Web
'      123         based
'      123         applications
'      123         using
'      123         Windows
'      123         CGI
'===================================================================
'
Sub UTILS_AddKeywordsToTempTable(rsSource As Recordset, KeywordDelimiters, rsDest As Recordset)

  Dim Ch As String
  Dim KeyWord As String
  Dim length As Long
  Dim Start As Long
  Dim i As Long
  Dim Description
  Dim Delimiters
  
  On Error Resume Next
  'Add newline characters to delimiters
  Delimiters = KeywordDelimiters & Chr(13) & Chr(10)
  'Remove leading and trailing spaces from the keyword field
  Description = Trim(rsSource![KeywordField])
  length = Len(Description)
  'Separate Description into individual keywords and
  'add them to the temp table
  If length = 0 Then Exit Sub
  Start = 1
  For i = 1 To length
    Ch = Mid(Description, i, 1)
    If InStr(Delimiters, Ch) > 0 Then
      KeyWord = Trim(Mid(Description, Start, i - Start))
      If KeyWord <> "" And Not IsNull(KeyWord) Then
        rsDest.AddNew
        rsDest![ID] = rsSource![ID]
        rsDest![KeyWord] = KeyWord
        rsDest.Update
      End If
      Start = i + 1
    End If
  Next
  'Handle the last keyword
  If Start < i Then
    KeyWord = Trim(Mid(Description, Start, i - Start))
    If KeyWord <> "" And Not IsNull(KeyWord) Then
      rsDest.AddNew
      rsDest![ID] = rsSource![ID]
      rsDest![KeyWord] = KeyWord
      rsDest.Update
    End If
  End If

End Sub

'===================================================================
' Sub UTILS_IndexField(db As Database, rsSource As Recordset, KeywordsLinkTable, Delimiters)
'
' Purpose: Creates a word-index of the Description field of a given
' recordset
'
' Inputs
' ------
' db: Database where the word-index will be stored
' rsSource: Recordset whose field has to be indexed
' KeywordsLinkTable: Table that holds the link between the each record of
'   the source recordset and the words of the tblKeywords table
' Delimiters: String containing the set of delimiter characters
'
'
' Notes
' -----
' - The db database must contain the following three tables:
'   1. tblSYS_Keywords: Table that will hold the word-dictionary
'       KeywordID: AutoNumber (Primary Key)
'         Keyword: Text (50) (Indexed, No Duplicates)
'
'   2. tblTMP_Keywords_Text: Table that will temporarily hold the
'      link between the source table that has a Text type primary key
'      and the words to be indexed
'            ID: Text (50) \
'       Keyword: Text (50) / They both form the primary key.
'
'   3. tblTMP_Keywords_Numeric: Table that will temporarily hold the
'      link between the source table that has a Number type primary key
'      and the words to be indexed
'            ID: Number (long) \
'       Keyword: Text (50)     / They both form the primary key
'
'- This procedure automatically determines which temp table to use
'  and locks it while the words are being indexed.
'
'- This procedure quits with an error if it is unable to lock the
'  temp table.
'
'- This procedure automatically appends any new keywords to the
'  tblSYS_Keywords table. It does delete any existing keywords.
'
'- This procedure does not delete any existing records in the
'  keywords link table.
'
' Example
' -------
' Inputs:
'   Let's say rsSource has the following two records.
'       ID         Description
'      ----        -------
'      123         "Create Web-based applications using Windows-CGI"
'      124         "Learn How To Create Windows 95 Applications"
'
'   Let's say the keywords link table is named tblLNK_Keywords and is
'   currently empty.
'
'   Let's say tblSYS_Keywords contains the following records:
'    KeywordID     Keyword
'    ---------     -------
'       1          and
'       2          applications
'       3          based
'
'   Finally, let's say Delimiters = ",.:;'""!#$[]{}()+-_"
'
'Results:
'  After this procedure is done executing:
'  tblSYS_Keywords will have the following records:
'
'    KeywordID     Keyword
'    ---------     -------
'       1          and
'       2          applications
'       3          based
'       4          Create
'       5          Web
'       6          using
'       7          Windows
'       8          CGI
'       9          Learn
'      10          how
'      11          to
'      12          95
'
' Note: The order of the IDs may be different.
'
' tblLNK_Keywords (the link table) will have the following records:
'        ID        KeywordID
'    ---------     ---------
'       123           4
'       123           5
'       123           3
'       123           2
'       123           6
'       123           7
'       123           8
'       124           9
'       124          10
'       124          11
'       124           4
'       124           7
'       124          12
'       124           2
'===================================================================
'
Public Sub UTILS_IndexField(db As Database, rsSource As Recordset, KeywordsLinkTable, Delimiters)
  
  Dim TempKeywordTable
  Dim ErrValue As Integer
  Dim rsTemp As Recordset
  Dim i, SQL
  
  If rsSource.EOF Then Exit Sub
  'Determine which temp table to use based on the data type of the ID field
  Select Case rsSource![ID].type
    Case dbText
      TempKeywordTable = "tblTMP_Keywords_Text"
    Case dbByte, dbInteger, dbLong
      TempKeywordTable = "tblTMP_Keywords_Numeric"
  End Select
  'Try to lock the temp table
  On Error Resume Next
  For i = 1 To 15000
    Set rsTemp = db.OpenRecordset(TempKeywordTable, dbOpenDynaset, dbDenyWrite)
    If Err = 0 Then Exit For
    DoEvents
  Next
  ErrValue = Err
  If ErrValue <> 0 Then  'Cannot lock
    On Error GoTo 0
    Error ErrValue       'Return with error
  End If
  Do Until rsTemp.EOF    'Delete any existing records from the temp table
    rsTemp.Delete
    DoEvents
    rsTemp.MoveNext
  Loop
  'Add keywords to the temp table from each record of the source recordset
  Do Until rsSource.EOF
    UTILS_AddKeywordsToTempTable rsSource, Delimiters, rsTemp
    DoEvents
    rsSource.MoveNext
  Loop
  rsTemp.Close
  On Error GoTo 0
  'Insert new keywords into tblSYS_Keywords
  SQL = "INSERT INTO tblSYS_Keywords ( Keyword ) " & _
        "SELECT DISTINCT " & TempKeywordTable & ".Keyword " & _
        "FROM " & TempKeywordTable & " LEFT JOIN tblSYS_Keywords " & _
        "ON " & TempKeywordTable & ".Keyword = tblSYS_Keywords.Keyword " & _
        "WHERE (((tblSYS_Keywords.Keyword) Is Null));"
  db.Execute SQL, dbFailOnError
  
  'Add keywords and id combinations to the destination table
  SQL = "INSERT INTO " & KeywordsLinkTable & " ( ID, KeywordID ) " & _
        "SELECT DISTINCT " & TempKeywordTable & ".ID, " & _
        "tblSYS_Keywords.KeywordID FROM " & TempKeywordTable & _
        " LEFT JOIN tblSYS_Keywords ON " & TempKeywordTable & _
        ".Keyword = tblSYS_Keywords.Keyword;"
  db.Execute SQL
  
End Sub

'===================================================================
' Function Utils_GetParameter(ParameterString, ParameterNumber, Delimiter)
'
' Purpose: Gets the Nth parameter value from the given Parameter
'          string
'
' Inputs
' ------
' ParameterString: String from which the parameter has to be extracted
' ParameterNumber: Tells which parameter to extract
' Delimiter: Character used to separate the parameters
'
' Example
' -------
' Utils_GetParameter("This+is+a+string",2,"+") returns "is".
'
' Notes
' -----
' Returns Null if ParameterString is empty or if no matching
' parameter is found
'
'===================================================================
'
Function Utils_GetParameter(ParameterString, ParameterNumber, Delimiter)
  
  Dim EndPos
  Dim Start
  Dim i
  
  If ParameterString = "" Then
    Utils_GetParameter = Null
    Exit Function
  End If
  Start = 1
  For i = 2 To ParameterNumber
    Start = InStr(Start, ParameterString, Delimiter) + 1
    If Start = 1 Then
      Start = 0
      Exit For
    End If
  Next
  If Start = 0 Then
    Utils_GetParameter = Null
    Exit Function
  End If
  EndPos = InStr(Start, ParameterString, Delimiter)
  If EndPos = 0 Then
    Utils_GetParameter = Mid(ParameterString, Start)
  Else
    Utils_GetParameter = Mid(ParameterString, Start, EndPos - Start)
  End If
  
End Function


'===================================================================
' Function Utils_EmptyToNullField(FieldName As String) As Variant
'
' Purpose: Returns the value of a form field if it is not empty,
'          otherwise, returns null if field is empty or absent
'
' Inputs
' ------
' FieldName: Field whose value is to be returned
'
' Notes
' -----
' Uses the GetSmallField function of the CGI32.BAS module
'
'===================================================================
'
Function Utils_EmptyToNullField(FieldName As String) As Variant
  Dim value

  On Error Resume Next
  value = Trim(GetSmallField(FieldName))
  If value = "" Or Err <> 0 Then
    Utils_EmptyToNullField = Null
  Else
    Utils_EmptyToNullField = value
  End If

End Function



'===================================================================
' Function Utils_ConvertFromQueryString(StringValue As String)
'
' Purpose: Decodes a string encoded using this library's
'          Utils_ConvertToQueryString function and returns
'          that decoded value
' Inputs
' ------
' StringValue: String to be converted
'
' Example
' -------
' Utils_GetParameter("Decoded__String") returns "Decoded String".
'
' Notes
' -----
' Used for passing data through the Query String portion of a URL
'
'===================================================================
'
Function Utils_ConvertFromQueryString(StringValue As String)
  
  Dim ConvertedString As String

  'Convert Spaces to Underscores
  ConvertedString = Utils_ReplaceString(StringValue, "__", " ")
  ConvertedString = Utils_ReplaceString(ConvertedString, "''", """")
  Utils_ConvertFromQueryString = ConvertedString

End Function



'===================================================================
' Function Utils_ConvertToQueryString(StringValue As String)
'
' Purpose: Encodes a string so that it can be passed as a query
'          string parameter in a URL
' Inputs
' ------
' StringValue: String to be converted
'
' Example
' -------
' Utils_GetParameter("Decoded String") returns "Decoded__String".
'
' Notes
' -----
' - This encoding method is NOT the same as the standard URL encoding.
' - It uses two characters to encode a special character.
' - Currently it only encodes the ' ' and '"' characters.
'   You can add other special characters to this list.
'
'===================================================================
'
Function Utils_ConvertToQueryString(StringValue As String)
  Dim ConvertedString As String

  'Convert Spaces to Underscores
  ConvertedString = Utils_ReplaceString(StringValue, " ", "__")
  ConvertedString = Utils_ReplaceString(ConvertedString, """", "''")
  Utils_ConvertToQueryString = ConvertedString

End Function



'===================================================================
' Function Utils_ReplaceString(SourceString, A, B)
'
' Purpose: Replaces SubString A with Substring B in SourceString
'
' Inputs
' ------
' SourceString: String where replacements will occur
' A: Substring to replace
' B: Substring to replace with

' Example
' -------
' Utils_ReplaceString("abcdab","ab","c") returns "ccdc".
'
' Notes
' -----
' - All occurrences of A are replaced with B.
' - A and B do not have to be of the same length.
'
'===================================================================
'
Function Utils_ReplaceString(SourceString, A, B)
  
  Dim i As Integer
  Dim NumCharsToReplace As Integer
  Dim NumCharsReplacedBy As Integer
  Dim Result As String
  Dim StringToReplace As String
  Dim Replacement As String
  
  Result = CStr(SourceString)
  StringToReplace = CStr(A)
  Replacement = CStr(B)
  NumCharsToReplace = Len(StringToReplace)
  NumCharsReplacedBy = Len(Replacement)
  i = InStr(1, Result, StringToReplace)
  Do While i <> 0
    Result = Mid(Result, 1, i - 1) & Replacement + Mid(Result, i + NumCharsToReplace)
    i = i + NumCharsReplacedBy
    i = InStr(i, Result, StringToReplace)
  Loop
  Utils_ReplaceString = Result

End Function



'===================================================================
' Function Utils_ProcessFile(ByVal InputFileNum As Integer) As Variant
'
' Purpose: Processes a template file and returns the processed
'          output
'
' Inputs
' ------
' InputFileNum: File number representing the template file
'
' Notes
' -----
'
' - The template file must be opened in read mode before
'   calling this function.
' - The template file is always processed from the beginning.
'   If you do not want this feature, then comment out the Seek
'   statement in this function.
' - If any error occurs while reading a file, then returns the
'   an HTML formatted comment listing the error message. Also
'   sets the UTILS_Error variable to the appropriate error code.
' - The processing method is described in the UTILS_ProcessString
'   function.
'
'===================================================================
'
Public Function Utils_ProcessFile(ByVal InputFileNum As Integer) As Variant
  
  Const INPUT_PAST_EOF = 62
  
  Dim Char As String
  Dim OutputChars As String
  Dim TokenChars As String
  Dim TokenResult As Variant
  Dim NumCharsRead As Variant
  Dim ErrValue As Integer
  Dim ErrString As String
  Dim Result As String
  Dim TokenOutput As String
  Dim RecordsetNumber As Integer
  Dim MaxLoops As Variant
  Dim LoopCount As Variant
  
  On Error GoTo Err_Utils_ProcessFile
  
  UTILS_Error = 0
  Result = ""
  Seek #InputFileNum, 1
  TokenChars = Utils_InputUpto(InputFileNum, Chr(0), 0, Char, NumCharsRead)
  Result = Result + Utils_ProcessString(TokenChars, "`")

Exit_Utils_ProcessFile:
  On Error Resume Next
  If UTILS_Error <> 0 Then
    Result = Result & ErrString
  End If
  Utils_ProcessFile = Result
  
Err_Utils_ProcessFile:
  UTILS_Error = Err
  ErrString = "<!--Utils_ProcessFile: " & Error$ & " -->"
  Resume Exit_Utils_ProcessFile
End Function

'===================================================================
' Function Utils_InputUpto(ByVal FileNum As Integer, Delimiters As String, MaxCharacters As Long, MatchedDelimiter As String, NumCharsRead As Variant) As Variant
'
'
' Purpose: Reads a file until it finds one of the given
'          delimiters or if it reads specified number of
'          characters or if it reaches the end of file.
'          Returns the read portion as a string.
'
' Inputs
' ------
' FileNum: File number representing the input file
' Delimiters: String containing all the delimiter characters
' MaxCharacters: Maximum number of characters to be read
'
' Outputs
' -------
' MatchedDelimiter: Delimiter that was found when reading
'                   the file
' NumCharsRead: Number of characters that were actually read
'
' Notes
' -----
'
' - To read the entire text file, specify Chr(0) as the delimiter.
'
'===================================================================
'
Public Function Utils_InputUpto(ByVal FileNum As Integer, Delimiters As String, MaxCharacters As Long, MatchedDelimiter As String, NumCharsRead As Variant) As Variant
  Dim Char As String
  Dim Done
  Dim Result As Variant
  
  NumCharsRead = 0
  Result = ""
  MatchedDelimiter = ""
  Done = EOF(FileNum)
  Do While Not Done
    Char = Input(1, #FileNum)
    NumCharsRead = NumCharsRead + 1
    If InStr(Delimiters, Char) > 0 Then
      MatchedDelimiter = Char
      Done = True
    Else
      Result = Result + Char
    End If
    If EOF(FileNum) Then Done = True
    If NumCharsRead = MaxCharacters Then Done = True
  Loop
  Utils_InputUpto = Result
End Function

'===================================================================
' Function Utils_Eval(TokenCharsToEval)
'
' Purpose: Processes a token string representing a valid expression.
'          The token string can include embedded variables/codes,
'          which are replaced with their current values before
'          computing the resulting expression.
'          Returns the processed string.
'
'          Some embedded codes actually represent an action
'          and an empty string is returned for those codes.
'
' Inputs
' ------
' TokenCharsToEval: String to process
'
' Examples
' -------_
' - Utils_Eval("1+2") returns 3
' - Utils_Eval("Search date = " & [F:SearchDate]) returns
'   "Search Date = 4/18/96" if there exists a form field named
'   SearchDate that currently has the value: "4/18/96". Note
'   that an embedded code/variable must be enclosed within
'   square brackets.
'
' Notes
' -----
' - If an error occurs while evaluating the expression, then an
'   HTML formatted comment listing the error message is returned.
' - This function uses the UTILS.MDB and an SQL statement to
'   evaluate the expression. Currently, no other easy alternative
'   seems to be available for this purpose.
'
' SYNTAX OF EMBEDDED CODES
' ------------------------
' All embedded codes are enclosed within square brackets and contain
' an instruction, a separator(: or .), and a parameter.
' Here are the types of things you can do through embedded codes:
'
' 1. Access form fields
'    Syntax: [F:fieldname] or [V:fieldname] where fieldname refers to
'            a form field
'    Examples: [F:SearchDate], [V:SearchDate]
'    Notes: The only difference between "F" and "V" instructions is
'           in what they return when the specified field
'           does not exist or contains an empty string as its value.
'           "F" returns a Null whereas "V" returns an empty string ("").
'
' 2. Access fields of a recordset
'    Syntax: [Rn:fieldname] where n is the recordset number and
'            fieldname refers to the name of a field in that
'            recordset
'    Example: [R1:JobID]
'    Notes: The recordset is assumed to be listed as the
'           nth element of the global array named UTILS_rsarray.
'
' 3. Change the current record of a recordset
'    Syntax: [Rn.movemethod] where n is the recordset number and
'            the movemethod can be: Next, Previous, First, or Last
'    Example:[R1.Next] to go to the next record of the first
'            recordset in the UTILS_rsarray array
'
' 4. Count the records in a recordset
'    Syntax: [Rn.Count] where n is the recordset number.
'    Example: [R1.Count]
'
' 5. Access the value of a CGI variable
'    Syntax: [C:variablename] where variablename refers to the name
'            of the CGI variable as declared in the CGI32.BAS library
'            without the "CGI_" prefix
'    Example: [C:ServerName] returns the value of CGI_ServerName
'
' 6. Access a query string parameter
'    Syntax: [Q:parameternumber] where parameternumber refers to the
'            position of the parameter in the query string
'    Example: [Q:2] returns 15 if CGI_QueryString contains "4+15+test"
'    Notes: The "+" character is assumed to be the parameter
'           separator character.
'
' 7. Return the contents of a file name
'    Syntax: [I:absolutefilepath] where absolutefilepath refers to the
'            absolute path of file whose contents are to be returned.
'    Example: [I:C:\WEBSITE\HTDOCS\TEST\TEST.HTM]
'    Notes: This code must be used by itself. It cannot be part of an
'           expression.
'           For example, "A" & [I:C:\WEBSITE\HTDOCS\TEST\TEST.HTM] will
'           just return the contents of the TEST.HTM file.
'===================================================================
'
Public Function Utils_Eval(TokenCharsToEval)

  Dim TokenChars, TokenLength
  Dim Start, i, BeginMatchPos, EndMatchPos
  Dim Variable, VariableType, RecordsetNumber
  Dim FieldName As String, FieldValue
  Dim rs As Recordset
  Dim QuoteChar As String
  Dim FieldType As Integer
  Dim SQL As String
  Dim qd As QueryDef
  
  On Error GoTo Err_Utils_Eval
  
  TokenChars = Trim(TokenCharsToEval)
  TokenLength = Len(TokenChars)
  If TokenLength = 0 Then
    Utils_Eval = ""
    Exit Function
  End If
  Start = 1
  Do While True
    QuoteChar = ""
    BeginMatchPos = InStr(Start, TokenChars, "[")
    If BeginMatchPos <> 0 Then
      EndMatchPos = InStr(BeginMatchPos, TokenChars, "]")
      If EndMatchPos = 0 Then EndMatchPos = TokenLength
      Variable = Mid(TokenChars, BeginMatchPos, EndMatchPos - BeginMatchPos + 1)
      VariableType = Mid(Variable, 2, 1)
      Select Case VariableType
        Case "R"  'e.g. R1:FieldName
          Eval_RecordsetField Variable, FieldValue, QuoteChar
        Case "F", "C", "Q", "V"  'e.g. F:FieldName, C:CGIVariableName, Q:ParameterNumber, V:FieldName
          Eval_VariableField VariableType, Variable, FieldValue, QuoteChar
        Case "I" 'e.g: I:FilePath
          Eval_IncludeFile Variable, FieldValue
          Utils_Eval = FieldValue
          Exit Function
        Case Else
          Utils_Eval = "Cannot handle variable: " & Variable
          Exit Function
      End Select
      If Variable = TokenChars Then
        Utils_Eval = IIf(IsNull(FieldValue), "<!--Null-->", FieldValue)
        Exit Function
      End If
      If IsNull(FieldValue) Then
        FieldValue = "Null"
        QuoteChar = ""
      Else
        If QuoteChar = """" Then
          FieldValue = Utils_ReplaceString(FieldValue, QuoteChar, QuoteChar + QuoteChar)
        End If
        FieldValue = QuoteChar & FieldValue & QuoteChar
      End If
      TokenChars = Utils_ReplaceString(TokenChars, Variable, FieldValue)
      Start = BeginMatchPos
    Else
      'Go ahead and eval
      Utils_OpenDatabase
      SQL = "SELECT " & TokenChars & " As Result FROM DummyTable;"
      Set rs = UTILS_db.OpenRecordset(SQL)
      Utils_Eval = IIf(IsNull(rs!Result), "<!--NULL-->", rs!Result)
      rs.Close
      Exit Do
    End If
  Loop

Exit_Utils_Eval:
  Exit Function
  
Err_Utils_Eval:
  Utils_Eval = "<!--" & Error$ & "-->"
  UTILS_Error = True
  Resume Exit_Utils_Eval
End Function

'===================================================================
' Function Utils_GetCGIVariable(VariableName)
'
' Purpose: Returns the value of the specified CGI variable name
'
' Inputs
' ------
' VariableName: Name of the CGI variable
'
'===================================================================
'
Public Function Utils_GetCGIVariable(VariableName)

  Select Case VariableName
    Case "ServerSoftware"
      Utils_GetCGIVariable = CGI_ServerSoftware
    Case "ServerName"
      Utils_GetCGIVariable = CGI_ServerName
    Case "ServerPort"
      Utils_GetCGIVariable = CGI_ServerPort
    Case "RequestProtocol"
      Utils_GetCGIVariable = CGI_RequestProtocol
    Case "ServerAdmin"
      Utils_GetCGIVariable = CGI_ServerAdmin
    Case "Version"
      Utils_GetCGIVariable = CGI_Version
    Case "RequestMethod"
      Utils_GetCGIVariable = CGI_RequestMethod
    Case "RequestKeepAlive"
      Utils_GetCGIVariable = CGI_RequestKeepAlive
    Case "LogicalPath"
      Utils_GetCGIVariable = CGI_LogicalPath
    Case "PhysicalPath"
      Utils_GetCGIVariable = CGI_PhysicalPath
    Case "ExecutablePath"
      Utils_GetCGIVariable = CGI_ExecutablePath
    Case "QueryString"
      Utils_GetCGIVariable = CGI_QueryString
    Case "RequestRange"
      Utils_GetCGIVariable = CGI_RequestRange
    Case "Referer"
      Utils_GetCGIVariable = CGI_Referer
    Case "From"
      Utils_GetCGIVariable = CGI_From
    Case "UserAgent"
      Utils_GetCGIVariable = CGI_UserAgent
    Case "RemoteHost"
      Utils_GetCGIVariable = CGI_RemoteHost
    Case "RemoteAddr"
      Utils_GetCGIVariable = CGI_RemoteAddr
    Case "AuthUser"
      Utils_GetCGIVariable = CGI_AuthUser
    Case "AuthPass"
      Utils_GetCGIVariable = CGI_AuthPass
    Case "AuthType"
      Utils_GetCGIVariable = CGI_AuthType
    Case "AuthRealm"
      Utils_GetCGIVariable = CGI_AuthRealm
    Case "ContentType"
      Utils_GetCGIVariable = CGI_ContentType
    Case "ContentLength"
      Utils_GetCGIVariable = CGI_ContentLength
    Case Else
      Utils_GetCGIVariable = "<!-- Unknown CGI Variable Name: " & VariableName & " -->"
  End Select
  
End Function

'===================================================================
' Sub Utils_OpenDatabase()
'
' Purpose: Opens the UTILS.MDB database if it is not already open
'
'===================================================================
'
Public Sub Utils_OpenDatabase()
  
  Dim i
  
  On Error Resume Next
  i = UTILS_db.name
  If Err <> 0 Then
    Set UTILS_db = Workspaces(0).OpenDatabase(Left(App.Path, 2) & UTILS_DB_PATH)
  End If
  
End Sub

'===================================================================
' Function Utils_ProcessString(InputString As String, Delimiter As String)
'
' Purpose: Processes a string based on the embedded instructions and
'          returns the processed result. The embedded instructions
'          allow if/then conditions, loops, and variable assignments.
'          You can also evaluate expressions supported by the
'          UTILS_Eval function.
'
' Inputs
' ------
' InputString: String to process
' Delimiter : The character that represents the beginning of
'             an embedded instruction (normally "`" is used)
'
' Examples
' --------
' - Utils_ProcessString("Your IP is: `[C:RemoteAddr]`","`") returns
'   "Your IP is 127.0.0.1" if the CGI request was made from localhost.
' - Utils_ProcessString("`1+2` and `3+4` makes `1+2+3+4`","`")
'   returns "3 and 7 makes 10".
' - Utils_ProcessString("If `?^"0"^Non-zero^Zero^","`") returns
'    "If Zero". See below for the syntax of the if instruction.
'
' Notes
' -----
' - All embedded instructions must start with the delimiter
'   character.
' - All characters that are not parameters of any embedded
'   instruction are returned as is. So if the input string does
'   not contain any embedded instructions, then it will be returned as is.
'
' - See also the documentation of UTILS_Eval function.
'
' SYNTAX OF EMBEDDED INSTRUCTIONS
' -------------------------------
' All embedded instructions must start with the delimiter character.
'
' Here are the types of things you can do through embedded
' instructions:
'
' 1. Process expressions
'     Syntax: `expression`
'             where expression is a string that can be processed
'             by this module's UTILS_Eval function. See the
'             documentation of UTILS_Eval function for more details.
'    Example: `[F:SearchDate]` returns the current value of the
'             SearchDate form field
'
' 2. Assign variables as form fields
'     Syntax: `A:variablename=expression` where variablename refers
'             the name of the variable and expression represents a
'             valid string that can be processed by the UTILS_Eval
'             function
'    Example: `A:Path=[C:ExecutablePath]` creates a form field
'              named Path if it does not already exists and
'              assigns Path to the value of the CGI_ExecutablePath
'              variable
'       Notes: You can reassign a variable to different
'              expressions any number of times in the input string.
'
' 3. Process only selected section of a string based on a condition
'     Syntax: `?^condition^truesubstring^falsesubstring^ where
'             condition is an expression that is considered false if it
'             evaluates to "<!--Null-->", "", "0", 0, "False", or "No",
'             otherwise the condition is considered true.
'             If condition is true, then truesubstring is processed, else
'             falsesubstring is processed.
'    Example: `?^[F:Test]^Non-zero^Zero^ returns "Zero" if the
'             form field Test evaluates to one of the false
'             conditions, otherwise it returns "Non-zero".
'      Notes: You can create nested if conditions by using
'             different separator characters. For example, the
'             following returns the string "Positive":
'             `?^1>=0^ `?*1>0*Positive*Zero* ^Negative^
'                        |__________________|
'                   (Nested If using * as separator char)
'
' 4. Process loops based on a recordset
'     Syntax: `L|n,maxloops,stringtoprocess|
'             where n is the recordset number, maxloops is an
'             expression that indicates the number of iterations to
'             perform, and stringtoprocess is the string which will
'             be processed during each iteration
'   Example1: `L|1,3,<B>Rec#: </B>`[R1:ID]`|  returns
'             "<B>Rec# ID: </B>1<B>Rec# ID: </B>2<B>Rec# ID: </B>3"
'             if the first three records of recordset 1 have an ID
'             field with values 1, 2, and 3, respectively.
'   Example2: `L|1,EOF,<B>Rec#: </B>`[R1:ID]`| will process
'             the string for all records of recordset 1.
'      Notes: - Normally MaxLoops must evaluate to a numeric expression.
'               The only exception is the value EOF, which means, loop
'               till the end of the recordset.
'             - The recordset must be listed in the nth element of the
'               UTILS_rsarray array.
'             - After every iteration, the current record is set
'               to the next record in the recordset.
'             - In the string, you can refer to form field named
'               Index_Rn for determining the iteration number.
'               For example: `L|1,3,Index = `[F:Index_R1]` | will return
'               "Index = 1 Index = 2 Index = 3 "
'             - You can use different separator characters to
'               create nested loops.
'
' 4. Process loops using an index variable to simulate For/Next loops
'     Syntax: `N|variablename,maxloops,stringtoprocess|
'             where variablename is the name of the index variable
'             (stored as a form field), maxloops is a numeric
'             expression that indicates the number of iterations to
'             perform, and stringtoprocess is the string which will
'             be processed during each iteration
'    Example: `N|i,1+2,i = `[F:i]` |  returns
'             "i = 1 i = 2 i = 3"
'      Notes: - You can preassign the value of the index variable to a
'               starting value other than 1 using the assignment
'               instruction as shown in the following example:
'               "`A:i=5``N|i,7,i = `[F:i]` |" will return
'               "i = 5 i = 6 i = 7"
'             - You can use different separator characters to
'               create nested loops
'
'
'===================================================================
'
Public Function Utils_ProcessString(InputString As String, Delimiter As String)
  
  Dim StringToProcess As String
  Dim Char As String
  Dim FirstChar As String
  Dim OutputChars As String
  Dim TokenChars As String
  Dim TokenResult As Variant
  Dim NumCharsRead As Variant
  Dim ErrValue As Integer
  Dim ErrString As String
  Dim Result As String
  Dim ProcessChars As String
  Dim DelimiterChar As String
  
  On Error GoTo Err_Utils_ProcessString
  
  Result = ""
  StringToProcess = InputString
  UTILS_Error = 0
  Do While StringToProcess <> ""
    Char = ""
    OutputChars = ""
    OutputChars = Utils_ScanUpto(StringToProcess, Delimiter, 0, Char, NumCharsRead)
    StringToProcess = Mid(StringToProcess, NumCharsRead + 1)
    If StringToProcess <> "" Then
      FirstChar = Left(StringToProcess, 1)
      DelimiterChar = Mid(StringToProcess, 2, 1)
      ProcessChars = Utils_ScanUpto(Mid(StringToProcess, 3), DelimiterChar, 0, Char, NumCharsRead)
      Select Case FirstChar
        Case Delimiter
          OutputChars = OutputChars + Delimiter
          StringToProcess = Mid(StringToProcess, 2)
        Case "." 'Exit
          StringToProcess = ""
        Case "A" 'Handle assignment
          ProcessString_Assign StringToProcess, NumCharsRead, Delimiter
        Case "?" 'Handle if/then statement
          ProcessString_Condition StringToProcess, NumCharsRead, Delimiter, DelimiterChar
        Case "L" 'Handle recordset based loops
          ProcessString_LoopRecordset ProcessChars, StringToProcess, NumCharsRead, Delimiter
        Case "N" 'Handle index based loops
          ProcessString_LoopIndex ProcessChars, StringToProcess, NumCharsRead, Delimiter
        Case Else   'Handle direct expression
          TokenChars = Utils_ScanUpto(StringToProcess, Delimiter, 0, Char, NumCharsRead)
          StringToProcess = Mid(StringToProcess, NumCharsRead + 1)
          TokenResult = Utils_Eval(TokenChars)
          OutputChars = OutputChars & TokenResult
      End Select
    End If
    Result = Result + OutputChars
  Loop

Exit_Utils_ProcessString:
  On Error Resume Next
  If ErrValue <> 0 Then
    Result = Result + OutputChars + " --" & ErrString & "-- " + "<PRE>" + StringToProcess + "</PRE>"
  End If
  Utils_ProcessString = Result
  Exit Function
  
Err_Utils_ProcessString:
  ErrValue = Err
  ErrString = Error$
  Resume Exit_Utils_ProcessString

End Function

'===================================================================
' Function Utils_ScanUpto(InputString As String, Delimiters As String, MaxCharacters As Long, MatchedDelimiter As String, NumCharsRead As Variant)
'
' Purpose: Returns the leftmost portion of a string up to a matching
'          delimiter character or up to a specified number of
'          characters, whichever happens first.
'
' Inputs
' ------
' InputString: String to scan
' DelimiterChars: List of delimiter characters to match
' MaxCharacters: Maximum number of characters to return
'
' Outputs
' -------
' MatchedDelimiter: Delimiter that was matched
' NumCharsRead: Number of characters returned
'
' Example
' -------
' Utils_ScanUpto("This is a test"," .",0,MatchChar,NumChars) returns
'   "This" with MatchChar = " " and NumChars = 4.
'
' Notes
' -----
'
' - Setting MaxCharacters to 0 does not impose any max character limit.
'
'===================================================================
'
Public Function Utils_ScanUpto(InputString As String, Delimiters As String, MaxCharacters As Long, MatchedDelimiter As String, NumCharsRead As Variant)
  
  Dim Char As String
  Dim i, FoundPos
  
  NumCharsRead = 0
  MatchedDelimiter = ""
  For i = 1 To Len(Delimiters)
    Char = Mid(Delimiters, i, 1)
    FoundPos = InStr(InputString, Char)
    If FoundPos > 0 Then
      MatchedDelimiter = Char
      If MaxCharacters > 0 And FoundPos > MaxCharacters Then FoundPos = MaxCharacters + 1
      NumCharsRead = FoundPos
      Utils_ScanUpto = Left$(InputString, FoundPos - 1)
      Exit Function
    End If
  Next
  MatchedDelimiter = ""
  FoundPos = Len(InputString)
  If MaxCharacters > 0 And FoundPos > MaxCharacters Then FoundPos = MaxCharacters
  NumCharsRead = FoundPos
  Utils_ScanUpto = Left$(InputString, FoundPos)
  
End Function

'===================================================================
' Function Utils_DLookup(db As Database, FieldExpression, RecordSource, Criteria, PickRecord)
'
' Purpose: Looks up a value from a database record source
'
' Inputs
' ------
' db: Database object representing an open database
' FieldExpression: The expression or the field name whose value
'                  is to be returned
' Recordsource: Name of the table or query that acts as the
'               source of the records
' Criteria: A valid SQL criteria to filter the records from the
'           Recordsource
' PickRecord: Which record to look up from in case multiple matching
'             records are found. Options are: "First", "Last", and
'             "Random".
'
' Examples
' -------
' Utils_DLookup(db,"JobID","tblJB_JOBS","JobState = 'FL'", "First")
'   returns the JobID of the first job in table tblJB_JOBS whose
'   JobState field has a value of "FL".
' Utils_DLookup(db,"Trim([CompanyName])","tblJB_Companies", "", "Random")
'   returns a random company name from table tblJB_Companies after
'   applying the trim function.
'
' Notes
' -----
' - Works similarly to the DLookup function provided in Access.
'
'===================================================================
'
Public Function Utils_DLookup(db As Database, FieldExpression, RecordSource, Criteria, PickRecord)
  
'PickRecord = "First", "Last", "Random"
  
  Dim SQL
  Dim CriteriaClause
  Dim rs As Recordset
  Dim RecordNumber, i
  
  Utils_OpenDatabase
  CriteriaClause = ""
  If Criteria <> "" Then CriteriaClause = " WHERE " & Criteria
  SQL = "Select " & FieldExpression & " As LookupValue FROM " & RecordSource & CriteriaClause & ";"
  Set rs = db.OpenRecordset(SQL)
  If rs.EOF Then
    Utils_DLookup = Null
  Else
    Select Case PickRecord
      Case "First"
      Case "Last"
        rs.MoveLast
      Case "Random"
        rs.MoveLast
        Randomize
        RecordNumber = Int(rs.RecordCount * Rnd)    ' Generate random value between 0 and RecordCount - 1.
        rs.MoveFirst
        For i = 1 To RecordNumber
          rs.MoveNext
        Next
    End Select
    Utils_DLookup = rs!LookupValue
  End If
  rs.Close

End Function

'===================================================================
' Function Utils_GetQueryParameter(ParameterNumber, Delimiter)
'
' Purpose: Returns the specified query parameter from the CGI query
'          string
'
' Inputs
' ------
' ParameterNumber: Which position of the parameter to be extracted
' Delimiter: The character that separates the parameters
'
'===================================================================
'
Public Function Utils_GetQueryParameter(ParameterNumber, Delimiter)
  Utils_GetQueryParameter = Utils_GetParameter(CGI_QueryString, ParameterNumber, Delimiter)
End Function

'===================================================================
' Sub Utils_AddField(FieldName, FieldValue)
'
' Purpose: Adds a fieldname/fieldvalue tuple to the list of
'          form fields
'
' Inputs
' ------
' FieldName: The name of the field to add
' FieldValue: Value of the field name
'
' Notes
' -----
' - Does not check for duplicate fields
'
'===================================================================
'
Public Sub Utils_AddField(FieldName, FieldValue)
  CGI_FormTuples(CGI_NumFormTuples).key = FieldName
  CGI_FormTuples(CGI_NumFormTuples).value = FieldValue
  CGI_NumFormTuples = CGI_NumFormTuples + 1
End Sub

'===================================================================
' Function Utils_Min(Value1, Value2)
' Purpose: Returns the minimum of two values
'
' Inputs
' ------
' Value1: First value (Variant)
' Value2: Second Value (Variant)
'
' Notes
' -----
' - Assumes values to be of the same types
'
'===================================================================
'
Public Function Utils_Min(Value1, Value2)
  If Value1 < Value2 Then
    Utils_Min = Value1
  Else
    Utils_Min = Value2
  End If
End Function

'===================================================================
' Function Utils_Max(Value1, Value2)
'
' Purpose: Returns the maximum of two values
'
' Inputs
' ------
' Value1: First value (Variant)
' Value2: Second Value (Variant)
'
' Notes
' -----
' - Assumes values to be of the same types
'
'===================================================================
'
Public Function Utils_Max(Value1, Value2)
  
  If Value1 > Value2 Then
    Utils_Max = Value1
  Else
    Utils_Max = Value2
  End If

End Function

'===================================================================
' Private Sub Eval_RecordsetField(Variable, FieldValue, QuoteChar)
'
' Purpose: Subprocedure of UTILS_Eval function for evaluating
'          a recordset based code
' Inputs
' ------
' Variable: The code to evaluate
'
' Outputs
' FieldValue: Current Value of the variable
' QuoteChar: " for text type variable, # for date type, and none for numeric
'
' Notes
' -----
' - Assumes values to be of the same types
'
'===================================================================
'
Private Sub Eval_RecordsetField(Variable, FieldValue, QuoteChar)
  Dim FieldName As String
  Dim Operation
  Dim RecordsetNumber
  Dim CurrentBM As String
  Dim FieldType
  Dim FieldNumber As Integer
  
  RecordsetNumber = Mid(Variable, 3, 1)
  Operation = Mid(Variable, 4, 1)
  FieldName = Mid(Variable, 5, Len(Variable) - 5)
  Select Case Operation
    Case "."
      FieldValue = ""
      Select Case FieldName
        Case "Next"
          UTILS_rsarray(RecordsetNumber).MoveNext
        Case "Previous"
          UTILS_rsarray(RecordsetNumber).MovePrevious
        Case "First"
          UTILS_rsarray(RecordsetNumber).MoveFirst
        Case "Last"
          UTILS_rsarray(RecordsetNumber).MoveLast
        Case "Count"
          FieldValue = UTILS_rsarray(RecordsetNumber).RecordCount
          If FieldValue > 0 And Not UTILS_rsarray(RecordsetNumber).EOF Then
            CurrentBM = UTILS_rsarray(RecordsetNumber).Bookmark
            UTILS_rsarray(RecordsetNumber).MoveLast
            FieldValue = UTILS_rsarray(RecordsetNumber).RecordCount
            UTILS_rsarray(RecordsetNumber).Bookmark = CurrentBM
          End If
        Case "EOF"
          FieldValue = UTILS_rsarray(RecordsetNumber).EOF
        Case "BOF"
          FieldValue = UTILS_rsarray(RecordsetNumber).BOF
      End Select
    Case Else
      If Operation = "/" Then
        FieldNumber = Utils_EmptyToNullField(FieldName)
        FieldType = UTILS_rsarray(RecordsetNumber)(FieldNumber).type
        FieldValue = UTILS_rsarray(RecordsetNumber)(FieldNumber)
      Else
        FieldType = UTILS_rsarray(RecordsetNumber)(FieldName).type
        FieldValue = UTILS_rsarray(RecordsetNumber)(FieldName)
      End If
      Select Case FieldType
        Case dbDate
          QuoteChar = "#"
        Case dbText, dbMemo
          QuoteChar = """"
      End Select
    End Select
End Sub
'===================================================================
' Private Sub Eval_VariableField(VariableType, Variable, FieldValue, QuoteChar)
'
' Purpose: Subprocedure of UTILS_Eval function for evaluating
'          a variable based code
' Inputs
' ------
' VariableType: The type of variable to evaluate: F,C,Q, or V
' Variable: The code to evaluate
'
' Outputs
' FieldValue: Current Value of the variable
' QuoteChar: " for text type variable, # for date type, and none for numeric
'
' Notes
' -----
' - Assumes values to be of the same types
'
'===================================================================
'
Private Sub Eval_VariableField(VariableType, Variable, FieldValue, QuoteChar)
  Dim FieldName As String
  Dim Operation
  Dim RecordsetNumber
  Dim CurrentBM As String
  Dim FieldType
          
  FieldName = Mid(Variable, 4, Len(Variable) - 4)
  Select Case VariableType
    Case "F", "V"
      FieldValue = Utils_EmptyToNullField(FieldName)
    Case "C"
      FieldValue = Utils_GetCGIVariable(FieldName)
    Case "Q"
      FieldValue = Utils_GetQueryParameter(Val(FieldName), "+")
  End Select
  If VariableType = "V" And IsNull(FieldValue) Then
    FieldValue = ""
  End If
  QuoteChar = """"
  If IsNumeric(FieldValue) Then
    QuoteChar = ""
  Else
    If IsDate(FieldValue) Then QuoteChar = "#"
  End If

End Sub

'===================================================================
' Private Sub Eval_IncludeFile(Variable, FieldValue)
'
' Purpose: Subprocedure of UTILS_Eval function for including the
'          contents of an external file
' Inputs
' ------
' Variable: The path and name of the file to be included
'
' Outputs
' FieldValue: The contents of the specified file
'
'===================================================================
'
Private Sub Eval_IncludeFile(Variable, FieldValue)
  
  Dim FilePath As String
  Dim FN As Integer
  Dim MatchedDelimiter As String
  Dim NumCharsRead
          
  FilePath = Mid(Variable, 4, Len(Variable) - 4)
  FN = FreeFile
  Open FilePath For Input Access Read As #FN
  FieldValue = Utils_InputUpto(FN, Chr(0), 0, MatchedDelimiter, NumCharsRead)
  Close #FN
  
End Sub

'===================================================================
' Function Utils_AcquireField(FieldName As String, QueryParameterNumber)
'
' Purpose: Returns the value of a given field based on the request
'          method CGI variable
'
' Inputs
' ------
' FieldName: Name of the field whose value has to be returned
' QueryParameterNumber: Position of the field in the query string for
'                       a get type request
'
' Notes
' -----
' - This procedure comes in handy when you sometimes pass a parameter
'   in the query string portion of a GET request or as a form field in
'   a POST request.
'
' - If the Request Method is POST, then this procedure simply returns the
'   value of the specified form field.
'
' - If the Request Method is GET, then this procedure does two things:
'      o returns the decoded value of the query string parameter whose
'        position is specified by the QueryParameterNumber
'      o Assigns the returned value to a form field with the specified
'        FieldName
'
' This procedure also creates another form field named [FieldName]_Coded,
' that contains the returned value in the encoded form.
'
' The encoding and decoding is done using the Utils_ConvertToQueryString
' and Utils_ConvertFromQueryString functions.
'
'===================================================================
'
Public Function Utils_AcquireField(FieldName As String, QueryParameterNumber)
  
  Dim FieldValue
  Dim CodedFieldValue
  
  CGI_RequestMethod = UCase$(CGI_RequestMethod)
  If CGI_RequestMethod = "POST" Then
    FieldValue = Utils_EmptyToNullField(FieldName)
    If IsNull(FieldValue) Then
      Utils_AssignField FieldName & "_Coded", ""
    Else
      Utils_AssignField FieldName & "_Coded", Utils_ConvertToQueryString(CStr(FieldValue))
    End If
  Else
    CodedFieldValue = Utils_GetQueryParameter(QueryParameterNumber, "+")
    If Not IsNull(CodedFieldValue) Then
      FieldValue = Utils_ConvertFromQueryString(CStr(CodedFieldValue))
      Utils_AssignField FieldName, FieldValue
      Utils_AssignField FieldName & "_Coded", CodedFieldValue
    Else
      Utils_AssignField FieldName, ""
      Utils_AssignField FieldName & "_Coded", ""
      FieldValue = Null
    End If
  End If
  Utils_AcquireField = FieldValue

End Function

'===================================================================
' Sub Utils_AssignField(FieldName, value)
'
' Purpose: Assigns the given value to a form field with the specified
'          FieldName
' Inputs
' ------
' FieldName: Name of the form field
' value: Value to be assigned
'
' Notes:
' ------
' If the field with the given Field name does not exist, then this
' procedure creates a new field with that name.
'
'===================================================================
Public Sub Utils_AssignField(FieldName, value)
    
    Dim i As Integer
    Dim FieldValue

    FieldValue = value
    If IsNull(FieldValue) Then FieldValue = ""
    For i = 0 To (CGI_NumFormTuples - 1)
        If CGI_FormTuples(i).key = FieldName Then
          CGI_FormTuples(i).value = FieldValue
          Exit Sub
        End If
    Next i
    Utils_AddField FieldName, FieldValue
  
End Sub


'===================================================================
' Function Utils_GetShortFormField(FieldName As String) As Variant
'
' Purpose: Returns a value of a form field without any conversion
'
' Inputs
' ------
' FieldName: Name of the form field
'
'===================================================================
Public Function Utils_GetShortFormField(FieldName As String) As Variant
    
    Dim i As Integer

    For i = 0 To (CGI_NumFormTuples - 1)
        If CGI_FormTuples(i).key = FieldName Then
            Utils_GetShortFormField = CGI_FormTuples(i).value
            Exit Function           ' ** DONE **
        End If
    Next i
    Utils_GetShortFormField = Null

End Function

'===================================================================
' Sub Utils_LimitRecords(rs As Recordset, Start, Limit)
'
' Purpose: Sets the record at the Start position as the current record
'          of the given recordset. Also, computes several form fields
'          based on the number of records in the recordset and the
'          specified Start and Limit parameters.
'
' Inputs
' ------
' rs: The Recordset object
' Start: Position of the record that has to be set as the current record
' Limit: Maximum number of records to be returned from the current
'        recordset
'
' Notes:
' ------
' This procedure is useful when you want to return the selected records
' of the recordset in a sequence of multiple pages. For example, the first
' 10 records in the first page, the next 10 records in the second page,
' and so on.
'
' The way you achieve this sequence effect with this procedure is as
' follows:
'   1. When you send the first page as your CGI response, give a link
'      to return the second page. That link should contain two
'      parameters: 11 and 10.
'
'   2. When the user clicks this link, regenerate the recordset with all
'      the records and pass that recordset to this procedure with the
'      Start parameter set to 11 and the Limit parameter set to 10.
'
'   3. This procedure will automatically set the current record of your
'      recordset to the record at position 11. Additionally, it will
'      set the following internal form fields to help you create the
'      link for the next page (assuming the recordset contains 26 records):
'              FieldName            Value
'              ---------            -----
'            UTILS_LR_Start           11
'            UTILS_LR_End             20
'            UTILS_LR_Limit           10
'            UTILS_LR_CurrentLimit    10
'            UTILS_LR_PreviousStart    1
'            UTILS_LR_PreviousEnd     10
'            UTILS_LR_PreviousLimit   10
'            UTILS_LR_NextStart       21
'            UTILS_LR_NextEnd         26
'            UTILS_LR_NextLimit        6
'
'   4. You can use the values of the UTILS_LR_Start and UTILS_LR_End
'      fields to output records 11 to 20 using a For loop. You can
'      use the values of the UTILS_LR_NextStart and UTILS_LR_NextLimit
'      fields to set up a link for requesting the next page. You can
'      use the values of the UTILS_LR_PreviousStart and
'      UTILS_LR_PreviousLimit fields to set up a link for requesting the
'      previous page.
'
'===================================================================
Public Sub Utils_LimitRecords(rs As Recordset, Start, Limit)
  
  Const DEFAULT_RECORD_LIMIT = 10
  Dim StartRecord As Long
  Dim RecordLimit As Long
  Dim EndRecord As Long
  Dim NextRecordLimit As Long
  
  If rs.RecordCount = 0 Then Exit Sub
  StartRecord = 1
  RecordLimit = DEFAULT_RECORD_LIMIT
  If Not IsNull(Start) Then StartRecord = Start
  If Not IsNull(Limit) Then RecordLimit = Limit
  rs.MoveLast
  EndRecord = Utils_Min(StartRecord + RecordLimit - 1, rs.RecordCount)
  rs.MoveFirst
  rs.Move StartRecord - 1
    
  Utils_AddField "UTILS_LR_Start", StartRecord
  Utils_AddField "UTILS_LR_End", EndRecord
  Utils_AddField "UTILS_LR_Limit", RecordLimit
  Utils_AddField "UTILS_LR_CurrentLimit", EndRecord - StartRecord + 1
  
  Utils_AddField "UTILS_LR_PreviousStart", Utils_Min(StartRecord - RecordLimit, 0)
  Utils_AddField "UTILS_LR_PreviousEnd", Utils_Min(StartRecord - 1, 0)
  Utils_AddField "UTILS_LR_PreviousLimit", Utils_Min(StartRecord - 1, RecordLimit)
  
  Utils_AddField "UTILS_LR_NextStart", Utils_Min(EndRecord + 1, rs.RecordCount)
  Utils_AddField "UTILS_LR_NextEnd", Utils_Min(EndRecord + RecordLimit, rs.RecordCount)
  Utils_AddField "UTILS_LR_NextLimit", Utils_Min(rs.RecordCount - EndRecord, RecordLimit)
  
End Sub

'===================================================================
' Private Sub ProcessString_LoopRecordset(ProcessChars, StringToProcess, NumCharsRead, Delimiter)
'
' Purpose: Subprocedure of UTILS_ProcessString procedure for
'          processing a recordset-based loop instruction
'
' Inputs
' ------
' ProcessChars: Characters forming the loop instruction (up to the ending
'               delimiter character)
' StringToProcess: String left to be processed (the loop portion + the
'                  rest of the text in the template file)
' NumCharsRead: Length of ProcessChars
' Delimiter: The "`" character
'
' Outputs
' -------
' StringToProcess
'
' An example showing how the input parameters are related:
' StringToProcess:= "R@1,EOF,ABCDEF@GHIJKL"
' ProcessChars:= "1,EOF,ABCDEF@"
' NumCharsRead:= 13 or Len(ProcessChars)
' Delimiter:= "`"
'
' Result StringToProcess after the procedure gets done
' If another loop iteration is left, then
'    StringToProcess:= "ABCDEF`R@1,EOF,ABCDEF@GHIJKL"
' If this was the last loop iteration, then
'    StringToProcess:= "ABCDEFGHIJKL"
'
' Notes:
' This procedure uses internal form fields to maintain the state
' of the loop between iterations.
'
'===================================================================
'
Private Sub ProcessString_LoopRecordset(ProcessChars, StringToProcess, NumCharsRead, Delimiter)
  
  Dim RecordsetNumber As Variant
  Dim MaxLoops As Variant
  Dim i As Variant
  Dim TokenChars As String
  Dim FieldName As String
  Dim FieldNameMax As String
  Dim Char As String
  Dim CharsRead As Long
  
  TokenChars = ProcessChars
  'Get the recordset number used for this loop
  RecordsetNumber = CInt(Utils_ScanUpto(TokenChars, ",", 0, Char, CharsRead))
  'Get the loop termination limit
  TokenChars = Mid(TokenChars, CharsRead + 1)
  MaxLoops = Utils_ScanUpto(TokenChars, ",", 0, Char, CharsRead)
  'Get the text to iterate on
  TokenChars = Mid(TokenChars, CharsRead + 1)
  'Determine the internal form field used by this loop
  FieldName = "Index_R" & RecordsetNumber
  'The following field holds the loop termination limit
  FieldNameMax = FieldName & "_Max"
  'Get the current value of loop index form field
  i = Utils_EmptyToNullField(FieldName)
  If IsNull(i) Then 'Loop has just started (1st iteration)
    'Determine loop termination limit from the input string
    i = 1
    If MaxLoops = "EOF" Then
      MaxLoops = 2147483647
    Else
      MaxLoops = Utils_Eval(MaxLoops)
    End If
    'Assign loop termination limit to a form field. The future
    'iterations will refer to this field to determine the loop limit
    Utils_AssignField FieldNameMax, MaxLoops
  Else 'This is not the first iteration of this loop
    i = i + 1
    UTILS_rsarray(RecordsetNumber).MoveNext  'Move to the next record
    'Get loop termination limit from the form field
    MaxLoops = CLng(Utils_EmptyToNullField(FieldNameMax))
  End If
  'Store the current value of the loop index into the form field for
  'future reference
  Utils_AssignField FieldName, i
  If Not UTILS_rsarray(RecordsetNumber).EOF And i <= MaxLoops Then
    'Loop has still more iterations to go
    StringToProcess = TokenChars & Delimiter & StringToProcess
  Else
    'This was the last iteration
    StringToProcess = Mid(StringToProcess, NumCharsRead + 3)
    'Make the loop index form field empty so that another
    'recordset-based loop instruction can work properly
    Utils_AssignField FieldName, ""
  End If

End Sub

'===================================================================
' Private Sub ProcessString_LoopIndex(ProcessChars, StringToProcess, NumCharsRead, Delimiter)
'
' Purpose: Subprocedure of UTILS_ProcessString procedure for
'          processing an index-based loop instruction
'
' Inputs
' ------
' ProcessChars: Characters forming the loop instruction (up to the ending
'               delimiter character)
' StringToProcess: String left to be processed (the loop portion + the
'                  rest of the text in the template file)
' NumCharsRead: Length of ProcessChars
' Delimiter: The "`" character
'
' Outputs
' -------
' StringToProcess
'
' An example showing how the input parameters are related:
' StringToProcess:= "N@i,5,ABCDEF@GHIJKL"
' ProcessChars:= "i,5,ABCDEF@"
' NumCharsRead:= 11 or Len(ProcessChars)
' Delimiter:= "`"
'
' Result StringToProcess after the procedure gets done
' If another loop iteration is left, then
'    StringToProcess:= "ABCDEF`N@i,5,ABCDEF@GHIJKL"
' If this was the last loop iteration, then
'    StringToProcess:= "ABCDEFGHIJKL"
'
'===================================================================
'
Private Sub ProcessString_LoopIndex(ProcessChars, StringToProcess, NumCharsRead, Delimiter)
  
  Dim MaxLoops As Variant
  Dim i As Variant
  Dim TokenChars As String
  Dim FieldName As String
  Dim FieldNameMax As String
  Dim Char As String
  Dim CharsRead As Long
  Dim PreviousMaxLoops As Variant
  
  TokenChars = ProcessChars
  'Get the name of the loop index field
  FieldName = Utils_ScanUpto(TokenChars, ",", 0, Char, CharsRead)
  'Get loop termination limit
  TokenChars = Mid(TokenChars, CharsRead + 1)
  MaxLoops = Utils_ScanUpto(TokenChars, ",", 0, Char, CharsRead)
  'Get the text to iterate on
  TokenChars = Mid(TokenChars, CharsRead + 1)
  'Determine the name of the form field that may hold the
  'loop termination limit
  FieldNameMax = FieldName & "_Max"
  'Get current value of the loop index field to determine which
  'iteration is being processed
  i = Utils_EmptyToNullField(FieldName)
  'Check if any loop termination limit has already been set by the
  'previous iteration
  PreviousMaxLoops = Utils_EmptyToNullField(FieldNameMax)
  If IsNull(PreviousMaxLoops) Then 'This is the first iteration
    MaxLoops = Utils_Eval(MaxLoops)  'Evaluate loop termination limit
    'Assign this limit to the form field for future reference
    Utils_AssignField FieldNameMax, MaxLoops
  Else 'This is not the first iteration
    'Get the termination limit from the form field
    MaxLoops = PreviousMaxLoops
  End If
  'Set or increment the loop index
  If IsNull(i) Then
    i = 1
  Else
    i = i + 1
  End If
  'Assign current index value to the loop index field
  Utils_AssignField FieldName, i
  MaxLoops = CLng(MaxLoops)
  If UTILS_Error = 0 And i <= MaxLoops Then 'Not the last iteration
    StringToProcess = TokenChars & Delimiter & StringToProcess
  Else 'Last iteration
    StringToProcess = Mid(StringToProcess, NumCharsRead + 3)
    Utils_AssignField FieldName, ""
    UTILS_Error = 0
  End If
  
End Sub

'===================================================================
' Sub ProcessString_Condition(StringToProcess As String, NumCharsRead, Delimiter, DelimiterChar As String)
'
' Purpose: Subprocedure of UTILS_ProcessString function for
'          processing a condition
'
' Inputs
' ------
' DelimiterChar: Delimiter character used for the condition, generally (^)
'
' Inputs and Outputs
' -------------------
' StringToProcess: Text left to be processed
' NumCharsRead: Number of characters read till the next occurrence of
'               the delimiter char
' Delimiter: The main delimiter character (`)
'
' Notes
' -----
' - Condition is considered false if it evaluates to "<!--Null-->","",
'   "0","False", or "No", otherwise it is considered true
'
'===================================================================
'
Public Sub ProcessString_Condition(StringToProcess As String, NumCharsRead, Delimiter, DelimiterChar As String)
  
  Dim TokenChars As String
  Dim Condition As String
  Dim TrueExpression As String
  Dim FalseExpression As String
  Dim ConditionResult As String
  Dim Char As String
  Dim StoreError As Variant
  
  StringToProcess = Mid(StringToProcess, 3)
  Condition = Utils_ScanUpto(StringToProcess, DelimiterChar, 0, Char, NumCharsRead)
  StringToProcess = Mid(StringToProcess, NumCharsRead + 1)
  TrueExpression = Utils_ScanUpto(StringToProcess, DelimiterChar, 0, Char, NumCharsRead)
  StringToProcess = Mid(StringToProcess, NumCharsRead + 1)
  FalseExpression = Utils_ScanUpto(StringToProcess, DelimiterChar, 0, Char, NumCharsRead)
  StringToProcess = Mid(StringToProcess, NumCharsRead + 1)
  StoreError = UTILS_Error
  UTILS_Error = 0
  ConditionResult = CStr(Utils_Eval(Condition))
  If UTILS_Error <> 0 Then
    StringToProcess = ConditionResult & StringToProcess
  Else
    UTILS_Error = StoreError
    Select Case ConditionResult
      Case "<!--Null-->", "", "0", "False", "No"
        StringToProcess = FalseExpression & StringToProcess
      Case Else
        StringToProcess = TrueExpression & StringToProcess
    End Select
  End If
  
End Sub

'===================================================================
' Sub ProcessString_Assign(StringToProcess As String, NumCharsRead, Delimiter As String)
'
' Purpose: Subprocedure of UTILS_ProcessString function for
'          processing an assignment instruction
'
' Inputs and Outputs
' -------------------
' StringToProcess: Text left to be processed
' NumCharsRead: Number of characters read till the next occurrence of
'               the delimiter char
' Delimiter: The main delimiter character (`)
'===================================================================
'
Public Sub ProcessString_Assign(StringToProcess As String, NumCharsRead, Delimiter As String)
  
  Dim Char As String
  Dim TokenChars As String
  Dim TokenResult As Variant
  Dim FieldName As String
         
  'Get the name of the form field to assign
  TokenChars = Utils_ScanUpto(StringToProcess, "=", 0, Char, NumCharsRead)
  FieldName = Mid(TokenChars, 3)
  'Read the expression whose result has to be assigned to this field
  StringToProcess = Mid(StringToProcess, NumCharsRead + 1)
  TokenChars = Utils_ScanUpto(StringToProcess, Delimiter, 0, Char, NumCharsRead)
  'Remove this assignment statement from the StringToProcess variable
  StringToProcess = Mid(StringToProcess, NumCharsRead + 1)
  'Evaluate the expression
  TokenResult = Utils_Eval(TokenChars)
  'Store the expression result in the specified field name
  Utils_AssignField FieldName, TokenResult

End Sub

'===================================================================
' Function UTILS_GetKeyword(KeywordString, KeywordDelimiters, KeywordNumber)
'
' Purpose: Returns the specified keyword from the KeywordString based on
' specified set of keyword delimiters
'
' Inputs
' ------
' KeywordString: String containing a list of keywords
' KeywordDelimiters: String containing the set of delimiter characters
' KeywordNumber: The position of the keyword being sought
'
' Example:
' UTILS_GetKeyword(" Word1 Word2 Word3"," .;:",2) returns Word2
' UTILS_GetKeyword(" Word1 Word2 Word3"," .;:",4) returns Null
'
' Notes:
' Returns Null if no keyword found for the specified position
'
'===================================================================
'
Public Function UTILS_GetKeyword(KeywordString, KeywordDelimiters, KeywordNumber)
  Dim Ch As String
  Dim KeyWord As String
  Dim length As Long
  Dim Start As Long
  Dim i As Long
  Dim Description
  Dim Delimiters
  Dim CurrentKeywordNumber
  
  CurrentKeywordNumber = 0
  UTILS_GetKeyword = Null
  Delimiters = KeywordDelimiters & Chr(13) & Chr(10)
  Description = Trim(KeywordString)
  length = Len(Description)
  If length = 0 Then Exit Function
  Start = 1
  For i = 1 To length
    Ch = Mid(Description, i, 1)
    If InStr(Delimiters, Ch) > 0 Then
      KeyWord = Trim(Mid(Description, Start, i - Start))
      If KeyWord <> "" And Not IsNull(KeyWord) Then
        CurrentKeywordNumber = CurrentKeywordNumber + 1
        If CurrentKeywordNumber = KeywordNumber Then
          UTILS_GetKeyword = KeyWord
          Exit Function
        End If
      End If
      Start = i + 1
    End If
  Next
  If Start < i Then
    KeyWord = Trim(Mid(Description, Start, i - Start))
    If KeyWord <> "" And Not IsNull(KeyWord) Then
        CurrentKeywordNumber = CurrentKeywordNumber + 1
        If CurrentKeywordNumber = KeywordNumber Then
          UTILS_GetKeyword = KeyWord
          Exit Function
        End If
    End If
  End If

End Function


