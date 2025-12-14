

         {#####################################################}
         {######### Transform input to Massage Value ##########}
         {#####################################################}


program Backpropagation_neuron_network;
uses crt;
const
     n = 8;                          {Number of input units}
     np = 200;                       {Number of training input patterns}
     np_test = 40;                   {Number of testing input patterns}
     m = 1;                          {Number of output units}
  {Identify min and max values of inputs&output}
     Max   =  0.9;
     Min   =  0.1;

type
     array_OPk = array[1..m,1..np]of real;
     array_inp = array[0..n,1..np]of real;
     array_min_max_ip = array[1..n]of real;
     array_min_max_tg = array[1..m]of real;

var  Xin:array_inp;                     {Store all input patterns(include bias)}
     Xin_num:integer;                   {Input pattern number}
     Tk:array_OPk;                      {Store target values of output units for each input patterns}
     OPk:array_OPk;                     {Store output values of output units for each input patterns}
     AmaxIP:array_min_max_ip;           {Store max values of input units}
     AminIP:array_min_max_ip;           {Store min values of input units}
     AmaxTG:array_min_max_tg;           {Store max values of targets(output units)}
     AminTG:array_min_max_tg;           {Store min values of targets(output units)}
     ans:char;


    {*********Store all input patterns(include bias 1)**********}
procedure store_input_patterns(NumIPP:longint);
var       i,j,x:integer;
          InputFile:Text;
          Filename:String[12];
          IP,IP1 : real;
begin
           writeln;
           write ('Enter Filename to read(Input File) : ');
           readln(Filename);
           Assign(InputFile,Filename);
           Reset(InputFile);
           x:=0;
        {calculate massage values(range 0.1-0.9) and store input patterns}
           for j:=1 to NumIPP do
               for i:=1 to n do
               begin    x:=x+1;
                        Readln(InputFile,IP);
                        IP1:=((Max-Min)*(IP-AminIP[i])/(AmaxIP[i]-AminIP[i]))+Min;
                        Xin[i][j]:=IP1;
                        writeln('massage values of inputs : ',IP1:3:5);
               end;
           writeln('num of massage  values: ',x);
           close(InputFile);
           for i:=1 to NumIPP do     {Store bias value(1) for every input pattern}
              Xin[0][i]:=1;
end;

 {****************** Write Massage Value of i/p&target *******************}

procedure  write_massage_value_of_input_target(MV_Xin:array_inp;MV_Tk:array_OPk;Num:integer);
var        MVfile:text;
           MV:real;
           head:string;
           Filename:string[14];
           x,i,j:integer;

begin
         x:=0;
         writeln;
         write('Enter name of file to write(Input and Target Massage Value File) : ');
         Readln(Filename);
         Assign(MVfile,Filename);
         Rewrite(MVfile);
         head:='                       Massage Value';
         writeln(MVfile,head);
       {Write Input Massage Value}
         head:='  Input Massage Value';
         writeln(MVfile,head);
         for j:=1 to Num do
         begin
             for i:=1 to n do
             begin    x:=x+1;
                      MV:=Xin[i][j];
                      writeln(MVfile,MV:2:6);
             end;
             writeln(MVfile,'   ');
         end;
         head:='   Number of input massage value = ';
         write(MVfile,head);
         writeln(MVfile,x);
         x:=0;
       {Write Target Massage Value}
         head:='   Target Massage Value';
         writeln(MVfile,head);
         for j:=1 to Num do
         begin
             for i:=1 to m do
             begin x:=x+1;
                   MV:=Tk[i][j];
                   writeln(MVfile,MV:2:6);
             end;
         end;
         head:='   Number of target massage value = ';
         write(MVfile,head);
         writeln(MVfile,x);
         close(MVfile);
end;



    {*********Store Min&Max values for input patterns**********}
procedure store_min_max_of_input_patterns;
var       i,x:integer;
          MinMaxFile:Text;
          Filename:String[12];
          _Min,_Max : real;
begin
           writeln;
           write ('Enter Filename to read(Min&Max(Input) File) : ');
           readln(Filename);
           Assign(MinMaxFile,Filename);
           Reset(MinMaxFile);
           x:=0;
        {Store min values of input units}
           for i:=1 to n do
           begin    x:=x+1;
                    Readln(MinMaxFile,_Min);
                    AminIP[i]:=_Min;
           end;
        {store max values of input units}
           for i:=1 to n do
           begin    x:=x+1;
                    Readln(MinMaxFile,_Max);
                    AmaxIP[i]:=_Max;
           end;
           close(MinMaxFile);
           writeln('num of min&max input units: ',x);
end;

    {*****************Store all target values*******************}
procedure store_target_values(NumIPP:longint);
var       i,j,x:integer;
          TargetFile:Text;
          Filename:String[12];
          TG,TG1 : real;
begin
           writeln;
           write ('Enter Filename to read(Target File) : ');
           readln(Filename);
           Assign(TargetFile,Filename);
           Reset(TargetFile);
           x:=0;
        {Calculate massage values(range 0.1-0.9) and store target values}
           for j:=1 to NumIPP do
               for i:=1 to m do
               begin      x:=x+1;
                          Readln(TargetFile,TG);
                          TG1:=((Max-Min)*(TG-AminTG[i])/(AmaxTG[i]-AminTG[i]))+Min;
                          Tk[i][j]:=TG1;
                          writeln('massage values of targets : ',TG1:3:5);
               end;
           writeln('num of massage values: ',x);
           close(TargetFile);
end;

    {*****************Store Min&Max for target values*******************}
procedure store_min_max_of_target_values;
var       i,x:integer;
          MinMaxFile :Text;
          Filename:String[12];
          _Min,_Max : real;
begin
           writeln;
           write ('Enter Filename to read(Min&Max(Targets) File) : ');
           readln(Filename);
           Assign(MinMaxFile,Filename);
           Reset(MinMaxFile);
           x:=0;
        {Store min values of output units}
           for i:=1 to m do
           begin    x:=x+1;
                    Readln(MinMaxFile,_Min);
                    AminTG[i]:=_Min;
           end;
        {Store max values of output units}
           for i:=1 to m do
           begin    x:=x+1;
                    Readln(MinMaxFile,_Max);
                    AmaxTG[i]:=_Max;
           end;
           close(MinMaxFile);
           writeln('num of min&max targets: ',x);
end;


begin
        ans:='y';
      Repeat
        clrscr;
        store_min_max_of_input_patterns;
        store_min_max_of_target_values;
{-----------------For training input patterns------------------}
        store_input_patterns(np);
        store_target_values(np);
        write_massage_value_of_input_target(Xin,Tk,np);
{-----------------For testing input patterns------------------}
        store_input_patterns(np_test);
        store_target_values(np_test);
        write_massage_value_of_input_target(Xin,Tk,np_test);
        write('Again(Yes:press any key,No:press n or N)? : ');
        readln(ans);
      until  (ans='n') or (ans='N');
        readln;
end.




