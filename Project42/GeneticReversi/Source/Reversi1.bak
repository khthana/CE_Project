Unit Reversi1 ;

interface

Const  Side          = 8  ;
       MaxPos        = 20 ;

Type   PlayerType    = (PlayerBlack,PlayerWhite,Blank) ;
       AlgoType      = (Conventional,Genetics,Human);
       LevelType     = (Easy,Medium,Expert,Master) ;
       ColorType     = (Green,Black) ;
       BoardType     = array[1..Side,1..Side] of PlayerType ;

       State      = Record
                        Board       : BoardType ;
                        PlayNumber  : PlayerType ; {who  see this board}
                        CurOptr,Optr,Depth  : integer ;
                        Play1Num,Play2Num : integer ; (* Number of player1 and
                                                         player2 *)
                        MaxOptr     : integer ;
                    end ;
       StackPtr   = ^StackType ;
       StackType  = Record
                        PlayerState : State    ;
                        Next        : StackPtr ;
                    end ;

       TBoardBase = object
                            BoardObj     : BoardType  ;
                            PlayerPlay   : PlayerType ;
                            NumBlack	 : integer ;
                            NumWhite     : integer ;

                            Procedure   Init ;
                            Procedure   Destroy ;
                            Procedure   ChangeBoard(Row,Column : integer  ;
                                        Players : PlayerType)  ;
                            Function    ChkForPass(Player : PlayerType) : Boolean ;
                            Function    IsGameOver : Boolean ;
                   end ;

       BoardObjType   = Object(TBoardBase)
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
                             Procedure  FindBestPut1(var Row,Column  : integer ;
                                        Player : PlayerType ; Level : integer) ;
                             Procedure  FindBestPut2(var Row,Column  : integer ;
                                        Player : PlayerType ; Level : integer) ;
                             Procedure  ReversePlayer ;
                             Procedure  ReverseBoard  ;
                             Procedure  TranposeBoard ;
                             Procedure  FindPlayerDisk ;

                             Function   CalculateScore(PlayerS : PlayerType) : real;
                             Function   ChkForError(Row,Column : integer ;
                                        Player : PlayerType)   : Boolean ;
                        end ;
       Function Fontier(var Brd1 : BoardType ; Plyer
                                 : PlayerType) : integer ;
       Function CXSquare(var Brd1 : BoardType ; Plyer
                                  : PlayerType) : integer ;
implementation


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


Function Mobility(var TempBoard : BoardType ;
                      Player    : PlayerType) : real ;
var  i,j,Count : integer ;
begin
     Count := 0 ;
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              if CanPut(TempBoard,i,j,Player) then
                 Count := Count+1 ;
         end ;
     Mobility := Count ;
end ;

Function Corner(var Brd1 : BoardType ; Plyer : PlayerType) : real ;
var  Sum : integer ;
begin
     Sum := 0 ;
     if Brd1[1,1   ]=Plyer then Sum := Sum+1 ;
     if Brd1[1,Side]=Plyer then Sum := Sum+1 ;
     if Brd1[Side,1]=Plyer then Sum := Sum+1 ;
     if Brd1[Side,Side]=Plyer then Sum := Sum+1 ;
     Corner := Sum ;
end ;

Function CXSquare(var Brd1 : BoardType ; Plyer : PlayerType) : real ;
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

Function Fontier(var Brd1 : BoardType ; Plyer : PlayerType) : real ;
var Sum,i,j  : integer ;
begin
     Sum := 0 ;
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              if FontierDisc(Brd1,i,j,Plyer) then
                 Sum := Sum+1 ;
         end ;
     Fontier := Sum ;
end ;

Function CalScore(var TBoard : BoardType ; PlayerS : PlayerType) : real ;
var  Oop,Play      : PlayerType ;
     Temp,i,j  : integer ;
     Score     : real ;

     P1,P2         : integer ;
     NumP1,NumP2   : real ;
     CornP1,CornP2 : real ;
     SqrP1,SqrP2   : real ;
     FontP1,FontP2 : real ;
     MobP1,MobP2   : real ;
begin
     Score := 0 ;
     Oop   := GetOpposite(PlayerS) ;

     CornP1 := Corner(TBoard,PlayerS)   ;
     CornP2 := Corner(TBoard,Oop)       ;
     SqrP1  := CXSquare(TBoard,PlayerS) ;
     SqrP2  := CXSquare(TBoard,Oop)     ;
     FontP1 := Fontier(TBoard,PlayerS)  ;
     FontP2 := Fontier(TBoard,Oop)      ;
     MobP1  := Mobility(TBoard,PlayerS) ;
     MobP2  := Mobility(TBoard,Oop)     ;
     StatisticS(TBoard,P1,P2) ;

     Score := (500*CornP1-CornP2)+(-100*SqrP1)+
              (FontP2-FontP1)+(MobP1-MobP2)+
              10*(P1-P2)  ;
{
     for i := 1 to side do
     for j := 1 to side do
         if TBoard[i,j]=Players then Score:=Score+1 ;
}
     CalScore := Score ;
end ;

Procedure Push(var TopS : StackPtr ; PlayerSt : State) ; {initial TopS = nil}
var    Temp : StackPtr ;
begin
       if TopS = nil then
          begin
               new(TopS) ;
               TopS^.PlayerState := PlayerSt ;
               TopS^.Next        := nil ;
          end
       else
           begin
                new(Temp) ;
                Temp^.PlayerState := PlayerSt ;
                Temp^.Next        := TopS ;
                TopS              := Temp ;
           end ;
end ;

Procedure Pop(var TopS : StackPtr ; var PlayerSt : State) ;
var  Temp : StackPtr ;
begin
     if TopS <> nil then
        begin
             Temp := TopS ;
             PlayerSt := TopS^.PlayerState ;
             TopS := TopS^.Next ;
             dispose(Temp) ;
        end ;
end ;

Procedure ClearStack(var TopS : StackPtr) ; (* Clear stack until empty *)
var   Temp : State ;
begin
      while (TopS <> nil) do
            begin
                  Pop(TopS,Temp) ;
            end ;
end ;

Procedure TopStack(TopS : StackPtr ; var PlayerSt : State) ;
begin
     if TopS <> nil then
        begin
             PlayerSt := TopS^.PlayerState ;
        end ;
end ;

Function ApplyAble(var State1,State2 : State ; Level : integer) : Boolean ;
var  Rows,Cols : integer ;
begin

     State2 := State1 ;
     Rows   := GetRow(State1.CurOptr) ;
     Cols   := GetColumn(State1.CurOptr) ;

     if (State1.Depth < Level) and (State1.CurOptr <= State1.MaxOptr) and
        ChkAndChgBoard(State1.Board,State2.Board,Rows,Cols,State1.PlayNumber)
     then
        begin
             with State2 do
                  begin
                       CurOptr := 1 ;
                       MaxOptr := State1.MaxOptr   ;
                       PlayNumber := GetOpposite(State1.PlayNumber) ;
                       Depth      := State1.Depth+1 ;
                       ApplyAble  := true ;
                  end ;
        end
     else ApplyAble := false ;
end ;

Function ChkPass(var Boards1 : BoardType ; Player : PlayerType) : Boolean ;
var   Row,Column : integer ;
      Flag       : Boolean ;
begin
      Flag := false ;
      Row  := 1     ;
      Repeat
            Column := 1 ;
            Repeat
                  if CanPut(Boards1,Row,Column,Player) then
                     Flag := true ;
                  Column := Column+1 ;
            until Flag or (Column > Side) ;
            Row := Row+1 ;
      until Flag or (Row > Side) ;
      ChkPass := not Flag ; {true if Player must pass}
end ;
(*
Function FindMin1(var Boards1 : BoardType ; PlayerSee : PlayerType ;
                      Level   : integer) : Real ;
var  OldState,TopState,NewState : State ;
     Tops              : StackPtr ;
     Max,Min,Temp      : real ;
     TRow,TCol         : integer ;
begin
     Min  := 100000000 ;
     Max  := -100 ;
     Temp := 50 ;
     Tops := nil ;
     with OldState do
          begin
                Board := Boards1 ;
                PlayNumber := PlayerSee ;
                CurOptr    := 1  ;
                MaxOptr    := 64 ;
                Depth      := 1  ;
          end ;
     push(Tops,OldState) ;
     TopStack(Tops,TopState) ;
     while (Tops <> nil) do
           begin
                if TopState.Depth = Level then
                   begin
                       Temp := CalScore(Boards1,TopState.PlayNumber) ;
                       if Temp > Max then Max := temp ;
                       if Temp < Min then Min := Temp ;
                   end ;
                if ApplyAble(TopState,NewState,Level) then
                   begin
                        inc(tops^.PlayerState.CurOptr) ;
                        Push(Tops,NewState) ;
                   end
                else
                    begin
                         if ChkPass(TopState.Board,TopState.PlayNumber) or
                            (TopState.CurOptr > TopState.MaxOptr) or
                            (TopState.Depth >= Level)
                         then
                            Pop(Tops,NewState)
                         else inc(Tops^.PlayerState.CurOptr) ;
                    end ;
                TopStack(Tops,TopState) ;
           end ;
     FindMin1 := Min ;
end ;
*)
(*
Function FindMin1(var Boards1 : BoardType ; PlayerSee : PlayerType ;
                      Level   : integer) : Real ;

var  TPlayer : PlayerType ;
     NewBoard1,NewBoard2  : BoardType ;
     TRow,TCol,i,j,k      : integer ;
     flag1,flag2          : boolean ;
     Max,Min,Temp         : real    ;
begin
     i := 1 ;
     j := 1 ;
     k := 1 ;
     Max := -10  ;
     Min := 1000000 ;

     flag1 := false ;
     while i <= 64 do
         begin
              TPlayer := PlayerSee ;
              if CheckForPass(Boards1,TPlayer) then
                 begin
                      i := 64 ;
                      NewBoard1 := Boards1 ;
                      flag1 := true ;
                 end ;
                 TRow := GetRow(i) ;
                 TCol := GetColumn(i) ;
                 TPlayer := PlayerSee ;
                 if flag1 or ChkAndChgBoard(Boards1,NewBoard1,TRow,TCol,TPlayer)
                 then
                    begin
                         j :=  1 ;
                         while j <= 64 do
                               begin
                                    flag2 := false ;
                                    TPlayer := GetOpposite(TPlayer) ;
                                    if CheckForPass(NewBoard1,TPlayer) then
                                       begin
                                            j := 64 ;
                                            NewBoard2 := NewBoard1 ;
                                            flag2 := true ;
                                       end ;
                                    //TPlayer := GetOpposite(TPlayer) ;
                                    TRow    := GetRow(j) ;
                                    TCol    := GetColumn(j) ;
                                    if flag2 or ChkAndChgBoard(NewBoard1,NewBoard2,TRow,TCol,TPlayer)
                                    then
                                      begin
                                           Temp := CalScore(NewBoard2,TPlayer) ;
                                           if Temp > Max then Max := temp ;
                                           if Temp < Min then Min := Temp ;
                                      end ;
                                    j := j+1 ;
                               end ;
                    end ;
              i := i+1 ;
         end ;
         FindMin1 := Min ;
end ;
*)

Function FindMin3(var Boards1 : BoardType ; PlayerSee : PlayerType ;
                      Level   : integer) : Real ;
begin
     FindMin3 := CalScore(BoardS1,PlayerSee) ;
end ;

Function FindMin2(var Boards1 : BoardType ; PlayerSee : PlayerType ;
                      Level   : integer) : Real ;
var  Temp,Min,MiniMax : real       ;
     i,j,TRow,TCol    : integer    ;
     TempBoard,NewBoard : BoardType  ;
     Opp              : PlayerType ;
     flag             : boolean ;
begin
     Minimax  := -1000000000;
     flag     := false ;
     if CheckForPass(Boards1,PlayerSee) then
        begin
             Opp := GetOpposite(PlayerSee) ;
             MiniMax := FindMin3(BoardS1,Opp,Level) ;
        end
     else
         for i := 1 to Side do
         for j := 1 to Side do
             begin
              if ChkAndChgBoard(BoardS1,TempBoard,i,j,PlayerSee) then
                 begin
                      TRow := i ;
                      TCol := j ;
                      Opp := GetOpposite(PlayerSee) ;
                      Min := FindMin3(TempBoard,Opp,Level) ;
                      if Min >= MiniMax then
                         begin
                              MiniMax := Min ;
                              flag    := true ;
                         end ;
                 end ;
             end ;
         FindMin2 := MiniMax ;
end ;


Function FindMin1(var Boards1 : BoardType ; PlayerSee : PlayerType ;
                      Level   : integer) : Real ;
var  Temp,Min,MiniMax : real       ;
     i,j,TRow,TCol    : integer    ;
     TempBoard,NewBoard : BoardType  ;
     Opp              : PlayerType ;
     flag             : boolean ;
begin
     Minimax  := -1000000000;
     flag     := false ;
     if CheckForPass(Boards1,PlayerSee) then
        begin
             Opp := GetOpposite(PlayerSee) ;
             MiniMax := FindMin2(BoardS1,Opp,Level) ;
        end
     else
         for i := 1 to Side do
         for j := 1 to Side do
             begin
              if ChkAndChgBoard(BoardS1,TempBoard,i,j,PlayerSee) then
                 begin
                      Opp := GetOpposite(PlayerSee) ;
                      Min := FindMin2(TempBoard,Opp,Level) ;
                      if Min >= MiniMax then
                         begin
                              MiniMax := Min ;
                              flag    := true ;
                         end ;
                 end ;
             end ;
         FindMin1 := MiniMax ;
end ;


(*--------------------------------------------------------------------------*)

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


Function   BoardObjType.ChkForError(Row,Column : integer ;
                        Player : PlayerType)   : Boolean ;
begin
      if CanPut(BoardObj,Row,Column,Player) then ChkForError := false
      else ChkForError := true ;
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

Function   BoardObjType.CalculateScore(PlayerS : PlayerType) : real ;
var  Temp,i,j,NumPut : integer ;
     Play            : PlayerType ;
     Score           : real ;
begin
     CalculateScore := CalScore(BoardObj,PlayerS) ;
end ;

Procedure TBoardBase.ChangeBoard(Row,Column : integer ;
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
var  Temp,Min,MiniMax : real       ;
     i,j,TRow,TCol    : integer    ;
     TempBoard        : BoardType  ;
     Opp              : PlayerType ;
     flag             : boolean ;
begin
     Minimax  := 1000000000;
     flag     := false ;
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              if ChkAndChgBoard(BoardObj,TempBoard,i,j,Player) then
                 begin
                      TRow := i ;
                      TCol := j ;
                      Opp := GetOpposite(Player) ;
                      Min := FindMin1(TempBoard,Opp,Level) ;
                      if Min <= MiniMax then
                         begin
                              MiniMax := Min ;
                              Row     := i   ;
                              Column  := j   ;
                              flag    := true ;
                         end ;
                 end ;
         end ;
     if not flag then
        begin
             Row := TRow ;
             Column := TCol ;
        end ;
end ;

Procedure  BoardObjType.FindBestPut2(var Row,Column  : integer    ;
                                         Player      : PlayerType ;
                                         Level       : integer)   ;
begin
end ;



end.