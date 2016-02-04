program Keeper2;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  ELAES in 'ELAES.pas',
  AES in 'AES.pas',
  Thread_Tenc in 'Thread_Tenc.pas',
  Thread_TDes in 'Thread_TDes.pas',
  InitForm in 'InitForm.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
