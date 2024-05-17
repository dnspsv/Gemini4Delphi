unit pGemini;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  System.JSON,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  System.StrUtils,
  UApiClientUnit,
  UApiGemini,
  Datasnap.DBClient,
  Data.DB;

type
  TuFrmPrincipal = class(TForm)
    Panel1: TPanel;
    mRequest: TMemo;
    Button1: TButton;
    Panel2: TPanel;
    edtToken: TEdit;
    Panel3: TPanel;
    mResponse: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbxModel: TComboBox;
    Label4: TLabel;
    TrackTemperatura: TTrackBar;
    Label5: TLabel;
    Panel4: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel5: TPanel;
    Label10: TLabel;
    EdtSystemInstructions: TEdit;
    Panel6: TPanel;
    Label11: TLabel;
    edtTopK: TEdit;
    Label12: TLabel;
    TrackTopP: TTrackBar;
    ProgressBar1: TProgressBar;
    TLoads: TTimer;
    cbxAssedio: TComboBox;
    cbxOdio: TComboBox;
    cbxSexualidade: TComboBox;
    cbxPerigoso: TComboBox;
    Label13: TLabel;
    cbxDiscovery: TComboBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure TrackTemperaturaChange(Sender: TObject);
    procedure cbxModelChange(Sender: TObject);
    procedure TrackTopPChange(Sender: TObject);
    procedure TLoadsTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtTokenExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtTopKExit(Sender: TObject);
    procedure cbxAssedioChange(Sender: TObject);
    procedure cbxOdioChange(Sender: TObject);
    procedure cbxSexualidadeChange(Sender: TObject);
    procedure cbxPerigosoChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure ConsomeGeminiAPI;
    function TratarResposta(REsposta:string):String;
    procedure LoadCombosSefety;

  public
    { Public declarations }
    procedure LoadModelos;
  end;

Var
  uFrmPrincipal: TuFrmPrincipal;
  Temperatura : double;
  TopP: double;
  Modelo: String;
  ApiGemini : TUApiGemini;
const
  APiKey: String = 'YOUR APIKEY';

implementation

{$R *.dfm}

procedure TuFrmPrincipal.Button1Click(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
  procedure()
  begin
    ConsomeGeminiAPI;
  end).Start;
end;

procedure TuFrmPrincipal.Button2Click(Sender: TObject);
begin
  ApiGemini.ClearConfiguration;
end;

procedure TuFrmPrincipal.cbxAssedioChange(Sender: TObject);
begin
  ApiGemini.FHC_HARASSMENT := cbxAssedio.Items[cbxAssedio.ItemIndex];
end;

procedure TuFrmPrincipal.cbxModelChange(Sender: TObject);
begin
  Modelo := cbxModel.Items[cbxModel.ItemIndex];
  if cbxModel.Items[cbxModel.ItemIndex] = 'models/gemini-1.5-pro-latest' then
    Panel5.Visible := true
  else
    Panel5.Visible := false;
end;

procedure TuFrmPrincipal.cbxOdioChange(Sender: TObject);
begin
  ApiGemini.FHC_HATE_SPEECH := cbxOdio.Items[cbxOdio.ItemIndex];
end;

procedure TuFrmPrincipal.cbxPerigosoChange(Sender: TObject);
begin
  ApiGemini.FHC_DANGEROUS_CONTENT := cbxPerigoso.Items[cbxPerigoso.ItemIndex];
end;

procedure TuFrmPrincipal.cbxSexualidadeChange(Sender: TObject);
begin
  ApiGemini.FHC_SEXUALLY_EXPLICIT := cbxSexualidade.Items[cbxSexualidade.ItemIndex];
end;

procedure TuFrmPrincipal.ConsomeGeminiAPI;
Var
  response : String;
begin
  TLoads.Enabled := true;
  mResponse.Lines.Clear;

  ApiGemini.FModel     := cbxModel.Items[cbxModel.ItemIndex];
  ApiGemini.FDiscovery := cbxDiscovery.Items[cbxDiscovery.ItemIndex];
  TratarResposta(ApiGemini.Models_GenerateContent(mRequest.Lines.Text));

  TLoads.Enabled := false;
  ProgressBar1.Position := 0;
end;

procedure TuFrmPrincipal.edtTokenExit(Sender: TObject);
begin
  if edtToken.Text <> '' then
    LoadModelos;
end;

procedure TuFrmPrincipal.edtTopKExit(Sender: TObject);
begin
  ApiGemini.FTopK := strtoint( edtTopK.Text );
end;

procedure TuFrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  ApiGemini.Free;
end;

procedure TuFrmPrincipal.FormCreate(Sender: TObject);
begin
   ApiGemini := TUApiGemini.Create(ApiKey);
end;

procedure TuFrmPrincipal.FormShow(Sender: TObject);
begin
  edtToken.Text := ApiKey;
  LoadModelos;
  LoadCombosSefety;

  cbxModel.ItemIndex := 0;
  TrackTemperatura.Position := Trunc(ApiGemini.FTemperature*100);
  TrackTopP.Position := Trunc(ApiGemini.FTopP*100);
  edtTopK.Text := ApiGemini.FTopK.ToString;
  cbxAssedio.ItemIndex     := cbxAssedio.Items.IndexOf(ApiGemini.FHC_HARASSMENT);
  cbxOdio.ItemIndex        := cbxOdio.Items.IndexOf(ApiGemini.FHC_HATE_SPEECH);
  cbxSexualidade.ItemIndex := cbxSexualidade.Items.IndexOf(ApiGemini.FHC_SEXUALLY_EXPLICIT);
  cbxPerigoso.ItemIndex    := cbxPerigoso.Items.IndexOf(ApiGemini.FHC_DANGEROUS_CONTENT);
end;

procedure TuFrmPrincipal.LoadCombosSefety;
begin
  TrackTemperatura.Position  :=  Trunc(ApiGemini.FTemperature);
  TrackTopP.Position         :=  Trunc(ApiGemini.FTopP);
  edtTopK.Text               :=  ApiGemini.FTopK.ToString;

  cbxAssedio.Items.AddStrings(ApiGemini.FSafetySettingsOptions);
  cbxOdio.Items.AddStrings(ApiGemini.FSafetySettingsOptions);
  cbxSexualidade.Items.AddStrings(ApiGemini.FSafetySettingsOptions);
  cbxPerigoso.Items.AddStrings(ApiGemini.FSafetySettingsOptions);
end;

procedure TuFrmPrincipal.LoadModelos;
Var
  Dados : TClientDataSet;
begin
   Dados := TClientDataSet.Create(nil);
   try
    ApiGemini.Models_List(Dados);
    while not Dados.Eof do
    begin
      cbxModel.Items.Add(Dados.FieldByName('name').AsString);
      dados.Next;
    end;
   finally
     Dados.Free;
   end;
end;


procedure TuFrmPrincipal.TLoadsTimer(Sender: TObject);
begin
  if ProgressBar1.Position < 500 then
    ProgressBar1.Position := ProgressBar1.Position + 1
  else
    ProgressBar1.Position := 0;
end;

procedure TuFrmPrincipal.TrackTemperaturaChange(Sender: TObject);
begin
  temperatura    := (TrackTemperatura.Position/100);
  Label4.Caption := 'Temperatura: ('+ floatToStr((TrackTemperatura.Position/100))+')';
  ApiGemini.FTemperature := Temperatura;
end;

procedure TuFrmPrincipal.TrackTopPChange(Sender: TObject);
begin
  TopP    := (TrackTopP.Position/100);
  Label11.Caption := 'Top P: ('+ floatToStr((TrackTopP.Position/100))+')';
  ApiGemini.FTopP := TopP;
end;

function TuFrmPrincipal.TratarResposta(Resposta:string):String;
var
  dados: TJSONObject;
  retorno : String;
  Linhas: TStringList;
//#13+10
begin
  Linhas  := TStringList.Create;
  Dados   := TJSONObject.ParseJSONValue(Resposta) as TJSONObject;
  retorno := Dados.GetValue<String>('candidates[0].content.parts[0].text');

  //Sanitizar a string
  retorno := StringReplace(retorno, '\n', #13, [rfReplaceAll]);
  Linhas.Text := retorno;
  mResponse.Lines.Add(linhas.Text);
  mResponse.CaretPos := Point(0, 0);
end;

end.
