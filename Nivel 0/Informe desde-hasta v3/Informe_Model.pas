unit Informe_Model;

interface

uses
{$IFDEF PRUEBAS}
  {$IFDEF VER130}
  Forms,
  {$ENDIF}
{$ENDIF}
  Classes;

type
  TmvvmNotifyEvent = procedure (aSender:TObject) of object;
type
  TdmInforme_Model_Class = class of TdmInforme_Model;
  TdmInforme_Model = class(TDataModule)
  private
    fTickInforme: TmvvmNotifyEvent;
  protected
    procedure Tick;
    procedure EmitirResultado;  virtual; {$IFNDEF PRUEBAS} abstract;  {$ENDIF}
  public
    class function CreateModel:TdmInforme_Model;
    procedure EmitirInforme(const aTickInforme:TmvvmNotifyEvent);
  end;




implementation


{$R *.DFM}

uses
{$IFDEF PRUEBAS}
  {$IFNDEF VER130}
  Forms,
  {$ENDIF}
  Dialogs;
{$ELSE}
  FormMax;
{$ENDIF}

procedure TdmInforme_Model.EmitirInforme(const aTickInforme:TmvvmNotifyEvent);
begin
  fTickInforme:=aTickInforme;
  EmitirResultado;
end;

class function TdmInforme_Model.CreateModel:TdmInforme_Model;
begin
{$IFDEF PRUEBAS}
  Application.CreateForm(Self,result)
{$ELSE}
  AppCreateDatamodule(Self,result);
{$ENDIF}
end;

{$IFDEF PRUEBAS}
procedure TdmInforme_Model.EmitirResultado;
begin
  ShowMessage('RESULTADO');
end;
{$ENDIF}

procedure TdmInforme_Model.Tick;
begin
  if Assigned(fTickInforme) then
    fTickInforme(Self);  
end;

end.

