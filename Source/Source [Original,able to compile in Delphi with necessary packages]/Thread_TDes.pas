Unit Thread_TDes; //Decrypting thread

Interface

Uses
  Classes, SysUtils;

Type
  TDes = Class(TThread)
  Private
    { Private declarations }
  Protected
    Procedure Execute; Override;
  End;

Implementation

Uses AES, MainForm;

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

  Synchronize(UpdateCaption);

  and UpdateCaption could look like,

  procedure Tdes.UpdateCaption;
  begin
  Form1.Caption := 'Updated in a thread';
  end;

  or

  Synchronize(
  procedure
  begin
  Form1.Caption := 'Updated in thread via an anonymous method'
  end
  )
  );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

{ Tdes }

Procedure TDes.Execute;
Begin
  { Place thread code here }
  Form1.spSkinTabSheet3.Enabled := False;
  DecryptFile(Trim(Form1.spSkinEdit1.Text), Form1.savefilepath,
    Form1.spSkinPasswordEdit1.Text, kb192);
  Form1.Timer1.Enabled := False;
  Form1.spSkinGauge1.Value := 100;
  Form1.spSkinPasswordEdit1.Text := '';
  Form1.spSkinTabSheet3.Enabled := True;
End;

End.
