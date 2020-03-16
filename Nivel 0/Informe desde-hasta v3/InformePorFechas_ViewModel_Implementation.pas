unit InformePorFechas_ViewModel_Implementation;

interface

uses
  Informe_Model,Informe_ViewModel_Implementation;

type
  TInformePorFechas_ViewModel = class(TInforme_ViewModel)
  private
    { Private declarations }
    fDesdeFecha: TDateTime;
    fHastaFecha: TDateTime;
    procedure SetDesdeFecha(const Value: TDateTime);
    procedure SetHastaFecha(const Value: TDateTime);
  protected
    function  GetEmitirInformeOK: boolean; override;
    function  ModelClass:TdmInforme_Model_Class; override;
    procedure AsignarPropiedadesModelo; override;
    procedure AsignacionesIniciales; override;
  public
    procedure Actualizar; virtual;
    property  DesdeFecha:TDateTime read fDesdeFecha write SetDesdeFecha;
    property  HastaFecha:TDateTime read fHastaFecha write SetHastaFecha;
  end;


implementation

uses
  InformePorFechas_Model,
  SysUtils;


procedure TInformePorFechas_ViewModel.Actualizar;
begin
  inherited;
end;

procedure TInformePorFechas_ViewModel.AsignacionesIniciales;
begin
  fDesdeFecha:=Date;
  fHastaFecha:=Date;
  inherited;
end;

procedure TInformePorFechas_ViewModel.AsignarPropiedadesModelo;
var
  M: TdmInformePorFechas_Model;
begin
  inherited;
  M:=(Model as TdmInformePorFechas_Model);
  M.DesdeFecha:=DesdeFecha;
  M.HastaFecha:=HastaFecha;
end;

function TInformePorFechas_ViewModel.GetEmitirInformeOK: boolean;
begin
  result:=(DesdeFecha<=HastaFecha)
          and inherited GetEmitirInformeOK;
end;

function TInformePorFechas_ViewModel.ModelClass: TdmInforme_Model_Class;
begin
  result:=TdmInformePorFechas_Model;
end;


procedure TInformePorFechas_ViewModel.SetDesdeFecha(const Value: TDateTime);
begin
  if fDesdeFecha<>Value then begin
    fDesdeFecha:=Value;
    CambioPropiedades;
  end;
end;

procedure TInformePorFechas_ViewModel.SetHastaFecha(const Value: TDateTime);
begin
  if fHastaFecha<>Value then begin
    fHastaFecha:=Value;
    CambioPropiedades;
  end;
end;

end.

