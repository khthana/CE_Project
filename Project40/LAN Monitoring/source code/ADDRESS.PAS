Program AddrBookProgram;
Uses INIF,EMS,Crt,stringop,grafica,g_applic,util256,graph,mouse;
Const
	AddrFile = 'Addr.ini';
Type
    adapplic = object(g_application)
               procedure background; virtual;
               end;
    AddrPtr  = ^AddrInfo;
    AddrInfo = record
    		   	   sName,sHWAddr,sIPAddr,sDesc : String;
				   pNext : AddrPtr;
			   end;
Var w : adapplic;
    key : char;
Procedure adapplic.background;
var i,j : integer;
begin
     hide;
     setviewport(0,21,639,454,true);
     setfillstyle(1,0);
     bar(0,0,getmaxx,getmaxy);

     SetFillStyle(1, 10);
     bar(260,80,420,220);

     SetFillStyle(1, 2);
     bar(280,100,400,200);

     SetFillStyle(1, 10);
     bar(260,240,420,260);

     SetFillStyle(10, 10);
     bar(40,280,600,282);

     SetFillStyle(10, 10);
     bar(340,260,342,280);

     for I:= 0 to 11 do
        line(80+i*40,300,100+i*40,300);
     for I:= 0 to 11 do
        line(100+i*40,320,120+i*40,320);
     for I:= 0 to 22 do
        line(100+i*20,300,100+i*20,320);
     setcolor(1);
     for I:= 0 to 20 do
        line(300-I,220+I,380+I,220+I);
     setviewport(0,0,639,479,true);

     show;
end;

Procedure ShowErrorDlg(ErrMsg1,ErrMsg2 : String);
Begin
	fer_tip := 3;
    w.newwin(100,200,400,280,'Error',true);
    w.newtext(110,240,ErrMsg1);
    w.newtext(110,260,ErrMsg2);
    w.handleevent;
    w.clrwin(1);
    cm := 0;
End;

Function CheckHWAddr(sHWAddr : String) : Boolean;
Var
	cnt : integer;
    IsCorrect : Boolean;
Begin
	{Check syntax of HWAddr,It should be aabbcc-ddeeff}
    cnt := 1;
    IsCorrect := True;
    If Length(sHWAddr) <> 13 then IsCorrect := False
    else begin
    		while (cnt <= 13) and (IsCorrect) do
    		begin
        	if cnt = 7 then {so it will be hyphen}
        		begin
            	if sHWAddr[cnt] <> '-' then IsCorrect := False
        		end
	    	else 					{else it will be hexadecimal}
        		if not (sHWAddr[cnt] in ['0'..'9','A'..'F','a'..'f']) then
					IsCorrect := False;
        	cnt := cnt+1;
    		end;
         end;
    CheckHWAddr := IsCorrect;
End;

Procedure NewAddr(Var phAddrInfo:AddrPtr; AddrNum:integer);
var
    IsCorrect : Boolean;
    pcAddrInfo,pnAddrInfo:AddrPtr;
Begin
	pcAddrInfo := phAddrInfo;
   	If phAddrInfo <> nil then
		While pcAddrInfo^.pNext <> nil do pcAddrInfo := pcAddrInfo^.pNext;
 	   {Display New/Edit Address Dialog}
    fer_tip := 5;
    w.newwin(150,100,400,350,'New Address',true);
    w.newtext(165,150,'Name :');
    w.newtext(165,180,'HW Address :');
    w.newtext(165,210,'IP Address :');
    w.newtext(165,240,'Description :');
    w.newinput(260,140,380,160,'','n');
    w.newinput(260,170,380,190,'','h');
    w.newinput(260,200,380,220,'','i');
    w.newinput(260,230,380,250,'','d');
    w.newbut(180,300,270,320,'~S~ave',1,os2,'');
    w.newbut(290,300,380,320,'~C~ancel',1,os2,'');
    repeat
    	w.handleevent;
        If cm = 2 then
        	Begin
            New(pnAddrInfo);
            pnAddrInfo^.sName := w.get_input(1);{ 1 is the order of newinput}
            pnAddrInfo^.sHWAddr := w.get_input(2);
            pnAddrInfo^.sIPAddr := w.get_input(3);
            pnAddrInfo^.sDesc := w.get_input(4);
            pnAddrInfo^.pNext := nil;
            IsCorrect := CheckHWAddr(pnAddrInfo^.sHWAddr);
            If IsCorrect = False then	{Show HWAddr. error dialog}
                begin
                ShowErrorDlg('Invalid Hardware Address.',
							 'It must be in form "xx-xx-xx-xx-xx-xx"');
                Dispose(pnAddrInfo);
                end
            else		{Save to link list}
                begin
                If phAddrInfo = nil then phAddrInfo := pnAddrInfo
				else pcAddrInfo^.pNext := pnAddrInfo;
                cm := 1;
                end;
            end;
    until (cm = 1) or (cm = 3);
    w.clrwin(1); cm := 0;
End;

Procedure EditAddr(phAddrInfo : AddrPtr; AddrNum : integer);
Var
    pcAddrInfo : AddrPtr;
	i : integer;
    IsCorrect : Boolean;
Begin
	i := 1;
    pcAddrInfo := phAddrInfo;
    While (pcAddrInfo <> nil) and (i < AddrNum) do
		begin
        pcAddrInfo := pcAddrInfo^.pNext;
        i := i+1;
        end;
    If (i <> AddrNum) or (pcAddrInfo = nil) then
		ShowErrorDlg('Address Not Found','')
    else			{ Go on your work. }
    begin
    	fer_tip := 5;
    	w.newwin(150,100,400,350,'Edit Address',true);
    	w.newtext(165,150,'Name :');
    	w.newtext(165,180,'HW Address :');
    	w.newtext(165,210,'IP Address :');
    	w.newtext(165,240,'Description :');
    	w.newinput(260,140,380,160,pcAddrInfo^.sName,'n');
    	w.newinput(260,170,380,190,pcAddrInfo^.sHWAddr,'h');
    	w.newinput(260,200,380,220,pcAddrInfo^.sIPAddr,'i');
    	w.newinput(260,230,380,250,pcAddrInfo^.sDesc,'d');
    	w.newbut(180,300,270,320,'~S~ave',1,os2,'');
    	w.newbut(290,300,380,320,'~C~ancel',1,os2,'');
    	repeat
    		w.handleevent;
        	If cm = 2 then
            begin
            IsCorrect := CheckHWAddr(w.get_input(2));
            If IsCorrect = False then	{Show HWAddr. error dialog}
                begin
                ShowErrorDlg('Invalid Hardware Address.',
							 'It must be in form "xx-xx-xx-xx-xx-xx"');
                end
            else
            	begin
            	pcAddrInfo^.sName := w.get_input(1);
            	pcAddrInfo^.sHWAddr := w.get_input(2);
            	pcAddrInfo^.sIPAddr := w.get_input(3);
            	pcAddrInfo^.sDesc := w.get_input(4);
                cm := 1;
            	end;
            end;
        until (cm = 1) or (cm = 3);
    	w.clrwin(1); cm := 0;
    end;
End;

Procedure DelAddr(Var phAddrInfo : AddrPtr; AddrNum : integer);
Var
    pcAddrInfo,pnAddrInfo : AddrPtr;
	i : integer;
Begin
	i := 1;
    pnAddrInfo := phAddrInfo;
    If AddrNum = 1 then
		begin
		phAddrInfo := phAddrInfo^.pNext;
        Dispose(pnAddrInfo);
        end
    else
    begin
    	While (pcAddrInfo <> nil) and (i < AddrNum) do
			begin
        	pcAddrInfo := pnAddrInfo;
        	pnAddrInfo := pnAddrInfo^.pNext;
        	i := i+1;
        	end;
    	If i <> AddrNum then ShowErrorDlg('Address Not Found','')
    	else			{ Go on your work. }
    		begin
        	pcAddrInfo^.pNext := pnAddrInfo^.pNext;
        	Dispose(pnAddrInfo);
    		end;
    end;
End;

Procedure DisplayAddrInfo(phAddrInfo : AddrPtr);
Var
	row : integer;
Begin
    w.chenar1(40,110,530,380,10,false);
    w.fill(40,110,530,380,12,1);
    row := 1;
    While phAddrInfo <> nil do
    begin
    	with phAddrInfo^ do
        begin
        	w.texl(44,100+(20*row),Int2Str(row));
            w.texl(74,100+(20*row),sName);
            w.texl(162,100+(20*row),sHWAddr);
            w.texl(304,100+(20*row),sIPAddr);
            w.texl(426,100+(20*row),sDesc);
        end;
        phAddrInfo := phAddrInfo^.pNext;
        row := row+1;
    end;
End;

Procedure GetAddrFromFile(Var phAddrInfo : AddrPtr);
Var
	pcAddrInfo,pnAddrInfo : AddrPtr; {c urrent ptr., n ext ptr. of AddrInfo}
    No : integer;
Begin
    No := 1;
    New(pnAddrInfo);
    GetProfileString(AddrFile,Int2Str(No),'HWAddress',pnAddrInfo^.sHWAddr,'');
    while pnAddrInfo^.sHWAddr <> '' do
    begin
 		with pnAddrInfo^ do
    	begin
        GetProfileString(AddrFile,Int2Str(No),'Name',sName,'');
        GetProfileString(AddrFile,Int2Str(No),'HWAddress',sHWAddr,'');
        GetProfileString(AddrFile,Int2Str(No),'IPAddress',sIPAddr,'');
        GetProfileString(AddrFile,Int2Str(No),'Description',sDesc,'');
    	end;
        If No = 1 then
			begin
			phAddrInfo := pnAddrInfo;
            pcAddrInfo := pnAddrInfo;
            end
        else
        	begin
            pcAddrInfo^.pNext := pnAddrInfo;
            pcAddrInfo := pnAddrInfo;
            end;
        No := No+1;
        New(pnAddrInfo);
        GetProfileString(AddrFile,Int2Str(No),'HWAddress',
						 pnAddrInfo^.sHWAddr,'');
    end;
    If No <> 1 then pcAddrInfo^.pNext := nil;
    Dispose(pnAddrInfo);
End;

Procedure FlushAddr(phAddrInfo : AddrPtr);
{ This procedure will flush all address to file}
Var
	pcAddrInfo,pnAddrInfo : AddrPtr;
    Num : integer;
Begin
    pnAddrInfo := phAddrInfo;
    Num := 1;

    DisposeINICollection;
    While pnAddrInfo <> nil do
    begin
    pcAddrInfo := pnAddrInfo;
    WriteProfileString(AddrFile,Int2Str(Num),'Name',pnAddrInfo^.sName);
    WriteProfileString(AddrFile,Int2Str(Num),'HWAddress',pnAddrInfo^.sHWAddr);
    WriteProfileString(AddrFile,Int2Str(Num),'IPAddress',pnAddrInfo^.sIPAddr);
    WriteProfileString(AddrFile,Int2Str(Num),'Description',pnAddrInfo^.sDesc);
    pnAddrInfo := pnAddrInfo^.pNext;
    Dispose(pcAddrInfo);
    Num := Num+1;
    end;
    WriteProfileString(AddrFile,'NILL','NILL','NILL');
    DisposeINICollection;
End;

Procedure AddrBook;
Var phAddrInfo : AddrPtr; {h eader p ointer of AddrInfo}
    AddrNum,Code : integer;
Begin
    phAddrInfo := nil;
    {Drawing Window}
    fer_tip := 5;
    w.newwin(30,50,610,430,'Address Book',true);
    w.newchenar(40,90,69,108,0,1,false);
    w.newchenar(70,90,157,108,0,1,false);
    w.newchenar(158,90,299,108,0,1,false);
    w.newchenar(300,90,421,108,0,1,false);
    w.newchenar(422,90,530,108,0,1,false);
    w.newtext(44,99,'No.');
    w.newtext(74,99,'Name');
    w.newtext(162,99,'HW Address');
    w.newtext(304,99,'IP Address');
    w.newtext(426,99,'Description');

    w.newbut(540,110,595,130,'~N~ew',1,os2,'');
    w.newbut(540,135,595,155,'~E~dit',1,os2,'');
    w.newbut(540,160,595,180,'~D~elete',1,os2,'');
    w.newtext(60,395,'Enter Number to Edit/Delete :');
    w.newinput(280,385,300,405,'','n');

    GetAddrFromFile(phAddrInfo);
    {Handle Event}
    repeat
    	DisplayAddrInfo(phAddrInfo);

     	w.handleevent;
        case cm of
        	2 : NewAddr(phAddrInfo,AddrNum);	{New/Edit}
            3 : begin
                Val(w.get_input(1),AddrNum,Code);
                If (Code <> 0) or (AddrNum < 0)
					then ShowErrorDlg('Invalid Number','')
                	else EditAddr(phAddrInfo,AddrNum);
                end;
        	4 : begin                               {Delete}
                Val(w.get_input(1),AddrNum,Code);
                If (Code <> 0) or (AddrNum <0)
					then ShowErrorDlg('Invalid Number','')
                	else DelAddr(phAddrInfo,AddrNum);
                end;
        end;
    until cm = 1;
    w.clrwin(1); cm := 0;
    FlushAddr(phAddrInfo);
End;

Begin
	 Clrscr;
     soundenable := False;
     w.init; _paleta := 4; w.ini_paleta;
     t_color := True;
     memimage := True;
     relief := False;
     nr_expl := 10;
     fer_tip := 0;

     w.newwin(0,0,getmaxx,20,'',false);
     w.newfill(1,456,638,478,10,1);
     w.newchenar(0,455,639,479,10,1,false);
     w.newchenar(2,457,520,476,0,1,true);
     w.newchenar(530,457,637,476,0,1,true);
     w.newbut(12,2,112,18,'~A~ddress Book',4,os2,'');
     w.newbut(582,2,632,18,'~Q~uit',4,os2,'');

     repeat
     	w.handleevent;
		case cm of
        	1 : AddrBook;
        End;
     until cm = 2;
     w.clrwin(1); w.done;
End.
