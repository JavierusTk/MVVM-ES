unit InformePorFechas_Model;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Informe_Model;

type
  TInformePorFechas_Propiedades = class(TInforme_Propiedades)
    DesdeFecha: TDateTime;
    HastaFecha: TDateTime;
  end;
  TdmInformePorFechas_Model = class(TdmInforme_Model)
  protected
    procedure EmitirResultado(const aPropiedades: TInforme_Propiedades);  override;
  end;


implementation

{$R *.dfm}

{ TdmInformePorFechas_Model }

procedure TdmInformePorFechas_Model.EmitirResultado(const aPropiedades: TInforme_Propiedades);
begin
  ShowMessage(Format('Informe Desde %s a %s',[FormatDateTime(ShortDateFormat,(aPropiedades as TInformePorFechas_Propiedades).DesdeFecha),FormatDateTime(ShortDateFormat,(aPropiedades as TInformePorFechas_Propiedades).HastaFecha)]));
end;

end.
