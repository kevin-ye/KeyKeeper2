Unit Thread_Tinit;

Interface

Uses
  Classes, cxTL;

Type
  Tinit = Class(TThread)
  Private
    { Private declarations }
  Protected
    Procedure Execute; Override;
    Procedure Initprocedure;
  End;

Implementation

Uses InitForm, MainForm;

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

  Synchronize(UpdateCaption);

  and UpdateCaption could look like,

  procedure Tinit.UpdateCaption;
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

{ Tinit }

Procedure Tinit.Initprocedure;
Var
  temp: TcxTreeListNode;
  I: Integer;
Begin
  Form2.spSkinButton1.Enabled := False;
  Form2.spSkinButton2.Enabled := False;
  Form2.spSkinPasswordEdit1.Enabled := False;
  // 开始初始化
  With Form1.ADOQuery1 Do
  Begin
    // load settings
    Close;
    SQL.Clear;
    SQL.Add('select * from settings');
    Open;
    First;
    Form1.AutoClose := FieldByName('自动关闭').AsBoolean;
    // end loading settings
    // load password types
    Close;
    SQL.Clear;
    SQL.Add('select distinct 类型 from password');
    Open;
    First;
    Form1.cxTreeList1.BeginUpdate;
    While Not Eof Do
    Begin
      With Form1.cxTreeList1 Do
      Begin
        temp := Add;
        temp.Texts[0] := FieldByName('类型').AsString;
      End;
      Next;
    End;
    Form1.cxTreeList1.EndUpdate;
    // end loading password types
    // load password names
    With Form1.cxTreeList1 Do
    Begin
      Form1.cxTreeList1.BeginUpdate;
      For I := 0 To Count - 1 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('select 标题 from password where 类型=:a');
        Parameters.ParamByName('a').Value := Items[I].Texts[0];
        Prepared;
        Open;
        First;
        while Not Form1.ADOQuery1.Eof Do
        Begin
          If Items[0].Count = 0 Then
            temp := Items[0].AddChildFirst
          Else
            temp := Items[0].AddChild;
          temp.Texts[1] := FieldByName('标题').AsString;
          Next;
        End;
      End;
      Form1.cxTreeList1.EndUpdate;
    End;
    // end loading password names
    // load words types
    Close;
    SQL.Clear;
    SQL.Add('select distinct 类型 from words');
    Open;
    First;
    Form1.cxTreeList2.BeginUpdate;
    While Not Eof Do
    Begin
      With Form1.cxTreeList2 Do
      Begin
        temp := Add;
        temp.Texts[0] := FieldByName('类型').AsString;
      End;
      Next;
    End;
    Form1.cxTreeList2.EndUpdate;
    // end loading words types
    // load words names
    With Form1.cxTreeList2 Do
    Begin
      Form1.cxTreeList2.BeginUpdate;
      For I := 0 To Count - 1 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('select 标题 from password where 类型=:a');
        Parameters.ParamByName('a').Value := Items[I].Texts[0];
        Prepared;
        Open;
        First;
        while Not Form1.ADOQuery1.Eof Do
        Begin
          If Items[0].Count = 0 Then
            temp := Items[0].AddChildFirst
          Else
            temp := Items[0].AddChild;
          temp.Texts[1] := FieldByName('标题').AsString;
          Next;
        End;
      End;
      Form1.cxTreeList2.EndUpdate;
    End;
    // end loading words names
  End;
  // 结束
End;

Procedure Tinit.Execute;
Begin
  { Place thread code here }
  Synchronize(Initprocedure);
End;

End.
