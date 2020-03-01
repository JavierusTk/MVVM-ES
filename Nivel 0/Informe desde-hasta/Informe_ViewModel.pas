unit Informe_ViewModel;

interface

uses
  Classes;

type
  IInforme_ViewModel = interface
    procedure Iniciar(const aOnCambiosEnViewModel:TNotifyEvent;const aDesde,aHasta:TDateTime;const aNombrePlantilla:string);
    procedure EmitirInforme(const TickInforme:TNotifyEvent);
    procedure Actualizar(const aDesdeFecha,aHastaFecha:TDateTime);
    function  GetDesdeFecha:TDateTime;
    procedure SetDesdeFecha(const Value: TDateTime);
    function  GetHastaFecha:TDateTime;
    procedure SetHastaFecha(const Value: TDateTime);
    procedure CambioPropiedades;
    function GetEmitirInformeOK:boolean;
    property  DesdeFecha:TDateTime read GetDesdeFecha write SetDesdeFecha;
    property  HastaFecha:TDateTime read GetHastaFecha write SetHastaFecha;
    property EmitirInformeOK:boolean read GetEmitirInformeOK;
  end;


implementation


end.

