unit add;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DynamicSkinForm, SkinCtrls, StdCtrls, Mask, SkinBoxCtrls;

type
  TForm3 = class(TForm)
    spDynamicSkinForm1: TspDynamicSkinForm;
    spSkinLabel1: TspSkinLabel;
    spSkinEdit1: TspSkinEdit;
    spSkinButton1: TspSkinButton;
    spSkinButton2: TspSkinButton;
    procedure spSkinButton1Click(Sender: TObject);
    procedure spSkinButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    res:string;
  end;

var
  Form3: TForm3;

implementation
uses MainForm;

{$R *.dfm}

procedure TForm3.spSkinButton1Click(Sender: TObject);
begin
  res:=spSkinEdit1.Text;
  Form3.Close;
end;

procedure TForm3.spSkinButton2Click(Sender: TObject);
begin
  res:='';
  Form3.Close;
end;

end.
