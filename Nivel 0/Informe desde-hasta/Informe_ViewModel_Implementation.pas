unit Informe_ViewModel_Implementation;

interface

uses
  Windows, Variants, Messages, SysUtils, Classes, Db, Forms,
  ppBands, ppCache, ppClass, ppProd, ppReport, ppReportMax, ppComm, ppRelatv, ppDB, ppDBPipe, ppDBBDE,
  kbmMemTable, TableMax, DBTables, Informe_ViewModel;

type
  TdmInforme_ViewModel = class(TDataModule)
  private
    fDesdeFecha,
    fHastaFecha: TDateTime;
    fOnCambioPropiedades: TNotifyEvent;
    fPropiedadesCambiadas: boolean;
    fCambioPropiedadesDisabled: integer;
    fNombrePlantilla: string;
    procedure SetDesdeFecha(const Value: TDateTime);
    procedure SetHastaFecha(const Value: TDateTime);
    procedure CambioPropiedades;
    function  GetEmitirInformeOK: boolean;
    procedure CambiarPropiedadesDisable;
    procedure CambiarPropiedadesEnable;
    function  GetDesdeFecha: TDateTime;
    function  GetHastaFecha: TDateTime;
    function  GetOnCambioPropiedades: TNotifyEvent;
    procedure SetOnCambioPropiedades(const Value: TNotifyEvent);
    procedure PrepararDatos(const TickInforme:TNotifyEvent);
  public
    procedure Iniciar(const aOnCambiosEnViewModel:TNotifyEvent;const aDesde,aHasta:TDateTime;const aNombrePlantilla:string);
    procedure Actualizar(const aDesdeFecha,aHastaFecha:TDateTime);
    procedure EmitirInforme(const TickInforme:TNotifyEvent);
    property  DesdeFecha:TDateTime read GetDesdeFecha write SetDesdeFecha;
    property  HastaFecha:TDateTime read GetHastaFecha write SetHastaFecha;
    property  OnCambioPropiedades:TNotifyEvent read GetOnCambioPropiedades write SetOnCambioPropiedades;
    property  EmitirInformeOK:boolean read GetEmitirInformeOK;
    destructor Destroy; override;
  end;



implementation

uses
  DialogsMax,
  CompatVarios, TypesMax, UtilFechas, EsperePorFavor, FormMax;

{$R *.DFM}


procedure TdmInforme_ViewModel.Iniciar(const aOnCambiosEnViewModel:TNotifyEvent;const aDesde,aHasta:TDateTime;const aNombrePlantilla:string);
begin
  if (aDesde=0) or (aHasta=0) then begin
    fDesdeFecha:=MinDaysOnDateMonth(SumaMeses(Date,-1));
    fHastaFecha:=MaxDaysOnDateMonth(fDesdeFecha);
   end
  else begin
    fDesdeFecha:=aDesde;
    fHastaFecha:=aHasta;
  end;                                                                 
  fNombrePlantilla:=aNombrePlantilla;
  fOnCambioPropiedades:=aOnCambiosEnViewModel;
end;

procedure TdmInforme_ViewModel.PrepararDatos(const TickInforme:TNotifyEvent);
begin
//....
end;


procedure TdmInforme_ViewModel.EmitirInforme(const TickInforme:TNotifyEvent);
begin
    PrepararDatos(TickInforme);
//    TExportarExcel.....
end;



procedure TdmInforme_ViewModel.Actualizar(const aDesdeFecha,aHastaFecha:TDateTime);
begin
  if (DesdeFecha<>aDesdeFecha) or (HastaFecha<>aHastaFecha) then begin
    fDesdeFecha:=aDesdeFecha;
    fHastaFecha:=aHastaFecha;
    CambioPropiedades;
  end;
end;

procedure TdmInforme_ViewModel.SetDesdeFecha(const Value: TDateTime);
begin
  if FDesdeFecha<>Value then begin
    FDesdeFecha := Value;
    CambioPropiedades;
  end;
end;

procedure TdmInforme_ViewModel.SetHastaFecha(const Value: TDateTime);
begin
  if FHastaFecha<>Value then begin
    FHastaFecha := Value;
    CambioPropiedades;
  end;
end;

procedure TdmInforme_ViewModel.CambiarPropiedadesDisable;
begin
  inc(fCambioPropiedadesDisabled);
end;

procedure TdmInforme_ViewModel.CambiarPropiedadesEnable;
begin
  dec(fCambioPropiedadesDisabled);
  if (fCambioPropiedadesDisabled=0) and fPropiedadesCambiadas then
    CambioPropiedades;
end;

procedure TdmInforme_ViewModel.CambioPropiedades;
begin
  if (fCambioPropiedadesDisabled<>0) then
    fPropiedadesCambiadas:=True
  else begin
    fPropiedadesCambiadas:=False;
    CambiarPropiedadesDisable;
    try
      if Assigned(fOnCambioPropiedades) then
        fOnCambioPropiedades(Self);
    finally
      CambiarPropiedadesEnable;
    end;
  end;
end;

function TdmInforme_ViewModel.GetEmitirInformeOK: boolean;
begin
  result:=(DesdeFecha<>0) and (DesdeFecha<=HastaFecha);
end;

function TdmInforme_ViewModel.GetDesdeFecha: TDateTime;
begin
  result:=fDesdeFecha;
end;

function TdmInforme_ViewModel.GetHastaFecha: TDateTime;
begin
  result:=fHastaFecha;
end;

function TdmInforme_ViewModel.GetOnCambioPropiedades: TNotifyEvent;
begin
  result:=fOnCambioPropiedades;
end;

procedure TdmInforme_ViewModel.SetOnCambioPropiedades(const Value: TNotifyEvent);
begin
  fOnCambioPropiedades:=Value;
end;

destructor TdmInforme_ViewModel.Destroy;
begin
  inherited;
end;

end.

