unit UnitAdjacencyMatrix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids,
  UnitFiles, UnitTGraphModel, UnitTypeAndConst, UnitSourceStrings;

type

  TFormAdjacencyMatrix = class(TForm)
    MainMenu: TMainMenu;
    AdjacencyMatrixGrid: TStringGrid;
    MMFile: TMenuItem;
    MMSaveToFile: TMenuItem;
    SaveDialog: TSaveDialog;
    procedure UpdateMatrix(GraphModel: TGraphModel);
    procedure MMSaveToFileClick(Sender: TObject);
  end;


implementation

{$R *.dfm}

{ TFormAdjacencyMatrix }

procedure TFormAdjacencyMatrix.MMSaveToFileClick(Sender: TObject);
begin
   SaveDialog.FileName:= '';
   if SaveDialog.Execute then
      if not FileExists(SaveDialog.FileName) or
        (MessageDlg(MsgFileExists + #10#13 + MsgWouldLikeOverwrite, mtConfirmation, mbYesNo, 0, mbYes) = mrYes)  then
         if SaveStringGridToFile(AdjacencyMatrixGrid, SaveDialog.FileName) then
            ShowMessage(MsgSaved)
         else
            MMSaveToFileClick(Sender)
      else
         MMSaveToFileClick(Sender);
end;

procedure TFormAdjacencyMatrix.UpdateMatrix(GraphModel: TGraphModel);
var
   VertexesModelsPointers: TVertexesModelsPointers;
   i, j: Integer;
begin
   with GraphModel, AdjacencyMatrixGrid do
   begin
      VertexesModelsPointers:= GetVertexesModelsPointers;
      ColCount:= Length(VertexesModelsPointers) + 1;
      RowCount:= Length(VertexesModelsPointers) + 1;
      for i := 0 to High(VertexesModelsPointers) do
         with VertexesModelsPointers[i]^ do
         begin
            Cells[0, i + 1]:= '''' + VertexesModelsPointers[i]^.FName + '''';
            Cells[i + 1, 0]:= '''' + VertexesModelsPointers[i]^.FName + '''';
            for j := 0 to High(VertexesModelsPointers) do
               if FPNeighborsList^.GetVertexPointerOfNeighbor(VertexesModelsPointers[j]^.FIndex) <> nil then
                  Cells[j + 1, i + 1]:= '1'
               else
                  Cells[j + 1, i + 1]:= '0';
         end;
   end;
end;

end.
