object fmInforme_View: TfmInforme_View
  Tag = 222
  Left = 674
  Top = 198
  Width = 462
  Height = 288
  Caption = 'INFORME MENSUAL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  Scaled = False
  ShowHint = True
  OnClose = FormMaxClose
  OnCreate = FormMaxCreate
  OnDestroy = FormMaxDestroy
  ParentColor = False
  ParentCtl3D = False
  ParentShowHint = False
  CaptionShort = 'Orden del día'
  ClientDrag = False
  HiddenCaption = False
  PixelsPerInch = 96
  TextHeight = 13
  object OkCancelPanel: TOkCancelPanel
    Left = 0
    Top = 190
    Width = 446
    Height = 60
    Align = alBottom
    TabOrder = 1
    Transparent = True
    OkEnabled = False
    OnOkClicked = OkCancelPanelOkClicked
  end
  object PanelMAX2: TPanelMAX
    Left = 0
    Top = 0
    Width = 446
    Height = 190
    Align = alClient
    object Bevel3: TBevel
      Left = 0
      Top = 0
      Width = 446
      Height = 24
      Align = alTop
      Shape = bsSpacer
    end
    object Bevel2: TBevel
      Left = 0
      Top = 118
      Width = 446
      Height = 24
      Align = alTop
      Shape = bsSpacer
    end
    object LabelMax1: TLabelMax
      Left = 0
      Top = 24
      Width = 446
      Height = 22
      Align = alTop
      AutoSize = False
      Caption = '      Se incluirán las llegadas y las salidas en este periodo...'
      Transparent = True
      Layout = tlCenter
      HitCaption = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 151
      Width = 446
      Height = 39
      Align = alBottom
      Shape = bsSpacer
    end
    object edtFechas: TDateRangePeriod
      Left = 0
      Top = 46
      Width = 446
      Height = 72
      Align = alTop
      Caption = 'edtFechas'
      Transparent = True
      EdtLeft = 160
      OnDataChange = edtRevisarDatos
      OnlyYear = 0
    end
  end
end
