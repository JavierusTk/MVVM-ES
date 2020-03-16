unit Informe_View;

interface

uses
  Informe_ViewModel_Implementation,
  Classes, Controls, Forms, StdCtrls, ExtCtrls, Buttons, ComCtrls, Graphics;

type
  TfmInforme_View = class(TForm)
    pnlGeneral: TPanel;
    Bevel2: TBevel;
    pnlOkCancel: TPanel;
    imgOK_CC_OkCancelPanel: TImage;
    imgCancel_CC_OkCancelPanel: TImage;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure evtCambiosEnView(Sender: TObject); virtual;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
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

class procedure TfmInforme_View.EmitirInforme(const InjectedViewModel:TInforme_ViewModel=nil);
var
  aView: TfmInforme_View;
begin
  Application.CreateForm(Self, aView);
  try
    if Assigned(InjectedViewModel) then
      aView.fViewModel:=InjectedViewModel
    else
      aView.fViewModel:=aView.ClaseInforme.Create;
    aView.ViewModel.Iniciar(aView.CambiosEnViewModel);
    aView.ViewModel.TickInforme:=aView.TickInforme;
    aView.ActualizarInterface;
    aView.ShowModal;
  except
    aView.Release;
  end
end;


procedure TfmInforme_View.btnOkClick(Sender: TObject);
begin
  if ViewModel.EmitirInformeOK then begin
    ViewModel.EmitirInforme;
  end;
  ModalResult:=mrOK;
end;


procedure TfmInforme_View.evtCambiosEnView(Sender: TObject);
begin
  CambiosEnView;
end;

procedure TfmInforme_View.ActualizarInterface;
begin
  btnOk.Enabled:=ViewModel.EmitirInformeOK;
end;

procedure TfmInforme_View.btnCancelClick(Sender: TObject);
begin
  Close;
end;


procedure TfmInforme_View.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmInforme_View.CambiosEnViewModel(Sender: TObject);
begin
  ActualizarInterface;
end;


procedure TfmInforme_View.CambiosEnView;
begin
  //Asignar datos de View a ViewModel
end;

function TfmInforme_View.ClaseInforme: TInforme_ViewModel_Class;
begin
  result:=TInforme_ViewModel;
end;

procedure TfmInforme_View.FormDestroy(Sender: TObject);
begin
  if Assigned(fViewModel) then begin
    fViewModel.Free;
    fViewModel:=nil;
  end;
end;

procedure TfmInforme_View.TickInforme(Sender: TObject);
begin
//  FormEspera.Avanzar;
end;



end.

