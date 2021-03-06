Unit MainForm; // main unit

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, spTrayIcon, SkinData, DynamicSkinForm, Menus, SkinCtrls, SkinExCtrls,
  ComCtrls, SkinTabs, ExtCtrls,
  SkinBoxCtrls, StdCtrls, Mask, DB, ADODB, SkinMenus;

Type
  TForm1 = Class(TForm)
    spDynamicSkinForm1: TspDynamicSkinForm;
    spSkinData1: TspSkinData;
    spCompressedStoredSkin1: TspCompressedStoredSkin;
    spSkinPageControl1: TspSkinPageControl;
    spSkinButtonEx1: TspSkinButtonEx;
    spSkinButtonEx3: TspSkinButtonEx;
    spSkinTabSheet1: TspSkinTabSheet;
    spSkinTabSheet2: TspSkinTabSheet;
    spSkinTabSheet3: TspSkinTabSheet;
    spSkinPanel1: TspSkinPanel;
    spSkinPanel2: TspSkinPanel;
    spSkinPanel3: TspSkinPanel;
    spSkinButton1: TspSkinButton;
    spSkinButton2: TspSkinButton;
    spSkinButton4: TspSkinButton;
    spSkinSplitter1: TspSkinSplitter;
    spSkinLabel1: TspSkinLabel;
    spSkinLabel2: TspSkinLabel;
    spSkinEdit1: TspSkinEdit;
    spSkinButton5: TspSkinButton;
    spSkinPasswordEdit1: TspSkinPasswordEdit;
    OpenDialog1: TOpenDialog;
    spSkinLabel3: TspSkinLabel;
    spSkinButton6: TspSkinButton;
    spSkinButton7: TspSkinButton;
    spSkinPanel4: TspSkinPanel;
    spSkinPanel5: TspSkinPanel;
    spSkinPanel6: TspSkinPanel;
    spSkinButton8: TspSkinButton;
    spSkinButton9: TspSkinButton;
    spSkinButton11: TspSkinButton;
    spSkinSplitter2: TspSkinSplitter;
    Timer1: TTimer;
    spSkinGauge1: TspSkinGauge;
    spSkinLabel5: TspSkinLabel;
    spSkinEdit2: TspSkinEdit;
    spSkinLabel6: TspSkinLabel;
    spSkinEdit3: TspSkinEdit;
    spSkinLabel7: TspSkinLabel;
    spSkinGroupBox1: TspSkinGroupBox;
    Memo1: TMemo;
    spSkinButton12: TspSkinButton;
    spSkinButton13: TspSkinButton;
    ADOQuery1: TADOQuery;
    spSkinButtonEx2: TspSkinButtonEx;
    spSkinShadowLabel1: TspSkinShadowLabel;
    spSkinLabel9: TspSkinLabel;
    spSkinEdit4: TspSkinEdit;
    spSkinGroupBox2: TspSkinGroupBox;
    Memo2: TMemo;
    spSkinButton16: TspSkinButton;
    spSkinButton17: TspSkinButton;
    spSkinEdit5: TspSkinEdit;
    spSkinListBox1: TspSkinListBox;
    spSkinListBox2: TspSkinListBox;
    SaveDialog1: TSaveDialog;
    spSkinButton3: TspSkinButton;
    spSkinButton10: TspSkinButton;
    spSkinPopupMenu1: TspSkinPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    spSkinPopupMenu2: TspSkinPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    spSkinButton14: TspSkinButton;
    spSkinShadowLabel2: TspSkinShadowLabel;
    spSkinMemo1: TspSkinMemo;
    Procedure FormCreate(Sender: TObject);
    Procedure spSkinButton5Click(Sender: TObject);
    Procedure spSkinEdit1Change(Sender: TObject);
    Procedure spSkinButton6Click(Sender: TObject);
    Procedure spSkinButton7Click(Sender: TObject);
    Procedure Timer1Timer(Sender: TObject);
    Procedure spSkinButtonEx3Click(Sender: TObject);
    Procedure spSkinButton12Click(Sender: TObject);
    Procedure spSkinButtonEx1Click(Sender: TObject);
    Procedure spSkinButtonEx2Click(Sender: TObject);
    Procedure FormShow(Sender: TObject);
    Procedure spSkinButton3Click(Sender: TObject);
    Procedure spSkinButton16Click(Sender: TObject);
    Procedure spSkinButton10Click(Sender: TObject);
    Procedure spSkinButton4Click(Sender: TObject);
    Procedure spSkinButton11Click(Sender: TObject);
    Procedure spSkinButton1Click(Sender: TObject);
    Procedure spSkinButton8Click(Sender: TObject);
    Procedure spSkinButton2Click(Sender: TObject);
    Procedure spSkinButton9Click(Sender: TObject);
    Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
    Procedure spSkinListBox1Click(Sender: TObject);
    Procedure spSkinListBox2Click(Sender: TObject);
    procedure spSkinButton14Click(Sender: TObject);
  Private
    { Private declarations }
    fmin, fmax: Integer;
  Public
    { Public declarations }
    savefilepath, password: String;
    psaved, dsaved, AutoClose: Boolean;
  End;

Var
  Form1: TForm1;

Implementation

Uses AES, Thread_Tenc, Thread_TDes, InitForm, add;
{$R *.dfm}

Procedure TForm1.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Begin
  If Not Form2.pwchecked Then
    Application.Terminate;
  If Application.MessageBox('Are you sure to exit?', PChar(Application.Title),    //confirm for exiting
    MB_YESNO + MB_ICONQUESTION) = IDNO Then
  Begin
    CanClose := False;
    Exit;
  End;
  Form1.Hide;
  ADOQuery1.Close;
  ADOQuery1.Active := False;
  ADOQuery1.Destroy;
  EncryptFile(ExtractFilePath(Application.ExeName) + '\Data\maindata.tmp',
    ExtractFilePath(Application.ExeName) + '\Data\MainData.mdb', password,
    kb192);
  DeleteFile(ExtractFilePath(Application.ExeName) + '\Data\maindata.tmp');
  //save the modified database and encrypt it
End;

Procedure TForm1.FormCreate(Sender: TObject);
Begin
  spSkinPageControl1.HideTabs;
  Randomize;
  ADOQuery1.ConnectionString :=                                                //link to Microsoft.Jet.OLEDB.4.0 enginee for database
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + ExtractFilePath
    (Application.ExeName) + '\data\maindata.tmp;Persist Security Info=False';
End;

Procedure TForm1.FormShow(Sender: TObject);
Begin
  Form1.OnShow := Nil;
  Application.CreateForm(TForm2, Form2);         //show initform first
  Form2.ShowModal;

End;

Procedure TForm1.spSkinButton10Click(Sender: TObject);
Begin
  Try                                                            // add items
    With ADOQuery1 Do
    Begin
      Close;
      SQL.Clear;
      SQL.add('select * from words');
      Open;
      Append;
      FieldByName('标题名').AsString := spSkinEdit4.Text;
      FieldByName('内容').AsString := Memo2.Text;
      Post;
      spSkinListBox2.Items.add(spSkinEdit4.Text);
      spSkinListBox2.ItemIndex := spSkinListBox2.Items.Count - 1;
    End;
    spSkinButton9Click(Sender);
  Except
    Application.MessageBox('Sorry,fail to add', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

Procedure TForm1.spSkinButton11Click(Sender: TObject);
Begin
  // words
  With Form1.ADOQuery1 Do                                //refresh datas
  Begin
    Close;
    SQL.Clear;
    SQL.add('select * from words');
    Open;
    First;
    Form1.spSkinListBox2.Items.Clear;
    Form1.spSkinListBox2.Items.BeginUpdate;
    While Not Eof Do
    Begin
      Form1.spSkinListBox2.Items.add(FieldByName('标题名').AsString);
      Next;
    End;
    Form1.spSkinListBox2.Items.EndUpdate;
  End;
  // words end
End;

Procedure TForm1.spSkinButton12Click(Sender: TObject);
Begin
  If spSkinListBox1.ItemIndex = -1 Then
    Exit;
  Try
    With ADOQuery1 Do                                //add or modify items
    Begin
      Close;
      SQL.Clear;
      SQL.add('select * from pw where 标题名=:a');
      Parameters.ParamByName('a').Value := spSkinListBox1.Items
        [spSkinListBox1.ItemIndex];
      Open;
      If RecordCount = 0 Then
        Append
      Else
        Edit;
      FieldByName('标题名').AsString := spSkinEdit2.Text;
      FieldByName('用户名').AsString := spSkinEdit3.Text;
      FieldByName('密码').AsString := spSkinEdit5.Text;
      FieldByName('备注').AsString := Memo1.Text;
      Post;
      spSkinListBox1.Items[spSkinListBox1.ItemIndex] := spSkinEdit2.Text;
    End;
    spSkinButton2Click(Sender);
  Except
    Application.MessageBox('Sorry,fail to save', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

procedure TForm1.spSkinButton14Click(Sender: TObject);
begin
  Application.MessageBox('KeyKeeper V2.0-English' + #13#10 + 'Author: 叶嘉影Ye JiaYing' + #13#10
    + 'Email: pokemon32@163.com' + #13#10 + 'Http://www.icyBit.com',
    PChar(Application.Title), MB_OK + MB_ICONINFORMATION);          //show "About" form

end;

Procedure TForm1.spSkinButton16Click(Sender: TObject);
Begin
  If spSkinListBox2.ItemIndex = -1 Then
    Exit;
  Try
    With ADOQuery1 Do                                             //save items
    Begin
      Close;
      SQL.Clear;
      SQL.add('select * from words where 标题名=:a');
      Parameters.ParamByName('a').Value := spSkinListBox2.Items
        [spSkinListBox2.ItemIndex];
      Open;
      If RecordCount = 0 Then
        Append
      Else
        Edit;
      FieldByName('标题名').AsString := spSkinEdit4.Text;
      FieldByName('内容').AsString := Memo2.Text;
      Post;
      spSkinListBox2.Items[spSkinListBox2.ItemIndex] := spSkinEdit4.Text;
    End;
    spSkinButton9Click(Sender);
  Except
    Application.MessageBox('Sorry,fail to save', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

Procedure TForm1.spSkinButton1Click(Sender: TObject);
Begin
  If spSkinListBox1.ItemIndex = -1 Then                              //delete items
    Exit;
  Try
    With ADOQuery1 Do
    Begin
      Close;
      SQL.Clear;
      SQL.add('select * from pw where 标题名=:a');
      Parameters.ParamByName('a').Value := spSkinListBox1.Items
        [spSkinListBox1.ItemIndex];
      Open;
      If RecordCount = 0 Then
        Exit;
      Delete;
      spSkinButton4Click(Sender);
      spSkinButton2Click(Sender);
    End;
  Except
    Application.MessageBox('Sorry,fail to delete', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

Procedure TForm1.spSkinButton2Click(Sender: TObject);
Begin
  spSkinEdit2.Text := '';
  spSkinEdit3.Text := '';
  spSkinEdit5.Text := '';
  Memo1.Lines.Clear;
End;

Procedure TForm1.spSkinButton3Click(Sender: TObject);
Begin
  Try
    With ADOQuery1 Do
    Begin                                                                //add items
      Close;
      SQL.Clear;
      SQL.add('select * from pw');
      Open;
      Append;
      FieldByName('标题名').AsString := spSkinEdit2.Text;
      FieldByName('用户名').AsString := spSkinEdit3.Text;
      FieldByName('密码').AsString := spSkinEdit5.Text;
      FieldByName('备注').AsString := Memo1.Text;
      Post;
      spSkinListBox1.Items.add(spSkinEdit2.Text);
      spSkinListBox1.ItemIndex := spSkinListBox1.Items.Count - 1;
    End;
    spSkinButton2Click(Sender);
  Except
    Application.MessageBox('Sorry,fail to add', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

Procedure TForm1.spSkinButton4Click(Sender: TObject);
Begin
  // pw
  With Form1.ADOQuery1 Do
  Begin
    Close;
    SQL.Clear;
    SQL.add('select * from pw');                      //refresh datas
    Open;
    First;
    Form1.spSkinListBox1.Items.Clear;
    Form1.spSkinListBox1.Items.BeginUpdate;
    While Not Eof Do
    Begin
      Form1.spSkinListBox1.Items.add(FieldByName('标题名').AsString);
      Next;
    End;
    Form1.spSkinListBox1.Items.EndUpdate;
  End;
  // pw end
End;

Procedure TForm1.spSkinButton5Click(Sender: TObject);
Begin
  Try
    If OpenDialog1.Execute Then                                     //select file
      spSkinEdit1.Text := OpenDialog1.FileName;
  Except
    Application.MessageBox('Sorry,unable to select this file', PChar(Application.Title),
      MB_OK + MB_ICONSTOP);
  End;
End;

Procedure TForm1.spSkinButton6Click(Sender: TObject);
Var
  f: File;
  enc: Tenc;
Begin
  If NOT FileExists(spSkinEdit1.Text) Then
  Begin
    Application.MessageBox('Sorry,file not found', PChar(Application.Title),
      MB_OK + MB_ICONSTOP);
    Exit;
  End;
  If spSkinPasswordEdit1.Text = '' Then
  Begin
    Application.MessageBox('Please enter the password', PChar(Application.Title),
      MB_OK + MB_ICONINFORMATION);
    Exit;
  End;
  Try
    spSkinGauge1.Value := 0;
    spSkinGauge1.ProgressText := 'Calculating file size...    ';
    Application.ProcessMessages;
    AssignFile(f, spSkinEdit1.Text);
    Reset(f);
    fmax := FileSize(f);                              //get file size
    CloseFile(f);
    fmin := 0;
    Timer1.Enabled := True;
    enc := Tenc.Create(False);                  //create and run a encrypting thread
  Except
    Timer1.Enabled := False;
    Application.MessageBox('Sorry,fail to encrypt', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

Procedure TForm1.spSkinButton7Click(Sender: TObject);
Var
  f: File;
  dect: TDes;
Begin
  If NOT FileExists(spSkinEdit1.Text) Then
  Begin
    Application.MessageBox('Sorry,file not found', PChar(Application.Title),
      MB_OK + MB_ICONSTOP);
    Exit;
  End;
  If spSkinPasswordEdit1.Text = '' Then
  Begin
    Application.MessageBox('Please enter the password', PChar(Application.Title),
      MB_OK + MB_ICONINFORMATION);
    Exit;
  End;
  Try
    spSkinGauge1.Value := 0;
    spSkinGauge1.ProgressText := 'Calculating file size...    ';
    Application.ProcessMessages;
    AssignFile(f, spSkinEdit1.Text);
    Reset(f);
    fmax := FileSize(f);                              //get file size
    CloseFile(f);
    fmin := 0;
    Timer1.Enabled := True;
    savefilepath := ChangeFileExt(Trim(spSkinEdit1.Text), '');
    dect := TDes.Create(False);                                      //create and run a decrypting thread
  Except
    Timer1.Enabled := False;
    Application.MessageBox('Sorry,fail to decrypt', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

Procedure TForm1.spSkinButton8Click(Sender: TObject);
Begin
  If spSkinListBox2.ItemIndex = -1 Then
    Exit;
  Try                                                               //save items
    With ADOQuery1 Do
    Begin
      Close;
      SQL.Clear;
      SQL.add('select * from words where 标题名=:a');
      Parameters.ParamByName('a').Value := spSkinListBox2.Items
        [spSkinListBox2.ItemIndex];
      Open;
      If RecordCount = 0 Then
        Exit;
      Delete;
      spSkinButton11Click(Sender);
      spSkinButton8Click(Sender);
    End;
  Except
    Application.MessageBox('Sorry,failto save', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

Procedure TForm1.spSkinButton9Click(Sender: TObject);
Begin
  spSkinEdit4.Text := '';
  Memo2.Lines.Clear;
End;

Procedure TForm1.spSkinButtonEx1Click(Sender: TObject);
Begin
  spSkinPageControl1.ActivePageIndex := 0;                        //trun to page 0
End;

Procedure TForm1.spSkinButtonEx2Click(Sender: TObject);
Begin
  spSkinPageControl1.ActivePageIndex := 1;                 //trun to page 1
End;

Procedure TForm1.spSkinButtonEx3Click(Sender: TObject);
Begin
  spSkinPageControl1.ActivePageIndex := 2;              //trun to page 2
End;

Procedure TForm1.spSkinEdit1Change(Sender: TObject);
Begin
  spSkinButton6.Enabled := False;
  spSkinButton7.Enabled := False;
  If ExtractFileExt(Trim(spSkinEdit1.Text)) = '.enc' Then
    spSkinButton7.Enabled := True
  Else
  Begin
    spSkinButton6.Enabled := True;
    spSkinButton7.Enabled := True;
  End;
End;

Procedure TForm1.spSkinListBox1Click(Sender: TObject);
Begin
  Try
    With ADOQuery1 Do
    Begin
      Close;                                                  //load selected datas
      SQL.Clear;
      SQL.add('select * from pw where 标题名=:a');
      Parameters.ParamByName('a').Value := spSkinListBox1.Items
        [spSkinListBox1.ItemIndex];
      Open;
      If RecordCount = 0 Then
        Exit;
      spSkinEdit2.Text := FieldByName('标题名').AsString;
      spSkinEdit3.Text := FieldByName('用户名').AsString;
      spSkinEdit5.Text := FieldByName('密码').AsString;
      Memo1.Text := FieldByName('备注').AsString;
    End;
  Except
    Application.MessageBox('Error', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

Procedure TForm1.spSkinListBox2Click(Sender: TObject);
Begin
  Try
    With ADOQuery1 Do
    Begin
      Close;                                                        //load selected datas
      SQL.Clear;
      SQL.add('select * from words where 标题名=:a');
      Parameters.ParamByName('a').Value := spSkinListBox2.Items
        [spSkinListBox2.ItemIndex];
      Open;
      If RecordCount = 0 Then
        Exit;
      spSkinEdit4.Text := FieldByName('标题名').AsString;
      Memo2.Text := FieldByName('内容').AsString;
    End;
  Except
    Application.MessageBox('Error', PChar(Application.Title),
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
  End;
End;

Procedure TForm1.Timer1Timer(Sender: TObject);
Begin
  spSkinGauge1.ProgressText := 'Handling the files...    Finished!';          //progress
  Application.ProcessMessages;
  If Random(3) = 0 Then
    fmin := fmin + Random(Round(fmax / 25));
  If fmin > fmax Then
    fmin := fmax;
  spSkinGauge1.Value := Round(95 * (fmin / fmax));
  Application.ProcessMessages;
End;

End.
