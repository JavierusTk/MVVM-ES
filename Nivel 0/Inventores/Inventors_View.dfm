object fmInventores_View: TfmInventores_View
  Tag = 222
  Left = 674
  Top = 198
  Width = 662
  Height = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  ShowHint = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGeneral: TPanel
    Left = 0
    Top = 0
    Width = 280
    Height = 305
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Bevel2: TBevel
      Left = 0
      Top = 0
      Width = 280
      Height = 24
      Align = alTop
      Shape = bsSpacer
    end
    object lbl1: TLabel
      Left = 56
      Top = 56
      Width = 37
      Height = 13
      Caption = 'Nombre'
    end
    object lbl2: TLabel
      Left = 56
      Top = 88
      Width = 42
      Height = 13
      Caption = 'Apellidos'
    end
    object lbl3: TLabel
      Left = 56
      Top = 120
      Width = 17
      Height = 13
      Caption = 'NIF'
    end
    object edtNombre: TEdit
      Left = 104
      Top = 56
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object edtApellidos: TEdit
      Left = 104
      Top = 88
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object edtNIF: TEdit
      Left = 104
      Top = 120
      Width = 121
      Height = 21
      TabOrder = 2
    end
  end
  object pnlOkCancel: TPanel
    Left = 0
    Top = 305
    Width = 646
    Height = 54
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOk: TBitBtn
      Left = 0
      Top = 0
      Width = 140
      Height = 54
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = OkClicked
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnCancel: TBitBtn
      Left = 304
      Top = 0
      Width = 140
      Height = 54
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object grdInventores: TDrawGrid
    Left = 280
    Top = 0
    Width = 366
    Height = 305
    Align = alRight
    ColCount = 4
    DefaultDrawing = False
    FixedCols = 0
    TabOrder = 2
    OnDrawCell = grdInventoresDrawCell
    OnSelectCell = grdInventoresSelectCell
    ColWidths = (
      64
      64
      143
      64)
  end
end
