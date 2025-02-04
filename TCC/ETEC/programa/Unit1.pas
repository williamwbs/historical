unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, DB, ADODB, Buttons;

type
  TfrmPesq_hist = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    ADOpesq_hist: TADOQuery;
    ADOpesq_histnome_alu: TWideStringField;
    ADOpesq_histnome_cur: TWideStringField;
    ADOpesq_histnfaltas: TWideStringField;
    ADOpesq_histstatus_alu: TWideStringField;
    ADOpesq_histobs_alu: TMemoField;
    ADOpesq_histmediafinal_alu: TWideStringField;
    ADOpesq_histdt_ini: TDateTimeField;
    ADOpesq_histnome_tur: TWideStringField;
    ADOpesq_histdt_fin: TDateTimeField;
    ADOpesq_histdt_prev: TDateTimeField;
    ADOpesq_histhorario_tur: TWideStringField;
    dspesq_hist: TDataSource;
    ADOpesq_histcodigo_alu: TAutoIncField;
    Button1: TButton;
    ADOpesq_histcodigo_hist: TAutoIncField;
    ComboBox2: TComboBox;
    ADOCURSO: TADOQuery;
    ADOCURSOcodigo_cur: TAutoIncField;
    ADOCURSOnome_cur: TWideStringField;
    Btnloc: TBitBtn;
    CheckBox1: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure BtnlocClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPesq_hist: TfrmPesq_hist;

implementation

uses API_F11, UpesqGeral, UDMeclipse, Uatualizar, UcadHistorico;

{$R *.dfm}

procedure TfrmPesq_hist.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  nomealu:=ADOpesq_histnome_alu.AsString;
  nomecur:=ADOpesq_histnome_cur.AsString;
  ADOpesq_hist.Close;
  ADOpesq_hist.Active := false;
  action:= cafree;
  frmPesq_hist:= nil;
end;

procedure TfrmPesq_hist.DBGrid1DblClick(Sender: TObject);
begin
  DMeclipse.TBhistorico.Close;
  DMeclipse.TBhistorico.SQL.Text := 'SELECT * FROM TB_HISTORICO WHERE CODIGO_HIST = :CODI';
  DMeclipse.TBhistorico.Parameters.ParamByName('CODI').Value := ADOpesq_histcodigo_hist.AsInteger;
  DMeclipse.TBhistorico.Open;
//  DMeclipse.TBhistoricocodigo_tur.AsInteger := ADOpesq_histcodigo_hist.AsInteger;
  Button1.Click;
end;

procedure TfrmPesq_hist.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPesq_hist.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13)then
  begin
    Key := #13;
    SelectNext(ActiveControl,true,true);
  end;
end;

procedure TfrmPesq_hist.FormShow(Sender: TObject);
begin
  ADOpesq_hist.Active := true;
  ADOCURSO.Open;
  if not(ADOCURSO.IsEmpty)then
  begin
    ADOCURSO.First;
    while not ADOCURSO.Eof do
    begin
      ComboBox2.Items.Add(ADOCURSOnome_cur.AsString);
      ADOCURSO.Next;
    end;
  ComboBox2.ItemIndex := 0;
  end;
end;

procedure TfrmPesq_hist.BtnlocClick(Sender: TObject);
begin
  with ADOpesq_hist do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT tb_aluno.codigo_alu,                                      ');
    SQL.Add('       tb_aluno.nome_alu,                                        ');
    SQL.Add('       tb_curso.nome_cur,                                        ');
    SQL.Add('       tb_historico.codigo_hist,                                 ');
    SQL.Add('       tb_historico.nfaltas,                                     ');
    SQL.Add('       tb_historico.status_alu,                                  ');
    SQL.Add('       tb_historico.obs_alu,                                     ');
    SQL.Add('       tb_historico.mediafinal_alu,                              ');
    SQL.Add('       tb_turma.dt_ini,                                          ');
    SQL.Add('       tb_turma.nome_tur,                                        ');
    SQL.Add('       tb_turma.dt_fin,                                          ');
    SQL.Add('       tb_turma.dt_prev,                                         ');
    SQL.Add('       tb_turma.horario_tur                                      ');
    SQL.Add('FROM (tb_curso INNER JOIN tb_turma ON tb_curso.codigo_cur = tb_turma.codigo_cur)                             ');
    SQL.Add('               INNER JOIN (tb_aluno INNER JOIN tb_historico ON tb_aluno.codigo_alu = tb_historico.codigo_alu)');
    SQL.Add('                                                            ON tb_turma.codigo_tur = tb_historico.codigo_tur ');
    SQL.Add('WHERE                                                             ');
    if(ComboBox1.ItemIndex = 1)then
      SQL.Add('tb_aluno.codigo_alu = :codi                                       ');
    if(ComboBox1.ItemIndex = 0)then
      SQL.Add('tb_aluno.nome_alu Like :nome                                      ');
    if(ComboBox1.ItemIndex = 2)then
      SQL.Add('tb_turma.dt_ini > :dt                                             ');

    if(ComboBox2.Enabled)then
    begin
      SQL.Add('and tb_curso.nome_cur like :Ntur');
      Parameters.ParamByName('Ntur').Value := ComboBox2.Text;
    end;

    if(ComboBox1.ItemIndex = 1)then
      Parameters.ParamByName('codi').Value := Edit1.Text;
    if(ComboBox1.ItemIndex = 0)then
      Parameters.ParamByName('nome').Value := Edit1.Text;
    if(ComboBox1.ItemIndex = 2)then
      Parameters.ParamByName('dt').Value := Edit1.Text;
    Open;
  end;
end;

procedure TfrmPesq_hist.CheckBox1Click(Sender: TObject);
begin
  ComboBox2.Enabled := CheckBox1.Checked;
end;

procedure TfrmPesq_hist.FormCreate(Sender: TObject);
begin
  Edit1.Text:='%';
  Btnloc.Click;
  edit1.Text:='';
end;

end.
