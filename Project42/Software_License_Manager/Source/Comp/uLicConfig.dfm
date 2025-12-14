object frmLCfgEditor: TfrmLCfgEditor
  Left = 128
  Top = 148
  BorderStyle = bsDialog
  Caption = 'License Configuration Editor'
  ClientHeight = 359
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 14
  object pnFeature: TPanel
    Left = 202
    Top = 8
    Width = 369
    Height = 313
    TabOrder = 2
    Visible = False
    object Label1: TLabel
      Left = 12
      Top = 19
      Width = 70
      Height = 14
      Caption = 'Feature Name:'
    end
    object Label4: TLabel
      Left = 27
      Top = 56
      Width = 56
      Height = 14
      Caption = 'Description:'
    end
    object Label2: TLabel
      Left = 8
      Top = 88
      Width = 84
      Height = 14
      Caption = 'Available Actions:'
    end
    object sbtnAdd: TSpeedButton
      Left = 168
      Top = 152
      Width = 23
      Height = 22
      Caption = '>'
      OnClick = sbtnAddClick
    end
    object sbtnAddAll: TSpeedButton
      Left = 168
      Top = 176
      Width = 23
      Height = 22
      Caption = '>>'
      OnClick = sbtnAddAllClick
    end
    object sbtnRem: TSpeedButton
      Left = 168
      Top = 200
      Width = 23
      Height = 22
      Caption = '<'
      OnClick = sbtnRemClick
    end
    object sbtnRemAll: TSpeedButton
      Left = 168
      Top = 224
      Width = 23
      Height = 22
      Caption = '<<'
      OnClick = sbtnRemAllClick
    end
    object edFeatureName: TEdit
      Left = 96
      Top = 16
      Width = 265
      Height = 22
      TabOrder = 0
      OnChange = edFeatureNameChange
    end
    object edFDescription: TEdit
      Left = 96
      Top = 48
      Width = 265
      Height = 22
      TabOrder = 1
      OnChange = edFDescriptionChange
    end
    object lbxActions: TListBox
      Left = 8
      Top = 104
      Width = 153
      Height = 193
      Columns = 1
      ItemHeight = 14
      MultiSelect = True
      TabOrder = 2
    end
    object lbxFActions: TListBox
      Left = 200
      Top = 104
      Width = 145
      Height = 193
      Columns = 1
      ItemHeight = 14
      MultiSelect = True
      TabOrder = 3
    end
  end
  object pnApplication: TPanel
    Left = 202
    Top = 8
    Width = 369
    Height = 313
    TabOrder = 4
    Visible = False
    object lbAppName: TLabel
      Left = 12
      Top = 21
      Width = 86
      Height = 14
      Caption = 'Application Name:'
    end
    object lbVersion: TLabel
      Left = 58
      Top = 55
      Width = 40
      Height = 14
      Caption = 'Version:'
    end
    object lbBuildNo: TLabel
      Left = 234
      Top = 50
      Width = 46
      Height = 14
      Caption = 'Build No.:'
    end
    object lbDescription: TLabel
      Left = 43
      Top = 89
      Width = 56
      Height = 14
      Caption = 'Description:'
    end
    object edAppName: TEdit
      Left = 104
      Top = 16
      Width = 257
      Height = 22
      TabOrder = 0
      OnChange = edAppNameChange
    end
    object edVersion: TEdit
      Left = 104
      Top = 50
      Width = 113
      Height = 22
      TabOrder = 1
      OnChange = edVersionChange
    end
    object speBuildNo: TSpinEdit
      Left = 288
      Top = 50
      Width = 73
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 0
      OnChange = speBuildNoChange
    end
    object edDescription: TEdit
      Left = 104
      Top = 84
      Width = 257
      Height = 22
      TabOrder = 3
      OnChange = edDescriptionChange
    end
  end
  object btnOK: TButton
    Left = 316
    Top = 328
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object btnSaveTemplate: TButton
    Left = 400
    Top = 328
    Width = 171
    Height = 25
    Caption = 'Save License Template File'
    TabOrder = 1
    OnClick = btnSaveTemplateClick
  end
  object tvFeatures: TTreeView
    Left = 3
    Top = 8
    Width = 193
    Height = 313
    Indent = 19
    ReadOnly = True
    TabOrder = 3
    OnChange = tvFeaturesChange
  end
  object sdlgTemplate: TSaveDialog
    DefaultExt = 'ltp'
    Filter = 'License Template File (*.ltp)|*.ltp|All Files (*.*)|*.*'
    Title = 'Save License Template to File.'
    Left = 6
    Top = 329
  end
end
