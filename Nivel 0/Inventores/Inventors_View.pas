unit Inventors_View;

interface

uses
  Inventores_ViewModel_Implementation,
  Windows, Classes, Controls, Forms, StdCtrls, ExtCtrls, Grids, Buttons;

type
  TfmInventores_View = class(TForm)
    pnlGeneral: TPanel;
    Bevel2: TBevel;
    pnlOkCancel: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    lbl1: TLabel;
    edtNombre: TEdit;
    lbl2: TLabel;
    edtApellidos: TEdit;
    lbl3: TLabel;
    edtNIF: TEdit;
    grdInventores: TDrawGrid;
    procedure OkClicked(Sender: TObject);
    procedure evtCambiosEnView(Sender: TObject); virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure grdInventoresDrawCell(Sender: TObject; ACol, ARow: Integer;Rect: TRect; State: TGridDrawState);
    procedure grdInventoresSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
  {$IFNDEF PRUEBAS}
    FormEspera: TfmEsperePorFavor;
  {$ENDIF}
    fViewModel: TInventores_ViewModel;
    procedure CambiosEnViewModel(Sender:TObject);
  protected
    procedure CambiosEnView; virtual;
    procedure ActualizarInterface; virtual;
    function ClaseViewModel:TInventores_ViewModel_Class; virtual;
    procedure Tick(Sender:TObject); virtual;
    property ViewModel:TInventores_ViewModel read fViewModel;
  public
    class procedure PresentarView(const InjectedViewModel:TInventores_ViewModel=nil);
  end;






implementation


{$R *.DFM}

{$IFNDEF PRUEBAS}
uses
  DialogsMAX;
{$ENDIF}

class procedure TfmInventores_View.PresentarView(const InjectedViewModel:TInventores_ViewModel=nil);
var
  aView: TfmInventores_View;
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
      aView.fViewModel:=aView.ClaseViewModel.Create;
    aView.ViewModel.Iniciar(aView.CambiosEnViewModel);
    aView.ViewModel.Tick:=aView.Tick;
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

procedure TfmInventores_View.CambiosEnView;
begin
  //Asignar datos de View a ViewModel
end;

function TfmInventores_View.ClaseViewModel: TInventores_ViewModel_Class;
begin
  result:=TInventores_ViewModel;
end;



procedure TfmInventores_View.OkClicked(Sender: TObject);
begin
  {$IFDEF PRUEBAS}
    if ViewModel.VistaOK then
      ViewModel.RealizarProceso;
    ModalResult:=mrOK;
  {$ELSE}
  FormEspera:=EsperaComenzarCreate('Realizando Proceso...');
  try
    FormEspera.AbortableRepetible;
    FormEspera.MostrarModal;
    ViewModel.EmitirInforme;
  finally
    FormEspera.Terminar;
  end;
  if PreguntaSN('¿ Desea realizar otro proceso ?') then
    OkCancelPanel.RemoveModalResult
  else
    ModalResult:=mrOk
  {$ENDIF}
end;


procedure TfmInventores_View.ActualizarInterface;
begin
  if grdInventores.RowCount<>ViewModel.InventoresCount then
    grdInventores.RowCount:=ViewModel.InventoresCount;
  {$IFDEF PRUEBAS}
  btnOk.Enabled:=ViewModel.VistaOK;
  {$ELSE}
  OkCancelPanel.OkEnabled:=ViewModel.VistaOK;
  {$ENDIF}
end;

procedure TfmInventores_View.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmInventores_View.CambiosEnViewModel(Sender: TObject);
begin
  ActualizarInterface;
end;


procedure TfmInventores_View.Tick(Sender: TObject);
begin
  {$IFNDEF PRUEBAS} 
  FormEspera.Avanzar;
  {$ENDIF} 
end;

procedure TfmInventores_View.FormDestroy(Sender: TObject);
begin
  if Assigned(fViewModel) then begin
    fViewModel.Free;
    fViewModel:=nil;
  end;
end;


procedure TfmInventores_View.evtCambiosEnView(Sender: TObject);
begin
  CambiosEnView;
end;

procedure TfmInventores_View.grdInventoresDrawCell(Sender: TObject; ACol,ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  NombreColumna: string;
  S: string;
begin
  Case ACol of
  0: NombreColumna:='ID';
  1: NombreColumna:='NOMBRE';
  2: NombreColumna:='INVENTO';
  3: NombreColumna:='ANYO';
  end;
  if ARow=0 then
    S:=NombreColumna
  else
    S:=ViewModel.ObtenValor(ARow-1,NombreColumna);
  grdInventores.Canvas.TextRect(Rect,Rect.Left,Rect.Top,S);
  if gdFocused in State then
    grdInventores.Canvas.DrawFocusRect(Rect);
end;

procedure TfmInventores_View.grdInventoresSelectCell(Sender: TObject; ACol,ARow: Integer; var CanSelect: Boolean);
begin
  LineaSeleccionada:=ARow;
end;

end.

