unit UnitVertexModelEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, UnitTGraphModel, UnitTypeAndConst,
  UnitSourceStrings;

type
  TFormVertexEdit = class(TForm)
  private
    VMPointer: PVertexModel;
  published
    ButtonOk: TBitBtn;
    ButtonCancel: TBitBtn;
    EditName: TEdit;
    LabelName: TLabel;
    constructor Create(VertexModelPointer: PVertexModel; AOwner: TComponent);
    procedure DestroySelf(NeedToDestroyVertex: Boolean);
    procedure EditNameKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonOkClick(Sender: TObject);
  public
    property VertexPointer: PVertexModel read VMPointer;
  end;


implementation

{$R *.dfm}

{ TFormVertexEdit }

procedure TFormVertexEdit.ButtonOkClick(Sender: TObject);
begin
   if EditName.Text = '' then
      case MessageDlg(MsgEmptyFields, mtWarning, mbOKCancel, 0, mbOK) of
         mrOK:
         begin
            VMPointer^.FName:= EditName.Text;
            ModalResult:= mrOK;
         end;
         mrCancel: ModalResult:= mrNone;
      end
   else
         VMPointer^.FName:= EditName.Text;
end;

constructor TFormVertexEdit.Create(VertexModelPointer: PVertexModel; AOwner: TComponent);
begin
   inherited Create(AOwner);
   VMPointer:= VertexModelPointer;
   EditName.Text:= VertexModelPointer^.FName;
end;

procedure TFormVertexEdit.DestroySelf(NeedToDestroyVertex: Boolean);
begin
   if NeedToDestroyVertex then
      Dispose(VMPointer)
   else
      VMPointer:= nil;
   Self.Destroy;
end;

procedure TFormVertexEdit.EditNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   Line: String;
begin
   Line:= EditName.Text;
   if Length(Line) > NameLength then
   begin
      SetLength(Line, NameLength);
      EditName.Text:= Line;
   end;
end;

end.
