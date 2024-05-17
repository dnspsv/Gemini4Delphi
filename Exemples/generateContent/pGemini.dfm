object uFrmPrincipal: TuFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Api-Gemini'
  ClientHeight = 692
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 625
    Width = 779
    Height = 67
    Align = alBottom
    TabOrder = 0
    object mRequest: TMemo
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 669
      Height = 55
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      Lines.Strings = (
        '')
      ParentFont = False
      TabOrder = 0
    end
    object Button1: TButton
      AlignWithMargins = True
      Left = 685
      Top = 6
      Width = 88
      Height = 55
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Enviar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 464
    Top = 11
    Width = 315
    Height = 614
    Align = alRight
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 22
      Width = 307
      Height = 13
      Align = alTop
      Caption = 'API-Key'
      ExplicitWidth = 47
    end
    object Label2: TLabel
      Left = 1
      Top = 1
      Width = 313
      Height = 18
      Margins.Bottom = 5
      Align = alTop
      Alignment = taCenter
      Caption = 'Configura'#231#245'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 126
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 68
      Width = 307
      Height = 13
      Align = alTop
      Caption = 'Modelo'
      ExplicitWidth = 40
    end
    object Label4: TLabel
      Left = 1
      Top = 111
      Width = 313
      Height = 13
      Align = alTop
      Caption = 'Temperatura'
      ExplicitWidth = 73
    end
    object edtToken: TEdit
      AlignWithMargins = True
      Left = 4
      Top = 41
      Width = 307
      Height = 21
      Align = alTop
      TabOrder = 0
      OnExit = edtTokenExit
    end
    object cbxModel: TComboBox
      AlignWithMargins = True
      Left = 4
      Top = 87
      Width = 307
      Height = 21
      Align = alTop
      TabOrder = 1
      OnChange = cbxModelChange
    end
    object TrackTemperatura: TTrackBar
      AlignWithMargins = True
      Left = 4
      Top = 127
      Width = 307
      Height = 45
      Align = alTop
      Max = 100
      TabOrder = 2
      OnChange = TrackTemperaturaChange
    end
    object Panel4: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 178
      Width = 307
      Height = 255
      Align = alTop
      TabOrder = 3
      object Label6: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 180
        Width = 299
        Height = 13
        Align = alTop
        Caption = 'Conte'#250'do Perigoso (Dangerous Content)'
        ExplicitWidth = 233
      end
      object Label7: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 30
        Width = 299
        Height = 13
        Align = alTop
        Caption = 'Ass'#233'dio (Harassment)'
        ExplicitWidth = 126
      end
      object Label8: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 80
        Width = 299
        Height = 13
        Align = alTop
        Caption = #211'dio (Hate)'
        ExplicitWidth = 66
      end
      object Label9: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 130
        Width = 299
        Height = 13
        Align = alTop
        Caption = 'Sexualmente Expl'#237'cito (Sexually Explicit)'
        ExplicitWidth = 233
      end
      object Label5: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 299
        Height = 18
        Margins.Bottom = 5
        Align = alTop
        Alignment = taCenter
        Caption = 'Configura'#231#245'es de seguran'#231'a'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 250
      end
      object cbxAssedio: TComboBox
        AlignWithMargins = True
        Left = 6
        Top = 51
        Width = 295
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alTop
        TabOrder = 0
        OnChange = cbxAssedioChange
      end
      object cbxOdio: TComboBox
        AlignWithMargins = True
        Left = 6
        Top = 101
        Width = 295
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alTop
        TabOrder = 1
        OnChange = cbxOdioChange
      end
      object cbxSexualidade: TComboBox
        AlignWithMargins = True
        Left = 6
        Top = 151
        Width = 295
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alTop
        TabOrder = 2
        OnChange = cbxSexualidadeChange
      end
      object cbxPerigoso: TComboBox
        AlignWithMargins = True
        Left = 6
        Top = 201
        Width = 295
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alTop
        TabOrder = 3
        OnChange = cbxPerigosoChange
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 436
      Width = 313
      Height = 177
      Align = alClient
      TabOrder = 4
      object Label11: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 74
        Width = 305
        Height = 13
        Align = alTop
        Caption = 'Top P'
        ExplicitWidth = 31
      end
      object Label12: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 28
        Width = 305
        Height = 13
        Align = alTop
        Caption = 'Top K'
        ExplicitWidth = 32
      end
      object Label13: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 305
        Height = 18
        Align = alTop
        Alignment = taCenter
        Caption = 'Configura'#231#245'es avan'#231'adas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 225
      end
      object edtTopK: TEdit
        AlignWithMargins = True
        Left = 4
        Top = 47
        Width = 305
        Height = 21
        Align = alTop
        TabOrder = 0
        Text = '0'
        OnExit = edtTopKExit
      end
      object TrackTopP: TTrackBar
        AlignWithMargins = True
        Left = 4
        Top = 93
        Width = 305
        Height = 45
        Align = alTop
        Max = 100
        TabOrder = 1
        OnChange = TrackTopPChange
      end
      object Button2: TButton
        AlignWithMargins = True
        Left = 4
        Top = 148
        Width = 305
        Height = 25
        Align = alBottom
        Caption = 'Limpar Configura'#231#245'es'
        TabOrder = 2
        OnClick = Button2Click
      end
    end
    object cbxDiscovery: TComboBox
      Left = 240
      Top = 6
      Width = 65
      Height = 21
      ItemIndex = 1
      TabOrder = 5
      Text = 'v1beta'
      Items.Strings = (
        'v1'
        'v1beta')
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 11
    Width = 464
    Height = 614
    Align = alClient
    TabOrder = 2
    object mResponse: TMemo
      AlignWithMargins = True
      Left = 6
      Top = 67
      Width = 452
      Height = 541
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 462
      Height = 61
      Align = alTop
      TabOrder = 1
      Visible = False
      object Label10: TLabel
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 450
        Height = 13
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Instru'#231#245'es do sistema (System Instructions)'
        ExplicitWidth = 254
      end
      object EdtSystemInstructions: TEdit
        AlignWithMargins = True
        Left = 6
        Top = 29
        Width = 450
        Height = 21
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alTop
        TabOrder = 0
        TextHint = 'Instru'#231#245'es opcionais de tom e estilo para o modelo'
      end
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 0
    Width = 779
    Height = 11
    Align = alTop
    Max = 500
    MarqueeInterval = 1
    TabOrder = 3
  end
  object TLoads: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TLoadsTimer
    Left = 400
    Top = 529
  end
end
