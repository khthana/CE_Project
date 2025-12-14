unit uLicInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus, Spin, ExtCtrls, Buttons, ActnList,
  SLM_01;

type
  TfrmLicInfo = class(TForm)
    btnOK: TButton;
    pnFeature: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    edFeatureName: TEdit;
    edFDescription: TEdit;
    lbxFActions: TListBox;
    pnApplication: TPanel;
    lbAppName: TLabel;
    lbVersion: TLabel;
    lbBuildNo: TLabel;
    lbDescription: TLabel;
    edAppName: TEdit;
    edVersion: TEdit;
    edDescription: TEdit;
    tvFeatures: TTreeView;
    Label3: TLabel;
    edLicType: TEdit;
    Label5: TLabel;
    edALicType: TEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    edBuildNo: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure tvFeaturesChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    procedure InitFeaturesTView;
    procedure ShowAppPanel(AppInfo: TAppInfo);
    procedure ShowFeaturePanel(Feature: TFeature);
  public
    LicenseConfig: TLicenseConfig;
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmLicInfo.FormActivate(Sender: TObject);
begin
  InitFeaturesTView;
end;

procedure TfrmLicInfo.InitFeaturesTView;
var
  i: Integer;
begin
  with LicenseConfig do
  begin
    tvFeatures.Items.AddChildObject(nil, AppInfo.AppName, @AppInfo);
    for i := 0 to Features.Count - 1 do
    begin
      with tvFeatures do
      begin
        Items.AddChildObject(Items[0], Features[i].Name, Pointer(Features[i]));
      end;
    end;
    tvFeatures.FullExpand;
    tvFeatures.SetFocus;
  end;
end;

procedure TfrmLicInfo.tvFeaturesChange(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.AbsoluteIndex = 0 then
  begin
    ShowAppPanel(PAppInfo(Node.Data)^);
  end
  else begin
    ShowFeaturePanel(TFeature(Node.Data));
  end;
end;

procedure TfrmLicInfo.ShowAppPanel(AppInfo: TAppInfo);
begin
  pnFeature.Visible := False;
  pnApplication.Visible := True;
  with AppInfo do
  begin
    edAppName.Text := AppName;
    edVersion.Text := Version;
    edBuildNo.Text := IntToStr(BuildNo);
    edDescription.Text := Description;
    if LicenseType = ltPermanent then
      edALicType.Text := 'Permanemt Use'
    else
      if LicenseType = ltDisable then
        edALicType.Text := 'Disable Use'
      else begin
        edALicType.Text := 'Expire on ' + DateToStr(ExpiredDate);
      end;
  end;
end;

procedure TfrmLicInfo.ShowFeaturePanel(Feature: TFeature);
var
  i: Integer;
begin
  pnApplication.Visible := False;
  pnFeature.Visible := True;
  with Feature do
  begin
    edFeatureName.Text := Name;
    edFDescription.Text := Description;
    if LicenseType = ltPermanent then
      edLicType.Text := 'Permanent Use'
    else
      if LicenseType = ltDisable then
        edLicType.Text := 'Disable Use'
      else begin
        edLicType.Text := 'Expire on ' + DateToStr(ExpiredDate);
      end;
    lbxFActions.Clear;
    if ActionList <> nil then
      for i := 0 to ActionList.Count - 1 do
        lbxFActions.Items.AddObject((ActionList.Objects[i] as TAction).Name, ActionList.Objects[i]);
  end;
end;

end.
