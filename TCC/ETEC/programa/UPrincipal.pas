unit UPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, XPMan, ComCtrls, Buttons, ToolWin, ExtCtrls,
  ShellCtrls,shellapi,pngimage;

type
  TFrmPrincipal = class(TForm)
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    isecretaria: TImage;
    iseguranca: TImage;
    ibiblioteca: TImage;
    iconsulta: TImage;
    iarquivo: TImage;
    ivoluntario: TImage;
    iassociado: TImage;
    ialuno: TImage;
    icurso: TImage;
    iturma: TImage;
    ibackup: TImage;
    irestauracao: TImage;
    ilogeventos: TImage;
    iusuarios: TImage;
    igenero: TImage;
    ilocador: TImage;
    ilocacao: TImage;
    ilivros: TImage;
    iconsultaturma: TImage;
    ilogoff: TImage;
    isair: TImage;
    icontrolbiblioteca: TImage;
    icontrolarquivo: TImage;
    icontrolsecretaria: TImage;
    icontrolseguranca: TImage;
    icontrolconsulta: TImage;
    ihelp: TImage;
    isobre: TImage;
    iajuda: TImage;
    icontrolhelp: TImage;
    iview: TImage;
    procedure Sair1Click(Sender: TObject);
    procedure Aluno1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Associado1Click(Sender: TObject);
    procedure Cargo1Click(Sender: TObject);
    procedure Curso1Click(Sender: TObject);
    procedure Gnero1Click(Sender: TObject);
    procedure Livro1Click(Sender: TObject);
    procedure Locador1Click(Sender: TObject);
    procedure Turma1Click(Sender: TObject);
    procedure Geral1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Voluntrio1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Sair2Click(Sender: TObject);
    procedure HistoricoAluno1Click(Sender: TObject);
    procedure Locao1Click(Sender: TObject);
    procedure Usurio1Click(Sender: TObject);
    procedure Backup1Click(Sender: TObject);
    procedure RestauraodeBackup1Click(Sender: TObject);
    procedure isecretariaClick(Sender: TObject);
    procedure iarquivoClick(Sender: TObject);
    procedure iconsultaClick(Sender: TObject);
    procedure ibibliotecaClick(Sender: TObject);
    procedure isegurancaClick(Sender: TObject);
    procedure tamanho;
    procedure ihelpClick(Sender: TObject);
    procedure iajudaClick(Sender: TObject);
    procedure iviewClick(Sender: TObject);
    procedure isobreClick(Sender: TObject);
    procedure ilogeventosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  i:timage;
  centrov,centroh:integer;
  r:boolean;
implementation

uses API_F11, Math, UCadAluno, UCadAssociado, UCadCargo, UCadCurso,
  UCadGenero, UCadLivro, UCadLocador, UCadTurma, UpesqGeral, Ucadvol,
  UcadHistorico, ULocLivro, Ucadusu, Registry, ULogin, Uconf, UPrincipal2,
  Usobre, Ulog;

{$R *.dfm}

procedure TFrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:= cafree;
  FrmPrincipal:= nil;
end;

procedure TFrmPrincipal.Sair2Click(Sender: TObject);
begin
  descarregarlog;
  Application.Terminate;
end;

procedure TFrmPrincipal.Sair1Click(Sender: TObject);
begin
  descarregarlog;
  FrmLogin.Show;
  Close;
end;

procedure TFrmPrincipal.Aluno1Click(Sender: TObject);
begin
  If(FrmAluno = nil)then
  begin
    Application.CreateForm(TFrmAluno, FrmAluno);
    FrmAluno.Show;
    close;
  end;
end;

procedure TFrmPrincipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key = #13)then
  begin
    Key := #13;
    SelectNext(ActiveControl,true,true);
  end;
end;

procedure TFrmPrincipal.Associado1Click(Sender: TObject);
begin
  If(FrmAssociado = nil)then
  begin
    Application.CreateForm(TFrmAssociado, FrmAssociado);
    FrmAssociado.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Cargo1Click(Sender: TObject);
begin
  If(FrmCargo = nil)then
  begin
    Application.CreateForm(TFrmCargo, FrmCargo);
    FrmCargo.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Curso1Click(Sender: TObject);
begin
  If(FrmCurso = nil)then
  begin
    Application.CreateForm(TFrmCurso, FrmCurso);
    FrmCurso.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Gnero1Click(Sender: TObject);
begin
  If(FrmGenero = nil)then
  begin
    Application.CreateForm(TFrmGenero, FrmGenero);
    FrmGenero.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Livro1Click(Sender: TObject);
begin
  If(FrmLivro = nil)then
  begin
    Application.CreateForm(TFrmLivro, FrmLivro);
    FrmLivro.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Locador1Click(Sender: TObject);
begin
  If(FrmLocador = nil)then
  begin
    Application.CreateForm(TFrmLocador, FrmLocador);
    FrmLocador.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Turma1Click(Sender: TObject);
begin
  If(FrmTurma = nil)then
  begin
    Application.CreateForm(TFrmTurma, FrmTurma);
    FrmTurma.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Geral1Click(Sender: TObject);
begin
  If(Frmpesq = nil)then
  begin
    Application.CreateForm(TFrmpesq, Frmpesq);
    Frmpesq.show;
    close;
  end;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var x:integer;
begin
  String_tb := TString_tb.Create;
  r:=true;
  Image1.Picture.LoadFromFile('imagens\menu\roda.png');
  icontrolhelp.Picture.LoadFromFile('imagens\menu\controlhelp.png');
  icontrolarquivo.Picture.LoadFromFile('imagens\menu\controlarquivo.png');
  icontrolsecretaria.Picture.LoadFromFile('imagens\menu\controlsecretaria.png');
  icontrolconsulta.Picture.LoadFromFile('imagens\menu\controlconsulta.png');
  icontrolseguranca.Picture.LoadFromFile('imagens\menu\controlseguranca.png');
  icontrolbiblioteca.Picture.LoadFromFile('imagens\menu\controlbiblioteca.png');
  iview.Picture.LoadFromFile('imagens\menu\view.png');
  isecretaria.Picture.LoadFromFile('imagens\menu\secretaria.png');
    ialuno.Picture.LoadFromFile('imagens\menu\secretaria\aluno.png');
    iassociado.Picture.LoadFromFile('imagens\menu\secretaria\associado.png');
    ivoluntario.Picture.LoadFromFile('imagens\menu\secretaria\voluntario.png');
    iturma.Picture.LoadFromFile('imagens\menu\secretaria\turma.png');
    icurso.Picture.LoadFromFile('imagens\menu\secretaria\curso.png');
  iseguranca.Picture.LoadFromFile('imagens\menu\seguranca.png');
    ibackup.Picture.LoadFromFile('imagens\menu\seguranca\backup.png');
    irestauracao.Picture.LoadFromFile('imagens\menu\seguranca\restauracaobackup.png');
    iusuarios.Picture.LoadFromFile('imagens\menu\seguranca\usuarios.png');
    ilogeventos.Picture.LoadFromFile('imagens\menu\seguranca\logeventos.png');
  ibiblioteca.Picture.LoadFromFile('imagens\menu\biblioteca.png');
    ilivros.Picture.LoadFromFile('imagens\menu\biblioteca\livros.png');
    ilocador.Picture.LoadFromFile('imagens\menu\biblioteca\locador.png');
    igenero.Picture.LoadFromFile('imagens\menu\biblioteca\genero.png');
    ilocacao.Picture.LoadFromFile('imagens\menu\biblioteca\locacao.png');
  iarquivo.Picture.LoadFromFile('imagens\menu\arquivo.png');
    isair.Picture.LoadFromFile('imagens\menu\arquivo\sair.png');
    ilogoff.Picture.LoadFromFile('imagens\menu\arquivo\logoff.png');
  ihelp.Picture.LoadFromFile('imagens\menu\help.png');
    iajuda.Picture.LoadFromFile('imagens\menu\help\ajuda.png');
    isobre.Picture.LoadFromFile('imagens\menu\help\sobre.png');
  iconsulta.Picture.LoadFromFile('imagens\menu\consulta.png');
    iconsultaturma.Picture.LoadFromFile('imagens\menu\consulta\consultaturma.png');
  centrov:=image1.Top;
  centroh:=image1.Left;
  Image1.left:=(screen.Width div 2)-(image1.Width div 2);
  image1.top:=(screen.Height div 2)-(image1.height div 2);
  centroh:=centroh-image1.Left;
  centrov:=centrov-image1.Top;
    for x:=0 to ComponentCount - 1 do
    begin
      if Components[x].ClassName = 'TImage' then
      begin
        if((Components[x] as TImage).Name <> 'Image1') then
        begin
          (Components[x] as Timage).left := (Components[x] as Timage).left-centroh;
          (Components[x]as TImage).top:=(Components[x]as TImage).top-centrov;
        end;
      end;
    end;
end;

procedure TFrmPrincipal.Voluntrio1Click(Sender: TObject);
begin
  If(frmcadvol = nil)then
  begin
    Application.CreateForm(Tfrmcadvol, frmcadvol);
    frmcadvol.Show;
    close;
  end;
end;

procedure TFrmPrincipal.HistoricoAluno1Click(Sender: TObject);
begin
   If(frmCadHistorico = nil)then
  begin
    Application.CreateForm(TfrmCadHistorico, frmCadHistorico);
    frmCadHistorico.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Locao1Click(Sender: TObject);
begin
  If(FrmLocLivro = nil)then
  begin
    Application.CreateForm(Tfrmloclivro, frmloclivro);
    frmloclivro.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Usurio1Click(Sender: TObject);
begin
  If(Frmcadusuario = nil)then
  begin
    Application.CreateForm(TFrmcadusuario, Frmcadusuario);
    Frmcadusuario.Show;
    close;
  end;
end;

procedure TFrmPrincipal.Backup1Click(Sender: TObject);
begin
  SaveDialog1.Execute;
  copyfile(pchar('bd\bdeclipse.mdb'),pchar(SaveDialog1.filename),true);
end;

procedure TFrmPrincipal.RestauraodeBackup1Click(Sender: TObject);
begin
  if(OpenDialog1.Execute)then
    begin
    If messagedlg('Tem certeza que deseja substituir o Banco de dados?'+#13+'Essa opera��o � irrevers�vel!', mtconfirmation, [mbyes, mbno], 0) = mryes then
    begin
      Application.CreateForm(Tfrmconfirmsenha,frmconfirmsenha);
      frmconfirmsenha.ShowModal;
      if conf=true then
      begin
        copyfile(pchar(OpenDialog1.filename),pchar('bd\bdeclipse.mdb'),false);
      end
      else if cancel<> true then
      begin
        showmessage('Senha Incorreta'+#13+'A se��o ser� encerrada.');
        close;
      end;
    end;
  end;
end;



procedure TFrmPrincipal.isecretariaClick(Sender: TObject);
var w:boolean;
begin
  if User_id.nivel=2 then
    showmessage('Voc� n�o tem permiss�o para acessar essa �rea')
  else
  begin
    w:=true;
    i:=isecretaria;
    if i.Width=112 then
      w:=false;
    tamanho;
    if w=false then
    begin
      ialuno.Visible:=true;
      ivoluntario.Visible:=true;
      iassociado.Visible:=true;
      icurso.Visible:=true;
      iturma.Visible:=true;
      icontrolsecretaria.Visible:=true;
      i.width:=132;
      i.Height:=121;
    end;
  end;
end;

procedure TFrmPrincipal.iarquivoClick(Sender: TObject);
var w:boolean;
begin
  w:=true;
  i:=iarquivo;
  if i.Width=112 then
    w:=false;
  tamanho;
  if w=false then
  begin
    i.width:=132;
    i.Height:=111;
    isair.Visible:=true;
    ilogoff.Visible:=true;
    icontrolarquivo.visible:=true;
  end;
end;

procedure TFrmPrincipal.iconsultaClick(Sender: TObject);
var w:boolean;
begin
  w:=true;
  i:=iconsulta;
  if i.Width=112 then
    w:=false;
  tamanho;
  if w=false then
  begin
    i.width:=132;
    i.Height:=111;
    icontrolconsulta.Visible:=true;
    iconsultaturma.Visible:=true;
  end;
end;

procedure TFrmPrincipal.ibibliotecaClick(Sender: TObject);
var w:boolean;
begin
  if User_id.nivel=1 then
    showmessage('Voc� n�o tem permiss�o para acessar essa �rea')
  else
  begin
    w:=true;
    i:=ibiblioteca;
    if i.Width=112 then
      w:=false;
    tamanho;
    if w=false then
    begin
      i.width:=132;
      i.Height:=111;
      ilocador.Visible:=true;
      ilocacao.Visible:=true;
      ilivros.Visible:=true;
      igenero.Visible:=true;
      icontrolbiblioteca.Visible:=true;
    end;
  end;
end;

procedure TFrmPrincipal.isegurancaClick(Sender: TObject);
var w:boolean;
begin
  if User_id.nivel<>3 then
    showmessage('Voc� n�o tem permiss�o para acessar essa �rea')
  else
  begin
    w:=true;
    i:=iseguranca;
    if i.Width=112 then
      w:=false;
    tamanho;
    if w=false then
    begin
      i.width:=132;
      i.Height:=111;
      iusuarios.Visible:=true;
      ilogeventos.Visible:=true;
      icontrolseguranca.Visible:=true;
      ibackup.Visible:=true;
      irestauracao.Visible:=true;
    end;
  end;
end;

procedure TFrmPrincipal.tamanho;
var x:integer;
begin
  for x:=0 to ComponentCount - 1 do
    begin
      if Components[x].ClassName = 'TImage' then
      begin
        if (((Components[x] as TImage).Name = 'ihelp')or((Components[x] as TImage).Name = 'iarquivo')or((Components[x] as TImage).Name = 'isecretaria')or((Components[x] as TImage).Name = 'ibiblioteca')or((Components[x] as TImage).Name = 'iconsulta')or((Components[x] as TImage).Name = 'iseguranca'))and((Components[x] as TImage).Width<>100) then
        begin
          if ((Components[x] as TImage).Name = 'ihelp') then
          begin;
            (Components[x] as Timage).width := 100;
            (Components[x]as TImage).Height:=100;
            (Components[x] as Timage).left:=(screen.Width div 2)-((Components[x] as Timage).Width div 2);
            (Components[x] as Timage).top:=(screen.Height div 2)-((Components[x] as Timage).height div 2);
          end
          else
          begin
            (Components[x] as Timage).width := 112;
            (Components[x]as TImage).Height:=91;
          end;
        end
        else if ((Components[x] as TImage).Name <> 'iview')and((Components[x] as TImage).Name <> 'ihelp')and((Components[x] as TImage).Name <> 'Image1')and ((Components[x] as TImage).Name <> 'iarquivo')and((Components[x] as TImage).Name <> 'isecretaria')and((Components[x] as TImage).Name <> 'ibiblioteca')and((Components[x] as TImage).Name <> 'iconsulta')and((Components[x] as TImage).Name <> 'iseguranca') then
        begin
          (Components[x]as TImage).Visible:=false;
        end;
      end;
    end;
end;

procedure TFrmPrincipal.ihelpClick(Sender: TObject);
var w:boolean;
begin
  w:=true;
  i:=ihelp;
  if i.Width=100 then
    w:=false;
  tamanho;
  if w=false then
  begin
    i.width:=150;
    i.Height:=150;
    iajuda.Visible:=true;
    isobre.Visible:=true;
    icontrolhelp.Visible:=true;
  end;
  i.left:=(screen.Width div 2)-(i.Width div 2);
  i.top:=(screen.Height div 2)-(i.height div 2);

end;

procedure TFrmPrincipal.iajudaClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open','help\eclipsehelp.chm', '', '', 1);
  ihelpClick(ihelp);
end;

procedure TFrmPrincipal.iviewClick(Sender: TObject);
begin
  rewrite(p);
  writeln(p,crypt('C','1900'));
  closefile(p);
  menup:='1900';
  application.CreateForm(tfrmprincipal2,frmprincipal2);
  frmprincipal2.show;
  close;
end;

procedure TFrmPrincipal.isobreClick(Sender: TObject);
begin
  If(FrmSobre = nil)then
  begin
    Application.CreateForm(Tfrmsobre, frmsobre);
    FrmSobre.ShowModal;
  end;
end;

procedure TFrmPrincipal.ilogeventosClick(Sender: TObject);
begin
  If(frmlog = nil)then
  begin
    Application.CreateForm(Tfrmlog, frmlog);
    frmlog.Show;
    close;
  end;
end;

end.
