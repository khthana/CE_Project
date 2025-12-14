unit uLicConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DsgnIntf, ComCtrls, Menus, Spin, ExtCtrls, Buttons, ActnList,
  SLM_01;

type
  TfrmLCfgEditor = class(TForm)
    btnOK: TButton;
    btnSaveTemplate: TButton;
    sdlgTemplate: TSaveDialog;
    pnFeature: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    sbtnAdd: TSpeedButton;
    sbtnAddAll: TSpeedButton;
    sbtnRem: TSpeedButton;
    sbtnRemAll: TSpeedButton;
    edFeatureName: TEdit;
    edFDescription: TEdit;
    lbxActions: TListBox;
    lbxFActions: TListBox;
    tvFeatures: TTreeView;
    pnApplication: TPanel;
    lbAppName: TLabel;
    lbVersion: TLabel;
    lbBuildNo: TLabel;
    lbDescription: TLabel;
    edAppName: TEdit;
    edVersion: TEdit;
    speBuildNo: TSpinEdit;
    edDescription: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure tvFeaturesChange(Sender: TObject; Node: TTreeNode);
    procedure edFeatureNameChange(Sender: TObject);
    procedure edFDescriptionChange(Sender: TObject);
    procedure edAppNameChange(Sender: TObject);
    procedure edVersionChange(Sender: TObject);
    procedure speBuildNoChange(Sender: TObject);
    procedure edDescriptionChange(Sender: TObject);
    procedure btnSaveTemplateClick(Sender: TObject);
    procedure cbMACClick(Sender: TObject);
    procedure cbIDEClick(Sender: TObject);
    procedure cbLogDiskClick(Sender: TObject);
    procedure cbPSNClick(Sender: TObject);
    procedure sbtnAddClick(Sender: TObject);
    procedure sbtnRemClick(Sender: TObject);
    procedure sbtnAddAllClick(Sender: TObject);
    procedure sbtnRemAllClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitFeaturesTView;
    procedure InitAvailableActions;
    procedure ShowAppPanel(AppInfo: TAppInfo);
    procedure ShowFeaturePanel(Feature: TFeature);
    procedure MoveListBoxItems(Source, Dest: TListBox; All: Boolean);
    procedure UpdateFeatureActs(AddFlag: Boolean; Action: TAction);
  public
    LicenseConfig: TLicenseConfig;
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmLCfgEditor.FormActivate(Sender: TObject);
begin
  InitFeaturesTView;
  InitAvailableActions;
end;

procedure TfrmLCfgEditor.InitFeaturesTView;
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

procedure TfrmLCfgEditor.tvFeaturesChange(Sender: TObject;
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

procedure TfrmLCfgEditor.edFeatureNameChange(Sender: TObject);
begin
  tvFeatures.Selected.Text := edFeatureName.Text;
  with TFeature(tvFeatures.Selected.Data) do
  begin
    Name := edFeatureName.Text;
  end;
end;

procedure TfrmLCfgEditor.edFDescriptionChange(Sender: TObject);
begin
  with TFeature(tvFeatures.Selected.Data) do
  begin
    Description := edFDescription.Text;
  end;
end;

procedure TfrmLCfgEditor.edAppNameChange(Sender: TObject);
begin
  tvFeatures.Selected.Text := edAppName.Text;
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    AppName := edAppName.Text;
  end;
end;

procedure TfrmLCfgEditor.edVersionChange(Sender: TObject);
begin
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    Version := edVersion.Text;
  end;
end;

procedure TfrmLCfgEditor.speBuildNoChange(Sender: TObject);
begin
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    BuildNo := speBuildNo.Value;
  end;
end;

procedure TfrmLCfgEditor.edDescriptionChange(Sender: TObject);
begin
  with PAppInfo(tvFeatures.Selected.Data)^ do
  begin
    Description := edDescription.Text;
  end;
end;

procedure TfrmLCfgEditor.btnSaveTemplateClick(Sender: TObject);
begin
  if sdlgTemplate.Execute then
  begin
    LicenseConfig.SaveLicTemplate(sdlgTemplate.FileName);
  end;
end;

procedure TfrmLCfgEditor.cbMACClick(Sender: TObject);
begin
end;

procedure TfrmLCfgEditor.cbIDEClick(Sender: TObject);
begin
end;

procedure TfrmLCfgEditor.cbLogDiskClick(Sender: TObject);
begin
end;

procedure TfrmLCfgEditor.cbPSNClick(Sender: TObject);
begin
end;

procedure TfrmLCfgEditor.sbtnAddClick(Sender: TObject);
begin
  MoveListBoxItems(lbxActions, lbxFActions, False);
end;

procedure TfrmLCfgEditor.MoveListBoxItems(Source, Dest: TListBox; All: Boolean);
var
  i: Integer;
begin
  for i := 0 to Source.Items.Count - 1 do
    if Source.Selected[i] or All then
    begin
      Dest.Items.AddObject(Source.Items[i], Source.Items.Objects[i]);
      UpdateFeatureActs(Source = lbxActions, Source.Items.Objects[i] as TAction);
    end;

  for i := Source.Items.Count - 1 downto 0 do
    if Source.Selected[i] or All then
      Source.Items.Delete(i);
end;

procedure TfrmLCfgEditor.sbtnRemClick(Sender: TObject);
begin
  MoveListBoxItems(lbxFActions, lbxActions, False);
end;

procedure TfrmLCfgEditor.sbtnAddAllClick(Sender: TObject);
begin
  MoveListBoxItems(lbxActions, lbxFActions, True);
end;

procedure TfrmLCfgEditor.sbtnRemAllClick(Sender: TObject);
begin
  MoveListBoxItems(lbxFActions, lbxActions, True);
end;

procedure TfrmLCfgEditor.ShowAppPanel(AppInfo: TAppInfo);
begin
  pnFeature.Visible := False;
  pnApplication.Visible := True;
  with AppInfo do
  begin
    edAppName.Text := AppName;
    edVersion.Text := Version;
    speBuildNo.Value := BuildNo;
    edDescription.Text := Description;
  end;
end;

procedure TfrmLCfgEditor.ShowFeaturePanel(Feature: TFeature);
var
  i: Integer;
begin
  pnApplication.Visible := False;
  pnFeature.Visible := True;
  with Feature do
  begin
    edFeatureName.Text := Name;
    edFDescription.Text := Description;
    lbxFActions.Clear;
    if ActionList <> nil then
      for i := 0 to ActionList.Count - 1 do
        lbxFActions.Items.AddObject((ActionList.Objects[i] as TAction).Name, ActionList.Objects[i]);
  end;
end;

procedure TfrmLCfgEditor.InitAvailableActions;
var
 i, j, k: Integer;
 Used: Boolean;
begin
  if LicenseConfig.ActionList = nil then Exit;

  with LicenseConfig do
    for i := 0 to ActionList.ActionCount - 1 do
    begin
      Used := False;
      for j := 0 to Features.Count - 1 do
      begin
        for k := 0 to Features[j].ActionList.Count - 1 do
          if Features[j].ActionList.Objects[k] = ActionList[i] then
          begin
            Used := True;
            Break;
        end;
        if Used then Break;
      end;
      if not Used then
        lbxActions.Items.AddObject(ActionList[i].Name, ActionList[i]);
    end;
end;

procedure TfrmLCfgEditor.UpdateFeatureActs(AddFlag: Boolean; Action: TAction);
begin
  with TFeature(tvFeatures.Selected.Data).ActionList do
    if AddFlag then
      AddObject(Action.Name, Action)
    else
      Delete(IndexOf(Action.Name));;
end;

end.
