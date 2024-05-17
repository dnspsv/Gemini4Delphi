unit UFileLog;

interface

uses
  System.SysUtils;

type TFileLog = class
  private
    function GetFileName: String;
  public
    constructor Create;
    destructor Destroy; override;
    Procedure GravaLog(ATexto : String);
end;

implementation


{ TLogFile }

constructor TFileLog.Create;
begin
  if not directoryexists('.\LOG') then
    forcedirectories('.\LOG');
end;

destructor TFileLog.Destroy;
begin

  inherited;
end;

function TFileLog.GetFileName: String;
begin
  result := '.\LOG\log-' + formatdatetime('dd-mm-yyyy',now) + '.txt';
end;

procedure TFileLog.GravaLog(ATexto: String);
var
  Arquivo: Textfile;
begin

  AssignFile(Arquivo, GetFileName);

  if not FileExists(GetFileName) then
    ReWrite(Arquivo)
  else
    Append(Arquivo);

  WriteLn(Arquivo,'');
  WriteLn(Arquivo, formatdatetime('HH:mm:ss', now)+' - '+Atexto);

  CloseFile(Arquivo);
end;

end.
