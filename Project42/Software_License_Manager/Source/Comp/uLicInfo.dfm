object frmLicInfo: TfrmLicInfo
  Left = 107
  Top = 139
  BorderStyle = bsDialog
  Caption = 'License Information'
  ClientHeight = 338
  ClientWidth = 577
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
    Height = 281
    TabOrder = 1
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
      Left = 16
      Top = 144
      Width = 84
      Height = 14
      Caption = 'Available Actions:'
    end
    object Label3: TLabel
      Left = 16
      Top = 115
      Width = 67
      Height = 14
      Caption = 'License Type:'
    end
    object Bevel2: TBevel
      Left = 16
      Top = 88
      Width = 337
      Height = 9
      Shape = bsTopLine
    end
    object edFeatureName: TEdit
      Left = 96
      Top = 16
      Width = 265
      Height = 22
      ReadOnly = True
      TabOrder = 0
    end
    object edFDescription: TEdit
      Left = 96
      Top = 48
      Width = 265
      Height = 22
      ReadOnly = True
      TabOrder = 1
    end
    object lbxFActions: TListBox
      Left = 16
      Top = 168
      Width = 345
      Height = 105
      Columns = 1
      ItemHeight = 14
      MultiSelect = True
      TabOrder = 2
    end
    object edLicType: TEdit
      Left = 96
      Top = 112
      Width = 265
      Height = 22
      ReadOnly = True
      TabOrder = 3
    end
  end
  object pnApplication: TPanel
    Left = 202
    Top = 8
    Width = 369
    Height = 281
    TabOrder = 2
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
    object Label5: TLabel
      Left = 28
      Top = 211
      Width = 67
      Height = 14
      Caption = 'License Type:'
    end
    object Bevel1: TBevel
      Left = 16
      Top = 168
      Width = 337
      Height = 9
      Shape = bsTopLine
    end
    object edAppName: TEdit
      Left = 104
      Top = 16
      Width = 257
      Height = 22
      ReadOnly = True
      TabOrder = 0
    end
    object edVersion: TEdit
      Left = 104
      Top = 50
      Width = 113
      Height = 22
      ReadOnly = True
      TabOrder = 1
    end
    object edDescription: TEdit
      Left = 104
      Top = 84
      Width = 257
      Height = 22
      ReadOnly = True
      TabOrder = 2
    end
    object edALicType: TEdit
      Left = 104
      Top = 206
      Width = 257
      Height = 22
      ReadOnly = True
      TabOrder = 3
    end
    object edBuildNo: TEdit
      Left = 288
      Top = 48
      Width = 73
      Height = 22
      TabOrder = 4
    end
  end
  object btnOK: TButton
    Left = 251
    Top = 304
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object tvFeatures: TTreeView
    Left = 3
    Top = 8
    Width = 193
    Height = 281
    Indent = 19
    ReadOnly = True
    TabOrder = 3
    OnChange = tvFeaturesChange
  end
end
