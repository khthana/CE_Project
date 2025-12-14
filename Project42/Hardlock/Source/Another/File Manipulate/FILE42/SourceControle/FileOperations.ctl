VERSION 5.00
Begin VB.UserControl FileOperations 
   ClientHeight    =   645
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1350
   ScaleHeight     =   645
   ScaleWidth      =   1350
   ToolboxBitmap   =   "FileOperations.ctx":0000
   Begin VB.Image Image1 
      Height          =   465
      Left            =   0
      Picture         =   "FileOperations.ctx":0182
      Top             =   0
      Width           =   1185
   End
End
Attribute VB_Name = "FileOperations"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
' Partie Manipulations de fichiers
Private Const FOF_ALLOWUNDO = &H40
Private Const FOF_NOALLOWUNDO = 0
Private Const FO_MOVE = &H1
Private Const FO_COPY = &H2
Private Const FO_DELETE = &H3
Private Const FO_RENAME = &H4

' ShowFolders
Private Const BIF_RETURNONLYFSDIRS = &H1
Private Const BIF_STATUSTEXT = &H4

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

' Partie Manipulations de fichiers
'Valeurs de propriétés par défaut:
Const m_def_PutInTrash = True
'Variables de propriétés:
Dim m_PutInTrash As Boolean

' ShowFolders
Private Type BROWSEINFO  'bi
    hOwner As Long
    pidlRoot As Long
    pszDisplayName As String
    lpszTitle As String
    ulFlags As Long
    lpfn As Long
    lParam As Long
    iImage As Long
End Type
        
Private Declare Function SHGetPathFromIDList Lib "shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long
Private Declare Function SHBrowseForFolder Lib "shell32.dll" Alias "SHBrowseForFolderA" (lpBrowseInfo As BROWSEINFO) As Long

' Partie Manipulations de fichiers


'************************************************
' Renome un fichier
' OldName : nom du fichier source
' NewName : nom du fichier destination
'************************************************
Public Function RenameFile(OldName As String, NewName As String) As Long
Attribute RenameFile.VB_Description = "Renome le fichier ou le répertoire."
    Dim FileOperation As SHFILEOPSTRUCT
    
    With FileOperation
        .wFunc = FO_RENAME
        .pFrom = OldName     'fichier à renomer
        .pTo = NewName    ' en ...
    End With
    RenameFile = SHFileOperation(FileOperation)    'Renome le fichier
End Function

'************************************************
' Copie un fichier
' SourceFileName : nom du fichier source
' DestinationFileName : nom du fichier destination
'************************************************
Public Function CopyFile(SourceFileName As String, DestinationFileName As String) As Long
Attribute CopyFile.VB_Description = "Copie le fichier ou le répertoire"
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
Attribute MoveFile.VB_Description = "Déplace le fichier ou le répertoire."
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
Attribute DeleteFile.VB_Description = "Supprime le fichier ou répertoire (ou l'envoie dans la corbeille en fonction de PutInTrash)"
    Dim FileOperation As SHFILEOPSTRUCT
    Dim iTrash    As Integer
    
    If m_PutInTrash Then
        iTrash = FOF_ALLOWUNDO    'Jette le fichier à la poubelle
    Else
        iTrash = FOF_NOALLOWUNDO    'Détruit le fichier
    End If
    
    With FileOperation
        .wFunc = FO_DELETE
        .pFrom = FileToDelete     'fichier à éffacer
        .fFlags = iTrash  ' 0= Destruction définitive, &H40=Poubelle
    End With
    DeleteFile = SHFileOperation(FileOperation)
End Function

Private Sub UserControl_EnterFocus()
    Image1.Visible = False
End Sub

'Initialiser les propriétés pour le UserControl
Private Sub UserControl_InitProperties()
    m_PutInTrash = m_def_PutInTrash
End Sub

'Charger les valeurs des propriétés à partir du stockage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)

    m_PutInTrash = PropBag.ReadProperty("PutInTrash", m_def_PutInTrash)
End Sub

Private Sub UserControl_Resize()
    UserControl.Width = Image1.Width
    UserControl.Height = Image1.Height
End Sub

'Écrire les valeurs des propriétés dans le stockage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    Call PropBag.WriteProperty("PutInTrash", m_PutInTrash, m_def_PutInTrash)
End Sub

' ***********************************************************************************
' PutInTrash : Indique si la suppression doit se faire en passant par la corbeille (valeur vraie par défaut)
' ***********************************************************************************
Public Property Get PutInTrash() As Boolean
Attribute PutInTrash.VB_Description = "Indique que les fichiers sont envoyés dans la poubelle lors de l'éffacement."
    PutInTrash = m_PutInTrash
End Property

Public Property Let PutInTrash(ByVal New_PutInTrash As Boolean)
    m_PutInTrash = New_PutInTrash
    PropertyChanged "PutInTrash"
End Property

' ***********************************************************************************
' ShowFolders : permet de visualiser et de choisir un dossier
' Parametres :
'       - Title : titre affiché dans la fenêtre
' Retour :
'       - Nom complet du répertoire sélectionné si l'annulation n'a pas été demandée, sinon chaîne vide
' ***********************************************************************************
Public Function ShowFolders(Title As String) As String
Attribute ShowFolders.VB_Description = "Affiche la liste des dossiers"
    Dim bi          As BROWSEINFO
    Dim pidl        As Long
    Dim r           As Long
    Dim spath       As String
    
    bi.hOwner = UserControl.hwnd
    bi.pidlRoot = 0&
    bi.lpszTitle = Title
    bi.ulFlags = BIF_RETURNONLYFSDIRS '+ BIF_STATUSTEXT
    pidl& = SHBrowseForFolder(bi)
    spath = Space(512)
    r = SHGetPathFromIDList(ByVal pidl, ByVal spath)
    If r Then
        ShowFolders = Left(spath, InStr(spath, Chr(0)) - 1)
    End If
End Function

