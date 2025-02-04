unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, jpeg, ExtCtrls;

type
  TFrmLogin = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label3: TLabel;
    val_Usu: TADOQuery;
    val_Usucodigo_usu: TAutoIncField;
    val_Usunome_usu: TWideStringField;
    val_Ususenha_usu: TWideStringField;
    val_Usunacesso_usu: TWideStringField;
    val_Usufrase_usu: TWideStringField;
    Image1: TImage;
    Image2: TImage;
    Edit3: TEdit;
    Button3: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Label3Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;
  tentativa:byte;
  imgtxt:string;


implementation

uses API_F11, UDMeclipse, UPrincipal, UPrincipal2, StrUtils, Math, Ufoto;

{$R *.dfm}

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  if not (FileExists('parametros.txt')) then
  begin
    Assignfile(p,'parametros.txt');
    Rewrite(p);
    Writeln(p,crypt('C','2900'));
    closefile(p);
  end;
  Assignfile(p,'parametros.txt');
  reset(p);
  readln(p,menup);
  menup:=Crypt('D',menup);
  closefile(p);
  tentativa:=1;
  FrmLogin.Height:=345;

end;

procedure TFrmLogin.Button1Click(Sender: TObject);
var senha:string;
begin
  if edit3.text<>imgtxt then
  begin
    showmessage('C�digo de confirma��o incorreto');
    Button3.click;
    edit3.Clear;
    Edit3.SetFocus;
    exit;
  end;
  with val_Usu do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *                     ');
    SQL.Add('  FROM TB_USUARIO T          ');
    SQL.Add(' WHERE T.NOME_USU = :NOME  ');
    Parameters.ParamByName('NOME').Value := Edit1.Text;
    Open;
    if not(IsEmpty)then
    begin
      senha:= Crypt('D',val_Ususenha_usu.asstring);
      if senha<>Edit2.Text then
      begin
        showmessage('Senha Incorreta');
        if tentativa>= 3 then
        begin
          frmlogin.Height:=480;
          Button3.Click;
        end
        else
          tentativa:=tentativa+1;
        edit2.SetFocus;
      end
      else
      begin
        User_id.nome  := val_Usunome_usu.AsString;
        User_id.nivel := val_Usunacesso_usu.AsInteger;
        user_id.senha:=Crypt('D',val_Ususenha_usu.AsString);
        User_id.frase:=val_Usufrase_usu.AsString;
        If(FrmPrincipal = nil)then
        begin
          Edit1.Text:='';
          edit2.Text:='';
          frmlogin.Hide;      
          if menup='1900' then
          begin
            application.CreateForm(TFrmPrincipal2,FrmPrincipal2);
            FrmPrincipal2.Show;
          end
          else
          begin
            application.CreateForm(TFrmPrincipal,FrmPrincipal);
            FrmPrincipal.Show;
          end;
          carregarlog;
        end;
      end;
    end
    else
    begin
      ShowMessage('Login inv�lido');
      if tentativa>= 3 then
      begin
        frmlogin.Height:=480;
        Button3.Click;
      end
      else
        tentativa:=tentativa+1;
      Edit1.Clear;
      Edit2.Clear;
      edit1.SetFocus;
    end;
  end;
end;

procedure TFrmLogin.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13)then
  begin
    Key := #13;
    SelectNext(ActiveControl,true,true);
  end;
end;

procedure TFrmLogin.Label3Click(Sender: TObject);
begin
  with val_Usu do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT *                     ');
    SQL.Add('  FROM TB_USUARIO T          ');
    SQL.Add(' WHERE T.NOME_USU = :NOME          ');
    Parameters.ParamByName('NOME').Value := Edit1.Text;
    Open;
    if not (isempty) then
    begin
      showmessage('Frase:'+#13+ val_Usufrase_usu.AsString);
    end
    else
      showmessage('Usu�rio n�o encontrado.')
  end;
end;

procedure TFrmLogin.Button3Click(Sender: TObject);
var charrnd:string;
    codimg: array [1..5] of string;
    i:byte;
    w,k:byte;
    cor:byte;
begin
  randomize;
  imgtxt:='';
  image2.Picture:=nil;
  image2.Canvas.Font.Name:='Times New Roman';
  image2.Canvas.Font.Size:=30;
  charrnd:='ABCDEFGHIJKLMNOPQRSTUVWXYZ�0123456789';
  w:=RandomRange(180,241);
  k:=RandomRange(15,30);
  image2.Canvas.Ellipse(w,k,w+30,k+30);
  w:=RandomRange(100,180);
  k:=RandomRange(30,50);
  image2.Canvas.Rectangle(w,k,w+30,k+30);
  w:=RandomRange(100,180);
  k:=RandomRange(5,30);
  image2.Canvas.Rectangle(w,k,w+30,k+30);
  w:=RandomRange(15,30);
  k:=random(20);
  for i:=1 to 5 do
  begin
   cor:=random(5);
   if cor=1 then
    Image2.Canvas.Font.Color:=clblack;
   if cor=2 then
    Image2.Canvas.Font.Color:=clblue;
   if cor=3 then
    Image2.Canvas.Font.Color:=cllime;
   if cor=4 then
    Image2.Canvas.Font.Color:=clred;
   if cor=5 then
    Image2.Canvas.Font.Color:=claqua;
   codimg[i]:=copy(charrnd,RandomRange(1,36),1);
   imgtxt:=imgtxt+codimg[i];
   image2.Canvas.textout(w,k,codimg[i]);
   w:=w+RandomRange(35,50);
   k:=random(20);
  end;
  for i:=1 to 5 do
  begin
    randomize;
    w:=RandomRange(10,70);
    k:=RandomRange(10,70);
    image2.Canvas.LineTo(w,k);
  end;

end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  User_id := TUser_id.Create;
end;

end.
