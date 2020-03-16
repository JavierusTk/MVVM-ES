unit InformePorFechas_Model;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Informe_Model;

type
  TdmInformePorFechas_Model = class(TdmInforme_Model)
  private
    fDesdeFecha:TDateTime;
    fHastaFecha:TDateTime;
  protected
    procedure EmitirResultado;  override;
  public
    property DesdeFecha:TDateTime read fDesdeFecha write fDesdeFecha;
    property HastaFecha:TDateTime read fHastaFecha write fHastaFecha;
  end;


implementation

{$R *.dfm}

{ TdmInformePorFechas_Model }

procedure TdmInformePorFechas_Model.EmitirResultado;
begin
  ShowMessage(Format('Informe Desde %s a %s',[FormatDateTime(ShortDateFormat,DesdeFecha),FormatDateTime(ShortDateFormat,HastaFecha)]));
end;

end.
