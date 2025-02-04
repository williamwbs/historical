unit Ucadusu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, DB, ADODB;

type
  TFrmcadusuario = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    DBText1: TDBText;
    Edit1: TEdit;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    DBRadioGroup1: TDBRadioGroup;
    DBEdit2: TDBEdit;
    usu_pesq: TADOQuery;
    Label4: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmcadusuario: TFrmcadusuario;
  pode:boolean;

implementation

uses UDMeclipse, UpesqGeral, API_F11, ULogin, UPrincipal, UPrincipal2;

{$R *.dfm}

procedure TFrmcadusuario.BitBtn1Click(Sender: TObject);
begin
 botoes(self);
 Edit1.Enabled:=true;
 edit1.Color:=clwhite;
 mudaedit(self, true);
 DMeclipse.tbusuario.Insert;
 pode:=false;
end;

procedure TFrmcadusuario.BitBtn2Click(Sender: TObject);
begin
  botoes(self);
  Edit1.Enabled:=true;
  edit1.Color:=clwhite;
  mudaedit(self, true);
  DMeclipse.TBusuario.edit;
  pode:=true;
  if dbedit2.text='admin' then
  begin
    dbedit2.enabled:=false;
    DBRadioGroup1.Enabled:=false;
  end;
end;

procedure TFrmcadusuario.BitBtn3Click(Sender: TObject);
begin
  If messagedlg('Tem certeza que deseja excluir esse usu�rio?'+#13+'Essa opera��o � irrevers�vel!', mtconfirmation, [mbyes, mbno], 0) = mryes then
  begin
     if dbedit2.text='admin' then
      showmessage('Voc� n�o pode excluir o cadastro de Administrador')
     else
      DMeclipse.TBusuario.Delete;
  end;
  pode:=false;
end;

procedure TFrmcadusuario.BitBtn4Click(Sender: TObject);
begin
  botoes(self);
  Edit1.Enabled:=false;
  edit1.Color:=clBtnFace;
  mudaedit(self, false);
  DMeclipse.TBusuario.cancel;
  pode:=false;
end;

procedure TFrmcadusuario.BitBtn5Click(Sender: TObject);
begin
  dbedit2.Text:=trim(DBEdit2.text);
  if dbedit3.Text <> edit1.Text then
  begin
    showmessage('Senhas Incompat�veis');
    dbedit3.Text:='';
    edit1.Text:='';
    dbedit3.SetFocus;
  end
  else if (trim(dbedit3.text)='')or(trim(DBEdit2.text)='')or(DBRadioGroup1.Value='') then
  begin
    showmessage('Preencha corretamente todos os campos');
    DBEdit2.SetFocus;
  end
  else
  begin
    with usu_pesq do
    begin
      Close;
      SQL.Text := 'select *               ';
      SQL.Add('  from tb_usuario       ');
      SQL.Add(' where nome_usu = :nome ');
      Parameters.ParamByName('nome').Value := DBEdit2.text;
      Open;
      if (IsEmpty)or(pode=true)then
      begin
        DBEdit3.Text:=Crypt('C',DBEdit3.text);
        DMeclipse.TBusuario.Post;
        DMeclipse.TBusuario.Refresh;
        botoes(self);
        Edit1.Enabled:=false;
        edit1.Color:=clBtnFace;
        mudaedit(self, false);
      end
      else
      begin
        showmessage('Usu�rio j� existente, escolha outro nome');
        DBEdit2.SetFocus;
      end;
    end;
  end;
end;

procedure TFrmcadusuario.BitBtn7Click(Sender: TObject);
begin
  String_tb.Stabela := 'Usuario';
  String_tb.Scampocod := 'Codigo_usu';
  String_tb.Scamponome := 'Nome_usu';
  String_tb.Qrytb := DMeclipse.TBusuario;
  String_tb.DStb := DMeclipse.DStbusuario;
  abrirpesq(self);
end;

procedure TFrmcadusuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DMeclipse.TBusuario.active:=false;
  if menup='1900' then
  begin
    frmprincipal2.Enabled:=true;
  end
  else
  begin
    application.CreateForm(TFrmPrincipal,FrmPrincipal);
    FrmPrincipal.Show;
  end;
  action:= cafree;
  Frmcadusuario:= nil;
end;

procedure TFrmcadusuario.BitBtn6Click(Sender: TObject);
begin
close;
end;

procedure TFrmcadusuario.FormCreate(Sender: TObject);
begin
  DMeclipse.TBusuario.active:=true;
  Frmcadusuario.Width:=442;
  frmcadusuario.Height:= 252;
  pode:=false;
end;       


procedure TFrmcadusuario.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  If messagedlg('Tem certeza que deseja fechar o formul�rio de cadastro de usu�rios?', mtconfirmation, [mbyes, mbno], 0) = mryes then
  begin
    DMeclipse.TBusuario.cancel;
    canclose:=true;
  end
  else
    canclose:=false;
end;

end.
