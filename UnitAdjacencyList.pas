unit UnitAdjacencyList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids,
  UnitFiles, UnitTGraphModel, UnitTypeAndConst, UnitSourceStrings;

type

  TFormAdjacencyList = class(TForm)
    MainMenu: TMainMenu;
    AdjacencyListGrid: TStringGrid;
    MMFile: TMenuItem;
    MMSaveToFile: TMenuItem;
    SaveDialog: TSaveDialog;
    procedure UpdateMatrix(GraphModel: TGraphModel);
    procedure MMSaveToFileClick(Sender: TObject);
  end;


implementation

{$R *.dfm}

{ TFormAdjacencyList }

procedure TFormAdjacencyList.MMSaveToFileClick(Sender: TObject);
begin
   SaveDialog.FileName:= '';
   if SaveDialog.Execute then
      if not FileExists(SaveDialog.FileName) or
        (MessageDlg(MsgFileExists + #10#13 + MsgWouldLikeOverwrite, mtConfirmation, mbYesNo, 0, mbYes) = mrYes)  then
         if SaveStringGridToFile(AdjacencyListGrid, SaveDialog.FileName) then
            ShowMessage(MsgSaved)
         else
            MMSaveToFileClick(Sender)
      else
         MMSaveToFileClick(Sender);
end;

procedure TFormAdjacencyList.UpdateMatrix(GraphModel: TGraphModel);
var
   VMP, CurrentNeighborsVMP: TVertexesModelsPointers;
   i, j: Integer;
begin
   with GraphModel, AdjacencyListGrid do
   begin
      VMP:= GetVertexesModelsPointers;
      ColCount:= Length(VMP);
      Cells[0,0]:= '';
      RowCount:= Length(VMP);

      for i := 0 to High(VMP) do
         with VMP[i]^ do
         begin
            Cells[0, i]:= '''' + VMP[i]^.FName + ''':';
            CurrentNeighborsVMP:= FPNeighborsList^.GetNeighborsPointers;
            for j := 0 to High(CurrentNeighborsVMP) do
               Cells[j + 1, i]:= CurrentNeighborsVMP[j]^.FName;
            for j := High(CurrentNeighborsVMP) + 1 to High(VMP) + 1 do
               Cells[j + 1, i]:= '';
         end;
   end;
end;

end.
