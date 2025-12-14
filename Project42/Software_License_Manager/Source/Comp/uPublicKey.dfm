object frmPBKeyDlg: TfrmPBKeyDlg
  Left = 196
  Top = 224
  BorderStyle = bsDialog
  Caption = 'Public Key Editor'
  ClientHeight = 273
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object btnOK: TButton
    Left = 192
    Top = 240
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 441
    Height = 225
    Caption = ' Public Key Information '
    TabOrder = 1
    object lbOwner: TLabel
      Left = 16
      Top = 24
      Width = 34
      Height = 14
      Caption = 'Owner:'
    end
    object Label3: TLabel
      Left = 16
      Top = 120
      Width = 27
      Height = 14
      Caption = 'Type:'
    end
    object Label4: TLabel
      Left = 256
      Top = 120
      Width = 40
      Height = 14
      Caption = 'Version:'
    end
    object Label5: TLabel
      Left = 16
      Top = 152
      Width = 59
      Height = 14
      Caption = 'Public Expo:'
    end
    object Bevel1: TBevel
      Left = 16
      Top = 88
      Width = 409
      Height = 18
      Shape = bsBottomLine
    end
    object Label6: TLabel
      Left = 256
      Top = 152
      Width = 56
      Height = 14
      Caption = 'Bits Length:'
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 48
      Height = 14
      Caption = 'Container:'
    end
    object btnChange: TButton
      Left = 352
      Top = 184
      Width = 75
      Height = 25
      Caption = 'Change...'
      TabOrder = 0
      OnClick = btnChangeClick
    end
    object edOwner: TEdit
      Left = 88
      Top = 24
      Width = 337
      Height = 22
      ReadOnly = True
      TabOrder = 1
    end
    object edType: TEdit
      Left = 88
      Top = 120
      Width = 153
      Height = 22
      ReadOnly = True
      TabOrder = 2
    end
    object edVersion: TEdit
      Left = 320
      Top = 120
      Width = 105
      Height = 22
      ReadOnly = True
      TabOrder = 3
    end
    object edPubExpo: TEdit
      Left = 88
      Top = 152
      Width = 153
      Height = 22
      ReadOnly = True
      TabOrder = 4
    end
    object edBitLen: TEdit
      Left = 320
      Top = 152
      Width = 105
      Height = 22
      ReadOnly = True
      TabOrder = 5
    end
    object edContainer: TEdit
      Left = 88
      Top = 56
      Width = 337
      Height = 22
      ReadOnly = True
      TabOrder = 6
    end
  end
  object odlgPublicKey: TOpenDialog
    DefaultExt = 'pks'
    Filter = 
      'Public Key Signature (*.pks)|*.pks|Public Key Exchange (*.pkx)|*' +
      '.pkx|All Files (*.*)|*.*'
    Options = [ofReadOnly, ofHideReadOnly, ofEnableSizing]
    Title = 'Select Public Key File.'
    Left = 416
    Top = 240
  end
end
