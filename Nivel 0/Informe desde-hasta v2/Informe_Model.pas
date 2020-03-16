unit Informe_Model;

interface

uses
  Classes;

type
  TInforme_Propiedades_Class = class of TInforme_Propiedades;
  TInforme_Propiedades = class
  end;
  TmvvmNotifyEvent = procedure (aSender:TObject) of object;
type
  TdmInforme_Model_Class = class of TdmInforme_Model;
  TdmInforme_Model = class(TDataModule)
  private
    fTickInforme: TmvvmNotifyEvent;
  protected
    procedure Tick;
    procedure EmitirResultado(const aPropiedades: TInforme_Propiedades);  virtual; //abstract;
    class function ClasePropiedadesValidas:TInforme_Propiedades_Class; virtual;
  public
    class function CreateModel:TdmInforme_Model;
    procedure EmitirInforme(const aTickInforme:TmvvmNotifyEvent;const aPropiedades: TInforme_Propiedades);
    class procedure EmitirInformeDirecto(const aPropiedades: TInforme_Propiedades);
  end;




implementation


{$R *.DFM}

uses
  Dialogs,
  Forms;

procedure TdmInforme_Model.EmitirInforme(const aTickInforme:TmvvmNotifyEvent;const aPropiedades: TInforme_Propiedades);
begin
  fTickInforme:=aTickInforme;
  EmitirResultado(aPropiedades);
end;



class function TdmInforme_Model.CreateModel:TdmInforme_Model;
begin
{$IFDEF MAX}
  AppCreateDatamodule(Self,result);
{$ELSE}
  Application.CreateForm(Self,result)
{$ENDIF}
end;


class procedure TdmInforme_Model.EmitirInformeDirecto(const aPropiedades: TInforme_Propiedades);
var
  fModel: TdmInforme_Model;
begin
  fModel:=CreateModel;
  try
    fModel.EmitirInforme(nil,aPropiedades);
  finally
    fModel.Free;
  end;
end;


procedure TdmInforme_Model.EmitirResultado(const aPropiedades: TInforme_Propiedades);
begin
  ShowMessage('RESULTADO');
end;

class function TdmInforme_Model.ClasePropiedadesValidas: TInforme_Propiedades_Class;
begin
  result:=TInforme_Propiedades;
end;

procedure TdmInforme_Model.Tick;
begin
  if Assigned(fTickInforme) then
    fTickInforme(Self);  
end;

end.

