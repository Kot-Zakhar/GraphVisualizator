unit UnitEdgeEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  UnitTGraphModel, UnitTypeAndConst, UnitSourceStrings, UnitTGraphView,
  Vcl.ExtCtrls;

type
   TFormEdgeEdit = class(TForm)
      ButtonCancel: TBitBtn;
      ButtonOk: TBitBtn;
      LabelName: TLabel;
      EditName: TEdit;
      LabelValue: TLabel;
      EditValue: TEdit;
      RadioGroupDirection: TRadioGroup;
      LabeledEditVertex1: TLabeledEdit;
      LabeledEditVertex2: TLabeledEdit;
      ButtonSwapVertexes: TBitBtn;
      constructor Create(EdgeModelPointer: PEdgeModel; EdgeViewPointer: PEdgeView;
        GraphOriented, GraphWeighted: Boolean; AOwner: TComponent);
      procedure EditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure EditValueKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
      procedure ButtonOkClick(Sender: TObject);
      procedure PanelOrientedMouseEnter(Sender: TObject);
      procedure RadioBidirectionalClick;
      procedure RadioUnidirectionalClick;
      procedure RadioGroupDirectionClick(Sender: TObject);
      procedure ButtonSwapVertexesClick(Sender: TObject);
   private
      EMPointer: PEdgeModel;
      EVPointer: PEdgeView;
      Weighted, Oriented: Boolean;
   end;


implementation

{$R *.dfm}

procedure TFormEdgeEdit.ButtonOkClick(Sender: TObject);
var
   TempVertexModelPointer: PVertexModel;
   TempVertexViewPointer: PVertexView;
begin
   if (EditValue.Text <> '') then
      with EMPointer^ do
      begin
         FName:= EditName.Text;
         if Weighted then
            FValue:= StrToInt(EditValue.Text);
         if Oriented then
            if (RadioGroupDirection.ItemIndex = Integer(DBidirectional)) and (FDirection <> DBidirectional) then
            begin
               FDirection:= DBidirectional;
               FPFromVertex^.FPNeighborsList^.CreateNewNeighbor(EMPointer^.FPToVertex, EMPointer);
            end
            else if RadioGroupDirection.ItemIndex = Integer(DUnidirectional) then
            begin
               if EMPointer^.FDirection = DBidirectional then
               begin
                  FPToVertex^.FPNeighborsList^.RemoveNeighbor(FPFromVertex);
                  FDirection:= DUnidirectional;
               end;
               if FPFromVertex^.FName <> LabeledEditVertex1.Text then
               begin
                  FPToVertex^.FPNeighborsList^.CreateNewNeighbor(FPFromVertex, EMPointer);
                  FPFromVertex^.FPNeighborsList.RemoveNeighbor(FPToVertex);
                  TempVertexModelPointer:= FPToVertex;
                  FPToVertex:= FPFromVertex;
                  FPFromVertex:= TempVertexModelPointer;
                  with EVPointer^ do
                  begin
                     TempVertexViewPointer:= FPStartVertexView;
                     FPStartVertexView:= FPEndVertexView;
                     FPEndVertexView:= TempVertexViewPointer;
                  end;
               end;
            end;
      end
      else
         case MessageDlg(MsgEmptyFields + #10#13 + MsgWontSave, mtWarning, mbOKCancel, 0, mbOK) of
            mrOk: ModalResult:= mrCancel;
            mrCancel: ModalResult:= mrNone;
         end
end;

procedure TFormEdgeEdit.ButtonSwapVertexesClick(Sender: TObject);
var
   TempString: String;
begin
   TempString:= LabeledEditVertex1.Text;
   LabeledEditVertex1.Text:= LabeledEditVertex2.Text;
   LabeledEditVertex2.Text:= TempString;
end;

constructor TFormEdgeEdit.Create(EdgeModelPointer: PEdgeModel;
  EdgeViewPointer: PEdgeView; GraphOriented, GraphWeighted: Boolean;
  AOwner: TComponent);
begin
   Oriented:= GraphOriented;
   Weighted:= GraphWeighted;
   Inherited Create(AOwner);
   EMPointer:= EdgeModelPointer;
   EVPointer:= EdgeViewPointer;
   EditName.Text:= EdgeModelPointer^.FName;
   EditValue.Text:= IntToStr(EdgeModelPointer^.FValue);
   EditValue.Enabled := Weighted;
   LabeledEditVertex1.Text:= EMPointer^.FPFromVertex^.FName;
   LabeledEditVertex2.Text:= EMPointer^.FPToVertex^.FName;
   if not Oriented then
   begin
      LabeledEditVertex1.Visible:= False;
      LabeledEditVertex2.Visible:= False;
      ButtonSwapVertexes.Visible:= False;
      RadioGroupDirection.Visible:= False;
      ButtonOk.Top:= 102;
      ButtonCancel.Top:= 102;
      Self.Height:= 180;
   end
   else
   begin
      RadioGroupDirection.ItemIndex:= Integer(EdgeModelPointer^.FDirection);
   end;
end;

procedure TFormEdgeEdit.EditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   Line: String;
begin
   with (Sender as TEdit) do
   begin
      Line:= Text;
      if Length(Line) > NameLength then
      begin
         SetLength(Line, NameLength);
         Text:= Line;
      end;
   end;
end;

procedure TFormEdgeEdit.EditValueKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   Line: String;
   i: Integer;
begin
   with (Sender as TEdit) do
   begin
      Line:= Text;
      for i := 0 to Length(Line) - 1 do
         if not (Line[i] in ['0'..'9']) then
            Delete(Line, i, 1);
      if Line <> Text then
         Text:= Line;
   end;              
end;

procedure TFormEdgeEdit.PanelOrientedMouseEnter(Sender: TObject);
begin
   ShowHint:= True;
end;

procedure TFormEdgeEdit.RadioBidirectionalClick;
begin
   LabeledEditVertex1.Visible:= False;
   LabeledEditVertex2.Visible:= False;
   ButtonSwapVertexes.Visible:= False;
   ButtonOk.Top:= 172;
   ButtonCancel.Top:= 172;
   Self.Height:= 245;
end;

procedure TFormEdgeEdit.RadioGroupDirectionClick(Sender: TObject);
begin
   if RadioGroupDirection.ItemIndex = 0 then
      RadioBidirectionalClick
   else
      RadioUnidirectionalClick;
end;

procedure TFormEdgeEdit.RadioUnidirectionalClick;
begin
   LabeledEditVertex1.Visible:= True;
   LabeledEditVertex2.Visible:= True;
   ButtonSwapVertexes.Visible:= True;
   ButtonOk.Top:= 223;
   ButtonCancel.Top:= 223;
   Self.Height:= 298;
end;

end.
