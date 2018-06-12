unit UnitIncidenceMatrix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids,
  UnitFiles, UnitTGraphModel, UnitTypeAndConst, UnitSourceStrings;

type

  TFormIncidenceMatrix = class(TForm)
    MainMenu: TMainMenu;
    IncidenceMatrixGrid: TStringGrid;
    MMFile: TMenuItem;
    MMSaveToFile: TMenuItem;
    SaveDialog: TSaveDialog;
    procedure UpdateMatrix(GraphModel: TGraphModel);
    procedure MMSaveToFileClick(Sender: TObject);
  end;


implementation

{$R *.dfm}

{ TFormIncidenceMatrix }

procedure TFormIncidenceMatrix.MMSaveToFileClick(Sender: TObject);
begin
   SaveDialog.FileName:= '';
   if SaveDialog.Execute then
      if not FileExists(SaveDialog.FileName) or
        (MessageDlg(MsgFileExists + #10#13 + MsgWouldLikeOverwrite, mtConfirmation, mbYesNo, 0, mbYes) = mrYes)  then
         if SaveStringGridToFile(IncidenceMatrixGrid, SaveDialog.FileName) then
            ShowMessage(MsgSaved)
         else
            MMSaveToFileClick(Sender)
      else
         MMSaveToFileClick(Sender);
end;

procedure TFormIncidenceMatrix.UpdateMatrix(GraphModel: TGraphModel);
var
   VertexesModelsPointers: TVertexesModelsPointers;
   i, j: Integer;
begin
   with GraphModel, IncidenceMatrixGrid do
   begin
      VertexesModelsPointers:= GetVertexesModelsPointers;
      ColCount:= Length(EdgesModelsPointers) + 1;
      RowCount:= Length(VertexesModelsPointers) + 1;
      for i := 0 to High(VertexesModelsPointers) do
      begin
         Cells[0, i + 1]:= '''' + VertexesModelsPointers[i]^.FName + '''';
         for j := 0 to High(EdgesModelsPointers) do
         begin
            Cells[j + 1, 0]:= '''' + EdgesModelsPointers[j]^.FName + '''';
            with EdgesModelsPointers[j]^ do
               if ((FDirection = DBidirectional) and
                 ((FPFromVertex = VertexesModelsPointers[i]) or
                 (FPToVertex = VertexesModelsPointers[i])))
                 or (FPFromVertex = VertexesModelsPointers[i]) then
                  Cells[j + 1, i + 1]:= IntToStr(FValue)
               else if (EdgesModelsPointers[j]^.FPToVertex = VertexesModelsPointers[i]) then
                  Cells[j + 1, i + 1]:= IntToStr(-FValue)
               else
                  Cells[j + 1, i + 1]:= '0';
         end;
      end;
   end;
end;

end.
