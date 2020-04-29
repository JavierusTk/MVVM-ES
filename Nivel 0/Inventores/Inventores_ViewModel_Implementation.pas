unit Inventores_ViewModel_Implementation;

interface

uses
  Inventores_Model;

type
  TInventores_ViewModel_Class = class of TInventores_ViewModel;
  TInventores_ViewModel = class
  private
    { Private declarations }
    fOnCambioPropiedades: TmvvmNotifyEvent;
    fPropiedadesCambiadas: boolean;
    fCambioPropiedadesDisabled: integer;
    fTick: TmvvmNotifyEvent;
    fModel: TdmInventores_Model;
    function  GetOnCambioPropiedades: TmvvmNotifyEvent;
    procedure SetOnCambioPropiedades(const Value: TmvvmNotifyEvent);
    procedure CreateModel;
  protected
    procedure CambioPropiedades;
    procedure CambiarPropiedadesDisable;
    procedure CambiarPropiedadesEnable;
    function  GetVistaOK: boolean; virtual;
    function  ModelClass:TdmInventores_Model_Class; virtual;
    procedure AsignacionesIniciales; virtual;
    procedure AsignarPropiedadesModelo; virtual;
    property  Model:TdmInventores_Model read fModel;
  public
    Constructor Create(const InjectedModel:TdmInventores_Model=nil);
    procedure RealizarProceso;
    procedure Iniciar(const aOnCambiosEnViewModel:TmvvmNotifyEvent); virtual;
    destructor Destroy; override;
    function  InventoresCount:integer;
    function  ObtenValor(const Fila:integer;const NombreColumna:string):string;
    property  OnCambioPropiedades:TmvvmNotifyEvent read GetOnCambioPropiedades write SetOnCambioPropiedades;
    property  VistaOK:boolean read GetVistaOK;
    property  Tick:TmvvmNotifyEvent read fTick write fTick;
  end;


implementation

uses
  SysUtils;


procedure TInventores_ViewModel.Iniciar(const aOnCambiosEnViewModel:TmvvmNotifyEvent);
begin
  AsignacionesIniciales;
  fOnCambioPropiedades:=aOnCambiosEnViewModel;
end;




function TInventores_ViewModel.ModelClass: TdmInventores_Model_Class;
begin
  result:=TdmInventores_Model
end;


procedure TInventores_ViewModel.AsignacionesIniciales;
begin
//Nada
end;

procedure TInventores_ViewModel.AsignarPropiedadesModelo;
begin
//
end;

procedure TInventores_ViewModel.CambiarPropiedadesDisable;
begin
  inc(fCambioPropiedadesDisabled);
end;

procedure TInventores_ViewModel.CambiarPropiedadesEnable;
begin
  dec(fCambioPropiedadesDisabled);
  if (fCambioPropiedadesDisabled=0) and fPropiedadesCambiadas then
    CambioPropiedades;
end;

procedure TInventores_ViewModel.CambioPropiedades;
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

function TInventores_ViewModel.GetVistaOK: boolean;
begin
  result:=True;
end;

function TInventores_ViewModel.GetOnCambioPropiedades: TmvvmNotifyEvent;
begin
  result:=fOnCambioPropiedades;
end;

procedure TInventores_ViewModel.SetOnCambioPropiedades(const Value: TmvvmNotifyEvent);
begin
  fOnCambioPropiedades:=Value;
end;

destructor TInventores_ViewModel.Destroy;
begin
  inherited;
end;


procedure TInventores_ViewModel.RealizarProceso;
begin
//  CreateModel;
  try
    AsignarPropiedadesModelo;
    fModel.RealizarProceso(fTick);
  finally
//    fModel.Free;
//    fModel:=nil;
  end;
end;

procedure TInventores_ViewModel.CreateModel;
begin
  fModel:=ModelClass.CreateModel;
end;



function TInventores_ViewModel.InventoresCount: integer;
begin
  result:=fModel.InventoresCuenta;
end;

function TInventores_ViewModel.ObtenValor(const Fila: integer;const NombreColumna: string): string;
var
  aInventor: TInventor;
begin
  aInventor:=fModel.LeerInventorIDX(Fila);
  if NombreColumna='ID' then
    result:=IntToStr(aInventor.ID)
  else if NombreColumna='NOMBRE' then
    result:=aInventor.Nombre
  else if NombreColumna='INVENTO' then
    result:=aInventor.INVENTO
  else if NombreColumna='ANYO' then
    result:=IntToStr(aInventor.Anyo)
  else
    result:='*ERROR*';
end;

constructor TInventores_ViewModel.Create(const InjectedModel: TdmInventores_Model);
begin
  inherited Create;
  fModel:=InjectedModel;
  if not assigned(Model) then
    CreateModel;
end;

end.

