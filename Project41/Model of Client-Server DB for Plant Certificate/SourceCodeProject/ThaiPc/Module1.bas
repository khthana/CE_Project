Attribute VB_Name = "Module1"
Private fMainForm As frmmain
Sub main()
    Dim PauseTime, Start
    frmSplash.Show
    'delay for showing splash
    PauseTime = 3.5
    Start = Timer
    Do While Timer < PauseTime + Start
        DoEvents
    Loop
    'end delay for showing splash
    frmSplash.Refresh
    Set fMainForm = New frmmain
    Load fMainForm
    Unload frmSplash
    
    frmmain.Show
End Sub
