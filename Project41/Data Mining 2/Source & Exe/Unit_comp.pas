
// ** Note **
{ select  by  Reproduction no repeat and reproduction average
  ( by select from both oldpop and newpop )
  ( cut 1 popsize )}

{ To select Project -> Option -> Linker -> min 16384  max 16777216 }

// ** Genetic algorithms program **
Unit Unit_comp;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

Const
     ip            = 8 ;     { number of input nodes not include bias :8 }
     hi_node       = 10 ;     { number of hidden nodes not include bias  }
     op_node       = 1 ;     { number of hidden nodes }
{    w_ip          = 27 ;    { number of weight from input nodes include weight for bias }
                             { => (ip+1)*hi_node : 20}
{    w_hi          = 4 ;     { number of weight from hidden nodes include weight for bias }
                             { => hi_node+1 }
     lch           = 11 ;
     nip_train     = 164 ;    {15 number of input patterns for training }
     nip_test      = 40;     {5 number of input patterns for testing }
     Max_pop       = 500 ;
     Max_count1    = 75 ;
     Max_count1_1  = 100 ;
     Max_count2    = 50 ;
     Cpop          = 10 ;
     pointcut_pop1 = 100 ;
     pointcut_pop2 = 200 ;
     pointcut_pop3 = 300 ;
     maxgen1       = 20 ;
     maxgen2       = 300 ;
     maxgen3       = 400 ;
     maxgen4       = 500 ;
{    maxbit        = 341;   { 341=> [(ip+1)*hi_node]+(hi_node+1)]*lcr }
{    round         = 2 ;}
     loop          = 1 ;    { loop for all popsize }
     round         = 1 ;    { loop for each popsize }
     error_train   = 0.05 ;
     error_test    = 0.05 ;
     max_range     = 0.9 ;
     min_range     = 0.1 ;
     njcrossmx     = 50 ;
     njcross1      = 2 ;
     njcross2      = 2 ;
     start1        = 1 ;
 {   start2        = 298 ;   { endd1 + 1 }
 {   end1          = 297;    { w_ip * lch }
 {   end2          = maxbit;}
     pcross        = 0.9;
     pmutation     = 0.05 ;
     min_num       = 2;
     name_ip       = 'ip01.txt' ;
     name_ipt      = 'ipt01.txt' ;
     name_op       = 'op01.txt' ;
     name_opt      = 'opt01.txt' ;
     name_mm       = 'mm01.txt' ;
     name_mmop     = 'mmop01.txt' ;

Type

    TForm2  = class(TForm)
    Edit1   : TEdit;
    Button1 : TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    ListBox1: TListBox;
Procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  end;

  Type
    Allele         = Byte;
    Chomosome      = Array[1..(((ip+1)*hi_node)+(hi_node+1))*lch] of Byte ;
    individual     = record
                     chrom  : Chomosome ;
                     value  : Array[1..((ip+1)*hi_node)+(hi_node+1)] of Single;
                     fitness : Single ;
                     fitness_complement : Single;
                     parent1,parent2,xsite : Integer;
                   end;
    individual2    = record
                     B_chrom  : Chomosome ;
                     B_value  : Array[1..((ip+1)*hi_node)+(hi_node+1)] of Single ;
                     B_fitness : Single ;
                   end;
    individual3    = record
                     value  : Array[1..((ip+1)*hi_node)+(hi_node+1)] of Single ;
                     fitness : Single ;
                     fitness_test  :Single;
                     fitness_fact  :Single;
                   end;

    Population     = Array[1..Max_pop] of individual ;
    Population2    = Array[1..min_num] of individual2 ;
    Population3    = Array[1..loop] of individual3 ;
    ip_array       = Array[1..(ip+1),1..nip_train] of Single ;{ input from input nodes to hidden nodes }
    ipt_array      = Array[1..(ip+1),1..nip_test] of Single ;{ input from input nodes to hidden nodes }
    hid_array      = Array[1..hi_node] of Single;{ input from hidden nodes to output node }
    op_array       = Array[1..nip_train] of Single ;
    opt_array      = Array[1..nip_test] of Single ;
    mm_array       = Array[1..(ip+2)] of Single;
    mm_op_array    = Array[1..op_node] of Single ;

Var
    Form2                 : TForm2;
    oldpop{,newpop}       : Population ;
    best_pop              : Population2;
    mate1,mate2           : Integer;
    a,j,njcross           : Integer;
    ncross1,ncross2       : Integer;
    nmutation1,nmutation2 : Integer;
    sumfitness_org        : Single;
    sumfitness            : Single;
    Best,Best_all         : Single;
    error_baht            : Single;
    error_baht_test       : Single;
    r,l                   : Byte ;
    popsize               : Integer;
    gen,maxgen            : Integer;
    maxbit,start2         : Integer;
    end1,end2             : Integer;
    count1,count2         : Byte;
    w_ip                  : Byte;   { W_ip number of weight from input nodes include weight for bias }
    w_hi                  : Byte;   { W_hi number of weight from hidden nodes include weight for bias }
    allelevel             : Allele;
{   jcross                : Array[1..njcross1] of Integer;}
    parent1,parent2       : Chomosome;
    child1,child2         : Chomosome;
    avg,min,max           : Single ;
    ip_train              : ip_array ;
    ip_test               : ipt_array ;
    op_train              : op_array ;
    op_test               : opt_array ;
    max_ip                : mm_array ;
    min_ip                : mm_array ;
    max_op,min_op         : Single ;
    flag1,flag2           : Boolean ;
    flag_chk              : Boolean ;
    main_use              : Boolean ;
    Time_start,Time_use   : TDateTime ;
    Time_end              : TDateTime ;
    hh,mm,ss,ss100        : String ;
    hh1,mm1,ss1,ss100_1   : String ;
    hh2,mm2,ss2,ss100_2   : String ;
    i,psize               : Integer;
    inp_train_file        : Text;
    op_train_file         : Text;
    inp_test_file         : Text;
    op_test_file          : Text;
    result_file           : Text;
    name_result           : String;
    sumfit1               : Single ;


implementation

uses Unit_proj;

{$R *.DFM}
{********************>> Function decode binary to Real <<********************}
Function decode(chrom:Chomosome; l:Integer):Single ;
Var
     d1,d2  : Integer ;
     acc,power :Single ;
Begin
     acc:= 0 ;
     power:= 1 ;
     d1:= l-lch;
     for d2:=1 to (lch-1) do
     begin
          d1:=d1+1;
          if chrom[d1] =1 then acc:=acc+power;
          power:=power*2 ;
     end;
     if chrom[l] =1 then acc := -acc ;
     decode:= acc / 1000;
End;

{**************************>>  Random  Weight   <<**************************}
Procedure random_weight ;
Var
     r1,r2,r3,r4,r5,r6 :Integer ;
Begin
     randomize;
{     r6:=0;}
     for r1:=1 to popsize do
     begin
          r5:=0;
{          writeln('********************>>   Random Weight   <<********************');
          writeln('Bit Lsb => Msb & Msb is signed bit');   }
          for r2:=1 to (w_ip+w_hi) do with oldpop[r1] do
          begin
               for r3:=1 to lch do
               begin
                    r5:= r5+1 ;
                    r4:=random(2);
                    chrom[r5] := r4 ;
{                    write(chrom[r5]);  }
               end;
               value[r2]:=decode(chrom,r5);
               if value[r2] >1  then value[r2] := 1;
               if value[r2] <-1 then value[r2] := -1;
{               writeln('   => ',value[r2]:0:5,'     No.weight := ',r2) ;}
          end;
{          r6:=r6+r5;}
{          writeln('No. popsize  :=  ',r1,'     Sum bit :=  ',r6) ;}
{          readln;}
     end;
End;

{*************>>  Store Min&Max input values for each pattern  <<*************}
Procedure store_minmax_input_patterns;
Var
     MinMaxfile       : Text ;
{     filename        : String[15] ;}
     s1               : Integer;
     _min,_max        : Single;
Begin
{     writeln('  ***************>>   Input Patterns   <<***************');}
    { write(' Enter filename of Min&Max input patterns to read :   ');
     readln(Filename);}
     assign(MinMaxfile,name_mm);
     reset(MinMaxfile);
     { **> Store min value of each input node }
     for s1:=2 to (ip+1) do
     begin
          readln(MinMaxfile,_Min);
          min_ip[s1] := _Min ;
{          writeln(min_ip[s1]:0:5); }
     end;
     { **> Store max value of each input node }
     for s1:=2 to (ip+1) do
     begin
         readln(MinMaxfile,_Max);
         max_ip[s1] := _Max ;
{         writeln(max_ip[s1]:0:5);}
     end;
     close(MinMaxfile);
End;

{********************>>  Store Min&Max output values  <<********************}
Procedure store_minmax_output;
Var
     MinMaxfile       : Text ;
    { filename         : String[15] ;}
     _min,_max        : Single;
Begin
{clrscr;}
{     writeln('  ***************>>   Output Patterns   <<***************');
     write(' Enter filename of Min&Max output patterns to read :   ');
     readln(Filename);}
     assign(MinMaxfile,name_mmop);
     reset(MinMaxfile);
     {**> Store min output value }
     readln(MinMaxfile,_Min);
     min_op := _Min ;
{     writeln(min_op:0:5);}
     {**> Store max output value }
     readln(MinMaxfile,_Max);
     max_op := _Max ;
{     writeln(max_op:0:5);}
     close(MinMaxfile);
End;

{************************>>  Store Input Patterns  <<*************************}
Procedure store_input_patterns(nip:Integer; filename:String; Var inputfile:Text);
Var
     s1,s2       : Integer;
     s3,s4       : Single;
Begin
     assign(inputfile,filename);
     reset(inputfile);
{     c:=0;}
     for s1:=1 to nip do
         begin
{         c:=c+1;}
         if nip = nip_train then ip_train[1][s1] := 1
         else
         begin
              ip_test[1][s1]:=1;
{             writeln(ip_test[1][s1]:0:5);}
         end;

         for s2:=2 to (ip+1) do
         begin
              readln(inputfile,s3);
             // s4:=((Max_range-Min_range)*(s3-Min_ip[s2])/(Max_ip[s2] - Min_ip[s2]))+Min_range;
              if nip = nip_train then ip_train[s2][s1] := s3
              else
              begin
                   ip_test[s2][s1]:=s3;
              end;
         end;
     end;
     close(inputfile);
{readln;}
End;

{************************>>  Store Output Patterns  <<*************************}
Procedure store_output_patterns(nip:Integer; filename:String; Var outputfile:Text);
Var
     s1           : Integer;
     s2,s3        : Single;
Begin
     assign(outputfile,filename);
     reset(outputfile);
{     writeln('Minimum output value is ',min_op:0:5);
     writeln('Maximum output value is ',max_op:0:5);}
     for s1:=1 to nip do
         begin
         readln(outputfile,s2);
//         s3:=((Max_range-Min_range)*(s2- min_op)/(max_op - min_op))+Min_range;
         if nip = nip_train then
              begin
              op_train[s1] := s2;
{              writeln('    Message value of output of train : ',s2:0:5,' => ',s3:0:5);}
              end
         else
              begin
              op_test[s1]:=s2;
{              writeln('    Message value of output of test : ',s2:0:5,' => ',s3:0:5);}
              end;
{         if s1 mod 20 =0 then readln;}
         end;
     close(outputfile);
{readln;}
End;

{***********>>  Claculate Sigmiod function for train <<***********}
Procedure calculate_train (Var pop:Population; nip:Integer; psize:Integer; main_use:Boolean);
Var
     c1             : Integer ;
     A_hi           : hid_array ;
     c2,c3,c4,b,a   : Integer;
     result,result1 : Single ;
     sumfit,sum,sum1,sum2,sum3,sigmoid1,sigmoid2  : Single ;
     word           : String;

Begin
      sumfit  := 0 ;
      for c1:=1 to psize do with pop[c1] do
     begin{c1}
{         clrscr;
          writeln('********************>>   Calculate At Hidden Nodes   <<********************');}
          result   := 0 ;
          result1  := 0 ;
          for c2:=1 to nip do
          begin{c2}
               a  := 0 ;
               for c3:=1  to hi_node do
               begin{c3}
                    sum := 0 ;
                    sum1:= 0 ;
                    for c4:= 1 to (ip+1) do
                    begin{c4}
                           b   := c4+(a*(ip+1));
                           sum := ip_train[c4][c2]*value[b] ;
                           sum1:= sum1+sum ;
{                          writeln('ip*w  ',ip_train[c4][c2]:0:5,' * ',value[w]:0:5,' = ',sum:0:5)}
                    end ;{c4}
                    sigmoid1 := 1/(1+exp(-sum1)) ;
                    A_hi[c3] := sigmoid1 ;
                    a := a+1 ;
                    {readln;}
               end;{c3}
               sum2 := 0 ;
               sum3 := 0 ;
               sum2 := 1*value[1+w_ip] ;
               sum3 := sum3+sum2 ;
               for c3:= 1 to hi_node do
               begin{c3}
                    sum2 := a_hi[c3]*value[1+c3+w_ip] ;
                    sum3 := sum3+sum2 ;
               end;{c3}
               sigmoid2 := 1/(1+exp(-sum3)) ;
               result   := abs(op_train[c2] - sigmoid2) ;
               result1  := result1+result ;

          end;{c2}
          fitness := result1/nip_train ;
          sumfit  := sumfit+fitness;
          fitness := result1/nip_train ;

      end ;{c1}
      sumfit1    := sumfit/popsize;

      {     readln;}
End;

{***********>>  Claculate Sigmiod function for test <<***********}
Procedure calculate_test (Var pop:Population3);
Var
     A_hi           : hid_array ;
     c2,c3,c4,b,a   : Integer;
     result,result1 : Single ;
     sum,sum1,sum2,sum3,sigmoid1,sigmoid2  : Single ;

Begin
     with pop[l] do
     begin{c1}
{         clrscr;
          writeln('********************>>   Calculate At Hidden Nodes   <<********************');}
          result   := 0 ;
          result1  := 0 ;
          for c2:=1 to nip_test do
          begin{c2}
               a  := 0 ;
               for c3:=1  to hi_node do
               begin{c3}
                    sum := 0 ;
                    sum1:= 0 ;
                    for c4:= 1 to (ip+1) do
                    begin{c4}
                           b   := c4+(a*(ip+1));
                           sum := ip_test[c4][c2]*value[b] ;
                           sum1:=sum1+sum ;
{                           write(ip_test[c4][c2]:0:5,' * ',value[b]:0:5);
                           writeln('   nip: ',c2,' hi_node : ',c3,' ip : ',c4,' sum : ',sum:0:5,' sum1 : ',sum1:0:5);}
                    end ;{c4}
                    sigmoid1 := 1/(1+exp(-sum1)) ;
{                    write('nip: ',c2,' hi : ',c3,' sigmoid : ',sigmoid1:0:5);
                    readln;}
                    A_hi[c3] := sigmoid1;
                    a := a+1 ;
                    {readln;}
               end;{c3}
               sum2 := 0 ;
               sum3 := 0 ;
               sum2 := 1*value[1+w_ip] ;
{               write('1 * ',value[1+w_ip]:0:5) ;}
               sum3 := sum3+sum2 ;
{               writeln('       nip/op: ',c2,' bias : ',sum2:0:5);}
               for c3:= 1 to hi_node do
               begin{c3}
                    sum2 := a_hi[c3]*value[1+c3+w_ip] ;
                    sum3 := sum3+sum2 ;
{                    write(a_hi[c3]:0:5,' * ',value[1+c3+w_ip]:0:5);
                    writeln('      nip/op: ',c2,' hi_node : ',c3,' sum2 : ',sum2:0:5,' sum3 : ',sum3:0:5);}
               end;{c3}
               sigmoid2 := 1/(1+exp(-sum3)) ;
{              write ('sum3 : ',sum3);
               writeln('nip/op: ',c2,' sigmoid : ',sigmoid2:0:5);}
               result   := abs(op_test[c2] - sigmoid2) ;
               result1  := result1+result ;
{               write(c2,'   op-tg_test : ',op_test[c2]:0:5,' -  ',sigmoid2:0:5);
               write('  := ',result:0:5,'       sum =: ',result1:0:5);
          readln;}
          end;{c2}
          fitness_test   := result1/nip_test ;

          {          writeln('fitness_test *=> ',result1:0:5,' / ',nip_test,'  :=  ',fitness_test:0:5);}
     end ;{c1}
{     readln;}
End;


{***********>>  Claculate Sigmiod function for test <<***********}
Procedure claculate_test_round ;
Var
        round_pop : Population3;
            i,j,k : Integer ;
             word : String;
             a    : Integer;
             b    : Single;
      weight_file : Text;
      name_weight : String;
      Temp        : String[5];
Begin
        round_pop[l].fitness := best_pop[1].B_fitness;
        if round_pop[l].fitness < error_train then flag1 := true
        else flag1 := false ;
        for i:=1 to (w_ip+w_hi) do
        begin
             round_pop[l].value[i] := best_pop[1].B_value[i];
       {      writeln(round_pop[l].value[i]:0:5);
             if i=15 then readln;}
        end;
        calculate_test(round_pop);
        if round_pop[l].fitness_test < error_test then flag2 := true
        else flag2 := false ;
        append(result_file);
        word := 'Best weight  :  ';
        writeln(result_file,word);
        for i:=1 to (w_ip+w_hi) do
        begin
             b:=round_pop[l].value[i];
             writeln(result_file,b:0:5);
        end;
        word := 'Avg Fitness for training  :  ';
        write(result_file,word);
        b := round_pop[l].fitness ;
        writeln(result_file,b:0:9);

        word := 'Avg Fitness for testing  :  ';
        write(result_file,word);
        b := round_pop[l].fitness_test ;
        writeln(result_file,b:0:9);

        error_baht      := round_pop[l].fitness*(Max_op-Min_op)/(Max_range -Min_range);
        Form2.ListBox1.Items.Add(' ');
        Temp  := FloatToStr(error_baht);
        Form2.ListBox1.Items.Add(' ค่าความผิดพลาดสำหรับข้อมูลชุดเรียนรู้   =>> '+Temp+'  บาท');

        error_baht_test := round_pop[l].fitness_test*(Max_op-Min_op)/(Max_range-Min_range);
        word := 'Avg Fitness for training for baht :  ';
        write(result_file,word);
        b := error_baht ;
        writeln(result_file,b:0:9);

        Temp  := FloatToStr(error_baht_test);
        Form2.ListBox1.Items.Add(' ค่าความผิดพลาดเฉลี่ยสำหรับชุดทดลอง   =>> '+Temp+'  บาท');

        word := 'Avg Fitness for testing for baht :  ';
        write(result_file,word);
        b := error_baht_test ;
        writeln(result_file,b:0:9);
        close(result_file);

// Write weight to new file for new pattern
        name_Weight := 'W_'+name_result;
        assign(Weight_file,name_Weight);
        if (l = 1) and (r = 1) then  rewrite(Weight_file)
        else append(Weight_file) ;

        writeln(weight_file,' ');
        word := 'Best weight at popsize :  ';
        write(Weight_file,word);
        writeln(Weight_file,popsize);
        for j:=1 to ip+1 do
            for k:=0 to (hi_node-1) do
            begin
                 i := (k*(ip+1)) + j ;
                 b := round_pop[l].value[i];
                 writeln(Weight_file,b:0:5);
             end;
        for k:=1 to w_hi do
        begin
             b := round_pop[l].value[i+k];
             writeln(Weight_file,b:0:5);
        end;
        close(weight_file);
End ;


{**************>>  Show All Input Patterns Form Input Nodes  <<**************}
Procedure show_input_pattern(nip:Integer);
Var
     i,j :Integer ;
Begin
{clrscr;}
   for i:=1 to nip do
       begin
         {   writeln('Show input pattern  ==>   ',i);}
            for j:=1 to (ip+1) do
{            if nip = nip_train then writeln(ip_train[j][i]:3:5)
            else writeln(ip_test[j][i]:3:5);}
       end;
{readln;}
end;
{***************************>>  GENETIC OPERATION <<*******************}
{---------------------------------------------------------------------}

function        rnd_real:Single;             { random number in [0-1] }
Var             r1:Integer;
                r2:Single;
begin
     randomize;
     r1:= random(101);
     rnd_real:= r1/100;
     r2:= r1/100;
end;


{---------------------------------------------------------------------}
function        flip(probability:Real):Boolean;     { random probability }
Var             b_flp:Boolean;
begin
     if probability = 1.0 then flip := true
     else
     begin
          flip := (rnd_real<=probability);
     end;
end;

{---------------------------------------------------------------------}
function        select(popsize:Integer; sumfitness:Single;         { selection chromosome }
                   Var pop:Population; Var newpop : Population;
                   min_i : Array of Integer) :Integer;
Var             rand,partsum : Real;
                i,j:Integer;
Begin
     partsum:= 0.00; j:=0;

     rand := rnd_real * sumfitness;
     repeat
           j:=j+1;
                if (j=min_i[j]) then
                else  partsum := partsum + pop[j].fitness_complement;
     until (partsum>=rand) or (j=popsize);
     select := j;
End;


{---------------------------------------------------------------------}

function        mutation(allelevel: Allele; pmutation:Single;   { mutation operation }
                Var nmutation:Integer):Allele;
Var             mutate : Boolean;
begin
     mutate := flip(pmutation);
     if mutate then
     begin
          nmutation:= nmutation+1;
          if allelevel=0 then mutation:= 1
          else if allelevel=1 then mutation := 0;
     end
     else   mutation := allelevel;
end;


{---------------------------------------------------------------------}

Procedure       crossover(Var parent1,parent2,child1,child2 : Chomosome;

{ crossover chromosome by random number of cut point  }

                          start,endd,njcross :Integer;
                          Var ncross,nmutation : Integer;
                          pcross,pmutation : Single);
Var             rd,jcross : Array[1..njcrossmx] of Integer;
                i,a,j1,rd_temp1,s,j,l,rd1:Integer;
Begin

     rd1:=1; rd_temp1:= 1;
     if flip(pcross) then
     begin
          ncross:= ncross+1;
          for a:=1 to njcross do jcross[a]:=0;
          randomize;
          rd1 := random(endd);
          if rd1=0 then
          begin
               repeat
                     rd1:= random(endd);
               until rd1<>0 ;
          end
          else if rd1< start then
          begin
               repeat
                     rd1 := random(endd);
               until rd1>= start ;
          end;
          jcross[1] := rd1;

          for j:= 1 to njcross-1 do
          begin
               randomize;
               rd1 := random(endd);
               while rd1< start do
               begin
                    randomize;
                    rd1:= random(endd);
               end;
               for s:=njcross  downto 1 do
               begin
                    if jcross[s]=rd1 then
                    begin
                         while jcross[s]=rd1 do
                         begin
                              randomize;
                              rd1 := random(endd);
                         end;
                    end;
               end;

               if rd1>jcross[j] then  jcross[j+1] := rd1
               else if rd1< jcross[j] then
               begin
                    rd_temp1:= jcross[j];
                    jcross[j] := rd1;
                    jcross[j+1] := rd_temp1;
                    j1:=j;
                    repeat
                          if jcross[j1]>jcross[j1-1] then jcross[j1]:= jcross[j1]
                          else if ((jcross[j1] < jcross[j1-1])and(j1<>1)) then
                          begin
                               rd_temp1 := jcross[j1-1];
                               jcross[j1-1] := jcross[j1];
                               jcross[j1]   := rd_temp1;
                          end;
                          j1 := j1-1;
                    until j1<=1;

               end;
          end;
     end else
     begin
          for a:=1 to njcross do
              jcross[a] := endd;
     end;
     if jcross[1] = endd then
        for j:= start to jcross[1] do
        begin
             child1[j] := mutation(parent1[j],pmutation,nmutation);
             child2[j] := mutation(parent2[j],pmutation,nmutation);
        end
     else
     begin
          for j:= start to jcross[1] do
          begin
               child1[j] := mutation(parent1[j],pmutation,nmutation);
               child2[j] := mutation(parent2[j],pmutation,nmutation);
          end;
          i:= 1;
          while i < njcross  do
          begin
               for j:= jcross[i]+1 to jcross[i+1] do
               begin
                    child1[j] := mutation(parent2[j],pmutation,nmutation);
                    child2[j] := mutation(parent1[j],pmutation,nmutation);
               end;
               if i+1 < njcross then
                  for j:= jcross[i+1]+1 to jcross[i+2] do
                  begin
                       child1[j] := mutation(parent1[j],pmutation,nmutation);
                       child2[j] := mutation(parent2[j],pmutation,nmutation);
                  end;
               i:= i+2;
          end;
          if ((njcross mod 2)=0) then
             for j:= jcross[njcross]+1 to endd do
             begin
                  child1[j] := mutation(parent1[j],pmutation,nmutation);
                  child2[j] := mutation(parent2[j],pmutation,nmutation);
             end
          else
             for j:= jcross[njcross]+1 to endd do
             begin
                  child1[j] := mutation(parent2[j],pmutation,nmutation);
                  child2[j] := mutation(parent1[j],pmutation,nmutation);
             end;

     end;

End;


{---------------------------------------------------------------}

{ operation in each generation and select best pop }

Procedure  generation(sumfitness_org:Single;Var sort_fit : Population; Var newpop:Population);
Var        x,j,i2,a,mate1,mate2:Integer;
           sumfitness,min_chk,min_tmp : Single;
           min_i : Array[0..min_num] of Integer;
           min_num_count,i1,s1 : Integer;
           min_tmp_arr : Chomosome;
           i,s           :Integer;
begin
           sumfitness := 0;
           for a:=1 to popsize do
           begin
                oldpop[a].fitness_complement := (1+sumfitness_org) / (1+oldpop[a].fitness) ;
                sumfitness := sumfitness + oldpop[a].fitness_complement;
           end;

           min := 100;  min_i[0] := 0;
           for i:=1 to popsize do
           begin
                if oldpop[i].fitness < min then
                begin
                     min:= oldpop[i].fitness;
                     min_i[1] := i;
                end;
           end;
           min_num_count := 1;
           while min_num_count<> min_num  do
           begin
                min := 100;
                for i:=1 to popsize do
                begin
                     if ((oldpop[i].fitness<min) and (oldpop[i].fitness<>min_i[min_num_count])
                        and (i<>min_i[min_num_count])) then
                     begin
                          min:= oldpop[i].fitness;
                          min_i[min_num_count+1] := i;
                     end;
                end;
                min_num_count := min_num_count+1;
           end;
           x:= min_i[1];
           best_pop[1].B_chrom := oldpop[x].chrom;
           best_pop[1].B_fitness := oldpop[x].fitness;
           for i:=1 to (w_ip+w_hi) do
               best_pop[1].B_value[i] := oldpop[x].value[i];
           for i:=1 to min_num do
           begin
                x := min_i[i];
                newpop[i].chrom := oldpop[x].chrom;
                newpop[i].fitness := oldpop[x].fitness;
                newpop[i].value := oldpop[x].value;
           end;
           for i:=1 to popsize do
           begin
               sort_fit[i].fitness := 0;
               for i2:=1 to maxbit do
                   sort_fit[i].chrom[i2]   := 0;
           end;
           sort_fit[1].fitness := oldpop[1].fitness;
           sort_fit[1].chrom   := oldpop[1].chrom;
           s:=2; i:= 1;
           while (i < popsize)  do
           begin
                     if (oldpop[s].fitness > sort_fit[i].fitness) then
                     begin
                               sort_fit[i+1].fitness := oldpop[s].fitness;
                               sort_fit[i+1].chrom := oldpop[s].chrom;
                     end
                     else if (oldpop[s].fitness < sort_fit[i].fitness) then
                     begin
                               min_tmp := sort_fit[i].fitness;
                               sort_fit[i].fitness := oldpop[s].fitness;
                               sort_fit[i+1].fitness := min_tmp;
                               min_tmp_arr := sort_fit[i].chrom;
                               sort_fit[i].chrom := oldpop[s].chrom;
                               sort_fit[i+1].chrom := min_tmp_arr;
                               i1 := i;
                               repeat
                                     if sort_fit[i1].fitness > sort_fit[i1-1].fitness then
                                     else if (sort_fit[i1].fitness < sort_fit[i1-1].fitness) and (i1<>1) then
                                     begin
                                          min_tmp := sort_fit[i1-1].fitness;
                                          sort_fit[i1-1].fitness := sort_fit[i1].fitness;
                                          sort_fit[i1].fitness   := min_tmp;
                                          min_tmp_arr := sort_fit[i1-1].chrom;
                                          sort_fit[i1-1].chrom := sort_fit[i1].chrom;
                                          sort_fit[i1].chrom := min_tmp_arr;
                                     end;
                                     i1 := i1-1;
                               until  i1<=1;
                     end
                     else
                     begin
                          sort_fit[i+1].fitness := oldpop[s].fitness;
                          sort_fit[i+1].chrom := oldpop[s].chrom;
                     end;

                i:= i+1;  s:= s+1;
           end;
      j:=3;
      repeat
           mate1 := select(popsize,sumfitness,oldpop,newpop,min_i);
           mate2 := select(popsize,sumfitness,oldpop,newpop,min_i);
           while mate2=mate1 do
           begin
                mate2 := select(popsize,sumfitness,oldpop,newpop,min_i);
           end;

           crossover(oldpop[mate1].chrom, oldpop[mate2].chrom,
                     newpop[j].chrom,     newpop[j+1].chrom,
                     start1,end1,njcross1,ncross1,nmutation1,
                     pcross,pmutation);
           crossover(oldpop[mate1].chrom, oldpop[mate2].chrom,
                     newpop[j].chrom,     newpop[j+1].chrom,
                     start2,end2,njcross2,ncross2,nmutation2,
                     pcross,pmutation);

           j:= j+2;
     until j>=(popsize);
end;


{---------------------------------------------------------------}

{ select best pop between oldpop and newpop by select minimum fitness chromosome }
Procedure   select_popsize(oldpop:Population; Var newpop:Population);
type
    individual4     = record
                      chrom  : Chomosome ;
                      fitness : Single ;
                     end;
    Population4  = Array[1..(2*Max_pop)] of individual4 ;
    Population5  = Array[1..(Max_pop)] of individual4 ;

Var         sel_pop                : Population4;
            newpop_tmp,new_tmp     : Population5;
            oldpop_tmp             : Population5;
            a1,o2,o4,o5,o7,o8,o9,i1,i2: Integer;
            n_repeat,n_rep,n_nrep  : Integer;
            n_nrepeat,n_nrepeat1   : Integer;
            min_tmp                : Single;
            min_tmp_arr            : Chomosome;
            pos_nrep               : Array[1..Max_pop] of Integer;
            pos_rep                : Array[1..Max_pop] of Integer;
            rep,rep1               : Boolean;
            s,i,a                  : Integer;
Begin

     for i:=1 to (popsize) do
     begin
          oldpop_tmp[i].fitness := 0;
          for i2:=1 to maxbit do
              oldpop_tmp[i].chrom[i2]   := 0;
     end;
     for i:=1 to (popsize) do
     begin
          newpop_tmp[i].fitness := 0;
          for i2:=1 to maxbit do
              newpop_tmp[i].chrom[i2]   := 0;
     end;
     for i:=1 to (popsize) do
     begin
          new_tmp[i].fitness := 0;
          for i2:=1 to maxbit do
              new_tmp[i].chrom[i2]   := 0;
     end;

     for i:=1 to (2*popsize) do
     begin
          sel_pop[i].fitness := 0;
          for i2:=1 to maxbit do
              sel_pop[i].chrom[i2]   := 0;
     end;

     o8 := 1;
     for o2:=1 to popsize do
     begin
          rep := false;
          for o4:=o2+1 to popsize do
              if (oldpop[o2].fitness = oldpop[o4].fitness)  then rep:= true;
          if not rep then
          begin
                oldpop_tmp[o8].fitness := oldpop[o2].fitness;
                oldpop_tmp[o8].chrom   := oldpop[o2].chrom;
                o8 := o8+1;
          end;

     end;


     sel_pop[1].fitness := oldpop_tmp[1].fitness;
     sel_pop[1].chrom   := oldpop_tmp[1].chrom;
     s:=2; i:= 1;
     while (s <= (o8-1) )  do
     begin
          if (oldpop_tmp[s].fitness > sel_pop[i].fitness) then
          begin
               sel_pop[i+1].fitness := oldpop_tmp[s].fitness;
               sel_pop[i+1].chrom := oldpop_tmp[s].chrom;
               i := i+1;
          end
          else if (oldpop_tmp[s].fitness < sel_pop[i].fitness) then
          begin
               min_tmp := sel_pop[i].fitness;
               sel_pop[i].fitness := oldpop_tmp[s].fitness;
               sel_pop[i+1].fitness := min_tmp;
               min_tmp_arr := sel_pop[i].chrom;
               sel_pop[i].chrom := oldpop_tmp[s].chrom;
               sel_pop[i+1].chrom := min_tmp_arr;
               i1 := i;
               repeat
                     if ((sel_pop[i1].fitness > sel_pop[i1-1].fitness)and(i1<>1)) then i1 := i1-1
                     else if (sel_pop[i1].fitness < sel_pop[i1-1].fitness) and (i1<>1) then
                     begin
                          min_tmp := sel_pop[i1-1].fitness;
                          sel_pop[i1-1].fitness := sel_pop[i1].fitness;
                          sel_pop[i1].fitness   := min_tmp;
                          min_tmp_arr := sel_pop[i1-1].chrom;
                          sel_pop[i1-1].chrom := sel_pop[i1].chrom;
                          sel_pop[i1].chrom := min_tmp_arr;
                          i1 := i1-1;
                     end
                     else if (i1<>1) then
                         i1:=i1;
{                     i1 := i1-1;}
               until  i1<=1;
               i := i+1;
          end
          else
          begin
               i := i;
          end;

          s:= s+1;
     end;

{     write('between change selpop(sel) * : ');
     for a:=1 to 2*popsize do
         write(sel_pop[a].fitness:2:8,',');
     writeln;readln;}

{     write('between change oldpop(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 20 do
             write(oldpop[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;
     write('between change newpop(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 20 do
             write(newpop[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;}

{     writeln('bet aft change sel_pop(sel)  : ');
     for a1:=1 to 2*popsize do
     begin
         for a:=1 to 100 do
             write(sel_pop[a1].chrom[a]);
         write(', '); write(sel_pop[a1].fitness); readln;
     end;
     writeln;readln;}







     for o7:=1 to popsize do   pos_rep[o7]:=0;
     for o7:=1 to popsize do   pos_nrep[o7]:=0;


     n_repeat := 0;
     for o2:=1 to popsize do
         for o4:=1 to popsize do
         begin
             if (newpop[o2].fitness = oldpop_tmp[o4].fitness)  then
             begin
                  if n_repeat<>0 then
                  begin
                       n_rep := n_repeat+1;
                       repeat
                             if o2=pos_rep[n_rep-1] then  rep:= true
                             else rep:= false;
                             n_rep:= n_rep-1
                       until (rep=true)or (n_rep<1);
                       if not rep then
                       begin
                            n_repeat := n_repeat + 1;
                            pos_rep[n_repeat] := o2;
                       end;

                  end
                  else  if n_repeat=0 then
                  begin
                       n_repeat := n_repeat + 1;
                       pos_rep[n_repeat] := o2;
                  end;
             end
             else
             begin
                  o9:=1; rep1:=true;
                  repeat
                       if (newpop[o2].chrom[o9] = oldpop_tmp[o4].chrom[o9]) then  rep1:= true
                       else  rep1:= false;
                       o9:= o9+1;
                  until ((o9=(maxbit+1)) or (rep1=false));
                  if not rep1 then
                  else
                       begin
                            n_repeat := n_repeat + 1;
                            pos_rep[n_repeat] := o2;
                       end;
             end;
         end;
     n_nrepeat1 := popsize - n_repeat;
     n_nrep := 1; n_rep := 1;
     for o5:=1 to popsize do
         if (o5<>pos_rep[n_rep]) then
         begin
              pos_nrep[n_nrep] := o5;
              n_nrep := n_nrep+1;
         end
         else  n_rep := n_rep + 1;



     for a:=1 to n_nrepeat1 do
     begin
          new_tmp[a].chrom := newpop[pos_nrep[a]].chrom;
          new_tmp[a].fitness := newpop[pos_nrep[a]].fitness;
     end;

{     new_tmp[2].fitness := 0.154448;
     new_tmp[4].fitness := 0.154448;}

{     n_repeat := 0;
     newpop_tmp[1].fitness := new_tmp[1].fitness;
     newpop_tmp[1].chrom := new_tmp[1].chrom;
     o2:= = 1;
     while  o2 <= n_nrepeat1 do
         begin
              if new_tmp[o2].fitness = newpop_tmp[o4].fitness then   o2 := o2+1
              else
              begin
                   newpop_tmp[o4+1].fitness := new_tmp[o2].fitness;
                   newpop_tmp[o4+1].chrom := new_tmp[o2].chrom;
                   o4:= o4+1;  o2:= o2+1;
              end;
         end;}

{         for o4:=1 to n_nrepeat1 do
             if ((new_tmp[o2].fitness = new_tmp[o4].fitness)and(o2<>o4))  then
             begin
                  if n_repeat<>0 then
                  begin
                       n_rep := n_repeat+1;
                       repeat
                             if o2=pos_rep[n_rep-1] then  rep:= true
                             else rep:= false;
                             n_rep:= n_rep-1
                       until (rep=true)or (n_rep<=1);
                       if not rep then
                       begin
                            n_repeat := n_repeat + 1;
                            pos_rep[n_repeat] := o2;
                       end;

                  end
                  else  if n_repeat=0 then
                  begin
                       n_repeat := n_repeat + 1;
                       pos_rep[n_repeat] := o2;
                  end;
             end  ;}



{     for o7:=1 to popsize do   pos_rep[o7]:=0;
     for o7:=1 to popsize do   pos_nrep[o7]:=0;}

{     write('between change new_tmp(sel) : ');
     for a:=1 to popsize do
         write(new_tmp[a].fitness:2:8,',');
     writeln;readln;}

{     writeln('between change new_tmp(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 100 do
             write(new_tmp[a1].chrom[a]);
         write(', '); write(new_tmp[a1].fitness); readln;
     end;
     writeln;readln;}

     n_repeat := 0; o8 := 1;
     for o2:=1 to n_nrepeat1 do
     begin
          rep := false;
          for o4:=o2+1 to n_nrepeat1 do
              if (new_tmp[o2].fitness = new_tmp[o4].fitness)  then rep:= true;
          if not rep then
          begin
                newpop_tmp[o8].fitness := new_tmp[o2].fitness;
                newpop_tmp[o8].chrom   := new_tmp[o2].chrom;
                o8 := o8+1;
          end;

     end;

{     write('between change oldpop(sel) * : ');
     for a:=1 to popsize do
         write(oldpop[a].fitness:2:8,',');
     writeln;readln;
     write('between change new_tmp(sel) * : ');
     for a:=1 to popsize do
         write(new_tmp[a].fitness:2:8,',');
     writeln;readln;}

{     write('between change newpop_tmp(sel) * : ');
     for a:=1 to popsize do
         write(newpop_tmp[a].fitness:2:8,',');
     writeln;readln;
     write('between change selpop(sel) * : ');
     for a:=1 to 2*popsize do
         write(sel_pop[a].fitness:2:8,',');
     writeln;readln;}

{     write('between change oldpop(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 20 do
             write(oldpop[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;
     write('between change new_tmp(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 20 do
             write(new_tmp[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;   }
{     writeln('between change newpop_tmp(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 100 do
             write(newpop_tmp[a1].chrom[a]);
         write(', '); write(newpop_tmp[a1].fitness); readln;
     end;
     writeln;readln;}
{     write('between change sel_pop(sel)  : ');
     for a1:=1 to 2*popsize do
     begin
         for a:=1 to 20 do
             write(sel_pop[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;}




{             begin
                  if n_repeat<>0 then
                  begin
                       n_rep := n_repeat+1;
                       repeat
                             if o2=pos_rep[n_rep-1] then  rep:= true
                             else rep:= false;
                             n_rep:= n_rep-1
                       until (rep=true)or (n_rep<=1);
                       if not rep then
                       begin
                            n_repeat := n_repeat + 1;
                            pos_rep[n_repeat] := o2;
                       end;

                  end
                  else  if n_repeat=0 then
                  begin
                       n_repeat := n_repeat + 1;
                       pos_rep[n_repeat] := o2;
                  end;
             end  ;
     n_nrepeat := n_nrepeat1 - n_repeat;

     n_nrep := 1; n_rep := 1;
     for o5:=1 to n_nrepeat1 do
         if (o5<>pos_rep[n_rep]) then
         begin
              pos_nrep[n_nrep] := o5;
              n_nrep := n_nrep+1;
         end
         else  n_rep := n_rep + 1;



     for a:=1 to n_nrepeat do
     begin
          newpop_tmp[a].chrom := new_tmp[pos_nrep[a]].chrom;
          newpop_tmp[a].fitness := new_tmp[pos_nrep[a]].fitness;
     end;}


     s:=1; {i:= 1;}
     while (s <= (o8-1))  do
     begin
          if (newpop_tmp[s].fitness > sel_pop[i].fitness) then
          begin
               sel_pop[i+1].fitness := newpop_tmp[s].fitness;
               sel_pop[i+1].chrom   := newpop_tmp[s].chrom;
               i := i+1;
          end
          else if (newpop_tmp[s].fitness < sel_pop[i].fitness) then
          begin
               min_tmp              := sel_pop[i].fitness;
               sel_pop[i].fitness   := newpop_tmp[s].fitness;
               sel_pop[i+1].fitness := min_tmp;
               min_tmp_arr          := sel_pop[i].chrom;
               sel_pop[i].chrom     := newpop_tmp[s].chrom;
               sel_pop[i+1].chrom   := min_tmp_arr;
               i1 := i; rep := false;
               repeat
                     if ((sel_pop[i1].fitness > sel_pop[i1-1].fitness)and(i1<>1)) then  i1 := i1-1
                     else if (sel_pop[i1].fitness < sel_pop[i1-1].fitness) and (i1<>1) then
                     begin
                          min_tmp := sel_pop[i1-1].fitness;
                          sel_pop[i1-1].fitness := sel_pop[i1].fitness;
                          sel_pop[i1].fitness   := min_tmp;
                          min_tmp_arr := sel_pop[i1-1].chrom;
                          sel_pop[i1-1].chrom := sel_pop[i1].chrom;
                          sel_pop[i1].chrom := min_tmp_arr;
                          i1 := i1-1;
                     end
                     else if (i1<>1) then
                          i1 := i1;
{                     i1 := i1-1;}
               until  i1<=1;
               i := i+1;
          end
          else
          begin
               i := i;
          end;

          s:= s+1;
     end;

{     write('between change oldpop(sel) * : ');
     for a:=1 to popsize do
         write(oldpop[a].fitness:2:8,',');
     writeln;readln;
     write('between change new_tmp(sel) * : ');
     for a:=1 to popsize do
         write(new_tmp[a].fitness:2:8,',');
     writeln;readln;

     write('between change newpop_tmp(sel) * : ');
     for a:=1 to popsize do
         write(newpop_tmp[a].fitness:2:8,',');
     writeln;readln;}
{     write('between change selpop(sel) * : ');
     for a:=1 to 2*popsize do
         write(sel_pop[a].fitness:2:8,',');
     writeln;readln;}

{     write('between change oldpop(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 20 do
             write(oldpop[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;
     write('between change new_tmp(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 20 do
             write(new_tmp[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;
     write('between change newpop_tmp(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 20 do
             write(newpop_tmp[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;}

{     writeln('after change sel_pop(sel)  : ');
     for a1:=1 to 2*popsize do
     begin
         for a:=1 to 100 do
             write(sel_pop[a1].chrom[a]);
         write(', ');write(sel_pop[a1].fitness); readln;
     end;
     writeln;readln;}


     for s:=1 to popsize do
     begin
          newpop[s].chrom := sel_pop[s].chrom;
          newpop[s].fitness := sel_pop[s].fitness;
     end;

{     write('after change oldpop(sel) * : ');
     for a:=1 to popsize do
         write(oldpop[a].fitness:2:8,',');
     writeln;readln;}
{     write('after change newpop(sel) * : ');
     for a:=1 to popsize do
         write(newpop[a].fitness:2:8,',');
     writeln;readln;}
{     write('after change selpop(sel) * : ');
     for a:=1 to 2*popsize do
         write(sel_pop[a].fitness:2:8,',');
     writeln;readln;}

{     write('after change oldpop(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 20 do
             write(oldpop[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;
     write('after change new_tmp(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 20 do
             write(new_tmp[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;}
{     writeln('after change newpop(sel)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 100 do
             write(newpop[a1].chrom[a]);
         write(', ');writeln(newpop[a1].fitness);
     end;
     writeln;readln;}
{     write('after change sel_pop(sel)  : ');
     for a1:=1 to 2*popsize do
     begin
         for a:=1 to 20 do
             write(sel_pop[a1].chrom[a]);
         write(',');
     end;
     writeln;readln;}




End;


{---------------------------------------------------------------}
{-----------------------------------------------------------------}

{ calculate  sumfitness for genetic operation }
Procedure  operation;
Var        i,ncross,nmutation,n_rep : Integer;
           sumfitness_org,x   : Single;
           a1,o1,o2,o3,o4,o5,o7  : Integer;
           n_nrepeat,n_repeat : Integer;
           sort_fit           : Population;
           pos_rep            : Array[1..Max_pop] of Integer;
           newpop             : Population;
           n_nrep ,j          : Integer;
           rep                : Boolean;
Begin
     ncross1:=0; nmutation1:=0; ncross2:=0; nmutation2:=0; {lchrom:= 121;}
     sumfitness_org := 0;
     for i:=1 to popsize do
     begin
          sumfitness_org := sumfitness_org + oldpop[i].fitness;
     end;
     generation(sumfitness_org,sort_fit,newpop);
     n_nrepeat := 0;
     main_use  := false;
     for i:=1 to popsize do with newpop[i] do
     begin
          for j:=1 to (w_ip+w_hi) do
          begin
               x:=  decode(chrom,(j*lch));
               if x >1  then x :=1
               else if x <-1 then x :=-1;
               newpop[i].value[j]:= x;
          end;
     end;
     for o7:=1 to popsize do   pos_rep[o7]:=0;
     calculate_train(newpop,nip_train,popsize,main_use);
     n_repeat := 0;
     for o2:=1 to popsize do
         for o4:=1 to popsize do
             if (newpop[o2].fitness = sort_fit[o4].fitness)  then
             begin
                  if n_repeat<>0 then
                  begin
                       n_rep := n_repeat+1;
                       repeat
                             if o2=pos_rep[n_rep-1] then  rep:= true
                             else rep:= false;
                             n_rep:= n_rep-1
                       until (rep=true)or (n_rep<=1);
                       if not rep then
                       begin
                            n_repeat := n_repeat + 1;
                            pos_rep[n_repeat] := o2;
                       end;

                  end
                  else  if n_repeat=0 then
                  begin
                       n_repeat := n_repeat + 1;
                       pos_rep[n_repeat] := o2;
                  end;
             end  ;

     for i:=1 to n_repeat do
     begin
          newpop[pos_rep[i]].chrom := sort_fit[i].chrom;
          newpop[pos_rep[i]].fitness := sort_fit[i].fitness;
     end;

     select_popsize(oldpop,newpop);

{     write('after change newpop(oper) * : ');
     for a:=1 to popsize do
         write(newpop[a].fitness:2:8,',');
     writeln;readln;}

{     writeln('after change newpop(oper)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 100 do
             write(newpop[a1].chrom[a]);
         write(', ');writeln(newpop[a1].fitness);
     end;
     writeln;readln;}


     for i:=1 to popsize do with newpop[i] do
     begin
          oldpop[i].chrom := chrom;
          for j:=1 to (w_ip+w_hi) do
          begin
               x:=  decode(chrom,(j*lch));
               if x >1  then x :=1
               else if x <-1 then x :=-1;
               oldpop[i].value[j]:= x;

          end;
     end;

{     writeln('after change oldpop(oper)  : ');
     for a1:=1 to popsize do
     begin
         for a:=1 to 100 do
             write(oldpop[a1].chrom[a]);
         write(', '); writeln(oldpop[a1].fitness);
     end;
     writeln;readln;}


End;


{**************************>>  write result to file  <<***********************}

Procedure Write_to_file_gen;
Var
      word  : String;
      Temp  : String[9];
      b     : Single;
Begin
      assign(result_file,name_result);
      append(result_file);
      if gen=1 then
      begin
           writeln(result_file,'  ');
           word :=' Avg Fitness for popsize : ';
           write(result_file,word);
           write(result_file,popsize);
           word :='   at round : ';
           write(result_file,word);
           writeln(result_file,r);
           Form2.ListBox1.Items.Add(' ');
           Form2.ListBox1.Items.Add(' ค่าความผิดพลาดเฉลี่ยสำหรับประชากรขนาด  '+FloatToStr(popsize)+' ณ.รอบที่  '+ FloatToStr(r));
      End;
      word :=' At gen : ';
      write(result_file,word);
      write(result_file,gen);
      word := ' =>  ';
      write(result_file,word);
      b := best_pop[1].B_fitness ;
      write(result_file,b:0:9);
      Form2.ListBox1.Items.Add(' ');
      Form2.ListBox1.Items.Add(' เจนเนอร์เรชั่นที่ '+FloatToStr(gen));
      Temp  := FloatToStr(b);
      Form2.ListBox1.Items.Add(' ค่าความผิดพลาดเฉลี่ยของประชากรที่เหมาะสมที่สุด =>> '+Temp);
//      word :='      All Avg Fitness =>  ';
      word :='      All  =>  ';
      write(result_file,word);
      b := sumfit1 ;
//      writeln(result_file,b:0:9);

      Temp  := FloatToStr(b);
      Form2.ListBox1.Items.Add(' ค่าความผิดพลาดเฉลี่ยของประชากรทั้งหมด             =>> '+Temp);
      Form2.ListBox1.Refresh;
      writeln(result_file,b:0:9);
      close(result_file);

End;

{******************>> Get start time <<********************}
Procedure Gettime_start;
Var   h,m,s,s100            : word ;

Begin
      Time_Start   := now ;
      DecodeTime(Time_start,h,m,s,s100);
      hh    :=IntToStr(h);    { Hour }
      mm    :=IntToStr(m);    { Minute }
      ss    :=IntToStr(s);    { second }
      ss100 :=IntToStr(s100); { second/1000 }
End;

{******************>> Get Finish time <<*******************}
Procedure Gettime_end;
Var   h,m,s,s100            : word ;
    //Time_end            : TDateTime ;
Begin
      Time_end := now ;
      decodeTime(Time_end,h,m,s,s100);
      hh1     :=IntToStr(h);     { Hour }
      mm1     :=IntToStr(m);     { Minute }
      ss1     :=IntToStr(s);     { second }
      ss100_1 :=IntToStr(s100);  { second/1000 }
End;

{******************>> Get use time <<********************}
Procedure Gettime_use;
Var   h,m,s,s100            : word ;

Begin
      Time_use := Time_start - Time_end ;
      decodeTime(Time_use,h,m,s,s100);
      hh2     :=IntToStr(h);     { Hour }
      mm2     :=IntToStr(m);     { Minute }
      ss2     :=IntToStr(s);     { second }
      ss100_2 :=IntToStr(s100);  { second/1000 }
End;

{***************************>>  Show Final Result  <<************************}

Procedure Show_Result;
Var  i,j,l: Integer;
     word : String;
     a    : Integer;
     b    : Single;
begin
     assign(result_file,name_result);
     append(result_file);

     word := 'Time result ';
     writeln(result_file,word);
     word := 'Start Time at    *=>  ';
     write(result_file,word);
     write(result_file,hh);
     write(result_file,' : ');
     write(result_file,mm);
     write(result_file,' : ');
     write(result_file,ss);
     write(result_file,' : ');
     writeln(result_file,ss100);

     word :='Finish Time at   *=>  ';
     write(result_file,word);
     write(result_file,hh1);
     write(result_file,' : ');
     write(result_file,mm1);
     write(result_file,' : ');
     write(result_file,ss1);
     write(result_file,' : ');
     writeln(result_file,ss100_1);

     word :='Use Time at      *=>  ';
     write(result_file,word);
     write(result_file,hh2);
     write(result_file,' : ');
     write(result_file,mm2);
     write(result_file,' : ');
     write(result_file,ss2);
     write(result_file,' : ');
     writeln(result_file,ss100_2);

     close(result_file);
     Form2.ListBox1.Items.Add(' ');
     Form2.ListBox1.Items.Add(' เวลาเริ่มต้น  =>> '+hh + ':'+mm+':'+ss);
     Form2.ListBox1.Items.Add(' เวลาที่เสร็จ   =>> '+hh1+ ':'+mm1+':'+ss1);
     Form2.ListBox1.Items.Add(' เวลาที่ใช้      =>> '+hh2+ ':'+mm2+':'+ss2);
     Form2.ListBox1.Refresh;

end;

{*************************>>  Show Time For Read Data  <<**********************}

Procedure Show_Time;
Var  i,j,l: Integer;
     word : String;
     a    : Integer;
     b    : Single;
begin
     assign(result_file,name_result);
     rewrite(result_file) ;

     word := ' Hidden node = ';
     write(result_file,word);
     writeln(result_file,hi_node);

     word := ' Pop_crossover = ';
     write(result_file,word);
     write(result_file,pcross:0:3);

     word := '    Pop_mutation = ';
     write(result_file,word);
     writeln(result_file,pmutation:0:3);

     word := ' Njcross_wip = ';
     write(result_file,word);
     write(result_file,njcross1);

     word := '               Njcross_whi = ';
     write(result_file,word);
     writeln(result_file,njcross2);

     word := ' Start Time to read at     *=>  ';
     write(result_file,word);
     write(result_file,hh);
     write(result_file,' : ');
     write(result_file,mm);
     write(result_file,' : ');
     write(result_file,ss);
     write(result_file,' : ');
     writeln(result_file,ss100);

     word :=' Finish Time to read at     *=>  ';
     write(result_file,word);
     write(result_file,hh1);
     write(result_file,' : ');
     write(result_file,mm1);
     write(result_file,' : ');
     write(result_file,ss1);
     write(result_file,' : ');
     writeln(result_file,ss100_1);

     word :=' Use Time to read at        *=>  ';
     write(result_file,word);
     write(result_file,hh2);
     write(result_file,' : ');
     write(result_file,mm2);
     write(result_file,' : ');
     write(result_file,ss2);
     write(result_file,' : ');
     writeln(result_file,ss100_2);


     close(result_file);
End;

Procedure store_output(nip:Integer; filename:String; Var outputfile:Text);
Begin
     assign(outputfile,filename);
     reset(outputfile);
     close(outputfile);
End;

Function FileExists(FileName: String): Boolean;

{ Boolean function that returns True if the file exists; otherwise,
  it returns False. Closes the file if it exists. }
 Var
  F: file;
begin
  {$I-}
  AssignFile(F, FileName);
  FileMode := 0;  { Set file access to read only }
  try
    Rewrite(F);
    CloseFile(F);
  except
        Application.MessageBox('ไม่สามารถเขียนไฟล์ได้', 'บันทึกไฟล์', MB_OK) ;
  end ;
  {$I+}
  FileExists := (IOResult = 0) and (FileName <> '');
End;  { FileExists }




Procedure TForm2.Button1Click(Sender: TObject);
Var
   temp1, temp2  : String ;

Begin
{      write('Enter file name to store your result  :  ');}
{      readln(name_result);}

       If (FileExists(Edit1.Text)) Then
       Begin
          name_result := Edit1.Text ;
          Gettime_start;
          flag1  := false ;
          flag2  := false ;
          l      := 1;
          r      := 0;
          w_ip   := (ip+1)*hi_node ;
          w_hi   := hi_node+1 ;
          maxbit := (w_ip+w_hi)*lch ;
          end1   := w_ip*lch ;
          start2 := end1+1 ;
          end2   := maxbit ;
          store_MinMax_input_patterns;
          store_MinMax_output;
          store_input_patterns(nip_train,name_ip,inp_train_file);    {show_input_pattern(nip_train);}
          store_input_patterns(nip_test,name_ipt,inp_test_file);     {show_input_pattern(nip_test);}
          store_output_patterns(nip_train,name_op,op_train_file);
          store_output_patterns(nip_test,name_opt,op_test_file);
          Gettime_end;
          Gettime_use;
          Show_Time;
       End
       Else
       Begin
          Application.MessageBox('ไม่สามารถเขียนไฟล์ได้', 'บันทึกไฟล์', MB_OK) ;
          Exit ;
       End ;

      Repeat
      Begin
           If r= round then
           begin
                r:= 1;
                l:= l+1;
           end
           else r:= r+1;

           Gettime_start;

             popsize := Cpop  ;
//           if l = 1 then  Popsize := (Cpop)*(l*4)
//           else popsize := Cpop * (l+3);

           if popsize >= pointcut_pop3 then maxgen := maxgen4
           else if popsize >= pointcut_pop2 then maxgen := maxgen3
           else if popsize >= pointcut_pop1 then maxgen := maxgen2
           else maxgen := maxgen1;
           random_weight;

           calculate_train(oldpop,nip_train,popsize,main_use);
           Flag_chk := True ;
           gen := 1;
           While ((gen <> maxgen) and (flag_chk <> False)) do
           begin
                 main_use := true;
                 operation;
                 calculate_train(oldpop,nip_train,popsize,main_use);
                 if gen = 1 then
                 begin
                      count1   := 0 ;
                      count2   := 0 ;
                      best     := best_pop[1].B_fitness ;
                      best_all := sumfit1;
                 end
                 else if (gen <>1) and (best - best_pop[1].B_fitness >= 0.000000001) then
                 begin
                      best     := best_pop[1].B_fitness ;
                      count1   := 0 ;
                      count2   := 0 ;
                 end
                 else if(gen <>1) and (best - best_pop[1].B_fitness < 0.000000001) then
                 begin
                      count1   := count1+1 ;
                 end;

                 If (gen <>1) and (best_all - sumfit1 < 0.000000001) and (count1 <> 0)then
                 begin
                      count2   := count2+1 ;
                 end
                 else if (gen <>1) and (best_all - sumfit1 >= 0.000000001) and (count1 <> 0)then
                 begin
                       best_all := sumfit1;
                       count2   := 0 ;
                 end;

                 if (gen >= 1) then
{                  if ((gen = 2) or (gen=5) or (gen=15) or ((gen mod 25)=0)) then}
                 begin
                      write_to_file_gen;
                   //   Form2.Refresh;
                  end;
            If ((Count1 >= Max_count1)and(Count2 >= Max_count2)) or (count1 >=Max_count1_1) then Flag_chk := False ;

            gen := gen+1 ;
            end;
{*********>> Calculate Error In Input pattern for testing <<*********}
           claculate_test_round;
           Gettime_end;
           Gettime_use;
           show_result;
      End;
      Until (((l=loop)and(r=round)) or ((flag1 = true) and (flag2 =true)));

      Application.MessageBox('ประมวลผลเสร็จเรียบร้อยแล้ว', 'โปรแกรม GA', MB_OK) ;
end;
procedure TForm2.Button2Click(Sender: TObject);
begin
     Form2.hide;
     Form3.show;
end;

End.
