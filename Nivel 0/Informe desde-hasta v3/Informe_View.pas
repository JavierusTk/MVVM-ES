unit Informe_View;

interface

uses
  Informe_ViewModel_Implementation,
  {$IFDEF PRUEBAS}
  Buttons, ComCtrls, Graphics,
  {$ELSE}
  SysUtils, EsperePorFavor,
  FormMax, StdCtrlsMax, PanelMax, Boxes, ccOkCancelPanel, StdCtrls,
  Controls, ExtCtrls, Classes
  {$ENDIF}
  Classes, Controls, Forms, StdCtrls, ExtCtrls;

type
//  TfmInforme_View = class(TForm)
  TfmInforme_View = class(TFormMax)
    pnlGeneral: TPanel;
    Bevel2: TBevel;
    pnlOkCancel: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure OkClicked(Sender: TObject);
    procedure evtCambiosEnView(Sender: TObject); virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
  {$IFNDEF PRUEBAS}
    FormEspera: TfmEsperePorFavor;
  {$ENDIF}
    fViewModel: TInforme_ViewModel;
    procedure CambiosEnViewModel(Sender:TObject);
  protected
    procedure CambiosEnView; virtual;
    procedure ActualizarInterface; virtual;
    function ClaseInforme:TInforme_ViewModel_Class; virtual;
    procedure TickInforme(Sender:TObject); virtual;
    property ViewModel:TInforme_ViewModel read fViewModel;//IInforme_ViewModel;
  public
    class procedure EmitirInforme(const InjectedViewModel:TInforme_ViewModel=nil);
  end;






implementation


{$R *.DFM}

{$IFNDEF PRUEBAS}
uses
  DialogsMAX;
{$ENDIF}

class procedure TfmInforme_View.EmitirInforme(const InjectedViewModel:TInforme_ViewModel=nil);
var
  aView: TfmInforme_View;
begin
  {$IFDEF PRUEBAS}
  Application.CreateForm(Self, aView);
  {$ELSE}
  AppCreateForm(Self, aView);
  {$ENDIF}
  try
    if Assigned(InjectedViewModel) then
      aView.fViewModel:=InjectedViewModel
    else
      aView.fViewModel:=aView.ClaseInforme.Create;
    aView.ViewModel.Iniciar(aView.CambiosEnViewModel);
    aView.ViewModel.TickInforme:=aView.TickInforme;
    aView.ActualizarInterface;
    {$IFDEF PRUEBAS}
    aView.ShowModal;
    {$ELSE}
    ShowFormCyberMax(aView,True);
    {$ENDIF}
  except
    aView.Release;
  end
end;

procedure TfmInforme_View.CambiosEnView;
begin
  //Asignar datos de View a ViewModel
end;

function TfmInforme_View.ClaseInforme: TInforme_ViewModel_Class;
begin
  result:=TInforme_ViewModel;
end;



procedure TfmInforme_View.OkClicked(Sender: TObject);
begin
  {$IFDEF PRUEBAS}
    if ViewModel.EmitirInformeOK then
      ViewModel.EmitirInforme;
    ModalResult:=mrOK;
  {$ELSE}
  FormEspera:=EsperaComenzarCreate('Calculando Informe...');
  try
    FormEspera.AbortableRepetible;
    FormEspera.MostrarModal;
    ViewModel.EmitirInforme;
  finally
    FormEspera.Terminar;
  end;
  if PreguntaSN('¿ Desea emitir otro Informe ?') then
    OkCancelPanel.RemoveModalResult
  else
    ModalResult:=mrOk
  {$ENDIF}
end;


procedure TfmInforme_View.ActualizarInterface;
begin
  {$IFDEF PRUEBAS}
  btnOk.Enabled:=ViewModel.EmitirInformeOK;
  {$ELSE}
  OkCancelPanel.OkEnabled:=ViewModel.EmitirInformeOK;
  {$ENDIF}
end;

procedure TfmInforme_View.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmInforme_View.CambiosEnViewModel(Sender: TObject);
begin
  ActualizarInterface;
end;


procedure TfmInforme_View.TickInforme(Sender: TObject);
begin
  {$IFNDEF PRUEBAS} 
  FormEspera.Avanzar;
  {$ENDIF} 
end;

procedure TfmInforme_View.FormDestroy(Sender: TObject);
begin
  if Assigned(fViewModel) then begin
    fViewModel.Free;
    fViewModel:=nil;
  end;
end;


procedure TfmInforme_View.evtCambiosEnView(Sender: TObject);
begin
  CambiosEnView;
end;

end.

