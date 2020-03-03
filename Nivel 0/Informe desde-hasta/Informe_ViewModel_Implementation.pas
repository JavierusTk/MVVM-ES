unit Informe_ViewModel_Implementation;

interface

uses
  Classes,
  Informe_Model, Informe_ViewModel;

type
  TInforme_ViewModel = class
  private
    fDesdeFecha,
    fHastaFecha: TDateTime;
    fOnCambioPropiedades: TNotifyEvent;
    fPropiedadesCambiadas: boolean;
    fCambioPropiedadesDisabled: integer;
    fNombrePlantilla: string;
    fModel: TdmInforme_Model;
    fTickInforme: TNotifyEvent;
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
    function GetTickInforme: TNotifyEvent;
    procedure SetTickInforme(const Value: TNotifyEvent);
    function GetNombrePlantilla: string;
    procedure SetNombrePlantilla(const Value: string);
  public
    procedure Iniciar(const aOnCambiosEnViewModel:TNotifyEvent;const aDesde,aHasta:TDateTime;const aNombrePlantilla:string);
    procedure Actualizar(const aDesdeFecha,aHastaFecha:TDateTime);
    procedure EmitirInforme;
    property  DesdeFecha:TDateTime read GetDesdeFecha write SetDesdeFecha;
    property  HastaFecha:TDateTime read GetHastaFecha write SetHastaFecha;
    property  OnCambioPropiedades:TNotifyEvent read GetOnCambioPropiedades write SetOnCambioPropiedades;
    property  EmitirInformeOK:boolean read GetEmitirInformeOK;
    property  TickInforme:TNotifyEvent read GetTickInforme write SetTickInforme;
    property  NombrePlantilla:string read GetNombrePlantilla write SetNombrePlantilla;
    constructor Create;
    destructor Destroy; override;
  end;



implementation

uses
  Forms;



procedure TInforme_ViewModel.Iniciar(const aOnCambiosEnViewModel:TNotifyEvent;const aDesde,aHasta:TDateTime;const aNombrePlantilla:string);
begin
  fOnCambioPropiedades:=aOnCambiosEnViewModel;
  CambiarPropiedadesDisable;
  try
    DesdeFecha:=aDesde;
    HastaFecha:=aHasta;
    NombrePlantilla:=aNombrePlantilla;
  finally
    CambiarPropiedadesEnable;
  end;
end;


procedure TInforme_ViewModel.EmitirInforme;
begin
  fModel.EmitirInforme;
end;



procedure TInforme_ViewModel.Actualizar(const aDesdeFecha,aHastaFecha:TDateTime);
begin
  if (DesdeFecha<>aDesdeFecha) or (HastaFecha<>aHastaFecha) then begin
    fDesdeFecha:=aDesdeFecha;
    fHastaFecha:=aHastaFecha;
    CambioPropiedades;
  end;
end;

procedure TInforme_ViewModel.SetDesdeFecha(const Value: TDateTime);
begin
  if FDesdeFecha<>Value then begin
    FDesdeFecha := Value;
    CambioPropiedades;
  end;
end;

procedure TInforme_ViewModel.SetHastaFecha(const Value: TDateTime);
begin
  if FHastaFecha<>Value then begin
    FHastaFecha := Value;
    CambioPropiedades;
  end;
end;

procedure TInforme_ViewModel.CambiarPropiedadesDisable;
begin
  inc(fCambioPropiedadesDisabled);
end;

procedure TInforme_ViewModel.CambiarPropiedadesEnable;
begin
  dec(fCambioPropiedadesDisabled);
  if (fCambioPropiedadesDisabled=0) and fPropiedadesCambiadas then
    CambioPropiedades;
end;

procedure TInforme_ViewModel.CambioPropiedades;
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

function TInforme_ViewModel.GetEmitirInformeOK: boolean;
begin
  result:=(DesdeFecha<>0) and (DesdeFecha<=HastaFecha);
end;

function TInforme_ViewModel.GetDesdeFecha: TDateTime;
begin
  result:=fDesdeFecha;
end;

function TInforme_ViewModel.GetHastaFecha: TDateTime;
begin
  result:=fHastaFecha;
end;

function TInforme_ViewModel.GetOnCambioPropiedades: TNotifyEvent;
begin
  result:=fOnCambioPropiedades;
end;

procedure TInforme_ViewModel.SetOnCambioPropiedades(const Value: TNotifyEvent);
begin
  fOnCambioPropiedades:=Value;
end;

destructor TInforme_ViewModel.Destroy;
begin
  fModel.Free;
  fModel:=nil;
  inherited;
end;

constructor TInforme_ViewModel.Create;
begin
  inherited Create;
  Application.CreateForm(TdmInforme_Model,fModel);
end;

function TInforme_ViewModel.GetTickInforme: TNotifyEvent;
begin
  result:=fTickInforme;
end;

procedure TInforme_ViewModel.SetTickInforme(const Value: TNotifyEvent);
begin
  if @FTickInforme<>@Value then begin
    FTickInforme:=Value;
    CambioPropiedades;
  end;
end;

function TInforme_ViewModel.GetNombrePlantilla: string;
begin
  result:=FNombrePlantilla;
end;

procedure TInforme_ViewModel.SetNombrePlantilla(const Value: string);
begin
  if FNombrePlantilla<>Value then begin
    FNombrePlantilla:= Value;
    CambioPropiedades;
  end;
end;

end.

