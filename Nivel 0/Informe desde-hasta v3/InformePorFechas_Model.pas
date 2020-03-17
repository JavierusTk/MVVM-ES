unit InformePorFechas_Model;

interface

uses
  Informe_Model;

type
  TdmInformePorFechas_Model = class(TdmInforme_Model)
  private
    fDesdeFecha:TDateTime;
    fHastaFecha:TDateTime;
  protected
{$IFDEF PRUEBAS}
    procedure EmitirResultado;  override;
{$ENDIF}
  public
    property DesdeFecha:TDateTime read fDesdeFecha write fDesdeFecha;
    property HastaFecha:TDateTime read fHastaFecha write fHastaFecha;
  end;


implementation

{$R *.dfm}

{$IFDEF PRUEBAS}
uses
  SysUtils, Dialogs;
{$ENDIF}


{$IFDEF PRUEBAS}
procedure TdmInformePorFechas_Model.EmitirResultado;
begin
  ShowMessage(Format('Informe Desde %s a %s',[FormatDateTime(ShortDateFormat,DesdeFecha),FormatDateTime(ShortDateFormat,HastaFecha)]));
end;
{$ENDIF}


end.
