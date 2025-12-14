Unit TReversi ;

interface

Const  Side          = 8  ;
       MaxPos        = 20 ;

Type   PlayerType    = (PlayerS1,PlayerS2,Blank) ;
       AlgoType      = (Conventional,Genetics,Human);
       LevelType     = (Easy,Medium,Expert,Master) ;
       ColorType     = (Green,Black) ;
       BoardType     = array[1..Side,1..Side] of PlayerType ;
       BoardObjType   = Object
                             BoardObj   : BoardType    ;
                             PlayerPlay : PlayerType   ; {who will play game}
                             P1Algo     : AlgoType  ; {algorithm of player1}
                             P2Algo     : AlgoType  ; {algorithm of player2}
                             P1Level    : LevelType ;
                             P2Level    : LevelType ;
                             P1Disk     : integer   ;
                             P2Disk     : integer   ;
                             P1Color    : ColorType ;
                             P2Color    : ColorType ;
                             PlayerFirst : PlayerType ;
                             
                             Procedure  Init    ;
                             Procedure  ChangeBoard(Row,Column : integer  ;
                                        Players : PlayerType)  ;
                             Procedure  FindBestPut1(var Row,Column  : integer ;
                                        Player : PlayerType ; Level : integer) ;
                             Procedure  FindBestPut2(var Row,Column  : integer ;
                                        Player : PlayerType ; Level : integer) ;
                             Procedure  ReversePlayer ;
                             Procedure  ReverseBoard  ;
                             Procedure  TranposeBoard ;
                             Procedure  FindPlayerDisk ;

                             Function   CalculateScore(PlayerS : PlayerType) : real;
                             Function   ChkForPass(Player : PlayerType) : Boolean ;
                             Function   ChkForError(Row,Column : integer ;
                                        Player : PlayerType)   : Boolean ;
                             Function   IsGameOver : Boolean ;
                        end ;
       Function FindFontier(var Brd1 : BoardType ; Plyer
                                     : PlayerType) : integer ;
       Function CXSquare(var Brd1 : BoardType ; Plyer
                                  : PlayerType) : integer ;
implementation

Function CXSquare(var Brd1 : BoardType ; Plyer : PlayerType) : integer ;
var Sum  : integer ;
begin
     Sum := 0 ;
     if Brd1[2,2]=Plyer then Sum := Sum+1 ;
     if Brd1[1,2]=Plyer then Sum := Sum+1 ;
     if Brd1[2,1]=Plyer then Sum := Sum+1 ;

     if Brd1[1,Side-1]=Plyer then Sum := Sum+1 ;
     if Brd1[2,Side-1]=Plyer then Sum := Sum+1 ;
     if Brd1[2,Side  ]=Plyer then Sum := Sum+1 ;

     if Brd1[Side-1,2]=Plyer then Sum := Sum+1 ;
     if Brd1[Side-1,1]=Plyer then Sum := Sum+1 ;
     if Brd1[Side,2  ]=Plyer then Sum := Sum+1 ;

     if Brd1[Side-1,Side-1]=Plyer then Sum := Sum+1 ;
     if Brd1[Side,Side-1  ]=Plyer then Sum := Sum+1 ;
     if Brd1[Side-1,Side  ]=Plyer then Sum := Sum+1 ;
     CXSquare := Sum ;
end ;

Function FontierDisc(var Brd1  : BoardType ; i1,j1 : integer ;
                         Plyer : PlayerType): Boolean ;
begin
     FontierDisc := false ;
     if (Brd1[i1,j1] = Plyer) then
        begin
             if (Brd1[i1-1,j1]=Blank) or
                (Brd1[i1+1,j1]=Blank) or
                (Brd1[i1,j1-1]=Blank) or
                (Brd1[i1,j1+1]=Blank) or
                (Brd1[i1-1,j1-1]=Blank) or
                (Brd1[i1-1,j1+1]=Blank) or
                (Brd1[i1+1,j1-1]=Blank) or
                (Brd1[i1+1,j1+1]=Blank) then
                    begin
                         FontierDisc := true
                    end
             else   FontierDisc := false ;
        end ;
end ;

Function FindFontier(var Brd1 : BoardType ; Plyer : PlayerType) : integer ;
var Sum,i,j  : integer ;
begin
     Sum := 0 ;
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              if FontierDisc(Brd1,i,j,Plyer) then
                 Sum := Sum+1 ;
         end ;
     FindFontier := Sum ;
end ;

Function GetOpposite(Player : PlayerType) : PlayerType ;
begin
       if Player = PlayerS1 then GetOpposite := PlayerS2 ;
       if Player = PlayerS2 then GetOpposite := PlayerS1 ;
end ;

Function GetPlayer(Player : PlayerType) : PlayerType ;
begin
       if Player = PlayerS1 then GetPlayer := PlayerS1 ;
       if Player = PlayerS2 then GetPlayer := PlayerS2 ;
end ;

Function CheckLeft_Ok(var TempBoard  : BoardType  ;
                          Row,Column : integer ;
                          Player     : PlayerType) : Boolean ;
var  Check_Ok : Boolean ;
     i        : integer ;
begin
       Check_Ok := false ;
       i        := 1     ;
       if ((Column-1) < 1) or
          (TempBoard[Row,Column-1] <> GetOpposite(Player)) then
          CheckLeft_Ok := false
       else
           begin
                repeat
                      i := i+1 ;
                      if TempBoard[Row,Column-i] <> GetOppoSite(Player) then
                         Check_Ok := true
                until Check_Ok or ((Column-i) < 1) ;
                if (TempBoard[Row,Column-i] <> GetPlayer(Player))
                   or ((Column-i) < 1) then
                   Check_Ok := false ;
                CheckLeft_Ok := Check_Ok ;
           end ;
end ;

Function CheckRight_Ok(var TempBoard  : BoardType  ;
                           Row,Column : integer ;
                           Player     : PlayerType) : Boolean ;
var  Check_Ok : Boolean ;
     i        : integer ;
begin
       Check_Ok := false ;
       i        := 1     ;
       if ((Column+1) > Side) or
          (TempBoard[Row,Column+1] <> GetOpposite(Player)) then
          CheckRight_Ok := false
       else
           begin
                repeat
                      i := i+1 ;
                      if TempBoard[Row,Column+i] <> GetOppoSite(Player) then
                         Check_Ok := true
                until Check_Ok or ((Column+i) > Side) ;
                if (TempBoard[Row,Column+i] <> GetPlayer(Player))
                   or ((Column+i) > Side)  then
                   Check_Ok := false ;
                CheckRight_Ok := Check_Ok ;
           end ;

end ;

Function CheckUp_Ok(var TempBoard  : BoardType  ;
                        Row,Column : integer ;
                        Player     : PlayerType) : Boolean ;
var  Check_Ok : Boolean ;
     i        : integer ;
begin
       Check_Ok := false ;
       i        := 1     ;
       if (TempBoard[Row-1,Column] <> GetOpposite(Player)) or
          ((Row-1) < 1) then CheckUp_Ok := false
       else
           begin
                repeat
                      i  := i+1 ;
                      if TempBoard[Row-i,Column] <> GetOppoSite(Player) then
                         Check_Ok := true
                until Check_Ok or ((Row-i) < 1) ;
                if (TempBoard[Row-i,Column] <> GetPlayer(Player))
                   or ((Row-i) < 1)  then
                   Check_Ok := false ;
           end ;
       CheckUp_Ok := Check_Ok ;
end ;

Function CheckDown_Ok(var TempBoard  : BoardType  ;
                          Row,Column : integer ;
                          Player     : PlayerType) : Boolean ;
var  Check_Ok : Boolean ;
     i        : integer ;
begin
       Check_Ok := false ;
       i        := 1     ;
       if (TempBoard[Row+1,Column] <> GetOpposite(Player)) or
          ((Row+1) > Side) then CheckDown_Ok := false
       else
           begin
                repeat
                      i := i+1 ;
                      if TempBoard[Row+i,Column] <> GetOppoSite(Player) then
                         Check_Ok := true
                until Check_Ok or ((Row+i) > Side) ;
                if (TempBoard[Row+i,Column] <> GetPlayer(Player))
                   or ((Row+i) > Side) then Check_Ok := false ;
                CheckDown_Ok := Check_Ok ;
           end ;

end ;

Function CheckUpRight_Ok(var TempBoard  : BoardType  ;
                             Row,Column : integer ;
                             Player     : PlayerType) : Boolean ;
var  Check_Ok : Boolean ;
     i        : integer ;
begin
       Check_Ok := false ;
       i        := 1     ;
       if (TempBoard[Row-1,Column+1] <> GetOpposite(Player)) or
          (Row-1 < 1) or (Column+1 > Side) then CheckUpRight_Ok := false
       else
           begin
                repeat
                      i := i+1 ;
                      if TempBoard[Row-i,Column+i] <> GetOppoSite(Player) then
                         Check_Ok := true
                until Check_Ok or ((Row-i) < 1) or ((Column+i) > Side);
                if (TempBoard[Row-i,Column+i] <> GetPlayer(Player))
                   or ((Row-i) < 1) or ((Column+i) > Side)then
                   Check_Ok := false ;
                CheckUpRight_Ok := Check_Ok ;
           end ;

end ;

Function CheckDownRight_Ok(var TempBoard  : BoardType  ;
                               Row,Column : integer ;
                               Player     : PlayerType) : Boolean ;
var  Check_Ok : Boolean ;
     i        : integer ;
begin
       Check_Ok := false ;
       i        := 1     ;
       if (TempBoard[Row+1,Column+1] <> GetOpposite(Player)) or
          (Row+1 > Side) or (Column+1 > Side) then CheckDownRight_Ok := false
       else
           begin
                repeat
                      i := i+1 ;
                      if TempBoard[Row+i,Column+i] <> GetOppoSite(Player) then
                         Check_Ok := true
                until Check_Ok or ((Row+i) > Side) or ((Column+i) > Side) ;
                if (TempBoard[Row+i,Column+i] <> GetPlayer(Player))
                   or ((Row+i) > Side) or ((Column+i) > Side) then
                   Check_Ok := false ;
                CheckDownRight_Ok := Check_Ok ;
           end ;

end ;

Function CheckUpLeft_Ok(var TempBoard  : BoardType  ;
                            Row,Column : integer ;
                            Player     : PlayerType) : Boolean ;
var  Check_Ok : Boolean ;
     i        : integer ;
begin
       Check_Ok := false ;
       i        := 1     ;
       if (TempBoard[Row-1,Column-1] <> GetOpposite(Player)) or
          (Row-1 < 1) or (Column-1 < 1) then CheckUpLeft_Ok := false
       else
           begin
                repeat
                      i := i+1 ;
                      if TempBoard[Row-i,Column-i] <> GetOppoSite(Player) then
                         Check_Ok := true
                until Check_Ok or ((Row-i) < 1) or ((Column-i) < 1) ;
                if (TempBoard[Row-i,Column-i] <> GetPlayer(Player))
                   or ((Row-i) < 1) or ((Column-i) < 1) then

                   Check_Ok := false ;
                CheckUpLeft_Ok := Check_Ok ;
           end ;

end ;

Function CheckDownLeft_Ok(var TempBoard  : BoardType  ;
                              Row,Column : integer ;
                              Player     : PlayerType) : Boolean ;
var  Check_Ok : Boolean ;
     i        : integer ;
begin
       Check_Ok := false ;
       i        := 1     ;
       if (TempBoard[Row+1,Column-1] <> GetOpposite(Player)) or
          (Row+1 > Side) or (Column-1 < 1) then CheckDownLeft_Ok := false
       else
           begin
                repeat
                      i := i+1 ;
                      if TempBoard[Row+i,Column-i] <> GetOppoSite(Player) then
                         Check_Ok := true
                until Check_Ok or ((Row+i) > Side) or ((Column-i) < 1) ;
                if (TempBoard[Row+i,Column-i] <> GetPlayer(Player))
                   or ((Row+i) > Side) or ((Column-i) < 1) then
                   Check_Ok := false ;
                CheckDownLeft_Ok := Check_Ok ;
           end ;

end ;

Function  ChkAndChgBoard(var TempBoard1,TempBoard2 : BoardType  ;
                             Row,Column : integer ;
                             Player     : PlayerType) : Boolean ;

var   Flag1,Flag2,Flag3,Flag4 : Boolean ;
      Flag5,Flag6,Flag7,Flag8 : Boolean ;
      OrFlag                  : Boolean ;
      i                       : integer ;
begin
      if TempBoard1[Row,Column] <> Blank then ChkAndChgBoard := false
      else
          begin
               Flag1 := CheckLeft_Ok(TempBoard1,Row,Column,Player) ;
               Flag2 := CheckRight_Ok(TempBoard1,Row,Column,Player) ;
               Flag3 := CheckUp_Ok(TempBoard1,Row,Column,Player) ;
               Flag4 := CheckDown_Ok(TempBoard1,Row,Column,Player) ;
               Flag5 := CheckUpRight_Ok(TempBoard1,Row,Column,Player) ;
               Flag6 := CheckDownRight_Ok(TempBoard1,Row,Column,Player) ;
               Flag7 := CheckUpLeft_Ok(TempBoard1,Row,Column,Player) ;
               Flag8 := CheckDownLeft_Ok(TempBoard1,Row,Column,Player) ;

               OrFlag := Flag1 or Flag2 or Flag3 or Flag4 or
                         Flag5 or Flag6 or Flag7 or Flag8 ;
               if OrFlag then
                 begin
                    TempBoard2 := TempBoard1 ;
                    TempBoard2[Row,Column] := GetPlayer(Player) ;

                    i          := 1 ;
                    if Flag1 then {can apply to left}
                    Repeat
                       TempBoard2[Row,Column-i] := GetPlayer(Player) ;
                       i := i+1 ;
                    until (TempBoard2[Row,Column-i] = GetPlayer(Player)) or
                          ((Column-i) < 1) ;

                    i          := 1 ;
                    if Flag2 then {can apply to right}
                    Repeat
                       TempBoard2[Row,Column+i] := GetPlayer(Player) ;
                       i := i+1 ;
                    until (TempBoard2[Row,Column+i] = GetPlayer(Player)) or
                          ((Column+i) > Side) ;

                    i          := 1 ;
                    if Flag3 then {can apply to Up}
                    Repeat
                       TempBoard2[Row-i,Column] := GetPlayer(Player) ;
                       i := i+1 ;
                    until (TempBoard2[Row-i,Column] = GetPlayer(Player)) or
                          ((Row-i) < 1) ;

                    i          := 1 ;
                    if Flag4 then {can apply to Down}
                    Repeat
                       TempBoard2[Row+i,Column] := GetPlayer(Player) ;
                       i := i+1 ;
                    until (TempBoard2[Row+i,Column] = GetPlayer(Player)) or
                          ((Row+i) > Side) ;

                    i          := 1 ;
                    if Flag5 then {can apply to UpRight}
                    Repeat
                       TempBoard2[Row-i,Column+i] := GetPlayer(Player) ;
                       i := i+1 ;
                    until (TempBoard2[Row-i,Column+i] = GetPlayer(Player)) or
                          ((Row-i) < 1) or ((Column+i) > Side) ;

                    i          := 1 ;
                    if Flag6 then {can apply to DownRight}
                    Repeat
                       TempBoard2[Row+i,Column+i] := GetPlayer(Player) ;
                       i := i+1 ;
                    until (TempBoard2[Row+i,Column+i] = GetPlayer(Player)) or
                          ((Row+i) > Side) or ((Column+i) > Side)  ;

                    i          := 1 ;
                    if Flag7 then {can apply to UpLeft}
                    Repeat
                       TempBoard2[Row-i,Column-i] := GetPlayer(Player) ;
                       i := i+1 ;
                    until (TempBoard2[Row-i,Column-i] = GetPlayer(Player)) or
                          ((Row-i) < 1) or ((Column-i) < 1)  ;

                    i          := 1 ;
                    if Flag8 then {can apply to DownLeft}
                    Repeat
                       TempBoard2[Row+i,Column-i] := GetPlayer(Player) ;
                       i := i+1 ;
                    until (TempBoard2[Row+i,Column-i] = GetPlayer(Player)) or
                          ((Row+i) > Side) or ((Column-i) < 1)  ;
                    ChkAndChgBoard := true ;
                 end
               else ChkAndChgBoard := false ;
          end ;
end ;

Function Inverse(Player : PlayerType) : PlayerType ;
begin
       if Player = PlayerS1 then Inverse := PlayerS2 ;
       if Player = PlayerS2 then Inverse := PlayerS1 ;
end ;

Function Inv(X : char) : char;
begin
     if X = 'X' then Inv := 'O' ;
     if X = 'O' then Inv := 'X' ;
end ;

Function CanPut(var TempBoard1  : BoardType  ;
                    Row,Column  : integer ;
                    Player      : PlayerType) : Boolean ;

var   Flag1,Flag2,Flag3,Flag4   : Boolean ;
      Flag5,Flag6,Flag7,Flag8   : Boolean ;
      OrFlag                    : Boolean ;
begin
      if TempBoard1[Row,Column] <> Blank then CanPut := false
      else
          begin
               Flag1 := CheckLeft_Ok(TempBoard1,Row,Column,Player) ;
               Flag2 := CheckRight_Ok(TempBoard1,Row,Column,Player) ;
               Flag3 := CheckUp_Ok(TempBoard1,Row,Column,Player) ;
               Flag4 := CheckDown_Ok(TempBoard1,Row,Column,Player) ;
               Flag5 := CheckUpRight_Ok(TempBoard1,Row,Column,Player) ;
               Flag6 := CheckDownRight_Ok(TempBoard1,Row,Column,Player) ;
               Flag7 := CheckUpLeft_Ok(TempBoard1,Row,Column,Player) ;
               Flag8 := CheckDownLeft_Ok(TempBoard1,Row,Column,Player) ;

               OrFlag := Flag1 or Flag2 or Flag3 or Flag4 or
                         Flag5 or Flag6 or Flag7 or Flag8 ;
               CanPut := OrFlag ;
          end ;
end ;


Function CheckForPass(var TempBoard : BoardType ;
                          Player : PlayerType) : Boolean ;
var   Row,Column : integer ;
      Flag       : Boolean ;
begin
      Flag := false ;
      Row  := 1     ;
      Repeat
            Column := 1 ;
            Repeat
                  if CanPut(TempBoard,Row,Column,Player) then
                     Flag := true ;
                  Column := Column+1 ;
            until Flag or (Column > Side) ;
            Row := Row+1 ;
      until Flag or (Row > Side) ;
      CheckForPass := not Flag ; {true if Player must pass}
end ;

Procedure StatisTics(var TempBoard : BoardType   ;
                     var P1,P2     : integer) ;
var  i,j : integer ;
begin
      P1    := 0 ;
      P2    := 0 ;
      for i := 1 to Side do
      for j := 1 to Side do
          begin
               if TempBoard[i,j] = GetPlayer(PlayerS1) then P1 := P1+1 ;
               if TempBoard[i,j] = GetPlayer(PlayerS2) then P2 := P2+1 ;
          end ;
end ;

Function GetNumPut(var TempBoard : BoardType ;
                       Player    : PlayerType) : integer ;
var  i,j,Count : integer ;
begin
     Count := 0 ;
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              if CanPut(TempBoard,i,j,Player) then
                 Count := Count+1 ;
         end ;
     GetNumPut := Count ;
end ;

Function CalScore(TBoard : BoardType ; PlayerS : PlayerType) : real ;
var  Play      : PlayerType ;
     Temp,i,j  : integer ;
     Score     : real ;
     P1,P2     : integer ;
     NumPut    : integer ;
begin


     NumPut := GetNumPut(TBoard,Inverse(PlayerS)) ;
     Temp  := Side-1 ;
     Score := 0 ;
     Play  := GetPlayer(PlayerS) ;
     if TBoard[   1,   1] = Play then Score := Score+15000 ;
     if TBoard[Side,Side] = Play then Score := Score+15000 ;
     if TBoard[   1,Side] = Play then Score := Score+15000 ;
     if TBoard[Side,   1] = Play then Score := Score+15000 ;

     for i := 2 to Temp do
     for j := 2 to Temp do
         begin
              if TBoard[i,j] = Play then Score := Score+1000 ;
         end ;

{         if (TBoard[2,2] = Play) or (TBoard[2,Side-1]=Play) or
            (TBoard[Side-1,2] = Play) or (TBoard[Side-1,Side-1]=Play)
            then Score := Score-150 ;}
         if (TBoard[2,2] = Play) then
            begin
                 if ((TBoard[1,1]=Blank) or (TBoard[Side,Side]=Blank)) then
                    begin
                        Score := Score-5500 ;
                    end
                 else  Score := Score+150 ;
            end ;
         if (TBoard[2,Side-1]=Play) then
            begin
                 if ((TBoard[1,Side]=Blank) or (TBoard[Side,1]=Blank)) then
                    begin
                        Score := Score-5500 ;
                    end
                 else  Score := Score+150 ;

            end ;
         if (TBoard[Side-1,2] = Play) then
            begin
                 if ((TBoard[1,Side]=Blank) or (TBoard[Side,1]=Blank)) then
                    begin
                        Score := Score-5500 ;
                    end
                 else  Score := Score+150 ;
            end ;
                  if (TBoard[Side-1,Side-1]=Play) then
                 if ((TBoard[1,1]=Blank) or (TBoard[Side,Side]=Blank)) then
                    begin
                        Score := Score-5500 ;
                    end
                 else  Score := Score+150 ;


     for i := 2 to Temp do
         begin
              if TBoard[   1,i] = Play  then Score := Score+1500 ;
              if TBoard[Side,i] = Play  then Score := Score+1500 ;
         end ;
     for i := 2 to Temp do
         begin
              if TBoard[   i,   1] = Play  then Score := Score+1500 ;
              if TBoard[   i,Side] = Play  then Score := Score+1500 ;
         end ;


     for i := 1 to Side do
     for j := 1 to Side do
         begin
              case TBoard[i,j] of
                   PlayerS1 : P1 := P1+1 ;
                   PlayerS2 : P2 := P2+1 ;
              end ;
         end ;
{     if (Play = Player1) then CalScore := ((Score+(P1-P2)*100)/((NumPut+1)+P2)) ;
     if (Play = Player2) then CalScore := ((Score+P2)/((NumPut+1)+P1)) ;
}
        case Play of
             PlayerS1 :
                     begin
                           if NumPut <> 0 then CalScore := P1*(P1-P2)/(NumPut)+Score/P2
                           else CalScore := 1000000
                     end ;
             PlayerS2 :
                     begin
                          if NumPut <> 0 then CalScore := P2*(P2-P1)/(NumPut)+Score/P1
                          else CalScore := 1000000 ;
                     end ;
        end ;
{     CalScore := Score ;}
end ;

(*--------------------------------------------------------------------------*)

Function  BoardObjType.IsGameOver : Boolean ;
var   Flag1,Flag2 : Boolean ;
begin
     Flag1 := CheckForPass(BoardObj,PlayerS1) ;
     Flag2 := CheckForPass(BoardObj,PlayerS2) ;
     if Flag1 and Flag2 then IsGameOver := true
     else IsGameOver := false ;
end ;


Function   BoardObjType.ChkForError(Row,Column : integer ;
                        Player : PlayerType)   : Boolean ;
begin
      if CanPut(BoardObj,Row,Column,Player) then ChkForError := false
      else ChkForError := true ;
end ;

Function   BoardObjType.ChkForPass(Player : PlayerType) : Boolean ;
var   Row,Column : integer ;
      Flag       : Boolean ;
begin
      Flag := false ;
      Row  := 1     ;
      Repeat
            Column := 1 ;
            Repeat
                  if CanPut(BoardObj,Row,Column,Player) then
                     Flag := true ;
                  Column := Column+1 ;
            until Flag or (Column > Side) ;
            Row := Row+1 ;
      until Flag or (Row > Side) ;
      ChkForPass := not Flag ; {true if Player must pass}
end ;

Function   BoardObjType.CalculateScore(PlayerS : PlayerType) : real ;
var  Temp,i,j,NumPut : integer ;
     Play            : PlayerType ;
     Score           : real ;
begin
     CalculateScore := CalScore(BoardObj,PlayerS) ;
end ;

Procedure BoardObjType.ChangeBoard(Row,Column : integer ;
                                   PlayerS    : PlayerType) ;
var  Temp : Boolean ;
begin
       Temp := ChkAndChgBoard(BoardObj,BoardObj,Row,Column,PlayerS) ;
end ;

Procedure BoardObjType.Init ;
var   i,j : integer ;
begin
      for i := 1 to Side do
      for j := 1 to Side do
         BoardObj[i,j] := Blank ;
      BoardObj[4,4] := PlayerS1 ;
      BoardObj[5,5] := PlayerS1 ;
      BoardObj[4,5] := PlayerS2 ;
      BoardObj[5,4] := PlayerS2 ;

      P1Disk := 2 ;
      P2Disk := 2 ;

      P1Color := Green ;
      P2Color := Black ;

      {P1Algo  := Human ;
      P2Algo  := Human ;}
      P1Level := Easy ;
      P2Level := Expert ;
end ;

Procedure BoardObjType.ReversePlayer ;
begin
     case PlayerPlay of
          PlayerS1 : PlayerPlay := PlayerS2 ;
          PlayerS2 : PlayerPlay := PlayerS1 ;
     end ;
end ;

Procedure BoardObjType.ReverseBoard ;
var i,j,Temp : integer ;
begin
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              case BoardObj[i,j] of
                   PlayerS1 : BoardObj[i,j] := PlayerS2 ;
                   PlayerS2 : BoardObj[i,j] := PlayerS1 ;
              end ;
         end ;
     Temp   := P1Disk ;
     P1Disk := P2Disk ;
     P2Disk := Temp   ;
end ;

Procedure BoardObjType.TranposeBOard ;
var  i,j  : integer ;
     Temp : BoardType ;
begin
     Temp := BoardObj ;
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              BoardObj[i,j] := Temp[j,i] ;
         end ;
end ;

Procedure  BoardObjType.FindPlayerDisk ;
var i,j : integer ;
begin
     P1Disk := 0 ;
     P2Disk := 0 ;
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              case BoardObj[i,j] of
                   PlayerS1 : inc(P1Disk) ;
                   PlayerS2 : inc(P2Disk) ;
              end ;
         end ;
end ;

Procedure  BoardObjType.FindBestPut1(var Row,Column  : integer    ;
                                         Player      : PlayerType ;
                                         Level       : integer)   ;
var   i,j : integer ;
begin
      for i := 1 to Side do
      for j := 1 to Side do
          begin
               if Canput(BoardObj,i,j,Player) then
                  begin
                       Row := i ;
                       Column := j ;
                  end ;
          end ;
end ;

Procedure  BoardObjType.FindBestPut2(var Row,Column  : integer    ;
                                         Player      : PlayerType ;
                                         Level       : integer)   ;
begin
end ;



end.