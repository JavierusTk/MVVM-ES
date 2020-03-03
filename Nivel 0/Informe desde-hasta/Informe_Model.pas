unit Informe_Model;

interface

uses
  Classes, Forms, Informe_ViewModel;

type
  TdmInforme_Model = class(TDataModule)
  private
    fDesdeFecha,
    fHastaFecha: TDateTime;
    fNombrePlantilla: string;
    fTickInforme: TNotifyEvent;
    procedure PrepararDatos(const TickInforme:TNotifyEvent);
  public
    procedure EmitirInforme;
    property  TickInforme:TNotifyEvent read fTickInforme write fTickInforme;
    property  DesdeFecha:TDateTime read fDesdeFecha write fDesdeFecha;
    property  HastaFecha:TDateTime read fHastaFecha write fHastaFecha;
    property  NombrePlantilla:string read fNombrePlantilla write fNombrePlantilla;
    destructor Destroy; override;
  end;



implementation



{$R *.DFM}


procedure TdmInforme_Model.PrepararDatos(const TickInforme:TNotifyEvent);
begin
//....
end;


procedure TdmInforme_Model.EmitirInforme;
begin
    PrepararDatos(TickInforme);
//    TExportarExcel.....
end;

destructor TdmInforme_Model.Destroy;
begin
  inherited;
end;

end.

