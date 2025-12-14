unit monitorfrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,Board2,Ga1 ;

type
  TForm4 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    Procedure FormDisPlay(var Pop : TPopulation) ;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.DFM}

Procedure TForm4.FormDisPlay(var Pop : TPopulation) ;
var Chrom1 : ChromType ;
    WeightString1,WeightString2 : String ;
    Weight       : WeightObj ;
begin
     Top  := Form1.Top ;
     Left := Form1.Left+Form1.Width+5 ;
     visible := true ;

     //Memo1.Clear ;
     Memo1.Lines.Add('Generation : '+IntToStr(Pop.Generation)) ;
     Memo1.Lines.Add('Chrom NO.  : '+IntToStr(Pop.CurPop)) ;
     Pop.GetChrom(Pop.CurPop,Chrom1) ;
    // Memo1.Lines.Add(Chrom1) ;
     ChromToWeight(Chrom1,Weight) ;
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
     Memo1.Lines.Add('Weight : '+WeightString1+' '+WeightString2) ;

     Memo2.Clear ;
     Memo2.Lines.Add('Pop size : '+IntToStr(Pop.PopSize))  ;
     Memo2.Lines.Add('PCross   : '+FloatToStr(Pop.PCross)) ;
     Memo2.Lines.Add('PMute    : '+FloatToStr(Pop.PMute))  ;

     case Pop.CrossType of
          OnePoint : Memo2.Lines.Add('Cross type : '+'One point') ;
          TwoPoint : Memo2.Lines.Add('Cross type : '+'Two point') ;
     end ;
end ;

procedure TForm4.FormCreate(Sender: TObject);
begin
     Memo1.Clear ;
end;

end.
