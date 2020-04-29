unit Inventores_Model;

interface

uses
{$IFDEF PRUEBAS}
  {$IFDEF VER130}
  Forms,
  {$ENDIF}
{$ENDIF}
  Classes;


type
  TInventor = class
    ID: integer;
    Nombre: string;
    Invento: string;
    Anyo: Integer;
    constructor Create(const aNombre,aInvento:string;const aAnyo: integer);
  end;

type
  TmvvmNotifyEvent = procedure (aSender:TObject) of object;
type
  TdmInventores_Model_Class = class of TdmInventores_Model;
  TdmInventores_Model = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    fTick: TmvvmNotifyEvent;
    fListaInventores: TList;
    function BuscaInventorID(const aID: integer): integer;
    procedure AddInventor(const aNombre,aInvento:string;const aAnyo: integer);
  protected
    procedure Tick;
    procedure ProducirResultado;  virtual; {$IFNDEF PRUEBAS} abstract;  {$ENDIF}
  public
    class function CreateModel:TdmInventores_Model;
    procedure RealizarProceso(const aTick:TmvvmNotifyEvent);
    procedure AppendInventor(const aInventor:TInventor);
    procedure ActualizarInventor(aInventor:TInventor);
    function LeerInventor(const aID:integer):TInventor;
    function LeerInventorIDX(const IDX:integer):TInventor;
    procedure DestruirInventor(const ID:integer);
    function InventoresCuenta:integer;
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
x  FormMax;
{$ENDIF}

procedure TdmInventores_Model.RealizarProceso(const aTick:TmvvmNotifyEvent);
begin
  fTick:=aTick;
  ProducirResultado;
end;

class function TdmInventores_Model.CreateModel:TdmInventores_Model;
begin
{$IFDEF PRUEBAS}
  Application.CreateForm(Self,result);
{$ELSE}
  AppCreateDatamodule(Self,result);
{$ENDIF}
end;

{$IFDEF PRUEBAS}
procedure TdmInventores_Model.ProducirResultado;
begin
  ShowMessage('RESULTADO');
end;
{$ENDIF}

procedure TdmInventores_Model.Tick;
begin
  if Assigned(fTick) then
    fTick(Self);
end;

procedure TdmInventores_Model.DataModuleCreate(Sender: TObject);
begin
  fListaInventores:=TList.Create;
  AddInventor('JACQUES E. BRANDENBERGER','CELOFÁN',1911);
  AddInventor('JUAN DE LA CIERVA','AUTOGIRO',1923);
  AddInventor('JOHN LOGIE BAIRD','TELEVISIÓN',1924);
  AddInventor('ERIK ROTHEIM','AEROSOL',1927);
  AddInventor('ALEXANDER FLEMING','PENICILINA',1928);
  AddInventor('MAX KNOLL - ERNST RUSKA','MICROSCOPIO ELECTRÓNICO',1931);
  AddInventor('ROBERT WATSON-WATT','RADAR',1935);
  AddInventor('WALLACE CAROTHERS','NAILON',1935);
  AddInventor('GEORGE Y LADISLAO BIRO','BOLÍGRAFO',1938);
  AddInventor('JOHN PRESPER ECKERT, JOHN W. MAUCHLY','ORDENADOR ELECTRÓNICO DIGITAL',1946);
  AddInventor('NARINDER SINGH KAPANY','FIBRA ÓPTICA',1955);
  AddInventor('MANUEL JALÓN COROMINAS','FREGONA',1956);
  AddInventor('CIENTÍFICOS SOVIÉTICOS','SATÉLITE ARTIFICIAL',1957);
  AddInventor('THEODORE MAIMAN, CHARLES H. TOWNES, ARTHUR L. SCHAWLOW','LÁSER',1960);
  AddInventor('MARCIAN EDWARD HOFF','MICROPROCESADOR',1971);
  AddInventor('ROBERT K. JARVIK','CORAZÓN ARTIFICIAL',1982);
end;

procedure TdmInventores_Model.DataModuleDestroy(Sender: TObject);
begin
  while FListaInventores.Count<>0 do
    DestruirInventor(0);
end;

procedure TdmInventores_Model.ActualizarInventor(aInventor: TInventor);
var
  InventorActual: TInventor;
begin
  InventorActual:=LeerInventor(aInventor.ID);
  InventorActual.Nombre:=aInventor.Nombre;
  InventorActual.Invento:=aInventor.Invento;
  InventorActual.Anyo:=aInventor.Anyo;
end;

procedure TdmInventores_Model.AppendInventor(const aInventor: TInventor);
var
  aID: integer;
  i: integer;
begin
  aID:=0;
  for i:=0 to FListaInventores.Count-1 do begin
    if TInventor(FListaInventores[i]).ID>aID then
      aID:=TInventor(FListaInventores[i]).ID;
  end;
  Inc(aID);
  aInventor.ID:=aID;
  FListaInventores.Add(aInventor);
end;

function TdmInventores_Model.BuscaInventorID(const aID:integer):integer;
var
  i: integer;
begin
  for i:=0 to FListaInventores.Count-1 do begin
    if TInventor(FListaInventores[i]).ID=aID then begin
      result:=i;
      EXIT;
    end;
  end;
  result:=-1;
end;

procedure TdmInventores_Model.DestruirInventor(const ID: integer);
var
  idx: integer;
begin
  idx:=BuscaInventorID(ID);
  TInventor(FListaInventores[idx]).Free;
  FListaInventores.Delete(idx);
end;

function TdmInventores_Model.LeerInventor(const aID: integer): TInventor;
var
  idx: integer;
begin
  idx:=BuscaInventorID(aID);
  if idx=-1 then
    result:=nil
  else
    result:=TInventor(FListaInventores[idx]);
end;

procedure TdmInventores_Model.AddInventor(const aNombre,aInvento:string;const aAnyo: integer);
begin
  AppendInventor(TInventor.Create(aNombre,aInvento,aAnyo));
end;

{ TInventor }

constructor TInventor.Create(const aNombre,aInvento:string;const aAnyo: integer);
begin
  inherited Create;
  Nombre:=aNombre;
  Invento:=aInvento;
  Anyo:=aAnyo;
end;

function TdmInventores_Model.InventoresCuenta: integer;
begin
  result:=fListaInventores.Count;
end;

function TdmInventores_Model.LeerInventorIDX(const IDX: integer): TInventor;
begin
  if idx=-1 then
    result:=nil
  else
    result:=TInventor(FListaInventores[idx]);
end;

end.

