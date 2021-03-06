unit Informe_ViewModel_Implementation;

interface

uses
  Informe_Model;

type
  TInforme_ViewModel_Class = class of TInforme_ViewModel;
  TInforme_ViewModel = class
  private
    { Private declarations }
    fOnCambioPropiedades: TmvvmNotifyEvent;
    fPropiedadesCambiadas: boolean;
    fCambioPropiedadesDisabled: integer;
    fTickInforme: TmvvmNotifyEvent;
    fModel: TdmInforme_Model;
    function  GetOnCambioPropiedades: TmvvmNotifyEvent;
    procedure SetOnCambioPropiedades(const Value: TmvvmNotifyEvent);
    procedure CreateModel;
  protected
    procedure CambioPropiedades;
    procedure CambiarPropiedadesDisable;
    procedure CambiarPropiedadesEnable;
    function  GetEmitirInformeOK: boolean; virtual;
    function  ModelClass:TdmInforme_Model_Class; virtual;
    function  PropiedadesParaModelo:TInforme_Propiedades; virtual;
    procedure AsignacionesIniciales; virtual;
    property  Model:TdmInforme_Model read fModel;
  public
    procedure EmitirInforme;
    procedure Iniciar(const aOnCambiosEnViewModel:TmvvmNotifyEvent); virtual;
    destructor Destroy; override;
    property  OnCambioPropiedades:TmvvmNotifyEvent read GetOnCambioPropiedades write SetOnCambioPropiedades;
    property  EmitirInformeOK:boolean read GetEmitirInformeOK;
    property  TickInforme:TmvvmNotifyEvent read fTickInforme write fTickInforme;
  end;


implementation


procedure TInforme_ViewModel.Iniciar(const aOnCambiosEnViewModel:TmvvmNotifyEvent);
begin
  AsignacionesIniciales;
  fOnCambioPropiedades:=aOnCambiosEnViewModel;
end;




function TInforme_ViewModel.ModelClass: TdmInforme_Model_Class;
begin
  result:=TdmInforme_Model
end;


procedure TInforme_ViewModel.AsignacionesIniciales;
begin
//Nada
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
  result:=True;
end;

function TInforme_ViewModel.GetOnCambioPropiedades: TmvvmNotifyEvent;
begin
  result:=fOnCambioPropiedades;
end;

procedure TInforme_ViewModel.SetOnCambioPropiedades(const Value: TmvvmNotifyEvent);
begin
  fOnCambioPropiedades:=Value;
end;

destructor TInforme_ViewModel.Destroy;
begin
  inherited;
end;

function TInforme_ViewModel.PropiedadesParaModelo:TInforme_Propiedades;
begin
  result:=TInforme_Propiedades.Create;
end;

procedure TInforme_ViewModel.EmitirInforme;
begin
  CreateModel;
  try
    fModel.EmitirInforme(fTickInforme,PropiedadesParaModelo);
  finally
    fModel.Free;
    fModel:=nil;
  end;
end;

procedure TInforme_ViewModel.CreateModel;
begin
  fModel:=ModelClass.CreateModel;
end;



end.

