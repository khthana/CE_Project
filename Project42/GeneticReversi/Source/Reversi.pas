Unit Reversi ;
interface

 {$R+}
uses Board2 ;
Const  Side          = 8  ;
       MaxPos        = 20 ;

Type   PlayerType    = (PlayerS1,PlayerS2,Blank) ;
       BoardType     = array[0..Side+1,0..Side+1] of PlayerType ;

       TBoardBase = object
                            BoardObj     : BoardType  ;
                            PlayerPlay   : PlayerType ;
                            NumBlack	 : integer ;
                            NumWhite     : integer ;

                            Procedure   Init ;
                            Procedure   Destroy ;
                            Procedure   FindNumDisc ;
                            Function    FindFitness(Player : PlayerType) : real ;
                            Procedure   ChangeBoard(Row,Column : integer)  ;
                            Function    ChkForPass(Player : PlayerType): Boolean ;
                            Function    IsGameOver : Boolean ;
                            Function    IsCanPut(Row,Column : integer): Boolean ;
                            Procedure   ConventionMove(var Level : Integer ;
                                                       var Weight : WeightObj) ;
                            Procedure   Reversed ;
                            Procedure   Transpose ;
                   end ;

Implementation

var Max : real ;

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

Function IsInBoard(Row,Col : integer) : Boolean ;
begin
     if (Row <= Side) and (Row >= 1) and
        (Col <= Side) and (Col >= 1) then IsInBoard := true
     else IsInBoard := false ;
end ;

Function CheckLeft_Ok(var TempBoard  : BoardType  ;
                          Row,Column : integer ;
                          Player     : PlayerType) : Boolean ;
var  Check_Ok : Boolean ;
     i        : integer ;
begin
       Check_Ok := false ;
       i        := 1     ;
       if (not IsInBoard(Row,Column)) then CheckLeft_Ok := false
       else
       if ((Column-1) < 1) or ((Column-1) > Side) or
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
       if (not IsInBoard(Row,Column)) then CheckRight_Ok := false
       else
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
       if (not IsInBoard(Row,Column)) then CheckUp_Ok := false
       else

       if ((Row <= 1)) then CheckUp_Ok := false
       else
           if (Row > Side) then CheckUp_Ok := false
              else
              if (TempBoard[Row-1,Column] <> GetOpposite(Player)) then
                 CheckUp_Ok := false
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

       if (not IsInBoard(Row,Column)) then CheckDown_Ok := false
       else

       if ((Row+1) > Side)or(TempBoard[Row+1,Column] <> GetOpposite(Player))
          or ((Row+1) < 1)
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
       if (not IsInBoard(Row,Column)) then CheckUpRight_Ok := false
       else

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
       if (not IsInBoard(Row,Column)) then CheckDownRight_Ok := false
       else

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
       if (not IsInBoard(Row,Column)) then CheckUpLeft_Ok := false
       else

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
       if (not IsInBoard(Row,Column)) then CheckDownLeft_Ok := false
       else

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
               Flag2 := CheckRight_Ok(TempBoard1,Row,Column,Player) ;
               Flag1 := CheckLeft_Ok(TempBoard1,Row,Column,Player) ;
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
               Flag2 := CheckRight_Ok(TempBoard1,Row,Column,Player) ;
               Flag1 := CheckLeft_Ok(TempBoard1,Row,Column,Player) ;
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

Function Perfect(var Brd1 : BoardType ; Plyer : PlayerType) : real ;
var i,j  : integer ;
    flag : boolean ;
begin
     i := 1 ;
     j := 1 ;
     flag := false ;
     while (i <= 8) and not flag do
           begin
                while (j <= 8) and not flag do
                      begin
                           if Brd1[i,j] = Inverse(Plyer) then
                              flag := true ;
                           j := j+1 ;
                      end ;
                i := i+1 ;
           end ;
     if flag then Perfect := 0
     else Perfect := 1 ;
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

Function Edge(var Brd : BoardType ; Plyer : PlayerType) : real ;
var Sum,j : integer ;
begin
     Sum := 0 ;
     for j := 1 to 8 do
         begin
              if Brd[1,j] = Plyer then Sum := Sum+1 ;
              if Brd[8,j] = Plyer then Sum := Sum+1 ;
              if Brd[j,1] = Plyer then Sum := Sum+1 ;
              if Brd[j,8] = Plyer then Sum := Sum+1 ;
         end ;
     Edge := Sum ;
end ;

Function CXSquare(var Brd1 : BoardType ; Plyer : PlayerType) : real ;
var Sum  : integer ;
begin
     Sum := 0 ;
     if Brd1[1,1]=Plyer then
        begin
             if Brd1[2,2]=Plyer then Sum := Sum+5 ;
             if Brd1[1,2]=Plyer then Sum := Sum+5 ;
             if Brd1[2,1]=Plyer then Sum := Sum+5 ;
        end
     else
         begin
             if Brd1[2,2]=Plyer then Sum := Sum-5 ;
             if Brd1[1,2]=Plyer then Sum := Sum-5 ;
             if Brd1[2,1]=Plyer then Sum := Sum-5 ;
         end ;

     if Brd1[1,Side] = Plyer then
        begin
             if Brd1[1,Side-1]=Plyer then Sum := Sum+5 ;
             if Brd1[2,Side-1]=Plyer then Sum := Sum+5 ;
             if Brd1[2,Side  ]=Plyer then Sum := Sum+5 ;
        end
     else
         begin
             if Brd1[1,Side-1]=Plyer then Sum := Sum-5 ;
             if Brd1[2,Side-1]=Plyer then Sum := Sum-5 ;
             if Brd1[2,Side  ]=Plyer then Sum := Sum-5 ;
         end ;

     if Brd1[Side,1] = Plyer then
        begin
             if Brd1[Side-1,2]=Plyer then Sum := Sum+5 ;
             if Brd1[Side-1,1]=Plyer then Sum := Sum+5 ;
             if Brd1[Side,2  ]=Plyer then Sum := Sum+5 ;
        end
     else
         begin
             if Brd1[Side-1,2]=Plyer then Sum := Sum-5 ;
             if Brd1[Side-1,1]=Plyer then Sum := Sum-5 ;
             if Brd1[Side,2  ]=Plyer then Sum := Sum-5 ;
         end ;

     if Brd1[Side,Side] = Plyer then
        begin
             if Brd1[Side-1,Side-1]=Plyer then Sum := Sum+5 ;
             if Brd1[Side,Side-1  ]=Plyer then Sum := Sum+5 ;
             if Brd1[Side-1,Side  ]=Plyer then Sum := Sum+5 ;
        end
     else
         begin
             if Brd1[Side-1,Side-1]=Plyer then Sum := Sum-5 ;
             if Brd1[Side,Side-1  ]=Plyer then Sum := Sum-5 ;
             if Brd1[Side-1,Side  ]=Plyer then Sum := Sum-5 ;
         end ;
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

Function CalScoreS(var TBoard : BoardType ; PlayerS : PlayerType ;
                   var Weigh  : WeightObj) : real ;
var  Oop,Play      : PlayerType ;
     W1,Temp,i,j  : integer ;
     Score     : real ;
     P1,P2         : integer ;
     NumP1,NumP2   : real ;
     CornP1,CornP2 : real ;
     SqrP1,SqrP2   : real ;
     FontP1,FontP2 : real ;
     MobP1,MobP2   : real ;
begin
     Score := 0 ;

     if CheckForPass(TBoard,PlayerS1) and
        CheckForPass(TBoard,PlayerS2)then W1 := Weigh.W_DifferP1
     else W1 := 0 ;

     Oop   := GetOpposite(PlayerS) ;

     CornP1 := Corner(TBoard,PlayerS)   ;
     CornP2 := Corner(TBoard,Oop)       ;
     SqrP1  := CXSquare(TBoard,PlayerS) ;
     SqrP2  := CXSquare(TBoard,Oop)     ;
     FontP1 := Perfect(TBoard,PlayerS)  ;
     FontP2 := Perfect(TBoard,Oop)      ;
     MobP1  := Mobility(TBoard,PlayerS) ;
     MobP2  := Mobility(TBoard,Oop)     ;
     StatisticS(TBoard,P1,P2) ;

     with Weigh do
          begin
               Score := W_CornerP1*CornP1  + W_CornerP2*CornP2+
                        W_CXSquareP1*SqrP1 + W_CornerP2*SqrP2+
                        W_FontierP1*FontP1 + W_FontierP2*FontP2+
                        W_MobilityP1*MobP1 + W_MobilityP2*MobP2+
                        W1*(P1+P2)  ;
          end ;
     CalScoreS := Score ;
end ;


Procedure NegGaMax(var Board             : BoardType  ;
                       P1,P2             : PlayerType ;
                   var i,j               : integer    ;
                       Depth             : integer    ;
                   var BoardValue        : real)      ;

var TBoard1,TBoard2   : BoardType ;
    flag              : boolean   ;
    TRow,TCol,Row,Col : integer ;
    TRow1,TCol1       : integer ;
    TPlayer           : PlayerType ;
    Score,TMax,TMin   : real ;

begin
     flag := false ;
     TBoard1 := Board ;

     if Depth <= 0 then
        begin
             Score := CalScoreS(TBoard1,P1,Weight1) ;
             BoardValue := Score ;
        end
     else
         if CheckForPass(TBoard1,P2) then
            begin
                 TPlayer := Inverse(P2) ;
                 NegGaMax(TBoard1,P1,TPlayer,TRow1,TCol1,Depth-1,Score) ;
                 if P1=P2 then Score := -1*Score ;
                 BoardValue := Score ;
            end
         else

     begin  {CheckForPass}
          for Row := 1 to Side do
          for Col := 1 to Side do
              begin
                   if ChkAndChgBoard(TBoard1,TBoard2,Row,Col,P2) then
                      begin
                           TPlayer := Inverse(P2) ;
                           NegGaMax(TBoard2,P1,TPlayer,TRow1,TCol1,Depth-1,Score) ;
                           if P1 = P2 then Score := -1*Score ;

                           if not flag then
                              begin
                                   TMax := Score ;
                                   TMin := Score ;
                                   TRow := Row   ;
                                   TCol := Col   ;
                                   flag := true  ;
                              end {if not flag}
                           else {if not flag}

                                if Score >= TMax then
                                       begin
                                            TMax := Score ;
                                            TRow := Row   ;
                                            TCol := Col   ;
                                       end

                      end {ChkAndChgBoard}
              end ; {for}
              BoardValue := TMax ;
              i := TRow ;
              j := TCol ;
     end ;
end ;

Procedure MiniMax(var Board              : BoardType  ;
                       P1,P2             : PlayerType ;
                   var i,j               : integer    ;
                       Depth             : integer    ;
                   var BoardValue        : real ;
                   var Weight            : WeightObj) ;

var TBoard1,TBoard2   : BoardType ;
    flag              : boolean   ;
    TRow,TCol,Row,Col : integer ;
    TRow1,TCol1       : integer ;
    TPlayer           : PlayerType ;
    Score,TMax,TMin   : real ;

begin
     flag := false ;
     TBoard1 := Board ;

     if Depth <= 0 then
        begin
             Score := CalScoreS(TBoard1,P1,Weight) ;
             BoardValue := Score ;
        end
     else
         if CheckForPass(TBoard1,P2) then
            begin
                 TPlayer := Inverse(P2) ;
                 Minimax(TBoard1,P1,TPlayer,TRow1,TCol1,Depth-1,Score,Weight) ;
                 BoardValue := Score ;
            end
         else

     begin  {CheckForPass}
          for Row := 1 to Side do
          for Col := 1 to Side do
              begin
                   if ChkAndChgBoard(TBoard1,TBoard2,Row,Col,P2) then
                      begin
                           TPlayer := Inverse(P2) ;
                           Minimax(TBoard2,P1,TPlayer,TRow1,TCol1,Depth-1,Score,Weight) ;
                           if not flag then
                              begin
                                   TMax := Score ;
                                   TMin := Score ;
                                   TRow := Row   ;
                                   TCol := Col   ;
                                   flag := true  ;
                              end {if not flag}
                           else {if not flag}
                               if P1 = P2 then
                                  begin
                                    if Score >= TMax then
                                       begin
                                            TMax := Score ;
                                            TRow := Row   ;
                                            TCol := Col   ;
                                       end
                                  end
                               else
                                   if Score <= TMin then
                                      begin
                                           TMin := Score ;
                                           TRow := Row   ;
                                           TCol := Col   ;
                                      end ;
                      end {ChkAndChgBoard}
              end ; {for}
              if P1 = P2 then
                 begin
                      BoardValue := TMax ;
                      i := TRow ;
                      j := TCol ;
                 end
              else
                  begin
                       BoardValue := TMin ;
                       i          := TRow ;
                       j          := TCol ;
                  end ;
     end ;
end ;

Procedure  FindBestPut1(var Brd : BoardType ; var Row,Column  : integer    ;
                        Player      : PlayerType ;
                        Level       : integer    ;
                        var Weight  : WeightObj)   ;
var  Temp : real ;
begin
     MiniMax(Brd,Player,Player,Row,Column,Level,Temp,Weight) ;
end ;


Procedure TBoardBase.Init ;
var i,j : integer ;
begin
     Max := -1000000000 ;
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

Function TBoardBase.IsCanPut(Row,Column : integer): Boolean ;
begin
     if Canput(BoardObj,Row,Column,PlayerPlay) then
        IsCanPut := true
     else IsCanPut := false ;
end ;

Function   TBoardBase.FindFitness(Player : PlayerType) : real ;
var  P1,P2 : integer ;
     Temp  : integer ;
begin
     Statistics(BoardObj,P1,P2) ;
     case Player of
          PlayerS1 : Temp := P1-P2 ;
          PlayerS2 : Temp := P2-P1 ;
     end ;
     FindFitness := Temp+64 ;
end ;

Procedure TBoardBase.Reversed ;
var  i,j  : integer ;
begin
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              if BoardObj[i,j] <> Blank then
                 BoardObj[i,j] := Inverse(BoardObj[i,j]) ;
         end ;
     Statistics(BoardObj,NumBlack,NumWhite) ;
end ;

Procedure TBoardBase.Transpose ;
var i,j  : integer ;
    TempBoard : BoardType ;
begin
     for i := 1 to Side do
     for j := 1 to Side do
         begin
              TempBoard[i,j] := BoardObj[j,i];
         end ;
     BoardObj := TempBoard ;
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

Procedure TBoardBase.ChangeBoard(Row,Column : integer) ;
var  Temp : Boolean ;
begin
       Temp := ChkAndChgBoard(BoardObj,BoardObj,Row,Column,PlayerPlay) ;
       if not ChkForPass(Inverse(PlayerPlay)) then
          PlayerPlay := Inverse(PlayerPlay) ;
       Statistics(BoardObj,NumBlack,NumWhite) ;
end ;

Procedure TBoardBase.ConventionMove(var Level  : Integer ;
                                    var Weight : WeightObj) ;
var  Row,Col : integer ;
     Temp    : Boolean ;
begin
     FindBestPut1(BoardObj,Row,Col,PlayerPlay,Level,Weight) ;
     Temp := ChkAndChgBoard(BoardObj,BoardObj,Row,Col,PlayerPlay) ;
     if not ChkForPass(Inverse(PlayerPlay)) then
        PlayerPlay := Inverse(PlayerPlay)
     else
         begin
            Repeat
              FindBestPut1(BoardObj,Row,Col,PlayerPlay,Level,Weight) ;
              Temp := ChkAndChgBoard(BoardObj,BoardObj,Row,Col,PlayerPlay) ;
            Until (not ChkForPass(Inverse(PlayerPlay))) or
                  (IsGameOver);
            PlayerPlay := Inverse(PlayerPlay) ;
         end ;
     Statistics(BoardObj,NumBlack,NumWhite) ;
end ;


Begin
end.
