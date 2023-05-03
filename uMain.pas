unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  System.IOUtils, // Para hacer uso de TPath.
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.Bind.Controls, FMX.StdCtrls, FMX.Layouts, FMX.Bind.Navigator,
  FMX.DateTimeCtrls, FMX.EditBox, FMX.SpinBox, FMX.Edit,
  FMX.Controls.Presentation, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope;

type
  TfrmMain = class(TForm)
    ToolBar1: TToolBar;
    btnOpenDB: TButton;
    pnlData: TPanel;
    lblNc: TLabel;
    edtNoControl: TEdit;
    lblN: TLabel;
    edtNombre: TEdit;
    rdbM: TRadioButton;
    rdbF: TRadioButton;
    Label1: TLabel;
    spnEdad: TSpinBox;
    lblE: TLabel;
    DateEdit1: TDateEdit;
    lblF: TLabel;
    BindNavigator1: TBindNavigator;
    StatusBar1: TStatusBar;
    lblStatus: TLabel;
    DB: TFDConnection;
    tblAlumno: TFDTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkPropertyToFieldIsChecked: TLinkPropertyToField;
    LinkPropertyToFieldIsChecked2: TLinkPropertyToField;
    LinkControlToField4: TLinkControlToField;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnOpenDBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  dbFileName: String;

implementation

{$R *.fmx}

procedure TfrmMain.btnOpenDBClick(Sender: TObject);
begin
  // Si el botón está en modo "Conectar".
  if btnOpenDB.Text = 'Conectar' then
  begin
    // Cambia el texto del botón a "Desconectar".
    btnOpenDB.Text := 'Desconectar';

    // Código para la Conexión.
    try
      DB.Connected := true;
      lblStatus.Text := 'Data Base: ON 🟢';
      pnlData.Enabled := true;
      tblAlumno.Active := true;
    except
      on E: Exception do
        lblStatus.Text := 'Data Base: OFF 🔴 Error: Intente de nuevo.';
    end;
  end
  // Si el botón está en modo "Desconectar".
  else
  begin
    // Cambia el texto del botón a "Conectar".
    btnOpenDB.Text := 'Conectar';
    // Código para la desconexión.
    DB.Connected := false;
    lblStatus.Text := 'Data Base: OFF 🔴';
    pnlData.Enabled := false;
    tblAlumno.Active := false;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  // por si se olvida desconcetar en tiempo de diseño
  DB.Connected := false;
  // configurar el componente de conexion FDConnection
  // ubicacion de la bd
{$IF DEFINED(MSWINDOWS)}
  // windows
  dbFileName := 'C:\Users\leone\OneDrive\Documentos\Embarcadero\Studio\Projects\SQLiteDemo\escolar.db';
{$ELSE}
  // Android, iOS, Mac
  dbFileName := TPath.Combine(TPath.GetDocumentsPath, 'escolar.db');
{$ENDIF}
  DB.Params.Database := dbFileName;
  lblStatus.Text := 'db off';
  // para evitar que el usuario intente usar los datos
  pnlData.Enabled := false;
end;

end.
