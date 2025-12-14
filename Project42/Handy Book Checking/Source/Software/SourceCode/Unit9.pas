unit Unit9;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Dialogs, ComCtrls;

type
  TForm9 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    ProgressBar1: TProgressBar;
    OpenDialog1: TOpenDialog;
    ListBox1: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

var
  Form9: TForm9;
  Fname : string ;
  l,ki : integer ;

implementation

uses Unit1,Main;

{$R *.DFM}



procedure TForm9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     main.Func3 := False ;
     action := cafree ;
end;

procedure TForm9.Button3Click(Sender: TObject);
var Pname ,STMP: string ;
    i,j : integer ;
begin
     Pname := '' ;
     Fname := '' ;
     j := 0 ;
     if opendialog1.Execute then
     begin
        STMP := Opendialog1.FileName  ;
        if not (STMP = null) then
        begin
             for i := length(STMP) downto 1 do
             begin
                  if STMP[i] <> '\' then
                  begin
                       if j = 1 then
                          Pname := STMP[i] + Pname
                       else
                           Fname := STMP[i] + Fname ;
                  end
                  else
                  begin
                       if j = 1 then
                          Pname := STMP[i] + Pname ;
                          j := 1 ;
                       end;
                  end;
             end;
             if Fname <> '' then
             begin
             datamodule1.Database2.Close ;
             datamodule1.Table2.Active := false ;
             datamodule1.Database2.Params.Text := 'PATH='+ Pname;
             datamodule1.Table2.TableName := Fname ;
             datamodule1.Database2.Open ;
             datamodule1.Table2.Active := true ;
             edit1.Text := STMP ;
             button1.Enabled := true ;

        end ;
    end;

end;

procedure TForm9.Button1Click(Sender: TObject);
var
   Temp : variant ;
   T1,T2,tmp,GroupTmp,CallTmp,NameTmp : string ;
   i,j : integer ;
begin
      l := 0 ;
     T2 := '' ;
     datamodule1.table1.Open ;
     datamodule1.table2.First;
     ProgressBar1.Max := datamodule1.table2.RecordCount ;
     ProgressBar1.Min := 0 ;
     ProgressBar1.Position := 0 ;
     while not datamodule1.table2.EOF do
     begin
          datamodule1.table1.IndexFieldNames := 'BKCODE' ;
          datamodule1.table1.FindKey([datamodule1.table2.fieldbyname('BKCODE').asstring]) ;
          if not {(}(datamodule1.table1.fieldbyname('BKCODE').asstring = datamodule1.table2.fieldbyname('BKCODE').asstring) {and (datamodule1.table1.fieldbyname('BKNAME').asstring = datamodule1.table2.fieldbyname('BKNAME').asstring))} then
          begin
          Temp := datamodule1.table2.FieldValues['BKCALL'] ;
          if Temp <> null then
          begin
          T1 := Temp;
          for i := 1 to length(T1) do
          begin
               if T1[i] <> ' ' then
               begin
                    T2 := T2 + T1[i] ;
               end ;
          end ;

          T1 := datamodule1.table2.FieldValues['BKCODE'] ;
          if T1[1] = 'E' then
          begin
               CallTmp := T2 ;
               NameTmp := datamodule1.table2.FieldValues['BKNAME'] ;
               GroupTmp := datamodule1.table2.FieldValues['BKGROUP']
          end
          else
          begin


          j := 0 ;
          while j < 3 do
          begin
               if (j = 0) then
               begin
                  tmp := T2 ;
               end;
               if (j = 1) and not (datamodule1.table2.FieldValues['BKGROUP'] = null) then
               begin
                  tmp := datamodule1.table2.FieldValues['BKGROUP'] ;
               end;
               if (j = 2) {and not (datamodule1.table2.FieldValues['BKNAME'] = null)} then
               begin
                    if datamodule1.table2.FieldValues['BKNAME'] = null then
                       tmp := 'NONAME'
                    else
                        tmp := datamodule1.table2.FieldValues['BKNAME'] ;
               end;

     for i := 0 to length(tmp) do
     begin
          case tmp[i] of
#128 : tmp[i] := char(149) ;
          #129 : tmp[i] := char(151) ;
          #130 : tmp[i] := char(155) ;
          #131 : tmp[i] := char(157) ;
          #132 : tmp[i] := char(159) ;
          #133 : tmp[i] := char(158) ;
          #134 : tmp[i] := char(152) ;
          #135 : tmp[i] := char(154) ;
          #136 : tmp[i] := char(156) ;
          #137 : tmp[i] := char(150) ;
#138 : tmp[i] := char(153) ;
          #139 : tmp[i] := char(250) ;
          #140 : tmp[i] := char(251) ;
          #141 : tmp[i] := char(238) ;
          #142 : tmp[i] := char(239) ;
          #143 : tmp[i] := char(223) ;
          #144 : tmp[i] := char(240) ;
          #145 : tmp[i] := char(241) ;
          #146 : tmp[i] := char(242) ;
          #147 : tmp[i] := char(243) ;
#148 : tmp[i] := char(244) ;
          #149 : tmp[i] := char(245) ;
          #150 : tmp[i] := char(246) ;
          #151 : tmp[i] := char(247) ;
          #152 : tmp[i] := char(248) ;
          #153 : tmp[i] := char(249) ;
          #154 : tmp[i] := char(163) ;
          #155 : tmp[i] := char(165) ;
          #156 : tmp[i] := char(220) ;
          #157 : tmp[i] := char(221) ;
#158 : tmp[i] := char(222) ;
          #159 : tmp[i] := char(219) ;
          #160 : tmp[i] := char(160) ;
          #161 : tmp[i] := char(161) ;
          #162 : tmp[i] := char(162) ;
          #163 : tmp[i] := char(164) ;
          #164 : tmp[i] := char(166) ;
          #165 : tmp[i] := char(167) ;
          #166 : tmp[i] := char(168) ;
          #167 : tmp[i] := char(169) ;
#168 : tmp[i] := char(170) ;
          #169 : tmp[i] := char(171) ;
          #170 : tmp[i] := char(172) ;
          #171 : tmp[i] := char(173) ;
          #172 : tmp[i] := char(174) ;
          #173 : tmp[i] := char(175) ;
          #174 : tmp[i] := char(176) ;
          #175 : tmp[i] := char(177) ;
          #176 : tmp[i] := char(178) ;
          #177 : tmp[i] := char(179) ;
#178 : tmp[i] := char(180) ;
          #179 : tmp[i] := char(181) ;
          #180 : tmp[i] := char(182) ;
          #181 : tmp[i] := char(183) ;
          #182 : tmp[i] := char(184) ;
          #183 : tmp[i] := char(185) ;
          #184 : tmp[i] := char(186) ;
          #185 : tmp[i] := char(187) ;
          #186 : tmp[i] := char(188) ;
          #187 : tmp[i] := char(189) ;
#188 : tmp[i] := char(190) ;
          #189 : tmp[i] := char(191) ;
          #190 : tmp[i] := char(192) ;
          #191 : tmp[i] := char(193) ;
          #192 : tmp[i] := char(194) ;
          #193 : tmp[i] := char(195) ;
          #194 : tmp[i] := char(196) ;
          #195 : tmp[i] := char(197) ;
          #196 : tmp[i] := char(199) ;
          #197 : tmp[i] := char(200) ;
#198 : tmp[i] := char(201) ;
          #199 : tmp[i] := char(202) ;
          #200 : tmp[i] := char(203) ;
          #201 : tmp[i] := char(204) ;
          #202 : tmp[i] := char(205) ;
          #203 : tmp[i] := char(206) ;
          #204 : tmp[i] := char(208) ;
          #205 : tmp[i] := char(198) ;
          #206 : tmp[i] := char(210) ;
          #207 : tmp[i] := char(211) ;
#208 : tmp[i] := char(224) ;
          #209 : tmp[i] := char(225) ;
          #210 : tmp[i] := char(226) ;
          #211 : tmp[i] := char(227) ;
          #212 : tmp[i] := char(228) ;
          #213 : tmp[i] := char(230) ;
          #214 : tmp[i] := char(207) ;
          #215 : tmp[i] := char(216) ;
          #216 : tmp[i] := char(217) ;
          #217 : tmp[i] := char(212) ;
#218 : tmp[i] := char(213) ;
          #219 : tmp[i] := char(214) ;
          #220 : tmp[i] := char(215) ;
          #221 : tmp[i] := char(209) ;
          #222 : tmp[i] := char(237) ;
          #223 : tmp[i] := char(231) ;
          #224 : tmp[i] := char(232) ;
          #225 : tmp[i] := char(233) ;
          #226 : tmp[i] := char(234) ;
          #227 : tmp[i] := char(235) ;
#228 : tmp[i] := char(236) ;
          #229 : tmp[i] := char(218) ;
          #230 : tmp[i] := char(252) ;
          #231 : tmp[i] := char(253) ;
          #232 : tmp[i] := char(254) ;
          #233 : tmp[i] := char(255) ;
          #234 : tmp[i] := char(128) ;
          #235 : tmp[i] := char(129) ;
          #236 : tmp[i] := char(130) ;
          #237 : tmp[i] := char(131) ;
#238 : tmp[i] := char(132) ;
          #239 : tmp[i] := char(133) ;
          #240 : tmp[i] := char(134) ;
          #241 : tmp[i] := char(135) ;
          #242 : tmp[i] := char(136) ;
          #243 : tmp[i] := char(137) ;
          #244 : tmp[i] := char(138) ;
          #245 : tmp[i] := char(139) ;
          #246 : tmp[i] := char(140) ;
          #247 : tmp[i] := char(141) ;
#248 : tmp[i] := char(142) ;
          #249 : tmp[i] := char(143) ;
          #250 : tmp[i] := char(144) ;
          #251 : tmp[i] := char(145) ;
          #252 : tmp[i] := char(146) ;
          #253 : tmp[i] := char(147) ;
          #254 : tmp[i] := char(148) ;
          #255 : tmp[i] := char(255) ;


          end;{case}
     end;{for}
           if j = 0 then
           begin
                CallTmp := tmp ;
                j := 1 ;
           end
           else
           if j = 1 then
           begin
                GroupTmp := tmp ;
                j := 2 ;
           end
           else
           if j = 2 then
           begin
                NameTmp := tmp ;
                j := 3 ;
           end;

     End;{while}


     End; {if T1[0] = 'E'}


//               datamodule1.Database1.TransIsolation := tiDirtyRead ;
//               datamodule1.Database1.StartTransaction ;
//               Try

                  datamodule1.table1.Append ;
                  datamodule1.table1.FieldValues['BKCALL'] := CallTmp ;
                  datamodule1.table1.FieldValues['BKCODE'] := datamodule1.table2.FieldValues['BKCODE'] ;
                  datamodule1.table1.FieldValues['BKNAME'] := NameTmp ;
                  datamodule1.table1.FieldValues['YEAR_LOST'] := 0 ;
                  datamodule1.table1.FieldValues['STATUS'] := 0 ;
                  datamodule1.table1.FieldValues['BKGROUP'] := GroupTmp ;
                  datamodule1.table1.Post ;

//               datamodule1.Database1.Commit ;
//               Except
//                     datamodule1.Database1.Rollback ;
//               end;
//               listbox1.Items.Add(datamodule1.table1.FieldValues['BKCODE']) ;
               inc(l) ;
          end;
          end;
          datamodule1.table2.Next;
          T2 := '' ;
          ProgressBar1.Position := ProgressBar1.Position + 1 ;
     end;
     datamodule1.table1.Close ;
     datamodule1.table2.Close ;
     datamodule1.Query1.Open ;
     ProgressBar1.Position := 0 ;
     button1.Enabled := false ;
     listbox1.Items.Add('จำนวนข้อมูลที่เพิ่มเติม : '+inttostr(l)) ;

end;

procedure TForm9.Button2Click(Sender: TObject);
begin
     close ;
end;

end.
