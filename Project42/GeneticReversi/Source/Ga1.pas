Unit    GA1 ;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls ;

Const    MaxLength = 60 ;
         MaxChrom  = 50 ;
         Numbit    = 6  ;
Type
         ChromType   = array[1..MaxLength] of char ;
         CrossType   = (OnePoint,TwoPoint) ;
         SelectType  = (Tournament,Roulette) ;
         String20    = String[20] ;

         TChromosome = object
                         Genotype  : ChromType ;
                         Lchrom    : integer   ;
                         Evaluate  : real      ;
                         Fitness   : real      ;
                         Number    : integer   ;
                         Gen       : integer   ;

                         Procedure DisPlay ;
                         Procedure Init ;
                         Procedure AddFitness(FValue  : real) ;
                         Procedure AddEvaluate(EValue : real) ;
//                         Procedure GetPhenoType(NumBit : integer) ;
                         Procedure AddChrom(var Phenome : ChromType) ;
                       end ;

         TChromList  = object
                         NumChrom  :  integer ;
                         ChromList :  array[1..MaxChrom] of TChromosome ;

                         Procedure Init ;
                         Procedure DisPlay ;
                       end ;

         TPopulation = object
                         PCross      : real    ;
                         PMute       : real    ;
                         CurPop      : integer ;
                         PopSize     : integer ;
                         Generation  : integer ;
                         ChromNumber : integer ;
                         Population  : TChromList ;
                         Crosstype   : CrossType  ;
                         Selecttype  : SelectType ;
                         InvertOptr  : boolean ;
                         SumFitness  : real ;
                         Average     : real ;
                         MaxChrom    : TChromosome ;
                         MinChrom    : TChromosome ;

                         Procedure Init ;
                         Procedure Selection   ;
                         Procedure CrossOver   ;
                         Procedure Mutation    ;
                         {Procedure CreateNextGen ;}
                         Procedure DisPlay     ;
                         Procedure UpdateGen   ;
                         Procedure CalSumFitness ;
                         Procedure CalFitNess(ChromNum  : integer) ;
                         Procedure SetFitNess(ChromNum  : integer ; fit : real) ;
                         Function  GetFitNess(ChromNum  : integer) : real ;
                         Procedure CalEvaluate(ChromNum : integer) ;
                         Procedure WriteToFile(FName : String20) ;
                         Procedure ReadFromFile(FName : String20) ;
                         Procedure FindMaxMin ;
                         Procedure GetChrom(ChromNum : integer ; var ChromS : ChromType) ;
                         Procedure ReportToFile(FName : String20) ;
                       end ;


                       Procedure Cross(var Par1,Par2,Chld1,Chld2 : TChromosome ;
                                           Pc : real) ;
                       Procedure Mutate(var Chrom1,Chrom2 : TChromosome ; Pm : real) ;

implementation
uses Board2 ;
var Spool : TChromList ;


Procedure TChromosome.DisPlay ;
var  i,Num : integer ;
begin
     Num := LChrom ;

{     Write('Parent1  = ') ;
     for i := 1 to Num do
         begin
              write(Phenotype[i]) ;
         end ;
     writeln ;

     Write('Parent2  = ') ;
     for i := 1 to Num do
         begin
              write(Phenotype[i]) ;
         end ;
     writeln ;
}
     Write('Chrom    = ') ;
     for i := 1 to Num do
         begin
              write(Genotype[i]) ;
         end ;
     writeln ;

     Writeln('Chrom No = ',Number) ;
     Writeln('LChrom   = ',LChrom) ;
     Writeln('Fitness  = ',Fitness:5:5) ;
     Writeln('Evaluate = ',Evaluate:5:5) ;
     writeln ;
end ;

Procedure TChromosome.Init ;
var  i,Rand : integer ;
begin
     LChrom   := MaxLength ;
     Evaluate := 0 ;
     Fitness  := 0 ;

     for i := 1 to LChrom do
     { generate chromosome }
         begin
              Rand := random(100) ;
              if Rand > 50 then Genotype[i] := '1'
              else Genotype[i] := '0' ;
         end ;
end ;

Procedure TChromosome.AddFitness(FValue  : real) ;
begin
     Fitness := FValue ;
end ;

Procedure TChromosome.AddEvaluate(EValue : real) ;
begin
     Evaluate := Evalue ;
end ;

Procedure TChromosome.AddChrom(var Phenome : ChromType) ;
begin
     Genotype := Phenome ;
end ;

Procedure TChromList.DisPlay ;
var i : integer ;
begin
    for i := 1 to NumChrom do
        begin
             ChromList[i].DisPlay ;
        end ;
end ;

Procedure TChromList.Init ;
var i : integer ;
begin
     for i := 1 to NumChrom do
         begin
              ChromList[i].Number := i ;
              ChromList[i].Init ;
         end ;
end ;

Function Rnd(St,Ed : integer) : integer ;
         {random value between St and Ed (Ed>St) }
begin
      Rnd := Random(Ed-St+1)+St ;
end ;

Function Flip(PopFlip : real) : boolean ; {}
var Rand : integer ;
begin
    Rand := Random(100) ;
    if Rand < PopFlip*100 then Flip := true
    else Flip := false ;
end ;

Function FlipBit(Bit : Char) : Char ;
begin
     case Bit of
          '1' : FlipBit := '0' ;
          '0' : FlipBit := '1' ;
     end ;
end ;

Procedure Mutate(var Chrom1,Chrom2 : TChromosome ; Pm : real) ;
var i,Num : integer ;
begin
    Num := Chrom1.LChrom ;
    Chrom2 := Chrom1 ;

    for i := 1 to Num do
        begin
             if Flip(Pm) then Chrom2.GenoType[i]
                              := FlipBit(Chrom1.GeNoType[i]) ;
        end ;
end ;

Procedure Cross(var Par1,Par2,Chld1,Chld2 : TChromosome ;
                Pc : real) ;
var  j,Jcross,Lc : integer ;
begin
     Lc := Par1.LChrom ;
     if Flip(Pc) then
        begin
             Jcross := Rnd(1,Lc-1) ; {random position for crossover}
        end
     else Jcross := Lc ;
     Chld1 := Par1 ;
     Chld2 := Par2 ;

     if Jcross <> Lc then
        for j := Jcross+1 to Lc do
            begin
                Chld1.Genotype[j] := Par2.Genotype[j] ;
                Chld2.Genotype[j] := Par1.Genotype[j] ;
            end ;
end ;

Function Select(var OldPop  : TChromList ; SumFitness : real ;
                    PopSize : integer ) : integer ;
         {Simulate the roulette wheel}
var Rand,PartSum : real ;
    j            : integer ;

begin
     PartSum := 0.0 ;
     j       := 0   ;
     Rand    := Random*SumFitness ;
     Repeat
           j := j+1 ;
           PartSum := PartSum+OldPop.ChromList[j].Fitness ;
     until (PartSum >= Rand) or (j = PopSize) ;
     Select := j ; {Return individual number}
end ;

Procedure TPopulation.Init ;
var  i : integer ;
begin
     randomize ;
     CurPop      := 0 ;
     PCross      := 0.35     ;
     PMute       := 0.003    ;
     Generation  := 0        ;
     ChromNumber := 0        ;
     Crosstype   := OnePoint ;
     Selecttype  := Roulette ;
     InvertOptr  := false    ;
     PopSize     := 30 ;
     Population.NumChrom := PopSize ;
     Population.Init ;
     MaxChrom.Init ;
     MinChrom.Init ;
     MaxChrom.Fitness := 0 ;
     MinChrom.Fitness := 800 ;
end ;

Procedure TPopulation.ReportToFile(FName : String20) ;
var   fp  : text ;
      WeightString1,WeightString2 : String ;
      Weight : WeightObj ;
begin
     AssignFile(fp,FName) ;
     append(fp) ;
     //rewrite(fp) ;
     writeln(fp,'Gen NO.     : ',Generation) ;
     writeln(fp,'MaxChrom is : ',MaxChrom.GenoType) ;
     writeln(fp,'Max fitness : ',MaxChrom.Fitness:0:3)  ;
     ChromToWeight(MaxChrom.GenoType,Weight) ;

     with Weight do
          begin
               WeightString1 := '(' + IntToStr(W_CornerP1)+','
                                   + IntToStr(W_CXSquareP1)+','
                                   + IntToStr(W_FontierP1)+','
                                   + IntToStr(W_MobilityP1)+','
                                   + IntToStr(W_DifferP1)+
                                ')' ;

               WeightString2 := '(' + IntToStr(W_CornerP2)+','
                                   + IntToStr(W_CXSquareP2)+','
                                   + IntToStr(W_FontierP2)+','
                                   + IntToStr(W_MobilityP2)+','
                                   + IntToStr(W_DifferP2)+
                                ')' ;
          end ;

     writeln(fp,'Max weight  : ',WeightString1,' ',WeightString2) ;

     writeln(fp,'MinChrom is : ',MinChrom.GenoType) ;
     writeln(fp,'Min fitness : ',MinChrom.Fitness:0:3)  ;
     ChromToWeight(MinChrom.GenoType,Weight) ;
     with Weight do
          begin
               WeightString1 := '(' + IntToStr(W_CornerP1)+','
                                   + IntToStr(W_CXSquareP1)+','
                                   + IntToStr(W_FontierP1)+','
                                   + IntToStr(W_MobilityP1)+','
                                   + IntToStr(W_DifferP1)+
                                ')' ;

               WeightString2 := '(' + IntToStr(W_CornerP2)+','
                                   + IntToStr(W_CXSquareP2)+','
                                   + IntToStr(W_FontierP2)+','
                                   + IntToStr(W_MobilityP2)+','
                                   + IntToStr(W_DifferP2)+
                                ')' ;
          end ;

     writeln(fp,'Min weight  : ',WeightString1,' ',WeightString2) ;
     writeln(fp,'Avg fitness : ',Average:3:3) ;
     writeln(fp,'------------------------------------------------------------') ;
     writeln(fp) ;
     CloseFile(fp) ;


end ;

Procedure TPopulation.DisPlay ;
begin
     writeln('========================================================') ;
     {Population.DisPlay ;}
     Writeln('PCross     = ',PCross:5:5) ;
     Writeln('PMute      = ',PMute:5:5) ;
     Writeln('PopSize    = ',PopSize) ;
     Writeln('Generation = ',Generation) ;
     Writeln('Simfitness = ',SumFitness:5:5) ;
     Writeln('Average    = ',Average:5:5) ;
     writeln ;
     Writeln('Max Chrom is ') ;
     MaxChrom.DisPlay ;
     Writeln('Min Chrom is ') ;
     MinChrom.DisPlay ;
     writeln('========================================================') ;
end ;

Procedure TPopulation.UpdateGen ;
begin
     Generation := Generation+1 ;
end ;

Procedure TPopulation.Selection   ;
var i,j   : integer ;
begin
     Spool.Init ;
     Spool.NumChrom := PopSize ;
     for i := 1 to PopSize do
         begin
              j := Select(Population,SumFitness,PopSize) ;
              Spool.ChromList[i] := Population.ChromList[j] ;
         end ;
     Population := Spool ;
end ;

Procedure TPopulation.CrossOver   ;
var  i,Num : integer ;
     Chld1,Chld2,Par1,Par2 : TChromosome ;
begin
     i    := 1 ;
     Num  := Population.NumChrom ;

     Repeat
          Par1 := Population.ChromList[i  ] ;
          Par2 := Population.ChromList[i+1] ;
          Cross(Par1,Par2,Chld1,Chld2,Pcross) ;
          Population.ChromList[i  ] := Chld1 ;
          Population.ChromList[i+1] := Chld2 ;
          i := i+2 ;
     until i > Num ;
end ;

Procedure TPopulation.Mutation    ;
var i,Num : integer ;
    Chrom1,Chrom2 : TChromosome ;
begin
    Num := Population.NumChrom ;
    for i := 1 to Num do
        begin
             Chrom1 := Population.ChromList[i] ;
             Mutate(Chrom1,Chrom2,PMute) ;
             Population.ChromList[i] := Chrom2 ;
        end ;
end ;

Procedure TPopulation.CalSumFitness ;
var i : integer ;
    Temp1,Temp2 : real ;
    Max,Min : real ;
begin
     Temp1 := 0.0 ;
     Temp2 := 0.0 ;
     Max  := 0   ; //MaxChrom.Fitness ;
     Min  := 800 ;//MinChrom.Fitness ;
     for i := 1 to Population.NumChrom do
         begin
             Temp1 := Population.ChromList[i].Fitness ;
             Temp2 := Temp1+Temp2 ;
             if Temp1 > Max then
                begin
                     Max := Temp1 ;
                     MaxChrom := Population.ChromList[i] ;
                     MaxChrom.Gen := Generation ;
                end ;

             if Temp1 < Min then
                begin
                     Min := Temp1 ;
                     MinChrom := Population.ChromList[i] ;
                     MinChrom.Gen := Generation ;
                end ;
         end ;
     SumFitness := Temp2 ;
     Average := SumFitness/(Population.NumChrom+1) ;
end ;

Procedure TPopulation.CalFitNess(ChromNum  : integer) ;
var  Temp : real ;
     Num1,i  : integer ;
begin
     Temp := 0 ;
     Num1  := Population.ChromList[ChromNum].LChrom ;
     for  i := 1 to Num1 do
          begin
               if Population.ChromList[ChromNum].Genotype[i] = '1' then
                  Temp := Temp+1 ;
          end ;
     Population.ChromList[ChromNum].Fitness := Temp ;
//     Population.ChromList[ChromNum].GetPhenoType(NumBit) ;
end ;

Procedure TPopulation.ReadFromFile(FName : String20) ;
var fp    : file of TPopulation ;
    Temp  : String[25] ;
    TempGen : TPopulation ;
begin
     assign(fp,FName) ;
     reset(fp) ;
     Read(fp,TempGen) ;
     closefile(fp) ;

     CurPop := TempGen.CurPop    ;
     PCross := TempGen.PCross    ;
     PMute  := TempGen.PMute     ;
     PopSize := TempGen.PopSize   ;
     Generation := TempGen.Generation  ;
     ChromNumber := TempGen.ChromNumber ;
     Population := TempGen.Population  ;
     CrossType := TempGen.Crosstype   ;
     SelectType := TempGen.Selecttype  ;
     InvertOptr := TempGen.InvertOptr  ;
     SumFitness := TempGen.SumFitness  ;
     Average := TempGen.Average     ;
     MaxChrom := TempGen.MaxChrom    ;
     MinChrom := TempGen.MinChrom    ;
end ;

Procedure TPopulation.WriteToFile(FName : String20) ;
var fp    : file of TPopulation ;
    Temp  : String[25] ;
    TempGen : TPopulation ;
begin
     TempGen.CurPop      := CurPop     ;
     TempGen.PCross      := PCross     ;
     TempGen.PMute       := PMute      ;
     TempGen.PopSize     := PopSize    ;
     TempGen.Generation  := Generation ;
     TempGen.ChromNumber := ChromNumber ;
     TempGen.Population  := Population  ;
     TempGen.Crosstype   := Crosstype   ;
     TempGen.Selecttype  := Selecttype  ;
     TempGen.InvertOptr  := InvertOptr  ;
     TempGen.SumFitness  := SumFitness  ;
     TempGen.Average     := Average   ;
     TempGen.MaxChrom    := MaxChrom  ;
     TempGen.MinChrom    := MinChrom  ;
     Str(Generation,Temp) ;
     assign(fp,FName) ;
     rewrite(fp) ;
     Write(fp,TempGen) ;
     closefile(fp) ;
end ;


{
Procedure TPopulation.CreateNextGen ;
var fp    : file of TPopulation ;
    Temp  : String[25] ;
    TempGen : TPopulation ;
begin
     Selection ;
     CrossOver ;
     Mutation  ;
     UpdateGen ;

     TempGen.PCross      := PCross     ;
     TempGen.PMute       := PMute      ;
     TempGen.PopSize     := PopSize    ;
     TempGen.Generation  := Generation ;
     TempGen.ChromNumber := ChromNumber ;
     TempGen.Population  := Population  ;
     TempGen.Crosstype   := Crosstype   ;
     TempGen.Selecttype  := Selecttype  ;
     TempGen.InvertOptr  := InvertOptr  ;
     TempGen.SumFitness  := SumFitness  ;
     TempGen.Average     := Average   ;
     TempGen.MaxChrom    := MaxChrom  ;
     TempGen.MinChrom    := MinChrom  ;

     Temp := 'CurGen.GEN' ;
     assign(fp,Temp) ;
     rewrite(fp) ;
     Write(fp,TempGen) ;
     closefile(fp) ;
end ;
}
Procedure TPopulation.FindMaxMin ;
begin

end ;

Procedure TPopulation.CalEvaluate(ChromNum : integer) ;
begin
end ;

Procedure TPopulation.SetFitNess(ChromNum  : integer ; fit : real) ;
begin
     Population.ChromList[ChromNum].Fitness := fit ;
end ;

Function  TPopulation.GetFitNess(ChromNum  : integer) : real ;
begin
     GetFitness := Population.ChromList[ChromNum].Fitness ;
end ;

Procedure TPopulation.GetChrom(ChromNum : integer ; var ChromS : ChromType) ;
begin
     ChromS := Population.ChromList[ChromNum].Genotype ;
end ;

end.