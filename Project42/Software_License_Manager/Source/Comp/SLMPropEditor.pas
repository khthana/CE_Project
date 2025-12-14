unit SLMPropEditor;

interface

uses Dialogs, Dsgnintf;

type
  TFileNameProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

implementation

{ TFileNameProperty }

procedure TFileNameProperty.Edit;
var
  OpenDialog: TOpenDialog;
begin
  OpenDialog := TOpenDialog.Create(nil);
  try
    OpenDialog.Filter := 'License File (*.lic)|*.lic|All Files (*.*)|*.*';
    OpenDialog.FileName := GetStrValue;
    if OpenDialog.Execute then
      SetStrValue(OpenDialog.FileName);
  finally
    OpenDialog.Free;
  end;
end;

function TFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

function TFileNameProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

procedure TFileNameProperty.SetValue(const Value: string);
begin
  SetStrValue(Value);
end;

end.
