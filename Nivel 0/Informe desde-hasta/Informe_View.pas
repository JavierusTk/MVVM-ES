unit Informe_View;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, Buttons, ComCtrls,
//  EsperePorFavor,
  Informe_ViewModel,
  Informe_ViewModel_Implementation, Graphics;

type
  TfmInforme_View = class(TForm)
    pnlGeneral: TPanel;
    Bevel2: TBevel;
    lbl1: TLabel;
    pnlFechas: TPanel;
    lblDesdeFecha: TLabel;
    lblHastaFecha: TLabel;
    edtDesdeFecha: TDateTimePicker;
    edtHastaFecha: TDateTimePicker;
    pnlOkCancel: TPanel;
    imgOK_CC_OkCancelPanel: TImage;
    imgCancel_CC_OkCancelPanel: TImage;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnOkClick(Sender: TObject);
    procedure evtRevisarDatos(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
//    FormEspera: TfmEsperePorFavor;
    fViewModel: TInforme_ViewModel;
    ViewModel: TInforme_ViewModel;
    procedure CambiosEnViewModel(Sender:TObject);
    procedure RevisarDatos;
    procedure TickInforme(Sender:TObject);
  end;



procedure Informe(const aDesdeFecha,aHastaFecha:TDateTime;const aNombrePlantilla:string);



implementation


{$R *.DFM}

procedure Informe(const aDesdeFecha,aHastaFecha:TDateTime;const aNombrePlantilla:string);
var
  AForm: TfmInforme_View;
begin
  Application.CreateForm(TfmInforme_View, AForm);
  with AForm do begin
    try
      ViewModel.TickInforme:=AForm.TickInforme;
      ViewModel.Iniciar(CambiosEnViewModel,aDesdeFecha,aHastaFecha,aNombrePlantilla);
      RevisarDatos;
      AForm.ShowModal;
    except
      Release;
    end
  end
end;



procedure TfmInforme_View.btnOkClick(Sender: TObject);
begin
  if ViewModel.EmitirInformeOK then begin
//    FormEspera:=EsperaComenzarCreate('Calculando Informe...');
    try
//      FormEspera.AbortableRepetible;
//      FormEspera.MostrarModal;
      ViewModel.EmitirInforme;
    finally
//      FormEspera.Terminar;
    end;
  end;
  ModalResult:=mrOK;
end;


procedure TfmInforme_View.evtRevisarDatos(Sender: TObject);
begin
  RevisarDatos;
end;

procedure TfmInforme_View.RevisarDatos;
begin
  ViewModel.Actualizar(edtDesdeFecha.Date,edtHastaFecha.Date);
  btnOk.Enabled:=ViewModel.EmitirInformeOK;
end;


procedure TfmInforme_View.FormCreate(Sender: TObject);
begin
  fViewModel:=TInforme_ViewModel.Create;
  ViewModel:=fViewModel;
end;

procedure TfmInforme_View.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmInforme_View.CambiosEnViewModel(Sender: TObject);
begin
  if edtDesdeFecha.Date<>ViewModel.DesdeFecha then
    edtDesdeFecha.Date:=ViewModel.DesdeFecha;
  if edtHastaFecha.Date<>ViewModel.HastaFecha then
    edtHastaFecha.Date:=ViewModel.HastaFecha;
end;


procedure TfmInforme_View.FormDestroy(Sender: TObject);
begin
  fViewModel.Free;
  fViewModel:=nil;
end;

procedure TfmInforme_View.TickInforme(Sender: TObject);
begin
//  FormEspera.Avanzar;
end;

end.

