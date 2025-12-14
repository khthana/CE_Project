Unit Reversi1 ;

interface

Const  Side          = 8  ;
       MaxPos        = 20 ;

Type   PlayerType    = (PlayerS1,PlayerS2,Blank) ;
       BoardType     = array[1..Side,1..Side] of PlayerType ;

       TBoardBase = object
                            BoardObj     : BoardType  ;
                            PlayerPlay   : PlayerType ;
                            NumBlack	 : integer ;
                            NumWhite     : integer ;

                            Procedure   Init ;
                            Procedure   Destroy ;
                            Procedure   FindNumDisc ;
                            Procedure   ChangeBoard(Row,Column : integer  ;
                                        Players : PlayerType)  ;
                            Function    ChkForPass(Player : PlayerType) : Boolean ;
                            Function    IsGameOver : Boolean ;
                   end ;

Implementation

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

Function GetRow(Operator : integer) : integer ;
begin
     if (Operator mod Side) = 0 then GetRow := (Operator div Side)
     else GetRow := (Operator div Side)+1 ;
end ;

Function GetColumn(Operator : integer) : integer ;
begin
     if (Operator mod Side) = 0 then GetColumn := Side
     else GetColumn := Operator mod Side ;
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
       if ((Row-1) < 1) or(TempBoard[Row-1,Column] <> GetOpposite(Player))
          then CheckUp_Ok := false
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
       if ((Row+1) > Side)or(TempBoard[Row+1,Column] <> GetOpposite(Player))
           then CheckDown_Ok := false
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
       if (Row-1 < 1) or (Column+1 > Side) or
          (TempBoard[Row-1,Column+1] <> GetOpposite(Player))
          then CheckUpRight_Ok := false
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
       if (Row+1 > Side) or (Column+1 > Side) or
          (TempBoard[Row+1,Column+1] <> GetOpposite(Player))
          then CheckDownRight_Ok := false
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
       if  (Row-1 < 1) or (Column-1 < 1)or
           (TempBoard[Row-1,Column-1] <> GetOpposite(Player))
           then CheckUpLeft_Ok := false
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
       if (Row+1 > Side) or (Column-1 < 1) or
          (TempBoard[Row+1,Column-1] <> GetOpposite(Player))
          then CheckDownLeft_Ok := false
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
      if  (Row <= 8) and (Row >=1) and (Column <=8) and (Column >=1) and
          (TempBoard1[Row,Column] <> Blank) then ChkAndChgBoard := false

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

Procedure TBoardBase.Init ;
var i,j : integer ;
begin
      for i := 1 to Side do
      for j := 1 to Side do
          BoardObj[i,j] := Blank ;
      BoardObj[4,4] := PlayerS1 ;
      BoardObj[5,5] := PlayerS1 ;
      BoardObj[4,5] := PlayerS2 ;
      BoardObj[5,4] := PlayerS2 ;

      NumBlack   := 2 ;
      NumWhite   := 2 ;
end ;

Procedure TBoardBase.FindNumDisc ;
begin
     Statistics(BoardObj,NumBlack,NumWhite) ;
end ;

Procedure TBoardBase.Destroy ;
begin
end ;

Function  TBoardBase.IsGameOver : Boolean ;
var   Flag1,Flag2 : Boolean ;
begin
     Flag1 := CheckForPass(BoardObj,PlayerS1) ;
     Flag2 := CheckForPass(BoardObj,PlayerS2) ;
     if Flag1 and Flag2 then IsGameOver := true
     else IsGameOver := false ;
end ;

Function   TBoardBase.ChkForPass(Player : PlayerType) : Boolean ;
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

Procedure TBoardBase.ChangeBoard(Row,Column : integer ;
                                   PlayerS    : PlayerType) ;
var  Temp : Boolean ;
begin
       Temp := ChkAndChgBoard(BoardObj,BoardObj,Row,Column,PlayerS) ;
end ;

end.