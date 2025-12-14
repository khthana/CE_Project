unit uLicRequest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus, Spin, ExtCtrls, Buttons, ActnList,
  SLM_01;

type
  TfrmLicRequest = class(TForm)
    btnOK: TButton;
    sdlgLicRequest: TSaveDialog;
    btnSaveLRQ: TButton;
    pnFeature: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    edFeatureName: TEdit;
    edFDescription: TEdit;
    gbLicTypes: TGroupBox;
    rbtnPermanent: TRadioButton;
    rbtnExpired: TRadioButton;
    dtpkExpired: TDateTimePicker;
    rbtnDisable: TRadioButton;
    lbxFActions: TListBox;
    pnApplication: TPanel;
    lbAppName: TLabel;
    lbVersion: TLabel;
    lbBuildNo: TLabel;
    lbDescription: TLabel;
    edAppName: TEdit;
    edVersion: TEdit;
    edDescription: TEdit;
    gbALicType: TGroupBox;
    rbtnAPermanent: TRadioButton;
    rbtnAExpired: TRadioButton;
    dtpkAExpired: TDateTimePicker;
    rbtnADisable: TRadioButton;
    tvFeatures: TTreeView;
    edBuildNo: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure tvFeaturesChange(Sender: TObject; Node: TTreeNode);
    procedure rbtnExpiredClick(Sender: TObject);
    procedure rbtnPermanentClick(Sender: TObject);
    procedure dtpkExpiredChange(Sender: TObject);
    procedure rbtnDisableClick(Sender: TObject);
    procedure rbtnAPermanentClick(Sender: TObject);
    procedure rbtnAExpiredClick(Sender: TObject);
    procedure dtpkAExpiredChange(Sender: TObject);
    procedure btnSaveLRQClick(Sender: TObject);
    procedure rbtnADisableClick(Sender: TObject);
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

procedure TfrmLicRequest.FormActivate(Sender: TObject);
begin
  InitFeaturesTView;
end;

procedure TfrmLicRequest.InitFeaturesTView;
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

procedure TfrmLicRequest.tvFeaturesChange(Sender: TObject;
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

procedure TfrmLicRequest.rbtnExpiredClick(Sender: TObject);
begin
  dtpkExpired.Visible := True;
  with TFeature(tvFeatures.Selected.Data) do
  begin
    dtpkExpired.Date := ExpiredDate;
    LicenseType := ltExpired;
  end;
end;

procedure TfrmLicRequest.rbtnPermanentClick(Sender: TObject);
begin
  dtpkExpired.Visible := False;
  with TFeature(tvFeatures.Selected.Data) do
  begin
    LicenseType := ltPermanent
  end;
end;

procedure TfrmLicRequest.dtpkExpiredChange(Sender: TObject);
begin
  with TFeature(tvFeatures.Selected.Data) do
  begin
    ExpiredDate := dtpkExpired.Date;
  end;
end;

procedure TfrmLicRequest.rbtnDisableClick(Sender: TObject);
begin
  dtpkExpired.Visible := False;
  with TFeature(tvFeatures.Selected.Data) do
  begin
    LicenseType := ltDisable;
  end;
end;

procedure TfrmLicRequest.rbtnAPermanentClick(Sender: TObject);
begin
  dtpkAExpired.Visible := False;
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    LicenseType := ltPermanent
  end;
end;

procedure TfrmLicRequest.rbtnAExpiredClick(Sender: TObject);
begin
  dtpkAExpired.Visible := True;
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    dtpkAExpired.Date := ExpiredDate;
    LicenseType := ltExpired;
  end;
end;

procedure TfrmLicRequest.dtpkAExpiredChange(Sender: TObject);
begin
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    ExpiredDate := dtpkAExpired.Date;
  end;
end;

procedure TfrmLicRequest.btnSaveLRQClick(Sender: TObject);
begin
  if sdlgLicRequest.Execute then
  begin
    LicenseConfig.SaveLicRequest(sdlgLicRequest.FileName);
    ShowMessage('Send license request file to vendor.');
  end;
end;

procedure TfrmLicRequest.rbtnADisableClick(Sender: TObject);
begin
  dtpkAExpired.Visible := False;
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    LicenseType := ltDisable;
  end;
end;

procedure TfrmLicRequest.ShowAppPanel(AppInfo: TAppInfo);
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
      rbtnAPermanent.Checked := True
    else
      if LicenseType = ltDisable then
        rbtnADisable.Checked := True
      else begin
        rbtnAExpired.Checked := True;
        dtpkAExpired.Date := ExpiredDate;
      end;
  end;
end;

procedure TfrmLicRequest.ShowFeaturePanel(Feature: TFeature);
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
      rbtnPermanent.Checked := True
    else
      if LicenseType = ltDisable then
        rbtnDisable.Checked := True
      else begin
        rbtnExpired.Checked := True;
        dtpkExpired.Date := ExpiredDate;
      end;
    lbxFActions.Clear;
    if ActionList <> nil then
      for i := 0 to ActionList.Count - 1 do
        lbxFActions.Items.AddObject((ActionList.Objects[i] as TAction).Name, ActionList.Objects[i]);
  end;
end;

end.
