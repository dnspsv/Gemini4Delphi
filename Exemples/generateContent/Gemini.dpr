program Gemini;

uses
  Vcl.Forms,
  pGemini in 'pGemini.pas' {uFrmPrincipal},
  UApiClientUnit in '..\..\Controllers\Api\UApiClientUnit.pas',
  UJSOnINFile in '..\..\Controllers\JSonInFile\UJSOnINFile.pas',
  UFileLog in '..\..\Controllers\LogFile\UFileLog.pas',
  UApiGemini in '..\..\Models\UApiGemini.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TuFrmPrincipal, uFrmPrincipal);
  Application.Run;
end.
