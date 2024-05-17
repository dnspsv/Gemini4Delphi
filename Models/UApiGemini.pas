{
  ## Classe desenvolvida para comunicação entre aplicações Delphi
  com o Gemini Google AI.

  ## Class developed for communication between Delphi applications
  with Gemini Google AI.

  Developer:
  Denis Roberto de Castro
  dns_spsv@hotmail.com
}
unit UApiGemini;

interface

uses
  UApiClientUnit,
  System.SysUtils,
  UJSOnINFile,
  Datasnap.DBClient,
  System.JSON,
  System.StrUtils, System.Classes;


Type TUApiGemini = class
  private
    AApiClient : TApiClient;
    AApiKey    : String;
    AURLServer : String;

    //configurações do servidor
    ADiscovery : String;
    AModel     : String;

    //**generationConfig
    ATemperature     : Double;
    ATopK            : Integer;
    ATopP            : Double;
    AMaxOutputTokens : String;
    AStopSequences   : TJSONArray;

    //**safetySettings
    AHC_HARASSMENT : String;
    AHC_HATE_SPEECH: String;
    AHC_SEXUALLY_EXPLICIT: String;
    AHC_DANGEROUS_CONTENT: String;

    //**systemInstruction
    ASysInstruction_Role: String;
    ASysInstruction_Text: String;

    //SafetySettings Options
    function GetSafetySettingsOptions: TStringList;

    procedure LoadConfig;
    procedure SetDefaultConfig;
    procedure GetFileConfig;
    procedure SetFileConfig;

    function CreateAContents(Role, Text: string): TJSONObject;
    function CreateAGenerationConfig: TJSONObject;
    function CreateASafetySettings: TJSONArray;
    function CreateAGenerateContent(AText:String): String;



  public
    constructor Create(const ApiKey: string);
    destructor Destroy; override;
    procedure Models_List(DataReturn : TClientDataSet);
    function Models_GenerateContent(AText:String): String;

    procedure ClearConfiguration;

    //**Configurações do modelo Ai
    //configurações do servidor
    property FDiscovery : String read ADiscovery write ADiscovery;
    property FModel     : String read AModel write AModel;

    //**generationConfig
    //Opções de configuração para geração e saídas de modelos.
    property FTemperature: Double read ATemperature write ATemperature;
    property FTopK: Integer read ATopK write ATopK;
    property FTopP: Double read ATopP write ATopP;
    property FMaxOutputTokens: String read AMaxOutputTokens write AMaxOutputTokens;

    //**safetySettings
    //Uma lista de instâncias SafetySetting exclusivas para bloquear conteúdo não seguro.
    property FHC_HARASSMENT : String read AHC_HARASSMENT write AHC_HARASSMENT;
    property FHC_HATE_SPEECH: String read AHC_HATE_SPEECH write AHC_HATE_SPEECH;
    property FHC_SEXUALLY_EXPLICIT: String read AHC_SEXUALLY_EXPLICIT write AHC_SEXUALLY_EXPLICIT;
    property FHC_DANGEROUS_CONTENT: String read AHC_DANGEROUS_CONTENT write AHC_DANGEROUS_CONTENT;

    //**SystemInstruction
    //Instrução do sistema do conjunto do desenvolvedor. No momento, somente texto.
    property FSysInstruction_Role: String  read ASysInstruction_Role write ASysInstruction_Role;
    property FSysInstruction_Text: String  read ASysInstruction_Text write ASysInstruction_Text;

    property FSafetySettingsOptions: TStringList read GetSafetySettingsOptions;
end;

implementation

uses
  Vcl.Dialogs;

{ TUApiGemini }


constructor TUApiGemini.Create(const ApiKey: string);
begin
  LoadConfig;
  AAPiKey    := Apikey;
  AApiClient := TApiClient.Create(AURLServer);
end;

destructor TUApiGemini.Destroy;
begin
  AApiClient.Free;
  inherited;
end;

function TUApiGemini.CreateAGenerateContent(AText: String): String;
var
  ReqBody: TJSONObject;
begin
  ReqBody := TJSONObject.Create;
  ReqBody.AddPair('contents', TJSONArray.Create(CreateAContents('user', AText)));
  ReqBody.AddPair('generationConfig', CreateAGenerationConfig);

  if AModel = 'gemini-1.5-pro-latest' then //Somente na versão 1.5
    ReqBody.AddPair('systemInstruction', CreateAContents(ASysInstruction_Role, ASysInstruction_Text));

  ReqBody.AddPair('safetySettings', CreateASafetySettings);
  Result := ReqBody.ToString;
end;

function TUApiGemini.CreateAGenerationConfig: TJSONObject;
var AGenerationConfig : TJSONObject;
begin
  AGenerationConfig := TJSONObject.Create;
  AGenerationConfig.AddPair('temperature', FloatToJson( ATemperature ));
  AGenerationConfig.AddPair('topK', ATopK.ToString);
  AGenerationConfig.AddPair('topP', FloatToJson( ATopP ));
  AGenerationConfig.AddPair('maxOutputTokens', AMaxOutputTokens);
  AGenerationConfig.AddPair('stopSequences', TJSONArray.Create);
  Result := AGenerationConfig;
end;

function TUApiGemini.CreateAContents(Role, Text: string): TJSONObject;
var
  AContentAParts    : TJSONObject;
  AParts            : TJSONArray;
begin
   role := ifthen(Role='' , 'user', role);

   AParts         := TJSONArray.Create;
   AContentAParts := TJSONObject.Create;

   AParts.Add(TJSONObject.Create(TJSONPair.Create('text', Text)));
   AContentAParts.AddPair('role', role);
   AContentAParts.AddPair('parts', AParts);

   Result := AContentAParts;
end;

function TUApiGemini.CreateASafetySettings: TJSONArray;
var
  ASafetySettings   : TJSONArray;
  ASafetySetting    : TJSONObject;
begin
  ASafetySettings := TJSONArray.Create;

  ASafetySetting := TJSONObject.Create;
  ASafetySetting.AddPair('category', 'HARM_CATEGORY_HARASSMENT');
  ASafetySetting.AddPair('threshold', AHC_HARASSMENT);
  ASafetySettings.Add(ASafetySetting);

  ASafetySetting := TJSONObject.Create;
  ASafetySetting.AddPair('category', 'HARM_CATEGORY_HATE_SPEECH');
  ASafetySetting.AddPair('threshold', AHC_HATE_SPEECH);
  ASafetySettings.Add(ASafetySetting);

  ASafetySetting := TJSONObject.Create;
  ASafetySetting.AddPair('category', 'HARM_CATEGORY_SEXUALLY_EXPLICIT');
  ASafetySetting.AddPair('threshold', AHC_SEXUALLY_EXPLICIT);
  ASafetySettings.Add(ASafetySetting);

  ASafetySetting := TJSONObject.Create;
  ASafetySetting.AddPair('category', 'HARM_CATEGORY_DANGEROUS_CONTENT');
  ASafetySetting.AddPair('threshold', AHC_DANGEROUS_CONTENT);
  ASafetySettings.Add(ASafetySetting);
  Result := ASafetySettings;
end;

procedure TUApiGemini.GetFileConfig;
var AFileJson : TJSOnINFile;
begin
  AFileJson := TJSOnINFile.Create('./Config.json');
  try
    AURLServer   := 'https://'+AFileJson.GetStringValue('AURLServer')+'/';
    ADiscovery   := AFileJson.GetStringValue('Discovery');
    AModel       := AFileJson.GetStringValue('Models');
    ATemperature := AFileJson.GetDoubleValue('Temperature');
    ATopK := AFileJson.GetIntegerValue('TopK');
    AtopP := AFileJson.GetDoubleValue('TopP');
    AMaxOutputTokens:= AFileJson.GetStringValue('MaxOutputTokens');
    AHC_HARASSMENT := AFileJson.GetStringValue('HARM_CATEGORY_HARASSMENT');
    AHC_HATE_SPEECH := AFileJson.GetStringValue('HARM_CATEGORY_HATE_SPEECH');
    AHC_SEXUALLY_EXPLICIT := AFileJson.GetStringValue('HARM_CATEGORY_SEXUALLY_EXPLICIT');
    AHC_DANGEROUS_CONTENT := AFileJson.GetStringValue('HARM_CATEGORY_DANGEROUS_CONTENT');
  finally
   AFileJson.Free;
  end;
end;

function TUApiGemini.GetSafetySettingsOptions: TStringList;
begin
  Result := TStringList.Create;
  Result.Add('HARM_BLOCK_THRESHOLD_UNSPECIFIED');
  Result.Add('BLOCK_LOW_AND_ABOVE');
  Result.Add('BLOCK_MEDIUM_AND_ABOVE');
  Result.Add('BLOCK_ONLY_HIGH');
  Result.Add('BLOCK_NONE');
end;



procedure TUApiGemini.LoadConfig;
begin
  if not FileExists('./Config.json') then
    SetDefaultConfig;

  GetFileConfig;
end;

procedure TUApiGemini.SetDefaultConfig;
var AFileJson : TJSOnINFile;
begin
  AFileJson := TJSOnINFile.Create;
  try
    AFileJson.AddString('AURLServer','generativelanguage.googleapis.com');
    AFileJson.AddString('Discovery','v1beta');
    AFileJson.AddString('Models','models/gemini-1.0-pro');
    AFileJson.AddString('Temperature','0');
    AFileJson.AddString('TopK','0');
    AFileJson.AddString('TopP','0');
    AFileJson.AddString('MaxOutputTokens','8192');
    AFileJson.AddString('HARM_CATEGORY_HATE_SPEECH', 'BLOCK_MEDIUM_AND_ABOVE');
    AFileJson.AddString('HARM_CATEGORY_SEXUALLY_EXPLICIT', 'BLOCK_MEDIUM_AND_ABOVE');
    AFileJson.AddString('HARM_CATEGORY_DANGEROUS_CONTENT', 'BLOCK_MEDIUM_AND_ABOVE');
    AFileJson.AddString('HARM_CATEGORY_HARASSMENT', 'BLOCK_MEDIUM_AND_ABOVE');
    AFileJson.SaveToFile('./Config.json');
  finally
   AFileJson.Free;
  end;
end;

procedure TUApiGemini.SetFileConfig;
var AFileJson : TJSOnINFile;
begin
  AFileJson := TJSOnINFile.Create;
  try
    AFileJson.AddString('AURLServer', 'generativelanguage.googleapis.com');
    AFileJson.AddString('Discovery',  ADiscovery);
    AFileJson.AddString('Models',     AModel);
    AFileJson.AddString('Temperature', FloatToJson( ATemperature ));
    AFileJson.AddString('TopK',ATopk.tostring);
    AFileJson.AddString('TopP',FloatToJson( AtopP ));
    AFileJson.AddString('MaxOutputTokens', AMaxOutputTokens);
    AFileJson.AddString('HARM_CATEGORY_HATE_SPEECH',AHC_HATE_SPEECH);
    AFileJson.AddString('HARM_CATEGORY_SEXUALLY_EXPLICIT',AHC_SEXUALLY_EXPLICIT);
    AFileJson.AddString('HARM_CATEGORY_DANGEROUS_CONTENT',AHC_DANGEROUS_CONTENT);
    AFileJson.AddString('HARM_CATEGORY_HARASSMENT',AHC_HARASSMENT);
    AFileJson.SaveToFile('./Config.json');
  finally
   AFileJson.Free;
  end;
end;

function TUApiGemini.Models_GenerateContent(AText: String): String;
begin
  SetFileConfig;
  Result := AApiClient.Post(ADiscovery+'/'+AModel+':generateContent?key='+AApiKey, CreateAGenerateContent(AText), '');
end;

procedure TUApiGemini.Models_List(DataReturn: TClientDataSet);
begin
  AApiClient.Get(ADiscovery+'/models/?key='+AApiKey, DataReturn, 'models');
end;

procedure TUApiGemini.ClearConfiguration;
var AFileJson : TJSOnINFile;
begin
  AFileJson := TJSOnINFile.Create();
  try
    AFileJson.DeleteToFile('./Config.json');
    SetDefaultConfig;
  finally
    AFileJson.Free;
  end;
end;

end.
