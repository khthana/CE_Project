object frmLicRequest: TfrmLicRequest
  Left = 48
  Top = 102
  BorderStyle = bsDialog
  Caption = 'License Request Editor'
  ClientHeight = 377
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
    Height = 329
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
      Left = 16
      Top = 208
      Width = 84
      Height = 14
      Caption = 'Available Actions:'
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
    object gbLicTypes: TGroupBox
      Left = 16
      Top = 80
      Width = 345
      Height = 121
      Caption = ' License Types '
      TabOrder = 2
      object rbtnPermanent: TRadioButton
        Left = 16
        Top = 24
        Width = 113
        Height = 17
        Caption = 'Permanent Use'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rbtnPermanentClick
      end
      object rbtnExpired: TRadioButton
        Left = 17
        Top = 88
        Width = 89
        Height = 17
        Caption = 'Expired Date'
        TabOrder = 1
        OnClick = rbtnExpiredClick
      end
      object dtpkExpired: TDateTimePicker
        Left = 112
        Top = 86
        Width = 217
        Height = 23
        CalAlignment = dtaLeft
        Date = 36596.9875196759
        Time = 36596.9875196759
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 2
        Visible = False
        OnChange = dtpkExpiredChange
      end
      object rbtnDisable: TRadioButton
        Left = 17
        Top = 56
        Width = 113
        Height = 17
        Caption = 'Disable Use'
        TabOrder = 3
        OnClick = rbtnDisableClick
      end
    end
    object lbxFActions: TListBox
      Left = 16
      Top = 224
      Width = 345
      Height = 97
      Columns = 3
      ItemHeight = 14
      MultiSelect = True
      TabOrder = 3
    end
  end
  object pnApplication: TPanel
    Left = 202
    Top = 8
    Width = 369
    Height = 329
    TabOrder = 3
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
    object gbALicType: TGroupBox
      Left = 8
      Top = 184
      Width = 353
      Height = 121
      Caption = ' License Types '
      TabOrder = 3
      object rbtnAPermanent: TRadioButton
        Left = 16
        Top = 24
        Width = 113
        Height = 17
        Caption = 'Permanent Use'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = rbtnAPermanentClick
      end
      object rbtnAExpired: TRadioButton
        Left = 17
        Top = 88
        Width = 89
        Height = 17
        Caption = 'Expired Date'
        TabOrder = 1
        OnClick = rbtnAExpiredClick
      end
      object dtpkAExpired: TDateTimePicker
        Left = 112
        Top = 86
        Width = 217
        Height = 23
        CalAlignment = dtaLeft
        Date = 36596.9875196759
        Time = 36596.9875196759
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 2
        Visible = False
        OnChange = dtpkAExpiredChange
      end
      object rbtnADisable: TRadioButton
        Left = 17
        Top = 56
        Width = 113
        Height = 17
        Caption = 'Disable Use'
        TabOrder = 3
        OnClick = rbtnADisableClick
      end
    end
    object edBuildNo: TEdit
      Left = 288
      Top = 50
      Width = 73
      Height = 22
      ReadOnly = True
      TabOrder = 4
    end
  end
  object btnOK: TButton
    Left = 356
    Top = 344
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object btnSaveLRQ: TButton
    Left = 440
    Top = 344
    Width = 129
    Height = 25
    Caption = 'Save License Request'
    TabOrder = 1
    OnClick = btnSaveLRQClick
  end
  object tvFeatures: TTreeView
    Left = 3
    Top = 8
    Width = 193
    Height = 329
    Indent = 19
    ReadOnly = True
    TabOrder = 4
    OnChange = tvFeaturesChange
  end
  object sdlgLicRequest: TSaveDialog
    DefaultExt = 'lrq'
    Filter = 'License Request File (*.lrq)|*.lrq|All Files (*.*)|*.*'
    Title = 'Save License Request to file.'
    Left = 14
    Top = 345
  end
end
