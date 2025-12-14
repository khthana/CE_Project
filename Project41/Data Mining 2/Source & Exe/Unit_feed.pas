
// ** Note **
{ select  by  Reproduction no repeat and reproduction average
  ( by select from both oldpop and newpop )
  ( cut 1 popsize )}

{ To select Project -> Option -> Linker -> min 16384  max 16777216 }

// ** Genetic algorithms program **
Unit Unit_feed;

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
     pointcut_pop3 = 3007 ;
     maxgen1       = 10 ;
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
//     cname_weight   = 'w_bp.txt';

Type

    TForm1  = class(TForm)
    Button1 : TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    ListBox1: TListBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
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
    individual3    = record
                     value  : Array[1..((ip+1)*hi_node)+(hi_node+1)] of Single ;
                     fitness : Single ;
                     fitness_test  :Single;
                     fitness_fact  :Single;
                   end;

    Population3    = Array[1..loop] of individual3 ;
    ip_array       = Array[1..(ip+1),1..nip_train] of Single ;{ input from input nodes to hidden nodes }
    ipt_array      = Array[1..(ip+1),1..nip_test] of Single ;{ input from input nodes to hidden nodes }
    hid_array      = Array[1..hi_node] of Single;{ input from hidden nodes to output node }
    op_array       = Array[1..nip_train] of Single ;
    opt_array      = Array[1..nip_test] of Single ;
    mm_array       = Array[1..(ip+2)] of Single;
    mm_op_array    = Array[1..op_node] of Single ;

Var
    Form1                 : TForm1;
    best_pop              : Population3;
    sumfitness            : Single;
    Best,Best_all         : Single;
    error_baht            : Single;
    error_baht_test       : Single;
    r,l                   : Byte ;
    popsize               : Integer;
    gen,maxgen            : Integer;
    maxbit,start2         : Integer;
    count1,count2         : Byte;
    w_ip                  : Byte;   { W_ip number of weight from input nodes include weight for bias }
    w_hi                  : Byte;   { W_hi number of weight from hidden nodes include weight for bias }
    allelevel             : Allele;
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
    Weightfile            : Text;
    op_train_file         : Text;
    inp_test_file         : Text;
    op_test_file          : Text;
    result_file           : Text;
    name_result           : String;
    name_weight           : String;
    sumfit1               : Single ;


implementation

uses Unit_proj;

{$R *.DFM}

{**************************>>  Store  Weight   <<**************************}
Procedure store_weight ;
Var
     r2 :Integer ;
     r4 :Single ;
Begin
          Assign(WeightFile,name_weight);
          Reset(WeightFile);

          for r2:=1 to (w_ip+w_hi) do
          begin
                    readln(weightfile,r4) ;
                    best_pop[1].value[r2] := r4 ;

          end;
          close(Weightfile);
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
     for s1:=2 to (ip+1) do
     begin
          readln(MinMaxfile,_Min);
          min_ip[s1] := _Min ;
     end;
     for s1:=2 to (ip+1) do
     begin
         readln(MinMaxfile,_Max);
         max_ip[s1] := _Max ;
     end;
     close(MinMaxfile);
End;

{********************>>  Store Min&Max output values  <<********************}
Procedure store_minmax_output;
Var
     MinMaxfile       : Text ;
     _min,_max        : Single;
Begin
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


{***********>>  Claculate Sigmiod function for test <<***********}
Procedure calculate_test (Var best_pop:Population3);
Var
     A_hi           : hid_array ;
     c2,c3,c4,b,a   : Integer;
     result,result1 : Single ;
     sum,sum1,sum2,sum3,sigmoid1,sigmoid2  : Single ;
     error_bath     : Single ;
     Temp           : String[7];

Begin
          Form1.ListBox1.Items.Add(' ');
          Form1.ListBox1.Items.Add(' แสดงค่าความผิดพลาดจากการทำนายอัตราแลกเปลี่ยน');
          Form1.ListBox1.Items.Add(' สำหรับข้อมูลชุดทดสอบ (04 Jan 98 -> 26 Feb 98)');
          Form1.ListBox1.Items.Add(' ไฟล์นำหนักที่ใช้ในการทำนายคือ   '+Form1.Edit1.text);
          Form1.ListBox1.Items.Add(' ');
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
                           sum := ip_test[c4][c2]*best_pop[1].value[b] ;
                           sum1:=sum1+sum ;

                    end ;{c4}
                    sigmoid1 := 1/(1+exp(-sum1)) ;
                    A_hi[c3] := sigmoid1;
                    a := a+1 ;
               end;{c3}
               sum2 := 0 ;
               sum3 := 0 ;
               sum2 := 1*best_pop[1].value[1+w_ip] ;
               sum3 := sum3+sum2 ;

               for c3:= 1 to hi_node do
               begin{c3}
                    sum2 := a_hi[c3]*best_pop[1].value[1+c3+w_ip] ;
                    sum3 := sum3+sum2 ;
               end;{c3}
               sigmoid2 := 1/(1+exp(-sum3)) ;
               result   := abs(op_test[c2] - sigmoid2) ;
               error_bath := (sigmoid2-0.1)*(Max_op-Min_op)/(Max_range-Min_range)+Min_op;
               Form1.ListBox1.Items.Add('   ข้อมูลชุดที่ '+FloatToStr(c2)+'.');
               temp       :=FloatToStr(error_bath);
               Form1.ListBox1.Items.Add('   ค่าที่ทำนายได้       =>>  '+ temp +'   บาท');
               error_bath := result*(Max_op-Min_op)/(Max_range-Min_range);
               temp       :=FloatToStr(error_bath);
               Form1.ListBox1.Items.Add('   ค่าความผิดพลาด   =>>  '+ temp +'   บาท');
               result1  := result1+result ;
          end;{c2}
          best_pop[1].fitness_test   := result1/nip_test ;
End;


{***********>>  Claculate Sigmiod function for test <<***********}
Procedure claculate_test_round ;
Var
            i,j,k : Integer ;
             word : String;
             a    : Integer;
             b    : Single;
      weight_file : Text;
      name_weight : String;
      Temp        : String[5];
Begin


        calculate_test(best_pop);
        error_baht_test := best_pop[1].fitness_test*(Max_op-Min_op)/(Max_range-Min_range);
        Temp    := FloatToStr(error_baht_test);
        Form1.ListBox1.Items.Add(' ');
        Form1.ListBox1.Items.Add('  ค่าความผิดพลาดเฉลี่ยสำหรับข้อมูลชุดทดลอง  '+temp+'   บาท');
        Form1.ListBox1.Items.Add(' ');

End ;

Function FileExists1(FileName: String): Boolean;
{ Boolean function that returns True if the file exists; otherwise,
  it returns False. Closes the file if it exists. }
 Var
  F: file;
begin
  {$I-}
  AssignFile(F, FileName);
  FileMode := 0;  { Set file access to read only }
  try
    Reset(F);
    CloseFile(F);
  except
        Application.MessageBox('ไม่สามารถค้นพบไฟล์', 'อ่านค่าจากไฟล์', MB_OK) ;
  end ;
  {$I+}
  FileExists1 := (IOResult = 0) and (FileName <> '');
End;  { FileExists }


Procedure TForm1.Button1Click(Sender: TObject);
Var
   temp1, temp2  : String ;

Begin
       If (FileExists1(Edit1.Text))Then
       Begin
          name_weight := Edit1.Text ;
//          name_weight   := cname_weight;
          w_ip   := (ip+1)*hi_node ;
          w_hi   := hi_node+1 ;
          maxbit := (w_ip+w_hi)*lch ;
          store_MinMax_input_patterns;
          store_MinMax_output;
          store_input_patterns(nip_train,name_ip,inp_train_file);    {show_input_pattern(nip_train);}
          store_input_patterns(nip_test,name_ipt,inp_test_file);     {show_input_pattern(nip_test);}
          store_output_patterns(nip_train,name_op,op_train_file);
          store_output_patterns(nip_test,name_opt,op_test_file);
       End
       Else
       Begin
          Application.MessageBox('ไม่สามารถค้นพบไฟล์', 'อ่านค่าจากไฟล์', MB_OK) ;
          Exit ;
       End ;
           popsize := Cpop  ;
           store_weight;

{*********>> Calculate Error In Input pattern for testing <<*********}
           claculate_test_round;
      Application.MessageBox('ประมวลผลเสร็จเรียบร้อยแล้ว', 'โปรแกรม GA', MB_OK) ;

end;
procedure TForm1.Button2Click(Sender: TObject);
begin
     Form1.hide;
     Form3.show;
end;

End.
