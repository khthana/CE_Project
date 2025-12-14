VERSION 4.00
Begin VB.Form Executor 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "File Executor"
   ClientHeight    =   2295
   ClientLeft      =   3495
   ClientTop       =   3075
   ClientWidth     =   4455
   BeginProperty Font 
      name            =   "MS Sans Serif"
      charset         =   0
      weight          =   700
      size            =   8.25
      underline       =   0   'False
      italic          =   0   'False
      strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Height          =   2700
   Icon            =   "File Executor.frx":0000
   Left            =   3435
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2295
   ScaleWidth      =   4455
   ShowInTaskbar   =   0   'False
   Top             =   2730
   Width           =   4575
   Begin VB.Frame Frame 
      Height          =   2055
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4215
      Begin VB.CommandButton Cancel 
         Caption         =   "&Cancel"
         BeginProperty Font 
            name            =   "MS Sans Serif"
            charset         =   0
            weight          =   400
            size            =   8.25
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3120
         TabIndex        =   9
         Top             =   1560
         Width           =   975
      End
      Begin VB.CommandButton Apply 
         Caption         =   "&Apply"
         BeginProperty Font 
            name            =   "MS Sans Serif"
            charset         =   0
            weight          =   400
            size            =   8.25
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3120
         TabIndex        =   8
         Top             =   1080
         Width           =   975
      End
      Begin VB.Frame Action 
         Caption         =   "Action:"
         BeginProperty Font 
            name            =   "MS Sans Serif"
            charset         =   0
            weight          =   400
            size            =   8.25
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   120
         TabIndex        =   4
         Top             =   960
         Width           =   2895
         Begin VB.OptionButton Prints 
            Caption         =   "&Print"
            BeginProperty Font 
               name            =   "MS Sans Serif"
               charset         =   0
               weight          =   400
               size            =   8.25
               underline       =   0   'False
               italic          =   0   'False
               strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   2040
            TabIndex        =   7
            Top             =   360
            Width           =   615
         End
         Begin VB.OptionButton Explore 
            Caption         =   "&Explore"
            BeginProperty Font 
               name            =   "MS Sans Serif"
               charset         =   0
               weight          =   400
               size            =   8.25
               underline       =   0   'False
               italic          =   0   'False
               strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   1080
            TabIndex        =   6
            Top             =   360
            Width           =   855
         End
         Begin VB.OptionButton Opens 
            Caption         =   "&Open"
            BeginProperty Font 
               name            =   "MS Sans Serif"
               charset         =   0
               weight          =   400
               size            =   8.25
               underline       =   0   'False
               italic          =   0   'False
               strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   240
            TabIndex        =   5
            Top             =   360
            Value           =   -1  'True
            Width           =   735
         End
      End
      Begin VB.CommandButton Browse 
         Caption         =   "&Browse..."
         BeginProperty Font 
            name            =   "MS Sans Serif"
            charset         =   0
            weight          =   400
            size            =   8.25
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3120
         TabIndex        =   3
         Top             =   480
         Width           =   975
      End
      Begin VB.TextBox Filename 
         BeginProperty Font 
            name            =   "MS Sans Serif"
            charset         =   0
            weight          =   400
            size            =   8.25
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   120
         TabIndex        =   2
         Top             =   480
         Width           =   2895
      End
      Begin MSComDlg.CommonDialog Dialog 
         Left            =   3720
         Top             =   120
         _Version        =   65536
         _ExtentX        =   847
         _ExtentY        =   847
         _StockProps     =   0
         DialogTitle     =   "Select A File"
         Flags           =   6148
      End
      Begin VB.Label Filenamelabel 
         Caption         =   "&Filename / Folder:"
         BeginProperty Font 
            name            =   "MS Sans Serif"
            charset         =   0
            weight          =   400
            size            =   8.25
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   1335
      End
   End
End
Attribute VB_Name = "Executor"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Option Explicit



Private Sub Apply_Click()

Dim Action As String 'declare the needed variables
  
If Opens.Value = True Then 'if Open is seleceted then
   Action = "Open"
ElseIf Explore.Value = True Then 'if Explore is selected then
   Action = "Explore"
Else 'otherwise just Print
   Action = "Print"
End If

FileExecutor Me.hWnd, filename.Text, Action 'call the function with the options selected
       
End Sub






Private Sub Browse_Click()

Dialog.ShowOpen 'show the dialog
filename.Text = Dialog.filename 'set the Filename text box to the selected file

End Sub

Private Sub Cancel_Click()

Unload Me 'exit the program

End Sub


Private Sub Form_Load()

Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2 'centre the form on the screen

'This project was downloaded from
'
'http://www.brianharper.demon.co.uk/
'
'Please use this project and all of its source code however you want.
'
'UNZIPPING
'To unzip the project files you will need a 32Bit unzipper program that
'can handle long file names. If you have a latest copy of Winzip installed
'on your system then you may use that. If you however dont have a copy,
'then visit my web site, go into the files section and from there you can
'click on the Winzip link to goto their site and download a copy of the
'program. By doing this you will now beable to unzip the project files
'retaining their proper long file names.
'Once upzipped, load up your copy of Visual Basic and goto
'File/Open Project. Locate the project files to where ever you unzipped
'them, then click Open. The project files will be loaded and are now ready
'for use.
'
'THE PROJECT
'When I have been creating a project for some reason, I have always needed
'to execute files such as other programs. This project uses a function from
'the API and allows three options. The user can execute individual files,
'print files, or explore folders. By typing in a folder in the text box,
'followed by the Explore option, will open Windows Explorer to the specified
'directory.
'
'NOTES
'I have only provided the necessary project files with the zip. This keeps
'the size of the zip files down to a minimum and enables me to upload more
'prjects files to my site.
'
'I hope you find the project usful in what ever you are programming. I
'have tried to write out a small explanation of what each line of code
'does in the project, although most of it is pretty simple to understand.
'
'If you find any bugs in the code then please dont hesitate to Email me and
'I will get back to you as soon as possible. If you however need help on a
'different matter concerning Visual Basic then please please Email me as
'I like to here from people and here what they are programming.
'
'My Email address is:
'Brian@brianharper.demon.co.uk
'
'My web site is:
'http://www.brianharper.demon.co.uk/
'
'Please visit my web site and find many other useful projects like this.
'

End Sub


