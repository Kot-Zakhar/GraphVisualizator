unit UnitTGraphView;

interface

uses
   Vcl.Graphics, System.SysUtils, System.Types,
   UnitTypeAndConst, Math, UnitTGraphModel;     //  can i use it without last one

const
   DefaultVertexColor: TColor = clWhite;

type
//----------------------------- Pointers -------------------------------------//
   PEdgeView = ^TEdgeView;
   PVertexView = ^TVertexView;
   PGraphViewEdge = ^TGraphViewEdge;
   PGraphViewVertex = ^TGraphViewVertex;

   TVertexesViewsPointers = array of PVertexView;
   TEdgesViewsPointers = array of PEdgeView;


   TVertexView = record
      FIndex: TIndex;
      FPosition: TPoint;
      FIsSelected: Boolean;
      constructor Create(VertexIndex: TIndex;
                         Position: TPoint;
                         IsSelected: Boolean);
   end;

   TGraphViewVertex = record
      FPNextGraphViewVertex: PGraphViewVertex;
      FPVertexView: PVertexView;
      procedure CreateEmpty;
   end;

   TEdgeView = record
      FIndex: TIndex;
      FPStartVertexView, FPEndVertexView: PVertexView;
      FIsSelected: Boolean;
      constructor Create(EdgeIndex: TIndex;
                         StartVertexViewPointer, EndVertexViewPointer: PVertexView;
                         IsSelected: Boolean);
   end;

   TGraphViewEdge = record
      FPNextGraphViewEdge: PGraphViewEdge;
      FPEdgeView: PEdgeView;
      procedure CreateEmpty;
   end;

   TGraphView = class (TObject)
      private
         FPVertexViewHead, FPVertexViewTail: PGraphViewVertex;
         FPEdgeViewHead, FPEdgeViewTail: PGraphViewEdge;
      public
         FVertexUnderMousePointer: PVertexView;
         FEdgeUnderMousePointer: PEdgeView;
         // creating
         constructor Create;
         function CreateNewVertexView(VertexIndex: TIndex;
            Position: TPoint; IsSelected: Boolean = False): PVertexView;
         function CreateNewEdgeView(EdgeIndex, FromVertexIndex, ToVertexIndex: TIndex;
            IsSelected: Boolean = False): PEdgeView;
         // getting
         function GetVertexViewPointer(VertexIndex: TIndex): PVertexView;
         function GetEdgeViewPointer(EdgeIndex: TIndex): PEdgeView;
         function GetSelectedVertexesViewsPointers: TVertexesViewsPointers;
         function GetSelectedEdgesViewsPointers: TEdgesViewsPointers;
         function GetVertexesViewsPointers: TVertexesViewsPointers;
         function GetEdgesViewsPointers: TEdgesViewsPointers;
         function GetEdgesViewsPointersWithVertex(VertexViewPointer: PVertexView): TEdgesViewsPointers;
         function IsPointOnEdge(Point: TPoint): PEdgeView;
         function IsPointOnVertex(Point: TPoint; VertexRadius: Word): PVertexView;
         // Reset
         procedure PaintGraphOnCanvas(Canvas: TCanvas;
            CurrentGraphModel: TGraphModel; ViewSettings: TVisualSettings);
         procedure ResetSelection;
         procedure SelectAll;
         // deleting
         destructor Destroy; override;
         procedure RemoveEdgeView(EdgeViewPointer: PEdgeView);
         procedure RemoveVertexView(VertexViewPointer: PVertexView);


      end;

implementation

{ TGraphView }

constructor TGraphView.Create;
begin
   New(FPVertexViewHead);
   FPVertexViewTail:= FPVertexViewHead;
   FPVertexViewHead^.CreateEmpty;
   New(FPEdgeViewHead);
   FPEdgeViewTail:= FPEdgeViewHead;
   FPEdgeViewHead^.CreateEmpty;
   FVertexUnderMousePointer:= nil;
   FEdgeUnderMousePointer:= nil;
end;

function TGraphView.CreateNewEdgeView(EdgeIndex, FromVertexIndex,
  ToVertexIndex: TIndex; IsSelected: Boolean = False): PEdgeView;
begin
   New(FPEdgeViewTail^.FPNextGraphViewEdge);
   FPEdgeViewTail:= FPEdgeViewTail^.FPNextGraphViewEdge;
   with FPEdgeViewTail^ do
   begin
      CreateEmpty;
      New(FPEdgeView);
      FPEdgeView^.Create(EdgeIndex,
                         GetVertexViewPointer(FromVertexIndex),
                         GetVertexViewPointer(ToVertexIndex),
                         IsSelected);
      Result:= FPEdgeView;
   end;
end;

function TGraphView.CreateNewVertexView(VertexIndex: TIndex;
   Position: TPoint;
   IsSelected: Boolean = False): PVertexView;
begin
   New(FPVertexViewTail^.FPNextGraphViewVertex);
   FPVertexViewTail:= FPVertexViewTail^.FPNextGraphViewVertex;
   with FPVertexViewTail^ do
   begin
      CreateEmpty;
      New(FPVertexView);
      FPVertexView^.Create(VertexIndex,
                           Position,
                           IsSelected);
      Result:= FPVertexView;
   end;
end;

destructor TGraphView.Destroy;
var
   CurrentVVToDeletePointer: PGraphViewVertex;
   CurrentEVToDeletePointer: PGraphViewEdge;
begin
   FPVertexViewTail:= FPVertexViewHead^.FPNextGraphViewVertex;
   while FPVertexViewTail <> nil do
   begin
      CurrentVVToDeletePointer:= FPVertexViewTail;
      FPVertexViewTail:= FPVertexViewTail^.FPNextGraphViewVertex;
      Dispose(CurrentVVToDeletePointer^.FPVertexView);
      Dispose(CurrentVVToDeletePointer);
   end;
   Dispose(FPVertexViewHead);
   FPVertexViewHead:= nil;
   FPEdgeViewTail:= FPEdgeViewHead^.FPNextGraphViewEdge;
   while FPEdgeViewTail <> nil do
   begin
      CurrentEVToDeletePointer:= FPEdgeViewTail;
      FPEdgeViewTail:= FPEdgeViewTail^.FPNextGraphViewEdge;
      Dispose(CurrentEVToDeletePointer^.FPEdgeView);
      Dispose(CurrentEVToDeletePointer);
   end;
   Dispose(FPEdgeViewHead);
   FPEdgeViewHead:= nil;
   inherited;
end;

function TGraphView.GetEdgesViewsPointers: TEdgesViewsPointers;
var
   CurrentGVEdgePointer: PGraphViewEdge;
begin
   if FPEdgeViewHead <> nil then
   begin
      SetLength(Result, 0);
      CurrentGVEdgePointer:= FPEdgeViewHead^.FPNextGraphViewEdge;
      while CurrentGVEdgePointer <> nil do
      begin
         SetLength(Result, Length(Result) + 1);
         Result[High(Result)]:= CurrentGVEdgePointer^.FPEdgeView;
         CurrentGVEdgePointer:= CurrentGVEdgePointer^.FPNextGraphViewEdge;
      end;
   end;
end;

function TGraphView.GetEdgesViewsPointersWithVertex(
  VertexViewPointer: PVertexView): TEdgesViewsPointers;
var
   GraphViewEdgePointer: PGraphViewEdge;
begin
   if FPVertexViewHead <> nil then
   begin
      SetLength(Result, 0);
      GraphViewEdgePointer:= FPEdgeViewHead^.FPNextGraphViewEdge;
      while GraphViewEdgePointer <> nil do
      begin
         if (GraphViewEdgePointer^.FPEdgeView^.FPStartVertexView = VertexViewPointer) or
            (GraphViewEdgePointer^.FPEdgeView^.FPEndVertexView = VertexViewPointer) then
         begin
            SetLength(Result, Length(Result) + 1);
            Result[High(Result)]:= GraphViewEdgePointer^.FPEdgeView;
         end;
         GraphViewEdgePointer:= GraphViewEdgePointer^.FPNextGraphViewEdge;
      end;
   end;
end;

function TGraphView.GetEdgeViewPointer(EdgeIndex: TIndex): PEdgeView;
var
   CurrentGVEdgePointer: PGraphViewEdge;
begin
   CurrentGVEdgePointer:= FPEdgeViewHead^.FPNextGraphViewEdge;
   while (CurrentGVEdgePointer <> nil) and
      (CurrentGVEdgePointer^.FPEdgeView^.FIndex <> EdgeIndex) do
      CurrentGVEdgePointer:= CurrentGVEdgePointer^.FPNextGraphViewEdge;
   if CurrentGVEdgePointer <> nil then
      Result:= CurrentGVEdgePointer^.FPEdgeView
   else
      Result:= nil;
end;

function TGraphView.GetSelectedEdgesViewsPointers: TEdgesViewsPointers;
var
   CurrentGVEP: PGraphViewEdge;
begin
   SetLength(Result, 0);
   CurrentGVEP:= FPEdgeViewHead^.FPNextGraphViewEdge;
   while CurrentGVEP <> nil do
   begin
      if CurrentGVEP^.FPEdgeView^.FIsSelected then
      begin
         SetLength(Result, Length(Result) + 1);
         Result[High(Result)]:= CurrentGVEP^.FPEdgeView;
      end;
         CurrentGVEP:= CurrentGVEP^.FPNextGraphViewEdge;
   end;
end;

function TGraphView.GetSelectedVertexesViewsPointers: TVertexesViewsPointers;
var
   CurrentGVVP: PGraphViewVertex;
begin
   SetLength(Result, 0);
   CurrentGVVP:= FPVertexViewHead^.FPNextGraphViewVertex;
   while CurrentGVVP <> nil do
   begin
      if CurrentGVVP^.FPVertexView^.FIsSelected then
      begin
         SetLength(Result, Length(Result) + 1);
         Result[High(Result)]:= CurrentGVVP^.FPVertexView;
      end;
      CurrentGVVP:= CurrentGVVP^.FPNextGraphViewVertex;
   end;
end;

function TGraphView.GetVertexesViewsPointers: TVertexesViewsPointers;
var
   CurrentGVVPointer: PGraphViewVertex;
begin
   if FPVertexViewHead <> nil then
   begin
      SetLength(Result, 0);
      CurrentGVVPointer:=  FPVertexViewHead^.FPNextGraphViewVertex;
      while CurrentGVVPointer <> nil do
      begin
         SetLength(Result, Length(Result) + 1);
         Result[High(Result)]:= CurrentGVVPointer^.FPVertexView;
         CurrentGVVPointer:= CurrentGVVPointer^.FPNextGraphViewVertex;
      end;
   end;
end;

function TGraphView.GetVertexViewPointer(VertexIndex: TIndex): PVertexView;
var
   CurrentGVVPointer: PGraphViewVertex;
begin
   Result:= nil;
   CurrentGVVPointer:= FPVertexViewHead^.FPNextGraphViewVertex;
   while (CurrentGVVPointer <> nil) and (CurrentGVVPointer^.FPVertexView^.FIndex <> VertexIndex) do
      CurrentGVVPointer:= CurrentGVVPointer^.FPNextGraphViewVertex;
   if CurrentGVVPointer <> nil then
      Result:= CurrentGVVPointer^.FPVertexView;
end;

function TGraphView.IsPointOnEdge(Point: TPoint): PEdgeView;
var
   GVEPointer: PGraphViewEdge;
   VectP1ToP, VectP1ToP2: TPoint;  {vectors}
begin
   Result:= nil;
   GVEPointer:= FPEdgeViewHead^.FPNextGraphViewEdge;
   while (GVEPointer <> nil) do
      with GVEPointer^ do
      begin
         VectP1ToP:= Point.Subtract(FPEdgeView^.FPStartVertexView^.FPosition);
         VectP1ToP2:= FPEdgeView^.FPEndVertexView^.FPosition.Subtract(FPEdgeView^.FPStartVertexView^.FPosition);
         if ((Abs(VectP1ToP2.X) < 7) and (Abs(VectP1ToP.X) < 10) and
             (VectP1ToP.Y > Min(VectP1ToP2.Y, 0)) and (VectP1ToP.Y < Max(VectP1ToP2.Y, 0))) or
            ((Abs(VectP1ToP2.Y) < 7) and (Abs(VectP1ToP.Y) < 10) and
             (VectP1ToP.X > Min(VectP1ToP2.X, 0)) and (VectP1ToP.X < Max(VectP1ToP2.X, 0))) or
            (not ((VectP1ToP.X = 0) or (VectP1ToP.Y = 0) or (VectP1ToP2.X = 0) or (VectP1ToP2.Y = 0)) and
            (abs(VectP1ToP.X / VectP1ToP2.X - VectP1ToP.Y / VectP1ToP2.Y) < 0.1) and
            ((VectP1ToP2.X / VectP1ToP.X) > 1) and (VectP1ToP2.X / VectP1ToP.X > 1)) then
         begin
            Result:= GVEPointer^.FPEdgeView;
            break;
         end;
         GVEPointer:= GVEPointer^.FPNextGraphViewEdge;
      end;
end;

function TGraphView.IsPointOnVertex(Point: TPoint; VertexRadius: Word): PVertexView;
var
   GVVPointer: PGraphViewVertex;
begin
   Result:= nil;
   GVVPointer:= FPVertexViewHead^.FPNextGraphViewVertex;
   while (GVVPointer <> nil) and not TPoint.PointInCircle(Point,
     GVVPointer^.FPVertexView^.FPosition,
     VertexRadius) do
      GVVPointer:= GVVPointer^.FPNextGraphViewVertex;
   if GVVPointer <> nil then
      Result:= GVVPointer^.FPVertexView;
end;

procedure TGraphView.PaintGraphOnCanvas(Canvas: TCanvas;
   CurrentGraphModel: TGraphModel; ViewSettings: TVisualSettings);
var
   VVPointers: TVertexesViewsPointers;
   EVPointers: TEdgesViewsPointers;
   i: Integer;
   Point1, Point2: TPoint;
   NameString: String;

procedure DrawArrowHead(Canvas: TCanvas; X,Y: Integer; Angle: Extended; ArrowSettings: TArrowSettings);
var
   A1, A2: Extended;
   Arrow: array[0..3] of TPoint;
begin
   with ArrowSettings do
   begin
      Angle := Pi + Angle;
      Arrow[0] := Point(X, Y);
      A1 := Angle - HalfAngle;
      A2 := Angle + HalfAngle;
      Arrow[1] := Point(X + Round(LineLength * LineSize * Cos(A1)), Y - Round(LineLength * LineSize * Sin(A1)));
      Arrow[2] := Point(X + Round(CenterLength * LineSize * Cos(Angle)),Y - Round(CenterLength * LineSize * Sin(Angle)));
      Arrow[3] := Point(X + Round(LineLength * LineSize * Cos(A2)), Y - Round(LineLength * LineSize * Sin(A2)));
      Canvas.Polygon(Arrow);
   end;
end;

procedure DrawArrow(Canvas: TCanvas; Point1, Poin2: TPoint;
   Direction: TDirection; NeedToDrawArrow: Boolean; ArrowSettings: TArrowSettings);
var
   Angle: Extended;
begin
   with ViewSettings.Edge, ViewSettings.Vertex, Canvas, ArrowSettings do
   begin
      Angle := ArcTan2(Point1.Y - Point2.Y, Point2.X - Point1.X);
      MoveTo(Point1.X, Point1.Y);
      LineTo(Point2.X, Point2.Y);
      if NeedToDrawArrow then
      begin
         DrawArrowHead(Canvas, Point2.X - Round(Cos(Angle) * Radius),
           Point2.Y + Round(Sin(Angle) * Radius), Angle, ArrowSettings);
         if Direction = DBidirectional then
         begin
            Angle:= ArcTan2(Point2.Y - Point1.Y, Point1.X - Point2.X);
            DrawArrowHead(Canvas, Point1.X - Round(Cos(Angle) * Radius),
              Point1.Y + Round(Sin(Angle) * Radius), Angle, ArrowSettings);
         end;
      end;
   end;
end;

begin
   with Canvas, CurrentGraphModel, ViewSettings do
   begin
      Brush.Color:= clWhite;
      FillRect(Canvas.ClipRect);
      EVPointers:= GetEdgesViewsPointers;
      for i := 0 to High(EVPointers) do
         with EVPointers[i]^, Edge do
         begin
            if FIsSelected then
            begin
               Pen.Color:= ActiveState.Color;
               Pen.Width:= ActiveState.Width;
               ApplyFontSettings(Font, ActiveState.TextFont);
            end
            else
            begin
               Pen.Color:= CommonState.Color;
               Pen.Width:= CommonState.Width;
               ApplyFontSettings(Font, CommonState.TextFont);
            end;
            Point1:= TPoint.Create(FPStartVertexView^.FPosition);
            Point2:= TPoint.Create(FPEndVertexView^.FPosition);
            with GetEdgeModelPointer(FIndex)^ do
               DrawArrow(Canvas, Point1, Point2,
                  GetEdgeModelPointer(FIndex)^.FDirection, Oriented, Edge.ArrowSettings);
            with GetEdgeModelPointer(FIndex)^ do
            begin
               NameString:= String(FName).Trim;
               if Weighted then
               begin
                  if NameString <> '' then
                     NameString:= NameString + ': ';
                  NameString:= NameString + IntToStr(FValue);
               end;
               TextOut((Point1.X + Point2.X) div 2 - 6 * Length(NameString) div 2,
                 (Point1.Y + Point2.Y) div 2 - 7, NameString);
            end;

         end;

      VVPointers:= GetVertexesViewsPointers;
      for i := 0 to High(VVPointers) do
         with VVPointers[i]^, Vertex do
         begin
            Point1:= FPosition.Subtract(TPoint.Create(Vertex.Radius, Vertex.Radius));
            Point2:= FPosition.Add(TPoint.Create(Vertex.Radius, Vertex.Radius));
            if FIsSelected then
            begin
               Brush.Color:= ActiveState.FillColor;
               ApplyFontSettings(Font, ActiveState.TextFont);
               Pen.Color:= ActiveState.Line.Color;
               Pen.Width:= ActiveState.Line.Width;
            end
            else
            begin
               Brush.Color:= CommonState.FillColor;
               ApplyFontSettings(Font, CommonState.TextFont);
               Pen.Color:= CommonState.Line.Color;
               Pen.Width:= CommonState.Line.Width;
            end;
            Ellipse(Point1.X, Point1.y, Point2.X, Point2.Y);
            //Point1:= Point1.Subtract(TPoint.Create(0, 15)); // 5 - text height

            with GetVertexModelPointer(FIndex)^ do
            begin
               if Length(FName) > 1 then
               begin
                  Point1:= FPosition.Subtract(TPoint.Create(Font.Size * Length(String(FName)) div 4, Font.Size * 2 + Radius));
                  Brush.Color:= clWhite;
               end
               else
               begin
                  Point1:= FPosition.Subtract(TPoint.Create(Font.Size div 2, Font.Size));
                  if Font.Color = Brush.Color then
                     Font.Color:= clWhite;
               end;
               TextOut(Point1.X, Point1.Y, FName);
            end;
         end;
   end;
end;

procedure TGraphView.RemoveEdgeView(EdgeViewPointer: PEdgeView);
var
   PreviousEVPointer, CurrentEVPointer: PGraphViewEdge;
begin
   PreviousEVPointer:= FPEdgeViewHead;
   while (PreviousEVPointer.FPNextGraphViewEdge <> nil) and
     (PreviousEVPointer^.FPNextGraphViewEdge^.FPEdgeView <> EdgeViewPointer) do
      PreviousEVPointer:= PreviousEVPointer^.FPNextGraphViewEdge;
   if PreviousEVPointer.FPNextGraphViewEdge <> nil then
   begin
      CurrentEVPointer:= PreviousEVPointer.FPNextGraphViewEdge;
      if CurrentEVPointer = FPEdgeViewTail then
         FPEdgeViewTail:= PreviousEVPointer;
      PreviousEVPointer^.FPNextGraphViewEdge:= CurrentEVPointer^.FPNextGraphViewEdge;
      Dispose(CurrentEVPointer^.FPEdgeView);
      Dispose(CurrentEVPointer);
   end;
end;

procedure TGraphView.RemoveVertexView(VertexViewPointer: PVertexView);
var
   AllNearEdgesViewsPointers: TEdgesViewsPointers;
   i: Integer;
   PreviousVVPointer, CurrentVVPointer: PGraphViewVertex;
begin
   AllNearEdgesViewsPointers:= GetEdgesViewsPointersWithVertex(VertexViewPointer);
   for i := 0 to High(AllNearEdgesViewsPointers) do
      RemoveEdgeView(AllNearEdgesViewsPointers[i]);
   PreviousVVPointer:= FPVertexViewHead;
   while (PreviousVVPointer^.FPNextGraphViewVertex <> nil) and
     (PreviousVVPointer^.FPNextGraphViewVertex^.FPVertexView <> VertexViewPointer) do
      PreviousVVPointer:= PreviousVVPointer^.FPNextGraphViewVertex;
   if PreviousVVPointer^.FPNextGraphViewVertex <> nil then
   begin
      CurrentVVPointer:= PreviousVVPointer^.FPNextGraphViewVertex;
      if CurrentVVPointer = FPVertexViewTail then
         FPVertexViewTail:= PreviousVVPointer;
      PreviousVVPointer^.FPNextGraphViewVertex:= CurrentVVPointer^.FPNextGraphViewVertex;
      Dispose(CurrentVVPointer^.FPVertexView);
      Dispose(CurrentVVPointer);
   end;

end;

procedure TGraphView.ResetSelection;
var
   GVVPointer: PGraphViewVertex;
   GEVPointer: PGraphViewEdge;
begin
   GVVPointer:= FPVertexViewHead^.FPNextGraphViewVertex;
   while GVVPointer <> nil do
   begin
      GVVPointer^.FPVertexView^.FIsSelected:= False;
      GVVPointer:= GVVPointer^.FPNextGraphViewVertex;
   end;
   GEVPointer:= FPEdgeViewHead^.FPNextGraphViewEdge;
   while GEVPointer <> nil do
   begin
      GEVPointer^.FPEdgeView^.FIsSelected:= False;
      GEVPointer:= GEVPointer^.FPNextGraphViewEdge;
   end;
end;

procedure TGraphView.SelectAll;
var
   GVVPointer: PGraphViewVertex;
   GEVPointer: PGraphViewEdge;
begin
   GVVPointer:= FPVertexViewHead^.FPNextGraphViewVertex;
   while GVVPointer <> nil do
   begin
      GVVPointer^.FPVertexView^.FIsSelected:= True;
      GVVPointer:= GVVPointer^.FPNextGraphViewVertex;
   end;
   GEVPointer:= FPEdgeViewHead^.FPNextGraphViewEdge;
   while GEVPointer <> nil do
   begin
      GEVPointer^.FPEdgeView^.FIsSelected:= True;
      GEVPointer:= GEVPointer^.FPNextGraphViewEdge;
   end;
end;

{ TVertexView }

constructor TVertexView.Create(VertexIndex: TIndex; Position: TPoint;
  IsSelected: Boolean);
begin
   FIndex:= VertexIndex;
   FPosition:= TPoint.Create(Position);
   FIsSelected:= IsSelected;
end;


{ TEdgeView }

constructor TEdgeView.Create(EdgeIndex: TIndex; StartVertexViewPointer,
  EndVertexViewPointer: PVertexView; IsSelected: Boolean);
begin
   FIndex:= EdgeIndex;
   FPStartVertexView:= StartVertexViewPointer;
   FPEndVertexView:= EndVertexViewPointer;
   FIsSelected:= IsSelected;
end;

{ TGraphViewEdge }

Procedure TGraphViewEdge.CreateEmpty;
begin
   Self.FPNextGraphViewEdge:= nil;
   Self.FPEdgeView:= nil;
end;

{ TGraphViewVertex }

procedure TGraphViewVertex.CreateEmpty;
begin
   Self.FPNextGraphViewVertex:=nil;
   Self.FPVertexView:= nil;
end;

end.
