unit Informe_View;

interface

uses
  Windows, Variants, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, FormMax,
  ExtCtrls, CheckButton, ccDBeditPanelLabeled, ListBoxMax,
  DBFiltro, ccDateRangePeriod, ccSelectorListados, Boxes,
  ccOkFilterCancelPanel, StdCtrls, StdCtrlsMax, PanelMax, ccOkCancelPanel,
  EsperePorFavor,
  Informe_ViewModel,
  Informe_ViewModel_Implementation;

type
  TfmInforme_View = class(TFormMax)
    OkCancelPanel: TOkCancelPanel;
    PanelMAX2: TPanelMAX;
    Bevel3: TBevel;
    Bevel2: TBevel;
    edtFechas: TDateRangePeriod;
    LabelMax1: TLabelMax;
    Bevel1: TBevel;
    procedure OkCancelPanelOkClicked(Sender: TObject);
    procedure evtReajustarBotones(Sender: TObject);
    procedure edtRevisarDatos(Sender: TObject);
    procedure FormMaxCreate(Sender: TObject);
    procedure FormMaxClose(Sender: TObject; var Action: TCloseAction);
    procedure FormMaxDestroy(Sender: TObject);
  private
    { Private declarations }
    FormEspera: TfmEsperePorFavor;
    fViewModel: TdmInforme_ViewModel;
    ViewModel: TdmInforme_ViewModel;
    procedure CambiosEnViewModel(Sender:TObject);
    procedure ReajustarBotones;
    procedure TickInforme(Sender:TObject);
  end;



procedure Informe(const aDesdeFecha,aHastaFecha:TDateTime;const aNombrePlantilla:string);



implementation



uses
  CompatVarios, TypesMax, DialogsMax, UtilFechas;

{$R *.DFM}

procedure Informe(const aDesdeFecha,aHastaFecha:TDateTime;const aNombrePlantilla:string);
var
  AForm: TfmInforme_View;
begin
  AppCreateForm(TfmInforme_View, AForm);
  with AForm do begin
    try
      edtFechas.DesdeFecha:=ViewModel.DesdeFecha;
      edtFechas.HastaFecha:=ViewModel.HastaFecha;
      ViewModel.Iniciar(CambiosEnViewModel,aDesdeFecha,aHastaFecha,aNombrePlantilla);
      ReajustarBotones;
      ShowFormCyberMax(AForm,True);
    except
      Release;
    end
  end
end;



procedure TfmInforme_View.OkCancelPanelOkClicked(Sender: TObject);
begin
  FormEspera:=EsperaComenzarCreate('Calculando Informe...');
  try
    FormEspera.AbortableRepetible;
    FormEspera.MostrarModal;
    ViewModel.EmitirInforme(TickInforme)
  finally
    FormEspera.Terminar;
  end;
  if PreguntaSN('¿ Desea emitir otro Informe ?') then
    OkCancelPanel.RemoveModalResult
  else
    ModalResult:=mrOk
end;


procedure TfmInforme_View.evtReajustarBotones(Sender: TObject);
begin
  ReajustarBotones;
end;

procedure TfmInforme_View.edtRevisarDatos(Sender: TObject);
begin
  ReajustarBotones;
end;

procedure TfmInforme_View.ReajustarBotones;
begin
  ViewModel.Actualizar(edtFechas.DesdeFecha,edtFechas.HastaFecha);
  OkCancelPanel.OkEnabled:=ViewModel.EmitirInformeOK;
end;


procedure TfmInforme_View.FormMaxCreate(Sender: TObject);
begin
  AppCreateDatamodule(TdmInforme_ViewModel,fViewModel);
  ViewModel:=fViewModel;
end;

procedure TfmInforme_View.FormMaxClose(Sender: TObject;var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmInforme_View.CambiosEnViewModel(Sender: TObject);
begin
  if edtFechas.DesdeFecha<>ViewModel.DesdeFecha then
    edtFechas.DesdeFecha:=ViewModel.DesdeFecha;
  if edtFechas.HastaFecha<>ViewModel.HastaFecha then
    edtFechas.HastaFecha:=ViewModel.HastaFecha;
end;


procedure TfmInforme_View.FormMaxDestroy(Sender: TObject);
begin
  FreeAndNil(fViewModel);
end;

procedure TfmInforme_View.TickInforme(Sender: TObject);
begin
  FormEspera.Avanzar;
end;

end.

