unit API_F11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, ExtCtrls, Mask, ComCtrls, DB, ToolWin,
  Buttons, Grids, DBGrids, ADODB, Menus;

type
  TUser_id = class
    nome : String;
    nivel : integer;
    senha : string;
    frase:string;
  end;

type
  TParam = record
    Param : Array of String;
  end;



var
  p, log:textfile;
  menup:string;
  User_id : TUser_id;
  Params : TParam;
  Getmaxcodi : TADOQuery;

  function data(vdata:string):boolean;
  function cpf(vcpf:string):boolean;
  function Crypt(Action, Src: String): String;
  procedure carregarlog;
  procedure descarregarlog;
  procedure trims(form:tform);
  procedure cor(grade:tdbgrid;color:tcolor);
  procedure mudaedit(form : TForm; resu : boolean);
  procedure botoes(Form : TForm);
  procedure abrirpesq(Form : TForm);
  procedure pesq (Form : TForm ; tabelapesq : TADOQuery ;nometb, camponome, campocodi : String);
  function atribfield(Cfield :TAutoIncField):integer;
  procedure niveldeacesso(n:integer);
  procedure pesq_val(Form : TForm; tabelapesq : TADOQuery; msg :String; edtcampopesq :TDBEdit; edtcamponome :TEdit; camponome : TWideStringField);
//  procedure param_user(Form : TForm; result : boolean; params : TParam);
//  function Getmax_codi(Form : TForm; tabela, campo : String; dataSource : TDataSource):integer;

implementation

uses UpesqGeral, UDMeclipse, ComObj, UPrincipal;


procedure descarregarlog;
begin
  if (FileExists('log.txt')) then
  begin
    Assignfile(log,'log.txt');
    Append(log);
    Writeln(log,crypt('C','                Usu�rio: '+User_id.nome+ '         encerrou no dia: '+datetostr(date)+ ' �s ' +TimeToStr(time)   ));
    Writeln(log,crypt('C','*******************************************************************************************************************************'));
    writeln(log,'');
    closefile(log);
  end;
end;


procedure carregarlog;
begin
  if not (FileExists('log.txt')) then
  begin
    Assignfile(log,'log.txt');
    Rewrite(log);
  end
  else
  begin
    Assignfile(log,'log.txt');
    Append(log);
  end;
  writeln(log,'');
  Writeln(log,crypt('C','*******************************************************************************************************************************'));
  Writeln(log,crypt('C','                Usu�rio: '+User_id.nome+ '         logado no dia: '+datetostr(date)+ ' �s ' +TimeToStr(time)   ));
  closefile(log);
end;

procedure trims(form:tform);
var x:integer;
begin
  with form do
  begin
    for x:=0 to ComponentCount - 1 do
     begin
       if Components[x].ClassName = 'TDBEdit' then
       begin
         (Components[x] as TDBEdit).text :=trim((Components[x] as TDBEdit).text);
       end;
     end;
   end;  
end;

function cpf(vcpf:string):boolean;
var a :array[1..13] of byte;
    i:integer;
begin
 if (Length(vcpf)<11) or (Length(vcpf)>11) then
 begin
  result:=false;
  exit;
 end;
 for i:=1 to 11 do
 begin
   a[i]:=strtoint(Copy(vcpf,i,1));
 end;
 a[12]:=((a[1]*1)+(a[2]*2)+(a[3]*3)+(a[4]*4)+(a[5]*5)+(a[6]*6)+(a[7]*7)+(a[8]*8)+(a[9]*9)) mod 11;
 a[13]:=((a[1]*0)+(a[2]*1)+(a[3]*2)+(a[4]*3)+(a[5]*4)+(a[6]*5)+(a[7]*6)+(a[8]*7)+(a[9]*8)+(a[10]*9)) mod 11;
 if a[12]>=10 then
   a[12]:=0;
 if a[13]>=10 then
    a[13]:=0;
 if (a[12]=a[10])and(a[13]=a[11]) then
    result:=true
 else
    result:=false;
end;

function Crypt(Action, Src: String): String;
Label Fim;
var KeyLen : Integer;
  KeyPos : Integer;
  OffSet : Integer;
  Dest, Key : String;
  SrcPos : Integer;
  SrcAsc : Integer;
  TmpSrcAsc : Integer;
  Range : Integer;
begin
  if (Src = '') Then
  begin
    Result:= '';
    Goto Fim;
  end;
  Key :='YUQL23KL23DF90WI5E1JAS467NMCXXL6JAOAUWWMCL0AOMM4A4VZYW9KHJUI2347EJHJKDF3424SKL K3LAKDJSL9RTIKJ';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range := 256;
  if (Action = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x',[OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
      if KeyPos < KeyLen then KeyPos := KeyPos + 1 else KeyPos := 1;
      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x',[SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  Else if (Action = UpperCase('D')) then
  begin
    OffSet := StrToInt('$'+ copy(Src,1,2));
    SrcPos := 3;
  repeat
    SrcAsc := StrToInt('$'+ copy(Src,SrcPos,2));
    if (KeyPos < KeyLen) Then KeyPos := KeyPos + 1 else KeyPos := 1;
    TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
    if TmpSrcAsc <= OffSet then TmpSrcAsc := 255 + TmpSrcAsc - OffSet
    else TmpSrcAsc := TmpSrcAsc - OffSet;
    Dest := Dest + Chr(TmpSrcAsc);
    OffSet := SrcAsc;
    SrcPos := SrcPos + 2;
  until (SrcPos >= Length(Src));
  end;
  Result:= Dest;
  Fim:
end;

procedure niveldeacesso(n:integer);
begin     {
  if n=1 then
  begin
    FrmPrincipal.Cadastro1.Enabled:=true;
    FrmPrincipal.Cadastro1.Visible:=true;
    FrmPrincipal.Biblioteca1.Enabled:=false;
    FrmPrincipal.Biblioteca1.Visible:=false;
    frmprincipal.Segurana1.Enabled:=false;
    FrmPrincipal.Segurana1.Visible:=false;
  end;
  if n=2 then
  begin
    FrmPrincipal.Cadastro1.Enabled:=false;
    FrmPrincipal.Cadastro1.Visible:=false;
    FrmPrincipal.Biblioteca1.Enabled:=true;
    FrmPrincipal.Biblioteca1.Visible:=true;
    frmprincipal.Segurana1.Enabled:=false;
    FrmPrincipal.Segurana1.Visible:=false;
  end;
  if n=3 then
  begin
    FrmPrincipal.Cadastro1.Enabled:=true;
    FrmPrincipal.Cadastro1.Visible:=true;
    FrmPrincipal.Biblioteca1.Enabled:=true;
    FrmPrincipal.Biblioteca1.Visible:=true;
    frmprincipal.Segurana1.Enabled:=true;
    FrmPrincipal.Segurana1.Visible:=true;
  end;   }
end;

{function Getmax_codi(Form : TForm; tabela, campo : String; dataSource : TDataSource):integer;
begin
  with Form do
  begin
    with Getmaxcodi do
    begin
      Getmaxcodi := TADOQuery.Create(Form);
      DataSource := dataSource;
      Close;
      SQL.Add('SELECT SUM('+ campo +') as MAX FROM TB_' + tabela);
      Open;

    end;
  end;
  Result := 2;
end;   }

//procedure param_user(Form : TForm; result : boolean; params : TParam);
//var x, y : integer ;
//begin
{  with form do
  begin
    for x:=0 to ComponentCount - 1 do
    begin
      if (Components[x].ClassName = 'TMenuItem') then
      begin
        for y:=0 to TMenuItem.

          if((Components[x] as TMenuItem).Name = params.Param[] )then
          (Components[x] as TMenuItem).Enabled := resu;
      end;
    end;

                             }
//end;

procedure pesq_val(Form : TForm; tabelapesq : TADOQuery; msg :String; edtcampopesq :TDBEdit; edtcamponome :TEdit; camponome : TWideStringField);
begin
  with form do
  begin
    try
      if(trim(edtcampopesq.Text) <> '')then
      begin
        tabelapesq.Close;
        tabelapesq.Parameters.ParamByName('CODI').Value := edtcampopesq.Text;
        tabelapesq.Open;
        if not(tabelapesq.IsEmpty)then
          edtcamponome.Text := camponome.AsString
        else
        begin
          ShowMessage(msg);
          edtcampopesq.SetFocus;
          edtcampopesq.Clear;
          edtcamponome.Clear;
        end;
      end;
    except
        on EOleException do
        ShowMessage('Valor inv�lido');
    end;
  end;
end;

function atribfield(Cfield :TAutoIncField):integer;
begin
  with DMeclipse do
  begin
    with Cfield do
    begin
      Result := AsInteger;
    end;
  end;
end;

procedure pesq (Form : TForm ; tabelapesq : TADOQuery ;nometb, camponome, campocodi : String);
begin
  with form do
  begin
    with DMeclipse do
    begin
      with tabelapesq do
      begin
        Close;
        if(Frmpesq.ComboBox1.ItemIndex = 1)then
        begin
          SQL.Text := 'SELECT * FROM ' + 'TB_'+ nometb + ' WHERE ' + campocodi + ' = ' + ':CODI';
          Parameters.ParamByName('CODI').Value := Frmpesq.Edit1.Text;
        end
        else
          if(Frmpesq.ComboBox1.ItemIndex = 0)then
          begin
            SQL.Text := 'SELECT * FROM ' + ' TB_'+ nometb + ' WHERE ' + camponome + ' like ' + ':NOME';
            Parameters.ParamByName('NOME').Value := Frmpesq.Edit1.Text;
          end;
        Open;
      end;
    end;
  end;
end;

procedure abrirpesq(Form : TForm);
begin
  with Form do
  begin
    If(Frmpesq = nil)then
    begin
      Application.CreateForm(TFrmpesq, Frmpesq);
      Frmpesq.ShowModal;
    end;
  end;
end;



//essa procedure so pode ser usada caso vc queira modificar o enable do button 1 ao 5 e 7
procedure botoes(Form : TForm);
var x :integer;
begin
  with Form do
  begin
    for x:=0 to ComponentCount - 1 do
    begin
      if Components[x].ClassName = 'TBitBtn' then
      begin
        if((Components[x] as TBitBtn).Name = 'BitBtn1') or  ((Components[x] as TBitBtn).Name = 'BitBtn2') or ((Components[x] as TBitBtn).Name = 'BitBtn3') or ((Components[x] as TBitBtn).Name = 'BitBtn4') or ((Components[x] as TBitBtn).Name = 'BitBtn5') or ((Components[x] as TBitBtn).Name = 'BitBtn7')then
          (Components[x] as TBitBtn).Enabled := not (Components[x] as TBitBtn).Enabled;
      end;
      if Components[x].ClassName = 'TSpeedButton' then
      begin
        if((Components[x] as TSpeedButton).Name = 'SpeedButton1') or ((Components[x] as TSpeedButton).Name = 'SpeedButton2')then
          (Components[x] as TSpeedButton).Enabled := not (Components[x] as TSpeedButton).Enabled;
      end;
    end;
  end;
end;

function data(vdata:string):boolean;
begin
  try
    StrToDate(vdata);
    data:=true;
  except
    MessageDlg('Data Inv�lida !!' , mtInformation, [mbOk], 0);
    data:=false;
  end;
end;

procedure cor(grade:tdbgrid;color:tcolor);
var
  i:integer;
  numcampos:integer;
begin
  numcampos:=grade.FieldCount;
  for I := 0 to numcampos-1 do
    grade.columns[i].font.color:=color;
end;

procedure mudaedit(form : TForm ;resu : boolean);
var x :integer;
begin
  with form do
  begin
    for x:=0 to ComponentCount - 1 do
    begin
      if (Components[x].ClassName = 'TDBEdit') then
      begin
        (Components[x] as TDBEdit).Enabled := resu;
        if(resu)then
        begin
          (Components[x] as TDBEdit).Color := clWhite;
          (Components[x] as TDBEdit).ReadOnly := false;
        end
        else
        begin
          (Components[x] as TDBEdit).Color := clBtnFace;
          (Components[x] as TDBEdit).ReadOnly := true;
        end;
      end;

      if(Components[x].ClassName = 'TDBComboBox')then
      begin
        (Components[x] as TDBComboBox).Enabled := resu;
          if(resu)then
          begin
            (Components[x] as TDBComboBox).Color := clWhite;
            (Components[x] as TDBComboBox).ReadOnly := false;
          end
          else
          begin
            (Components[x] as TDBComboBox).Color := clBtnFace;
            (Components[x] as TDBComboBox).ReadOnly := true;
          end;
      end;
      if(Components[x].ClassName = 'TDBRadioGroup')then
      begin
        (Components[x] as TDBRadioGroup).Enabled := resu;
        if(resu)then
        begin
          //(Components[x] as TDBRadioGroup).Color := clWhite;
          (Components[x] as TDBRadioGroup).ReadOnly := false;
        end
        else
        begin
          (Components[x] as TDBRadioGroup).Color := clBtnFace;
          (Components[x] as TDBRadioGroup).ReadOnly := true;
        end;
      end;

      if(Components[x].ClassName = 'TDBImage')then
      begin
        (Components[x] as TDBImage).Enabled := resu;
         if(resu)then
           begin
             //(Components[x] as TDBImage).Color := clWhite;
             (Components[x] as TDBImage).ReadOnly := false;
           end
           else
           begin
             //(Components[x] as TDBImage).Color := clBtnFace;
             (Components[x] as TDBImage).ReadOnly := true;
           end;
      end;

      if(Components[x].ClassName = 'TDBGrid')then
      begin
        (Components[x] as TDBGrid).Enabled := resu;
        if(resu)then
        begin
          (Components[x] as TDBGrid).Color := clWhite;
          (Components[x] as TDBGrid).ReadOnly := false;
        end
        else
        begin
          (Components[x] as TDBGrid).Color := clBtnFace;
          (Components[x] as TDBGrid).ReadOnly := true;
        end;
      end;

      if(Components[x].ClassName = 'TDateTimePicker')then
      begin
        (Components[x] as TDateTimePicker).Enabled := resu;
        if(resu)then
        begin
          (Components[x] as TDateTimePicker).Color := clWhite;
        end
        else
        begin
          (Components[x] as TDateTimePicker).Color := clBtnFace;
        end;
      end;

      if(Components[x].ClassName = 'TDBMemo')then
      begin
        (Components[x] as TDBMemo).Enabled := resu;
        if(resu)then
        begin
          (Components[x] as TDBMemo).Color := clWhite;
          (Components[x] as TDBMemo).ReadOnly := false;
        end
        else
        begin
          (Components[x] as TDBMemo).Color := clBtnFace;
          (Components[x] as TDBMemo).ReadOnly := true;
        end;
      end;

      if(Components[x].ClassName = 'TComboBox')then
      begin
        (Components[x] as TComboBox).Enabled := resu;
        if(resu)then
        begin
          (Components[x] as TComboBox).Color := clWhite;
        end
        else
        begin
          (Components[x] as TComboBox).Color := clBtnFace;
        end;
      end;

    end;
  end;
end;

end.
