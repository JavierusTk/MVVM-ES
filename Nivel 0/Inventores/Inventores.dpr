program Inventores;

uses
  Forms,
  Inventors_View in 'Inventors_View.pas' {fmInventores_View},
  Inventores_ViewModel_Implementation in 'Inventores_ViewModel_Implementation.pas',
  Inventores_Model in 'Inventores_Model.pas' {dmInventores_Model};

{$R *.res}

begin
  Application.Initialize;
  TfmInventores_View.PresentarView;
  Application.Run;
end.
