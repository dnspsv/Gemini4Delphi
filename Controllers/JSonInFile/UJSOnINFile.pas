unit UJSOnINFile;

interface

uses
  System.SysUtils, System.Classes, System.JSON,System.IOUtils;

type
  TJSOnINFile = class
  private
    FJSONObject: TJSONObject;
  public
    constructor Create(FileName : String = '');
    destructor Destroy; override;
    procedure AddString(const Key, Value: string);
    procedure AddInteger(const Key: string; Value: Integer);
    function GetStringValue(const Key : string):String;
    procedure SaveToFile(const FileName: string);
    procedure DeleteToFile(const FileName: string);
    function GetDoubleValue(const Key: string): Double;
    function GetIntegerValue(const Key: string):Integer;
  end;

implementation

uses
  Vcl.Dialogs;

{ TJSONWriter }

constructor TJSONINFile.Create(FileName: String = '');
var
  JSONText: string;
begin
  FJSONObject := TJSONObject.Create;
  if FileName <> '' then
  begin
    JSONText    := TFile.ReadAllText(fileName, TEncoding.UTF8);
    FJSONObject := TJSONObject.ParseJSONValue(JSONText) as TJSONObject;
  end;
end;

procedure TJSOnINFile.DeleteToFile(const FileName: string);
begin
  Tfile.Delete(FileName);
end;

destructor TJSOnINFile.Destroy;
begin
  FJSONObject.Free;
  inherited;
end;

function TJSOnINFile.GetStringValue(const Key: string): String;
begin
  Result := FJSONObject.GetValue<String>(key);
end;

function TJSOnINFile.GetDoubleValue(const Key: string): Double;
begin
  Result := FJSONObject.GetValue<Double>(key);
end;

function TJSOnINFile.GetIntegerValue(const Key: string): Integer;
begin
  Result := FJSONObject.GetValue<Integer>(key);
end;

procedure TJSOnINFile.AddString(const Key, Value: string);
begin
  FJSONObject.AddPair(Key, Value);
end;

procedure TJSOnINFile.AddInteger(const Key: string; Value: Integer);
begin
  FJSONObject.AddPair(Key, TJSONNumber.Create(Value));
end;

procedure TJSOnINFile.SaveToFile(const FileName: string);
begin
  TFile.WriteAllText(FileName, FJSONObject.ToString);
end;

end.
