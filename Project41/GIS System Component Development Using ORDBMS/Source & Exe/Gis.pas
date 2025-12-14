unit Gis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, ExtCtrls, StdCtrls, Menus;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    OracleSession1: TOracleSession;
    OracleQuery1: TOracleQuery;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Menu1: TPopupMenu;
    m_length: TMenuItem;
    N2: TMenuItem;
    m_w: TMenuItem;
    N1: TMenuItem;
    m_id: TMenuItem;
    N3: TMenuItem;
    m_n: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure WindowClose(Sender: TObject; var Action: TCloseAction);
    procedure MouseClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Showroads(Sender: TObject);
    procedure Showrivers(Sender: TObject);
    procedure FormPaint(Sender: TObject);



  private

    { Private declarations }
    BitMap: TBitMap;
    St1,St2,St3,St4 : String;

    procedure WMEraseBkgnd(var m : TWMEraseBkgnd);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure TForm1.FormCreate(Sender: TObject);
var point1,point2 :TPoint;


begin
     Bitmap:= TBitMap.Create;
     Bitmap.LoadFromFile('bor6.bmp');
     St1 := 'เขต ';
     St2 := 'จำนวนประชากร ';
     St3 := 'พื้นที่ ';

     with OracleSession1 do
          try
             Logon;
          Except
             on E:EOracleError do ShowMessage(E.Message);
          end;
     with OracleQuery1 do
          try
              clear;
              SQL.add('select sdo_x1,sdo_y1,sdo_x2,sdo_y2 from citys_sdogeom');
              Execute;
              while not eof do begin
                 point1 := point(180+FieldAsInteger(0),180-FieldAsInteger(1));
                 point2 := point(180+FieldAsInteger(2),180-FieldAsInteger(3));
                 Image1.Canvas.Polyline([point1,point2]);
                 next;
              end;
          except
              on E:EOracleError do ShowMessage(E.Message);
          end;
          Image1.Canvas.Brush.Color := clOlive;
          Image1.Canvas.FloodFill(5,5,clBlack,fsBorder);
          Image1.Canvas.Brush.Color := clTeal;
          Image1.Canvas.FloodFill(350,5,clBlack,fsBorder);
          Image1.Canvas.Brush.Color := clMaroon;
          Image1.Canvas.FloodFill(5,350,clBlack,fsBorder);
          Image1.Canvas.Brush.Color := clPurple;
          Image1.Canvas.FloodFill(350,350,clBlack,fsBorder);
          Showrivers(Sender);
          Showroads(Sender);
end;


procedure TForm1.WindowClose(Sender: TObject; var Action: TCloseAction);
begin
     Bitmap.free;
     OracleQuery1.Close;
     OracleSession1.Logoff;
end;

procedure TForm1.MouseClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var id,people,area,sp : integer;
    st,sti : string;

begin
     with OracleQuery1 do
          try
              clear;
              DeclareVariable('X',otInteger);
              DeclareVariable('Y',otInteger);
              DeclareVariable('ID',otInteger);
              DeclareVariable('NAME',otString);
              DeclareVariable('CPEOPLE',otInteger);
              DeclareVariable('CAREA',otInteger);
              DeclareVariable('TYPE',otString);
              DeclareVariable('DEPTH',otInteger);
              DeclareVariable('SP',otInteger);

              SQL.add('declare');
              SQL.add('gm citys_geometry;');
              SQL.add('rd roads_geometry;');
              SQL.add('rv rivers_geometry;');
              SQL.add('found number;');
              SQL.add('begin');
              SQL.add('rd.getinfo(found,:X,:Y,:ID,:NAME,:CPEOPLE,:CAREA,:TYPE);');
              SQL.Add(':SP := 1;');
              SQL.add('if found = 0 then');
              SQL.add('rv.getinfo(found,:X,:Y,:ID,:NAME,:CPEOPLE,:CAREA,:DEPTH);');
              SQL.Add(':SP := 2;');
              SQL.add('if found = 0 then');
              SQL.add('gm.getinfo(found,:X,:Y,:ID,:NAME,:CPEOPLE,:CAREA);');
              SQL.Add(':SP := 3;');
              SQL.add('end if;');  
              SQL.add('end if;');
              SQL.add('end;');
              SetVariable('X',X-180);
              SetVariable('Y',180-Y);
              Execute;
              id := GetVariable('ID');
              sti := GetVariable('NAME');
              people := GetVariable('CPEOPLE');
              area := GetVariable('CAREA');
              sp := GetVariable('SP');
              if sp = 1 then begin
                 st1 := 'ถนน ';
                 st2 := 'ระยะทาง ';
                 st3 := 'กว้าง ';
              end
              else if sp = 2 then begin
                 st1 := 'แม่น้ำ ';
                 st2 := 'ระยะทาง ';
                 st3 := 'กว้าง ';
              end
              else begin
                 st1 := 'เขต ';
                 st2 := 'ประชากร ';
                 st3 := 'พื้นที่ ';
              end;
              str(id,st);
              Menu1.Items[0].Caption := 'รหัส '+st;
              Menu1.Items[2].Caption := St1+sti;
              str(people,st);
              Menu1.Items[4].Caption := St2+st;
              str(area,st);
              Menu1.Items[6].Caption := St3+st;
              Menu1.Popup(232+X,88+Y);
          except
              on E:EOracleError do ShowMessage(E.Message);
          end;

end;

procedure TForm1.Showroads(Sender: TObject);
var point1,point2 :TPoint;
begin
      Label1.Enabled := false;
      with OracleQuery1 do
          try
              clear;
              SQL.add('select sdo_x1,sdo_y1,sdo_x2,sdo_y2 from roads_sdogeom');
              Execute;
              while not eof do begin
                 point1 := point(180+FieldAsInteger(0),180-FieldAsInteger(1));
                 point2 := point(180+FieldAsInteger(2),180-FieldAsInteger(3));
                 Image1.Canvas.Polyline([point1,point2]);
                 next;
              end;
          except
              on E:EOracleError do ShowMessage(E.Message);
          end;
          Image1.Canvas.Brush.Color := clBlack;
          Image1.Canvas.FloodFill(188,7,clBlack,fsBorder);
          Image1.Canvas.FloodFill(123,97,clBlack,fsBorder);
          Image1.Canvas.FloodFill(107,189,clBlack,fsBorder);
          Image1.Canvas.FloodFill(60,216,clBlack,fsBorder);
          Image1.Canvas.FloodFill(10,245,clBlack,fsBorder);
          Image1.Canvas.FloodFill(305,116,clBlack,fsBorder);
          Image1.Canvas.FloodFill(273,187,clBlack,fsBorder);
          Image1.Canvas.FloodFill(262,225,clBlack,fsBorder);
          Image1.Canvas.FloodFill(275,248,clBlack,fsBorder);
          Image1.Canvas.FloodFill(309,309,clBlack,fsBorder);
          Image1.Canvas.FloodFill(321,282,clBlack,fsBorder);
          Image1.Canvas.FloodFill(296,287,clBlack,fsBorder);
          Image1.Canvas.FloodFill(273,187,clBlack,fsBorder);
          Image1.Canvas.FloodFill(265,292,clBlack,fsBorder);
          Image1.Canvas.FloodFill(223,300,clBlack,fsBorder);
          Image1.Canvas.FloodFill(208,302,clBlack,fsBorder);
          Image1.Canvas.FloodFill(199,304,clBlack,fsBorder);
          Image1.Canvas.FloodFill(188,307,clBlack,fsBorder);
          Image1.Canvas.FloodFill(178,308,clBlack,fsBorder);
          Image1.Canvas.FloodFill(72,327,clBlack,fsBorder);
          Image1.Canvas.FloodFill(22,337,clBlack,fsBorder);
          Image1.Canvas.FloodFill(21,348,clBlack,fsBorder);
          Image1.Canvas.FloodFill(22,251,clBlack,fsBorder);
          Image1.Canvas.FloodFill(22,291,clBlack,fsBorder);
          Image1.Canvas.FloodFill(22,293,clBlack,fsBorder);
          Image1.Canvas.FloodFill(23,238,clBlack,fsBorder);
          Image1.Canvas.FloodFill(22,178,clBlack,fsBorder);
          Image1.Canvas.FloodFill(218,301,clBlack,fsBorder);
end;

procedure TForm1.Showrivers(Sender: TObject);
var point1,point2 :TPoint;
begin
      Label2.Enabled := false;
      with OracleQuery1 do
          try
              clear;
              SQL.add('select sdo_x1,sdo_y1,sdo_x2,sdo_y2 from rivers_sdogeom');
              Execute;
              while not eof do begin
                 point1 := point(180+FieldAsInteger(0),180-FieldAsInteger(1));
                 point2 := point(180+FieldAsInteger(2),180-FieldAsInteger(3));
                 Image1.Canvas.Polyline([point1,point2]);
                 next;
              end;
          except
              on E:EOracleError do ShowMessage(E.Message);
          end;
          Image1.Canvas.Brush.Color := clAqua;
          Image1.Canvas.FloodFill(31,1,clBlack,fsBorder);
          Image1.Canvas.FloodFill(150,278,clBlack,fsBorder);
          Image1.Canvas.FloodFill(203,285,clBlack,fsBorder);
          Image1.Canvas.FloodFill(212,177,clBlack,fsBorder);
          Image1.Canvas.FloodFill(243,66,clBlack,fsBorder);
          Image1.Canvas.FloodFill(292,26,clBlack,fsBorder);
          Image1.Canvas.FloodFill(214,307,clBlack,fsBorder);
          Image1.Canvas.FloodFill(254,240,clBlack,fsBorder);
          Image1.Canvas.FloodFill(313,169,clBlack,fsBorder);
          Image1.Canvas.FloodFill(200,349,clBlack,fsBorder);
          Image1.Canvas.FloodFill(355,147,clBlack,fsBorder);
   {       Image1.Canvas.FloodFill(197,332,clBlack,fsBorder);
          Image1.Canvas.FloodFill(204,330,clBlack,fsBorder); }
end;

procedure TForm1.WMEraseBkgnd(var m : TWMEraseBkgnd);
begin
  m.Result := LRESULT(False);
end;

procedure TForm1.FormPaint(Sender: TObject);
var
  x, y: Integer;
begin
  y := 0;
  while y < Height do
  begin
    x := 0;
    while x < Width do
    begin
      Canvas.Draw(x, y, Bitmap);
      x := x + Bitmap.Width;
    end;
    y := y + Bitmap.Height;
  end;
end;


end.
