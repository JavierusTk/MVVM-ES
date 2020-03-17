unit InformePorFechas_View;

interface

uses
  Informe_View,
  Informe_ViewModel_implementation,
  ComCtrls, StdCtrls, Buttons, Graphics, ExtCtrls, Controls, Classes;


type
  TfmInformePorFechas_View = class(TfmInforme_View)
    pnlFechas: TPanel;
    lblDesdeFecha: TLabel;
    lblHastaFecha: TLabel;
    dtpDesdeFecha: TDateTimePicker;
    dtpHastaFecha: TDateTimePicker;
  protected
    function ClaseInforme:TInforme_ViewModel_Class; override;
    procedure ActualizarInterface; override;
    procedure CambiosEnView; override;
  end;


implementation

{$R *.dfm}

uses
  InformePorFechas_ViewModel_implementation;


function TfmInformePorFechas_View.ClaseInforme: TInforme_ViewModel_Class;
begin
  result:=TInformePorFechas_ViewModel;
end;

procedure TfmInformePorFechas_View.ActualizarInterface;
var
  VM: TInformePorFechas_ViewModel;
begin
  inherited;
  VM:=(ViewModel as TInformePorFechas_ViewModel);
  //VM->UI: Asignar las propiedades de VM a los elementos del Interfaz de Usuario
  {$IFDEF PRUEBAS}
  if dtpDesdeFecha.Date<>VM.DesdeFecha then
    dtpDesdeFecha.Date:=VM.DesdeFecha;
  if dtpHastaFecha.Date<>VM.HastaFecha then
    dtpHastaFecha.Date:=VM.HastaFecha;
  {$ELSE}
  if edtFechas.DesdeFecha<>VM.DesdeFecha then
    edtFechas.DesdeFecha:=VM.DesdeFecha;
  if edtFechas.HastaFecha<>VM.HastaFecha then
    edtFechas.HastaFecha:=VM.HastaFecha;
  {$ENDIF}
end;

procedure TfmInformePorFechas_View.CambiosEnView;
var
  VM: TInformePorFechas_ViewModel;
begin
  inherited;
  VM:=(ViewModel as TInformePorFechas_ViewModel);
  //UI->VM: Asignar los datos de los elementos del UI a las propiedades del VM
  {$IFDEF PRUEBAS}
  VM.DesdeFecha:=dtpDesdeFecha.Date;
  VM.HastaFecha:=dtpHastaFecha.Date;
  {$ELSE}
  VM.DesdeFecha:=edtFechas.DesdeFecha;
  VM.HastaFecha:=edtFechas.HastaFecha;
  {$ENDIF}
end;


end.
