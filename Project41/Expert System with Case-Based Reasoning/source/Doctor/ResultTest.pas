unit ResultTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TResultTestForm = class(TForm)
    ResultBox: TListBox;
    CloseButton: TButton;
    Check: TListBox;
    procedure CloseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ResultTestForm: TResultTestForm;

implementation

uses AttrEnter;

{$R *.DFM}

procedure TResultTestForm.CloseButtonClick(Sender: TObject);
begin
     ResultTestForm.close;
     AttrEnterForm.show;
end;

end.
