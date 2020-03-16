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

procedure TfmInformePorFechas_View.ActualizarInterface;
begin
  dtpDesdeFecha.Date:=(ViewModel as TInformePorFechas_ViewModel).DesdeFecha;
  dtpHastaFecha.Date:=(ViewModel as TInformePorFechas_ViewModel).HastaFecha;
  inherited;
end;

procedure TfmInformePorFechas_View.CambiosEnView;
begin
  (ViewModel as TInformePorFechas_ViewModel).DesdeFecha:=dtpDesdeFecha.Date;
  (ViewModel as TInformePorFechas_ViewModel).HastaFecha:=dtpHastaFecha.Date;
  inherited;
end;

function TfmInformePorFechas_View.ClaseInforme: TInforme_ViewModel_Class;
begin
  result:=TInformePorFechas_ViewModel;
end;

end.
