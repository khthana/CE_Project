VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "FilesOperations"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit
'API nécessaire pour le mode "toujours visible"
' hwnd : handle de la fenêtre à metre toujours visible
' hWndInsertAfter : mettre -1 pour que la fenêtre soit toujours visible, -2 sinon
' wFlags : mettre &H2 Or &H1 Or &H40 Or &H10
Private Declare Function SetWindowPos Lib "user32" ( _
                                ByVal hwnd As Long, _
                                ByVal hWndInsertAfter As Long, _
                                ByVal X As Long, _
                                ByVal Y As Long, _
                                ByVal cx As Long, _
                                ByVal cy As Long, _
                                ByVal wFlags As Long) As Long


'API utilisée pour jeter des fichiers à la corbeille
'Constantes nécessaires
Private Const FOF_ALLOWUNDO = &H40
Private Const FOF_NOALLOWUNDO = 0
Private Const FO_MOVE = &H1
Private Const FO_COPY = &H2
Private Const FO_DELETE = &H3
Private Const FO_RENAME = &H4

Private Type SHFILEOPSTRUCT
     hwnd As Long
     wFunc As Long
     pFrom As String
     pTo As String
     fFlags As Integer
     fAnyOperationsAborted As Boolean
     hNameMappings As Long
     lpszProgressTitle As String
End Type
Private Declare Function SHFileOperation Lib "shell32.dll" Alias "SHFileOperationA" (lpFileOp As SHFILEOPSTRUCT) As Long

'************************************************
' Rend une fenêtre couvrable ou non couvrable (toujours visible)
' f : fenêtre dont il est question
' bVisible : Vrai si toujours visible
'************************************************
'Public Sub ToujoursVisible(f As Form, bVisible As Boolean)
'    Dim Resultat As Long
'
'    If bVisible Then
'        Resultat = SetWindowPos(f.hwnd, -1, 0, 0, 0, 0, &H2 Or &H1 Or &H40 Or &H10)      ' Rendre cette fenêtre toujours visible
'    Else
'        Resultat = SetWindowPos(f.hwnd, -2, 0, 0, 0, 0, &H2 Or &H1 Or &H40 Or &H10)      ' Rendre cette fenêtre recouvrable
'    End If
'End Sub


'variables locales de stockage des valeurs de propriétés
Private mvarPutInTrash As Boolean 'copie locale

Public Property Let PutInTrash(ByVal vData As Boolean)
'utilisé lors de l'affectation d'une valeur à la propriété, du coté gauche de l'affectation.
'Syntax: X.PutInTrash = 5
    mvarPutInTrash = vData
End Property


Public Property Get PutInTrash() As Boolean
'utilisé lors de la lecture de la valeur de la propriété, du coté droit de l'instruction.
'Syntax: Debug.Print X.PutInTrash
    PutInTrash = mvarPutInTrash
End Property

'************************************************
' Renome un fichier
' OldName : nom du fichier source
' NewName : nom du fichier destination
'************************************************
Public Function RenameFile(OldName As String, NewName As String) As Long
    Dim FileOperation As SHFILEOPSTRUCT
    
    With FileOperation
        .wFunc = FO_RENAME
        .pFrom = OldName     'fichier à renomer
        .pTo = NewName    ' en ...
    End With
    NameFile = SHFileOperation(FileOperation)    'Renome le fichier
End Function

'************************************************
' Copie un fichier
' SourceFileName : nom du fichier source
' DestinationFileName : nom du fichier destination
'************************************************
Public Function CopyFile(SourceFileName As String, DestinationFileName As String) As Long
    Dim FileOperation As SHFILEOPSTRUCT
    
    With FileOperation
        .wFunc = FO_COPY
        .pFrom = SourceFileName     ' fichier à copier
        .pTo = DestinationFileName        ' en
    End With
    CopyFile = SHFileOperation(FileOperation)    'Copie le fichier
End Function

'************************************************
' Déplace un fichier
' SourceFileName : nom du fichier source
' DestinationFileName : nom du fichier destination
'************************************************
Public Function MoveFile(SourceFileName As String, DestinationFileName As String) As Long
    Dim FileOperation As SHFILEOPSTRUCT
    
    With FileOperation
        .wFunc = FO_MOVE
        .pFrom = SourceFileName     'fichier à déplacer
        .pTo = DestinationFileName    ' vers le fichier...
    End With
    MoveFile = SHFileOperation(FileOperation)    'Déplace le fichier
End Function


'************************************************
' Efface un fichier en la mettant dans la corbeille si PutInTrash=vrai
' Efface un fichier en la détruisant si PutInTrash=faux
' FileToDelete : nom du fichier à envoyer dans la poubelle
'************************************************

Public Function DeleteFile(FileToDelete As String) As Long
    Dim FileOperation As SHFILEOPSTRUCT
    Dim iTrash    As Integer
    
    If mvarPutInTrash Then
        iTrash = FOF_ALLOWUNDO    'Jette le fichier à la poubelle
    Else
        iTrash = FOF_NOALLOWUNDO    'Détruit le fichier
    End If
    
    With FileOperation
        .wFunc = FO_DELETE
        .pFrom = FileToDelete     'fichier à éffacer
        .fFlags = iTrash  ' 0= Destruction définitive, &H40=Poubelle
    End With
    DelFile = SHFileOperation(FileOperation)
End Function

Private Sub Class_Initialize()
    mvarPutInTrash = True   'Jette le fichier à la poubelle par défaut
End Sub
