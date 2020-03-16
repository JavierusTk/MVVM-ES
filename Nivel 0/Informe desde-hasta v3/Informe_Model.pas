unit Informe_Model;

interface

uses
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
    procedure EmitirResultado;  virtual; //abstract;
  public
    class function CreateModel:TdmInforme_Model;
    procedure EmitirInforme(const aTickInforme:TmvvmNotifyEvent);
  end;




implementation


{$R *.DFM}

uses
  Dialogs,
  Forms;

procedure TdmInforme_Model.EmitirInforme(const aTickInforme:TmvvmNotifyEvent);
begin
  fTickInforme:=aTickInforme;
  EmitirResultado;
end;

class function TdmInforme_Model.CreateModel:TdmInforme_Model;
begin
{$IFDEF MAX}
  AppCreateDatamodule(Self,result);
{$ELSE}
  Application.CreateForm(Self,result)
{$ENDIF}
end;

procedure TdmInforme_Model.EmitirResultado;
begin
  ShowMessage('RESULTADO');
end;

procedure TdmInforme_Model.Tick;
begin
  if Assigned(fTickInforme) then
    fTickInforme(Self);  
end;

end.

