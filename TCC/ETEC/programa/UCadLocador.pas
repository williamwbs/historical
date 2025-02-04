unit UCadLocador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask, Buttons, ppCtrls, ppVar,
  ppPrnabl, ppClass, ppDB, ppBands, ppCache, ppProd, ppReport, ppComm,
  ppRelatv,shellapi, ppDBPipe, DB, ADODB, ppModule, raCodMod;

type
  TFrmLocador = class(TForm)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    DBComboBox1: TDBComboBox;
    DBRadioGroup2: TDBRadioGroup;
    ppReport1: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppSystemVariable1: TppSystemVariable;
    ppLabel34: TppLabel;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel2: TppLabel;
    ppDBText2: TppDBText;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppLabel4: TppLabel;
    ppDBText4: TppDBText;
    ppLabel5: TppLabel;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppLabel8: TppLabel;
    ppDBText8: TppDBText;
    ppLabel9: TppLabel;
    ppDBText9: TppDBText;
    ppLabel10: TppLabel;
    ppDBText10: TppDBText;
    ppLabel11: TppLabel;
    ppDBText11: TppDBText;
    ppLabel12: TppLabel;
    ppDBText12: TppDBText;
    ppLabel13: TppLabel;
    ppDBText13: TppDBText;
    ppLabel14: TppLabel;
    ppDBText14: TppDBText;
    ppLabel15: TppLabel;
    ppDBText15: TppDBText;
    ppLabel16: TppLabel;
    ppDBText16: TppDBText;
    ppLabel17: TppLabel;
    ppDBText17: TppDBText;
    ppLabel18: TppLabel;
    ppDBText18: TppDBText;
    ppLabel19: TppLabel;
    ppDBText19: TppDBText;
    ppLabel20: TppLabel;
    ppDBText20: TppDBText;
    ppLabel21: TppLabel;
    ppDBText21: TppDBText;
    ppLabel22: TppLabel;
    ppDBText22: TppDBText;
    ppLabel23: TppLabel;
    ppDBText23: TppDBText;
    ppDBText24: TppDBText;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppLabel41: TppLabel;
    ppLabel42: TppLabel;
    ppLabel43: TppLabel;
    ppLabel44: TppLabel;
    ppLabel45: TppLabel;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppFooterBand1: TppFooterBand;
    ppLine6: TppLine;
    ppLabel38: TppLabel;
    raCodeModule1: TraCodeModule;
    ppDBPipeline1: TppDBPipeline;
    ppDBPipeline1ppField1: TppField;
    ppDBPipeline1ppField2: TppField;
    ppDBPipeline1ppField3: TppField;
    ppDBPipeline1ppField4: TppField;
    ppDBPipeline1ppField5: TppField;
    ppDBPipeline1ppField6: TppField;
    ppDBPipeline1ppField7: TppField;
    ppDBPipeline1ppField8: TppField;
    ppDBPipeline1ppField9: TppField;
    ppDBPipeline1ppField10: TppField;
    ppDBPipeline1ppField11: TppField;
    ppDBPipeline1ppField12: TppField;
    ppDBPipeline1ppField13: TppField;
    ppDBPipeline1ppField14: TppField;
    ppDBPipeline1ppField15: TppField;
    ppDBPipeline1ppField16: TppField;
    ppDBPipeline1ppField17: TppField;
    ppDBPipeline1ppField18: TppField;
    ppDBPipeline1ppField19: TppField;
    ppDBPipeline1ppField20: TppField;
    ppDBPipeline1ppField21: TppField;
    ppDBPipeline1ppField22: TppField;
    ppDBPipeline1ppField23: TppField;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure bloqletrarg(Sender: TObject; var Key: Char);
    procedure bloqletra(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLocador: TFrmLocador;



implementation

uses UDMeclipse, API_F11, UpesqGeral, Uatualizar, Math, UPrincipal,
  UPrincipal2;

{$R *.dfm}

procedure TFrmLocador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dmeclipse.TBlocador.active:=false;
  DMeclipse.TBfnlocador.active:=false;
  DMeclipse.TBtpfone.active:=false;
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
  FrmLocador:= nil;
end;

procedure TFrmLocador.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13)then
  begin
    Key := #13;
    SelectNext(ActiveControl,true,true);
  end;
end;

procedure TFrmLocador.BitBtn1Click(Sender: TObject);
begin
  botoes(self);
  mudaedit(self, true);
  DMeclipse.TBlocador.Insert;
  DMeclipse.TBlocadorBlock_loc.AsString:='n';
end;

procedure TFrmLocador.BitBtn2Click(Sender: TObject);
begin
  if not(DMeclipse.TBlocador.IsEmpty)then
  begin
    botoes(self);
    mudaedit(self, true);
    DMeclipse.TBlocador.Edit;
  end
  else
    ShowMessage('N�o existe registro para edi��o.');
end;

procedure TFrmLocador.BitBtn3Click(Sender: TObject);
begin
  if dmeclipse.TBlocador.isempty then
  begin
     showmessage('N�o existe registro a ser excluido');
     exit;
  end;
  If messagedlg('Tem certeza que deseja excluir esse curso?'+#13+'Essa opera��o � irrevers�vel!', mtconfirmation, [mbyes, mbno], 0) = mrno then
    exit;
  DMeclipse.TBlocador.Delete;
end;

procedure TFrmLocador.BitBtn4Click(Sender: TObject);
begin
  botoes(self);
  mudaedit(self, false);
  DMeclipse.TBlocador.Cancel;
end;

procedure TFrmLocador.BitBtn5Click(Sender: TObject);
begin
  trims(self);
  if  (dbedit2.text='')or(DBRadioGroup1.Value='')or((DBEdit4.text='')and(DBEdit5.text=''))or(DBEdit6.text='')or(dbedit7.text='')or(DBComboBox1.text='') then
  begin
    showmessage('Preencha todos os campos requeridos');
    exit;
  end;
  if (cpf(dbedit5.Text)=false)and(dbedit5.text<>'') then
  begin
    showmessage('CPF Inv�lido');
    DBEdit5.SetFocus;
    exit;
  end;
  botoes(self);
  mudaedit(self, false);
  DMeclipse.TBlocador.Post;
  DMeclipse.TBlocador.Refresh;
end;

procedure TFrmLocador.BitBtn6Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmLocador.BitBtn7Click(Sender: TObject);
begin
  String_tb.Stabela := 'Locador';
  String_tb.Scampocod := 'Codigo_loc';
  String_tb.Scamponome := 'Nome_Loc';
  String_tb.Qrytb := DMeclipse.TBlocador;
  String_tb.DStb := DMeclipse.DStblocador;
  abrirpesq(self);
  String_tb.resultcodi := DMeclipse.TBlocadorcodigo_loc.AsInteger;
end;

procedure TFrmLocador.bloqletrarg(Sender: TObject; var Key: Char);
begin
  if ((key<#48)or(key>#57))and(key<>#8)and(key<>#120)and (key<>#88)then
    key:=#0;
end;

procedure TFrmLocador.bloqletra(Sender: TObject; var Key: Char);
begin
  if ((key<#48)or(key>#57))and(key<>#8) then
    key:=#0;
end;

procedure TFrmLocador.FormCreate(Sender: TObject);
begin
  DMeclipse.TBlocador.active:=true;
  DMeclipse.TBfnlocador.active:=true;
  DMeclipse.TBtpfone.active:=true;
end;

procedure TFrmLocador.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  If messagedlg('Tem certeza que deseja fechar o formul�rio de cadastro de aluno?', mtconfirmation, [mbyes, mbno], 0) = mryes then
  begin
    DMeclipse.TBlocador.cancel;
    DMeclipse.TBfnlocador.cancel;
    dmeclipse.TBtpfone.cancel;
    canclose:=true;
  end
  else
    canclose:=false;
end;

procedure TFrmLocador.Label3Click(Sender: TObject);
begin
 ShellExecute(Handle, 'open','http://www.receita.fazenda.gov.br/aplicacoes/ATCTA/cpf/ConsultaPublica.asp', '', '', 1);
end;

end.
