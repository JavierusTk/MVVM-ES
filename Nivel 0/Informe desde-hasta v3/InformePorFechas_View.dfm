inherited fmInformePorFechas_View: TfmInformePorFechas_View
  Caption = 'fmInformePorFechas_View'
  PixelsPerInch = 120
  TextHeight = 13
  inherited pnlGeneral: TPanel
    object pnlFechas: TPanel
      Left = 0
      Top = 24
      Width = 444
      Height = 99
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblDesdeFecha: TLabel
        Left = 112
        Top = 34
        Width = 67
        Height = 13
        Alignment = taRightJustify
        Caption = 'Desde Fecha:'
        Transparent = True
      end
      object lblHastaFecha: TLabel
        Left = 115
        Top = 58
        Width = 64
        Height = 13
        Alignment = taRightJustify
        Caption = 'Hasta Fecha:'
        Transparent = True
      end
      object dtpDesdeFecha: TDateTimePicker
        Left = 183
        Top = 30
        Width = 93
        Height = 24
        Date = 36526.000000000000000000
        Time = 36526.000000000000000000
        Checked = False
        TabOrder = 0
        OnChange = evtCambiosEnView
      end
      object dtpHastaFecha: TDateTimePicker
        Left = 183
        Top = 54
        Width = 93
        Height = 24
        Date = 36526.351064687500000000
        Time = 36526.351064687500000000
        TabOrder = 1
        OnChange = evtCambiosEnView
      end
    end
  end
end
