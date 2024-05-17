unit UApiClientUnit;

interface

uses
  System.SysUtils,
  System.Classes,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Response.Adapter,
  REST.Json,
  REST.Types,
  System.JSON,
  Data.DB,
  Datasnap.DBClient,
  vcl.Dialogs,
  UFileLog;

type
  TApiClient = class
  private
    FLogFile: TFileLog;
    FRestClient: TRESTClient;
    FRestRequest: TRESTRequest;
    FRestResponse: TRESTResponse;
    FDataSetAdapter: TRESTResponseDataSetAdapter;
    procedure SetupRequest;

  public
    constructor Create(const BaseURL: string);
    destructor Destroy; override;

    function Get(const Endpoint: string; dados: TClientDataSet; ElementContent:string=''): string;
    function Post(const Endpoint: string; const RequestBody: string; Token:string = ''): string;
    function Update(const Endpoint: string; const RequestBody: string): string;
    function Delete(const Endpoint: string): string;

  end;

implementation

constructor TApiClient.Create(const BaseURL: string);
begin
  FLogFile        := TFileLog.Create;
  FRestClient     := TRESTClient.Create(BaseURL);
  FRestRequest    := TRESTRequest.Create(nil);
  FRestResponse   := TRESTResponse.Create(nil);
  FDataSetAdapter := TRESTResponseDataSetAdapter.Create(nil);

  FRestRequest.Client       := FRestClient;
  FRestRequest.Response     := FRestResponse;

  FDataSetAdapter.Response  := FRestResponse;
  FRestResponse.ContentType := 'application/json';
end;

destructor TApiClient.Destroy;
begin
  FLogFile.Free;
  FRestClient.Free;
  FRestRequest.Free;
  FRestResponse.Free;
  FDataSetAdapter.Free;
  inherited;
end;

procedure TApiClient.SetupRequest;
begin
  FRestRequest.Params.Clear;
  FRestRequest.Params.AddItem('Content-Type', 'application/json', TRESTRequestParameterKind.pkHTTPHEADER);
end;

function TApiClient.Get(const Endpoint: string; dados: TClientDataSet; ElementContent:string=''): string;
begin
  SetupRequest;

  FRestRequest.Method      := TRESTRequestMethod.rmGET;
  FRestRequest.Resource    := Endpoint;
  FRestRequest.ReadTimeout := 10000;
  FDataSetAdapter.Dataset  := dados;

  FRestResponse.ContentType := 'application/json; charset=UTF-8';
  FRestResponse.RootElement := ElementContent;

  try
    FRestRequest.Execute;
  except on E: ERestException do
    Result := '0';
  end;

  Result := FRestResponse.Content;

  FLogFile.GravaLog(Result);
end;

function TApiClient.Post(const Endpoint: string; const RequestBody: string; Token:string = ''): string;
var I : integer;
begin
  SetupRequest;
  FRestRequest.Method := TRESTRequestMethod.rmPOST;
  FRestRequest.Resource := Endpoint;
  FRestRequest.ClearBody;

  FRestResponse.RootElement := '';

  with FRESTRequest.Params.AddItem do
  begin
    ContentType:= ctAPPLICATION_JSON;
    Kind := pkREQUESTBODY;
    name :=  'body';
    Value:= RequestBody;
    //Options := [TRESTRequestParameterOption.poDoNotEncode];
  end;

  FRestRequest.Execute;
  Result := FRestResponse.Content;
  FLogFile.GravaLog(Result);
end;

function TApiClient.Update(const Endpoint: string; const RequestBody: string): string;
begin
  SetupRequest;
  FRestRequest.Method := TRESTRequestMethod.rmPUT;
  FRestRequest.Resource := Endpoint;
  FRestRequest.AddBody(RequestBody, TRESTContentType.ctAPPLICATION_JSON);
  FRestRequest.Execute;
  Result := FRestResponse.Content;
  FLogFile.GravaLog(Result);
end;

function TApiClient.Delete(const Endpoint: string): string;
begin
  SetupRequest;
  FRestRequest.Method := TRESTRequestMethod.rmDELETE;
  FRestRequest.Resource := Endpoint;
  FRestRequest.Execute;
  Result := FRestResponse.Content;
  FLogFile.GravaLog(Result);
end;

end.

