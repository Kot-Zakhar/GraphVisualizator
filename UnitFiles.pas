unit UnitFiles;

interface

uses
   Vcl.Grids, UnitTGraphModel, UnitTGraphView, UnitTypeAndConst, SysUtils, Types;

function SaveGraphToFile(GraphModel: TGraphModel; GraphView: TGraphView;
  FileName: String): Boolean;

function LoadGraphFromFile(var GraphModel: TGraphModel; var GraphView: TGraphView;
  FileName: String): Boolean;

function SaveStringGridToFile(StringGrid: TStringGrid; FileName: String): Boolean;

implementation

function SaveGraphToFile(GraphModel: TGraphModel; GraphView: TGraphView;
  FileName: String): Boolean;
var
   TheFile: TextFile;
   i: Integer;
   VertexesModelsPointers: TVertexesModelsPointers;
begin
   Result:= True;
   with GraphView, GraphModel do
   begin
      AssignFile(TheFile, FileName);
      try
         Rewrite(TheFile);
         Writeln(TheFile, Byte(Oriented));
         Writeln(TheFile, Byte(Weighted));
         VertexesModelsPointers:= GetVertexesModelsPointers;
         Writeln(TheFile, Length(VertexesModelsPointers));
         for i := 0 to High(VertexesModelsPointers) do
         begin
            Writeln(TheFile, VertexesModelsPointers[i]^.FName);
            with GetVertexViewPointer(VertexesModelsPointers[i]^.FIndex)^.FPosition do
               Writeln(TheFile, X, ' ', Y);
         end;
         Writeln(TheFile, Length(EdgesModelsPointers));
         for i := 0 to High(EdgesModelsPointers) do
            with EdgesModelsPointers[i]^ do
            begin
               Writeln(TheFile, FName);
               Writeln(TheFile, FValue);
               Writeln(TheFile, Byte(FDirection));
               Writeln(TheFile, FPFromVertex^.FName);
               Writeln(TheFile, FPToVertex^.FName);
            end;
      except
         Result:= False;
      end;
      CloseFile(TheFile);
//      FileSetReadOnly(FileName, True);
   end;
end;

function LoadGraphFromFile(var GraphModel: TGraphModel; var GraphView: TGraphView;
  FileName: String): Boolean;
var
   TheFile: TextFile;
   i: Integer;
   Amount: Integer;
   EdgeDetails: record
      Name: TName;
      Value: TEdgeValue;
      Direction: Byte;
      FromVertexName, ToVertexName: TName;
   end;
begin
   Result:= FileExists(FileName);
   if Result then
   begin
      AssignFile(TheFile, FileName);
      with GraphModel, GraphView do
         try
            Reset(TheFile);
            // Reading oriented;
            Readln(TheFile, Amount);
            Oriented:= Boolean(Amount);
            // Reading weighted
            Readln(TheFile, Amount);
            Weighted:= Boolean(Amount);
            // Reading the amount of vertexes
            Readln(TheFile, Amount);
            // Reading each vertex details
            for i := 0 to Amount - 1 do
               with CreateNewVertexModel^ do
               begin
                  Readln(TheFile, FName);
                  with CreateNewVertexView(FIndex, TPoint.Create(0, 0), False)^ do
                  begin
                     Read(TheFile, FPosition.X);
                     Readln(TheFile, FPosition.Y);
                  end;
               end;
            // Reading the amount of edges
            Readln(TheFile, Amount);
            for i := 0 to Amount - 1 do
               with EdgeDetails do
               begin
                  Readln(TheFile, Name);
                  Readln(TheFile, Value);
                  Readln(TheFile, Direction);
                  Readln(TheFile, FromVertexName);
                  Readln(TheFile, ToVertexName);
                  with CreateNewEdgeModel(GetVertexModelPointer(FromVertexName),
                    GetVertexModelPointer(ToVertexName), UnitTypeAndConst.TDirection(Direction))^ do
                  begin
                     FName:= Name;
                     FValue:= Value;
                     CreateNewEdgeView(FIndex, FPFromVertex^.FIndex, FPToVertex^.FIndex, False);
                  end;
               end;
         except
            Result:= False;
         end;
      CloseFile(TheFile);
   end;
end;

function SaveStringGridToFile(StringGrid: TStringGrid; FileName: String): Boolean;
var
   TheFile: TextFile;
   i, j: Integer;
begin
   Result:= True;
   with StringGrid do
   begin
      AssignFile(TheFile, FileName);
      try
         Rewrite(TheFile);
         for i := 0 to RowCount - 1 do
         begin
            for j := 0 to ColCount - 1 do
               Write(TheFile, Cells[j, i], #9);
            Writeln(TheFile, '');
         end;
      except
         Result:= False;
      end;
      CloseFile(TheFile);
   end;
end;

end.
