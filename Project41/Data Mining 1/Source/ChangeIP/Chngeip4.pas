

        {########################################################}
        {######### Transform input to Time Series Input #########}
        {######## And Time Series Input to Massage Value ########}
        {########################################################}


program Backpropagation_neuron_network;
uses crt;
const
     n = 8;                          {Number of input units}
     m = 1;                          {Number of output units}
     np = 164;                       {Number of training input patterns}
     np_test = 40;                   {Number of testing input patterns}
     TimeSeries = 3;                 {Number of time series}
  {Identify min and max values of inputs&output}
     Max   =  0.9;
     Min   =  0.1;

type
     array_inp = array[0..n+1,1..np]of real;
     array_OPk = array[1..m,1..np]of real;
     array_min_max_ip = array[1..n+1]of real;
     array_min_max_tg = array[1..m]of real;


var  Xin:array_inp;                     {Store all input patterns(include bias 1)}
     Xin_num:integer;                   {Input pattern number}
     Tk:array_OPk;                      {Store target values of output units for each input patterns}
     OPk:array_OPk;                     {Store output values of output units for each input patterns}
     AmaxIP:array_min_max_ip;           {Store max values of input units}
     AminIP:array_min_max_ip;           {Store min values of input units}
     AmaxTG:array_min_max_tg;           {Store max values of targets(output units)}
     AminTG:array_min_max_tg;           {Store min values of targets(output units)}
     ans:char;
     Tseries:array[1..np+3] of real;    {Store all inputs(baht)}
     Factor:array[1..3] of real;        {Using for transforming inputs(baht) to time series inputs(baht)}
     TseriesIP:array[1..3,1..np] of real;   {Store all time series inputs(baht)}
     MinTIP,MaxTIP:real;                {Store min and max value of time series inputs(baht)}



    {*********Store all input patterns(include bias 1)**********}
procedure store_input_patterns(NumIPP:longint);
var       i,j,t,x:integer;
          InputFile:Text;
          Filename:String[12];
          IP,IP1,sum,temp_min,temp_max: real;
begin
           writeln;
           write ('Enter Filename to read(Input File) : ');
           readln(Filename);
           Assign(InputFile,Filename);
           Reset(InputFile);
           x:=0;
           t:=0;
           for j:=1 to NumIPP do
               for i:=1 to n+1 do
               begin
                    Readln(InputFile,IP);
                    if i<6 then    {Calculate massage values(range 0.1-0.9) and store training inputs(not baht)}
                    begin      x:=x+1;
                               IP1:=((Max-Min)*(IP-AminIP[i])/(AmaxIP[i]-AminIP[i]))+Min;
                               Xin[i][j]:=IP1;
                               writeln('massage values of inputs : ',IP1:3:5);
                    end
                    else           {Store training inputs(baht)}
                    begin
                               x:=x+1;
                               if j=1 then   {Case of storing first training input(baht) which store 3 values of baht}
                               begin
                                    t:=t+1;
                                    Tseries[t]:=IP;
                                    writeln(Tseries[t]:3:5);
                               end
                               else          {Case of storing other training input(baht) which store 1 values of baht(last)}
                                    if i=9 then
                                    begin
                                         t:=t+1;
                                         Tseries[t]:=IP;
                                         writeln(Tseries[t]:3:5);
                                    end;
                    end;
               end;
           writeln('Number of training time series inputs(baht): ',t);
           writeln('Number of massage value inputs(not baht) : ',x);
       {Calculate factors which use for transforming inputs(baht) to time series inputs(baht)}
           for j:=1 to 3 do
           begin
                sum:=0;
                for i:=(TimeSeries+1) to NumIPP+3 do
                     sum:=sum+abs(Tseries[i]-Tseries[i-j])/Tseries[i];
                factor[j]:=2*sum/(NumIPP);
                writeln('Factor',j,' is ',factor[j]:3:5);
           end;
           temp_max:=-10;
           temp_min:=10;
       {Transform training inputs(baht) to time series inputs(baht) and find min and max value of time series inputs(baht)}
           for j:=1 to NumIPP do
               for i:=1 to 3 do
               begin
                        TseriesIP[i][j]:=(Tseries[TimeSeries+j]-Tseries[TimeSeries+j-i])/(Tseries[TimeSeries+j]*factor[i]);
                        if TseriesIP[i][j]>temp_max then temp_max:=TseriesIP[i][j];
                        if TseriesIP[i][j]<temp_min then temp_min:=TseriesIP[i][j];
               end;
           MaxTIP:=temp_max;
           MinTIP:=temp_min;
           writeln;
           writeln('Min of Input is ',MinTIP:3:5);
           writeln('Max of Input is ',MaxTIP:3:5);
       {Calculate massage values(range 0.1-0.9) of training inputs(baht)}
           for j:=1 to NumIPP do
               for i:=1 to 3 do
                        TseriesIP[i][j]:=((Max-Min)*(TseriesIP[i][j]-MinTIP)/(MaxTIP-MinTIP))+Min;
       {Store training massage value inputs(baht)}
           for j:=1 to NumIPP do
               for i:=6 to n do
                    Xin[i][j]:=TseriesIP[i-5][j];
           close(InputFile);
           for i:=1 to NumIPP do         {store bias value(1) for every input patterns}
               Xin[0][i]:=1;
end;

    {*********Store all input patterns for test(include bias 1)**********}
procedure store_input_patterns_for_test(NumIPP:longint);
var       i,j,t,x:integer;
          InputFile:Text;
          Filename:String[12];
          IP,IP1,sum : real;
begin
           writeln;
           write ('Enter Filename to read(Input File) : ');
           readln(Filename);
           Assign(InputFile,Filename);
           Reset(InputFile);
           x:=0;
           t:=0;
           for j:=1 to NumIPP do
               for i:=1 to n+1 do
               begin
                    Readln(InputFile,IP);
                    if i<6 then         {Calculate massage values(range 0.1-0.9) and store testing inputs(not baht)}
                    begin      x:=x+1;
                               IP1:=((Max-Min)*(IP-AminIP[i])/(AmaxIP[i]-AminIP[i]))+Min;
                               Xin[i][j]:=IP1;
                               writeln('massage values of inputs : ',IP1:3:5);
                    end
                    else                {Store testing inputs(baht)}
                    begin
                               x:=x+1;
                               if j=1 then       {Case of storing first testing input(baht) which store 3 values of baht}
                               begin
                                    t:=t+1;
                                    Tseries[t]:=IP;
                                    writeln(Tseries[t]:3:5);
                               end
                               else              {Case of storing other testing input(baht) which store 1 values of baht(last)}
                                    if i=9 then
                                    begin
                                         t:=t+1;
                                         Tseries[t]:=IP;
                                         writeln(Tseries[t]:3:5); {readln;}
                                    end;
                    end;
               end;
           writeln('Number of testing time series inputs(baht): ',t);
           writeln('Number of massage value inputs(not baht) : ',x);
       {Transform testing inputs(baht) to time series inputs(baht) and find min and max value of time series inputs(baht)}
           for j:=1 to NumIPP do
               for i:=1 to 3 do
                        TseriesIP[i][j]:=(Tseries[TimeSeries+j]-Tseries[TimeSeries+j-i])/(Tseries[TimeSeries+j]*factor[i]);
       {Calculate massage values(range 0.1-0.9) and store testing inputs(baht)}
           for j:=1 to NumIPP do
               for i:=1 to 3 do
                        TseriesIP[i][j]:=((Max-Min)*(TseriesIP[i][j]-MinTIP)/(MaxTIP-MinTIP))+Min;
       {Store testing massage value inputs(baht)}
           for j:=1 to NumIPP do
           begin
               t:=0;
               for i:=6 to n do
               begin
                    t:=t+1;
                    Xin[i][j]:=TseriesIP[t][j];
               end;
           end;
           close(InputFile);
           for i:=1 to NumIPP do           {store bias value(1) for every input pattern}
               Xin[0][i]:=1;
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
       {Store min values of inputs(not baht)}
           for i:=1 to n-3 do
           begin    x:=x+1;
                    Readln(MinMaxFile,_Min);
                    AminIP[i]:=_Min;
           end;
       {Store max values of inputs(not baht)}
           for i:=1 to n-3 do
           begin    x:=x+1;
                    Readln(MinMaxFile,_Max);
                    AmaxIP[i]:=_Max;
           end;
           close(MinMaxFile);
           writeln('Number of min&max inputs(not baht): ',x);
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
        {Calculate massage values(range 0.1-0.9) and store target values(baht)}
           for j:=1 to NumIPP do
               for i:=1 to m do
               begin      x:=x+1;
                          Readln(TargetFile,TG);
                          TG1:=((Max-Min)*(TG-AminTG[i])/(AmaxTG[i]-AminTG[i]))+Min;
                          Tk[i][j]:=TG1;
                          writeln('massage values of targets : ',TG1:3:5);
               end;
           writeln('Number of massage values: ',x);
           readln;
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
       {Store min values of targets(baht)}
           for i:=1 to m do
           begin    x:=x+1;
                    Readln(MinMaxFile,_Min);
                    AminTG[i]:=_Min;
           end;
       {Store max values of targets(baht)}
           for i:=1 to m do
           begin    x:=x+1;
                    Readln(MinMaxFile,_Max);
                    AmaxTG[i]:=_Max;
           end;
           close(MinMaxFile);
           writeln('Number of min&max targets: ',x);
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
         head:='  Input Massage Value';
         writeln(MVfile,head);
      {Write Input Massage Value}
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
         head:='   Target Massage Value';
         writeln(MVfile,head);
      {Write Target Massage Value}
         for j:=1 to Num do
         begin
             for i:=1 to m do
             begin
                   MV:=Tk[i][j];
                   writeln(MVfile,MV:2:6);
                   x:=x+1;
             end;
         end;
         head:='   Number of target massage value = ';
         write(MVfile,head);
         writeln(MVfile,x);
         close(MVfile);
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
{-----------------For testing input patterns-------------------}
        store_input_patterns_for_test(np_test);
        store_target_values(np_test);
        write_massage_value_of_input_target(Xin,Tk,np_test);
        writeln;
        write('Again(Yes:press any key,No:press n or N)? : ');
        readln(ans);
      until  (ans='n') or (ans='N');
        readln;
end.




