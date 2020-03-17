program Informe;

uses
  Forms,
  Informe_Model in 'Informe_Model.pas' {dmInforme_Model: TDataModule},
  Informe_View in 'Informe_View.pas' {fmInforme_View},
  InformePorFechas_ViewModel_Implementation in 'InformePorFechas_ViewModel_Implementation.pas',
  InformePorFechas_View in 'InformePorFechas_View.pas' {fmInformePorFechas_View},
  InformePorFechas_Model in 'InformePorFechas_Model.pas' {dmInformePorFechas_Model: TDataModule},
  Informe_ViewModel_Implementation in 'Informe_ViewModel_Implementation.pas';

{$R *.res}

begin
  Application.Initialize;
  TfmInformePorFechas_View.EmitirInforme;
  Application.Run;
end.
