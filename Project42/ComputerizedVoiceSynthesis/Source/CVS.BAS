Attribute VB_Name = "CVS"
Public Function Convert_To_Payang(s As String) As String
        Dim n, np(10) As String
        
        n = ""
        My_soundmap.Seek "=", s
        If Not My_soundmap.NoMatch Then
                If Not My_soundmap.slb_dtl1 = "" Then np(1) = My_soundmap.slb_dtl1
                If Not My_soundmap.slb_dtl2 = "" Then np(2) = My_soundmap.slb_dtl2
                If Not My_soundmap.slb_dtl3 = "" Then np(3) = My_soundmap.slb_dtl3
                If Not My_soundmap.slb_dtl4 = "" Then np(4) = My_soundmap.slb_dtl4
                If Not My_soundmap.slb_dtl5 = "" Then np(5) = My_soundmap.slb_dtl5
                If Not My_soundmap.slb_dtl6 = "" Then np(6) = My_soundmap.slb_dtl6
                If Not My_soundmap.slb_dtl7 = "" Then np(7) = My_soundmap.slb_dtl7
                If Not My_soundmap.slb_dtl8 = "" Then np(8) = My_soundmap.slb_dtl8
                If Not My_soundmap.slb_dtl9 = "" Then np(9) = My_soundmap.slb_dtl9
                If Not My_soundmap.slb_dtl10 = "" Then np(10) = My_soundmap.slb_dtl10
                For i = 1 To My_soundmap.amt_slb
                        n = n & np(i) & " "
                Next i
        End If
        Convert_To_Payang = n
End Function
Public Function Character_First(s As String) As String
        Select Case s
                Case "¡"
                        Character_First = "k"
                Case "¤", "¢", "¦"
                        Character_First = "kh"
                Case "§"
                        Character_First = "ng"
                Case "©", "ª", "¬"
                        Character_First = "sh"
                Case "¨"
                        Character_First = "ch"
                Case "«", "Ê", "É", "È"
                        Character_First = "s"
                Case "­", "Â", "ËÂ", "Ë­"
                        Character_First = "y"
                Case "®", "´"
                        Character_First = "d"
                Case "¯", "µ"
                        Character_First = "t"
                Case "°", "¶", "·", "¸", "±"
                        Character_First = "th"
                Case "¹", "³", "Ë¹"
                        Character_First = "n"
                Case "º"
                        Character_First = "b"
                Case "»"
                        Character_First = "p"
                Case "¾", "¼"
                        Character_First = "ph"
                Case "½", "¿"
                        Character_First = "f"
                Case "Á", "ËÁ"
                        Character_First = "m"
                Case "Ã", "ËÃ"
                        Character_First = "r"
                Case "Å", "ËÅ"
                        Character_First = "l"
                Case "Ç", "ËÇ"
                        Character_First = "w"
                Case "Í"
                        Character_First = "?"
                Case "Î", "Ë"
                        Character_First = "h"
                Case "¡Ç"
                        Character_First = "kw"
                Case "¡Ã"
                        Character_First = "kr"
                Case "¡Å"
                        Character_First = "kl"
                Case "¤Ã"
                        Character_First = "khr"
                Case "¤Ç"
                        Character_First = "khw"
                Case "¤Å"
                        Character_First = "khl"
                Case "¾Å"
                        Character_First = "phl"
                Case "¾Ã"
                        Character_First = "phr"
                Case "»Å"
                        Character_First = "pl"
                Case "»Ã"
                        Character_First = "pr"
                Case "µÃ"
                        Character_First = "tr"
                Case "·Ã"
                        Character_First = "thr"
                Case "´Ã"
                        Character_First = "dr"
                Case "¿Ã"
                        Character_First = "fr"
                Case "¿Å"
                        Character_First = "fl"
                Case "ºÃ"
                        Character_First = "br"
                Case "ºÅ"
                        Character_First = "bl"
        End Select
End Function
Public Function vowel(n As String) As String
        Select Case n
                Case "Ð", "Ò"
                        vowel = "a"
                Case "Ô", "Õ"
                        vowel = "i"
                Case "Ø", "Ù"
                        vowel = "u"
                Case "Ö", "×"
                        vowel = "ue"
                Case "àÐ", "à", "àç"
                        vowel = "e"
                Case "âÐ", "â"
                        vowel = "o"
                Case "Í", "àÒÐ"
                        vowel = "oa"
                Case "àÍÐ", "àÍ", "àÔ"
                        vowel = "er"
                Case "áÐ", "á", "áç"
                        vowel = "ae"
                Case "ÑÇÐ", "ÑÇ", "Ç"
                        vowel = "ua"
                Case "à×ÍÐ", "à×Í"
                        vowel = "uea"
                Case "àÕÂÐ", "àÕÂ"
                        vowel = "ia"
        End Select
End Function
Public Function check_vowel(v As String) As String
        Select Case v
                Case "Ð", "Ô", "Ø", "Ö", "àÐ", "âÐ", "àÒÐ", "àÍÐ", "áÐ", "ÑÐ", "à×ÍÐ", "àÕÂÐ"
                        check_vowel = ""
                Case "Ò", "Õ", "Ù", "à", "â", "Í", "àÐ", "á", "Ñ", "à×Í", "àÕÂ", "×", "ÑÇ", "Ç", "àÍ"
                        check_vowel = "_"
        End Select
End Function
Public Function character_last(s As String) As String
        Select Case s
                Case "¡", "¢", "¤", "¦"
                        character_last = "k"
                Case "¨", "ª", "«", "®", "¯", "°", "±", "²", "´", "µ", "¶", "·", "¸", "È", "É", "Ê"
                        character_last = "t"
                Case "º", "»", "¾", "¿", "À"
                        character_last = "p"
                Case "§"
                        character_last = "ng"
                Case "¹", "­", "³", "Å", "Ì"
                        character_last = "n"
                Case "Á"
                        character_last = "m"
                Case "Â"
                        character_last = "y"
                Case "Ç"
                        character_last = "w"
        End Select
End Function
Public Function check_level(c1 As String, v As String, c2 As String, t As String) As Integer
        Dim a As String, b As String, c As String
        Select Case c1
                Case "¡", "¨", "´", "µ", "®", "¯", "º", "»", "Í"
                        a = "1"
                Case "¢", "©", "Ê", "È", "É", "¶", "°", "¼", "½", "Ë", "ËÃ", "ËÅ", "ËÇ", "Ë¹", "ËÁ", "ËÂ", "Ë­"
                        a = "2"
                Case "¤", "¦", "§", "ª", "¬", "«", "Â", "­", "·", "¸", "²", "±", "¹", "³", "¾", "À", "¿", "Á", "Ã", "Å", "Ç", "Î"
                        a = "3"
        End Select
        If v = "" Then b = "1" Else b = "2"
        Select Case c2
                Case "ng", "n", "m", "y", "w"
                        c = "2"
                Case ""
                        c = b
                Case Else
                        c = "1"
        End Select
        a = a & b & c & t
        Select Case a
                Case "1121", "1221", "3121", "3221"
                        check_level = 1
                Case "1111", "1112", "1211", "1212", "1222", "1122", "2111", "2112", "2211", "2212", "2222", "2122", "2215"
                        check_level = 2
                Case "1113", "1213", "1123", "1223", "2113", "2123", "2223", "3112", "3211", "3122", "3222"
                        check_level = 3
                Case "1114", "1214", "1124", "1224", "3111", "3113", "3114", "3213", "3214", "3123", "3223", "3124", "3224"
                        check_level = 4
                Case "1115", "1215", "1125", "1225", "2121", "2221", "2125", "2225", "3115", "3215"
                        check_level = 5
        End Select
End Function
Public Function pattern(s As String, c As String, v As String, t As String) As String
        Dim c1 As String, c2 As String, v1 As String
        Dim worked
        c1 = ""
        c2 = ""
        v1 = ""
        Select Case s
                Case "CV"
                        c1 = c
                        If v = "Ó" Then
                                v = "Ð"
                                c2 = "Á"
                        End If
                Case "CVC"
                        If v = "Ñ" Then
                                If Mid(c, 2, 1) = "Ç" Then
                                        v = "ÑÇ"
                                Else
                                        v = "Ð"
                                        c2 = Mid(c, 2, 1)
                                End If
                        Else
                                c2 = Mid(c, 2, 1)
                        End If
                        c1 = Mid(c, 1, 1)
                Case "CVCV"
                        c1 = Mid(c, 1, 1)
                        v = Mid(v, 1, 1) & Mid(c, 2, 1) & Mid(v, 2, 1)
                Case "CC"
                        If Mid(c, 2, 1) = "Í" Then
                                v = "Í"
                        Else
                                c2 = Mid(c, 2, 1)
                                v = "âÐ"
                        End If
                        c1 = Mid(c, 1, 1)
                Case "CCC"
                        c1 = Mid(c, 1, 2)
                        v = "âÐ"
                        c2 = Mid(c, 3, 1)
                        If Mid(c, 2, 1) = "Ç" Or Mid(c, 2, 1) = "Í" Then
                                c1 = Mid(c, 1, 1)
                                c2 = Mid(c, 3, 1)
                                v = Mid(c, 2, 1)
                        End If
                        If (Mid(c, 2, 1) = "Ã" Or Mid(c, 2, 1) = "Å") And Mid(c, 1, 1) <> "Ë" Then
                                c1 = Mid(c, 1, 2)
                                v = "Í"
                        End If
                Case "CCV"
                        c1 = Mid(c, 1, 2)
                Case "CCVC"
                        c1 = Mid(c, 1, 2)
                        c2 = Mid(c, 3, 1)
                        If v = "Ñ" Then v = "Ð"
                Case "CCVCV"
                        If Mid(c, 2, 1) = "Ã" Or Mid(c, 2, 1) = "Å" Or Mid(c, 2, 1) = "Ç" Then
                                c1 = Mid(c, 1, 2)
                                c2 = Mid(c, 3, 1)
                        End If
                Case "CCCC"
                       If Mid(c, 3, 1) = "Ç" Or Mid(c, 3, 1) = "Í" Then
                                c1 = Mid(c, 1, 2)
                                c2 = Mid(c, 4, 1)
                                v = Mid(c, 3, 1)
                        End If
                        If Mid(c, 1, 1) = "Ë" Then
                                c1 = Mid(c, 2, 1)
                                t = 5
                        End If
                Case "VC"
                        c1 = Mid(c, 1, 1)
                        If v = "ä" Or v = "ã" Then
                                c2 = "Â"
                                v = "Ð"
                        End If
                Case "VCC"
                        '¡¯·Õè 19
                        c1 = Mid(c, 1, 1)
                        c2 = Mid(c, 2, 1)
                        If Mid(c, 2, 1) = "Ã" Or Mid(c, 2, 1) = "Å" Then
                                c1 = Mid(c, 1, 2)
                        '¡¯·Õè 12
                        End If
                        If Mid(c, 2, 1) = "Í" Then
                                v = "àÍ"
                        End If
                        If v = "ä" Or v = "ã" Then
                                 c2 = "Â"
                                 v = "Ð"
                                 c1 = Mid(c, 2, 1)
                        End If
                Case "VCV"
                        If Mid(v, 2, 1) = "Ò" Then
                                c2 = "Ç"
                                v = "Ð"
                        End If
                        c1 = Mid(c, 1, 1)
                Case "VCCV"
                        If Mid(c, 2, 1) = "Í" Then
                                c1 = Mid(c, 1, 1)
                                v = Mid(v, 1, 1) & "Í" & Mid(v, 2, 1)
                        Else
                                If Mid(c, 2, 1) = "Ã" Or Mid(c, 2, 1) = "Å" Or Mid(c, 2, 1) = "Ç" Then
                                        c1 = Mid(c, 1, 2)
                                End If
                        End If
                        If Mid(v, 2, 1) = "Ò" Then
                                c2 = "Ç"
                                v = "Ð"
                        End If
                Case "VCVV"
                        c1 = Mid(c, 1, 1)
                Case "VCVC"
                        c1 = Mid(c, 1, 1)
                        If Mid(c, 2, 1) = "Í" Or Mid(c, 2, 1) = "Â" Then
                                v = v & Mid(c, 2, 1)
                        Else
                                c2 = Mid(c, 2, 1)
                        End If
                Case "VCVCC"
                        c1 = Mid(c, 1, 1)
                        c2 = Mid(c, 3, 1)
                        v = v & Mid(c, 2, 1)
                Case "VCVCV"
                        c1 = Mid(c, 1, 1)
                        v = Mid(v, 1, 2) & Mid(c, 2, 1) & Mid(v, 3, 1)
                Case "VCCC"
                        If Mid(c, 3, 1) = "Í" Then
                                c1 = Mid(c, 1, 2)
                                v = "àÍ"
                                c2 = ""
                        Else
                                c1 = Mid(c, 1, 2)
                                c2 = Mid(c, 3, 1)
                        End If
                Case "VCCCV"
                        c1 = Mid(c, 1, 2)
                        v = Mid(v, 1, 1) & Mid(c, 3, 1) & Mid(v, 2, 1)
                Case "VCCVV"
                        c1 = Mid(c, 1, 2)
                Case "VCCVC"
                        c1 = Mid(c, 1, 2)
                        v = v & Mid(c, 3, 1)
                Case "VCCVCC"
                         c1 = Mid(c, 1, 2)
                         c2 = Mid(c, 4, 1)
                         v = v & Mid(c, 3, 1)
                Case "VCCVCV"
                         c1 = Mid(c, 1, 2)
                         v = Mid(v, 1, 2) & Mid(c, 3, 1) & Mid(v, 3, 1)
        End Select
        c1 = Character_First(c1)
        c2 = character_last(c2)
        v1 = check_vowel(v)
        v = vowel(v)
        If c1 = "?" Then
                pattern = v & v1 & c2 & check_level(Mid(c, 1, 1), v1, c2, t)
        Else
                pattern = c1 & v & "+" & v & v1 & c2 & check_level(Mid(c, 1, 1), v1, c2, t)
        End If
   
   ' worked = sndPlaySoundA("c:\sound\" & c1 & v & ".wav", 0)
    'worked = sndPlaySoundA("c:\sound\" & v & v1 & c2 & check_level(Mid(c, 1, 1), v1, c2, t) & ".wav", 0)

End Function
Public Function Convert_Middle_Pattern(s As String) As String
        
        Dim cmp As String, cmpa As String, payang As String
        Dim a As String, c As String, v As String
        Dim i As Integer, j As Integer, t As Integer, length As Integer
        
        cmp = ""
        payang = ""
        c = ""
        v = ""
        t = 1
        length = Len(s)
        'á»Å§à»ç¹ÊÑ­ÅÑ¡É³ì â´Â  C = ¾ÂÑ­ª¹Ð V = ÊÃÐ 1-4 = ÇÃÃ³ÂØ¡µì
        For i = 1 To length
                a = Mid(s, i, 1)
                payang = payang & a
                j = Asc(a)
                Select Case j
                        Case 161 To 206
                                cmp = cmp & "C"
                                c = c & a
                        Case 32
                                cmp = pattern(cmp, c, v, CStr(t))
                                cmpa = cmpa & " " & cmp
                                cmp = ""
                                c = ""
                                v = ""
                                t = 1
                        Case 134 To 137
                                t = j - 132
                        Case 232 To 235
                                t = j - 230
                        Case Else
                                cmp = cmp & "V"
                                v = v & a
                End Select
        Next i
                        
        '¨Ñ´ÃÙ»ãËÁèµÒÁ¡¯ 26 ¢éÍ
        Convert_Middle_Pattern = Trim(cmpa)
End Function
