unit UnitPersonalization;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  UnitTypeAndConst, UnitTGraphView, UnitTGraphModel, Vcl.Buttons;

type
   TFormPersonalization = class(TForm)
      ColorDialog: TColorDialog;
      PanelVertexSettings: TPanel;
      PaintBoxCurrentSettings: TPaintBox;
      PaintBoxVertexActiveFill: TPaintBox;
      PaintBoxVertexActiveLine: TPaintBox;
      PaintBoxVertexCommonFill: TPaintBox;
      PaintBoxVertexCommonLine: TPaintBox;
      LabelVertexHeader: TLabel;
      FontDialog: TFontDialog;
      PanelSubmit: TPanel;
      LabelVertexActive: TLabel;
      LabelVertexCommon: TLabel;
      LabelVertexFillColor: TLabel;
      LabelVertexLineColor: TLabel;
      ScrollBarVertexActiveLineWidth: TScrollBar;
      LabelVertesLineWidth: TLabel;
      ScrollBarVertexCommonLineWidth: TScrollBar;
      ButtonVertexActiveFont: TButton;
      ButtonVertexCommonFont: TButton;
      LabelVertexRadius: TLabel;
      ScrollBarVertexRadius: TScrollBar;
      PanelEdgeSettings: TPanel;
      LabelArrowHeader: TLabel;
      LabelEdgeActive: TLabel;
      PaintBoxEdgeActiveLine: TPaintBox;
      LabelEdgeCommon: TLabel;
      PaintBoxEdgeCommonLine: TPaintBox;
      LabelEdgeLineColor: TLabel;
      LabelEdgeLineWidth: TLabel;
      ScrollBarEdgeActiveLineWidth: TScrollBar;
      ScrollBarEdgeCommonLineWidth: TScrollBar;
      ButtonEdgeActiveFont: TButton;
      ButtonEdgeCommonFont: TButton;
      LabelArrowSideLength: TLabel;
      ScrollBarArrowLineLength: TScrollBar;
      ScrollBarArrowCenterLength: TScrollBar;
      ScrollBarArrowAngle: TScrollBar;
      LabelEdgeHeader: TLabel;
      LabelArrowMiddleLength: TLabel;
      Label1: TLabel;
    ButtonCancel: TBitBtn;
    ButtonOK: TBitBtn;
      function ShowModal: Integer; override;
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure PaintBoxCurrentSettingsPaint(Sender: TObject);
      procedure FormCreate(Sender: TObject);
      procedure ScrollBarArrowLineLengthScroll(Sender: TObject; ScrollCode: TScrollCode;
         var ScrollPos: Integer);
      procedure ScrollBarArrowCenterLengthScroll(Sender: TObject; ScrollCode: TScrollCode;
         var ScrollPos: Integer);
      procedure ScrollBarArrowAngleScroll(Sender: TObject; ScrollCode: TScrollCode;
         var ScrollPos: Integer);
      procedure SetControlsWithVS(Sender: TObject);
    procedure PaintBoxVertexActiveFillClick(Sender: TObject);
    procedure PaintBoxVertexActiveLineClick(Sender: TObject);
    procedure PaintBoxVertexCommonFillClick(Sender: TObject);
    procedure PaintBoxVertexCommonLineClick(Sender: TObject);
    procedure PaintBoxEdgeActiveLineClick(Sender: TObject);
    procedure PaintBoxEdgeCommonLineClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ScrollBarVertexActiveLineWidthScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarVertexCommonLineWidthScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarVertexRadiusScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarEdgeActiveLineWidthScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ScrollBarEdgeCommonLineWidthScroll(Sender: TObject;
      ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure ButtonVertexActiveFontClick(Sender: TObject);
    procedure ButtonVertexCommonFontClick(Sender: TObject);
    procedure ButtonEdgeActiveFontClick(Sender: TObject);
    procedure ButtonEdgeCommonFontClick(Sender: TObject);
   public
         CurrentVisualSettings: TVisualSettings;
   end;

implementation

{$R *.dfm}

var
   VisualSettingsToChange: TVisualSettings;
   GraphModelExample: TGraphModel;
   GraphViewExample: TGraphView;

procedure TFormPersonalization.ScrollBarArrowLineLengthScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   VisualSettingsToChange.Edge.ArrowSettings.LineLength:= ScrollPos;
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.ScrollBarEdgeActiveLineWidthScroll(
  Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   VisualSettingsToChange.Edge.ActiveState.Width:= ScrollPos;
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.ScrollBarEdgeCommonLineWidthScroll(
  Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   VisualSettingsToChange.Edge.CommonState.Width:= ScrollPos;
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.ScrollBarVertexActiveLineWidthScroll(
  Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   VisualSettingsToChange.Vertex.ActiveState.Line.Width:= ScrollPos;
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.ScrollBarVertexCommonLineWidthScroll(
  Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   VisualSettingsToChange.Vertex.CommonState.Line.Width:= ScrollPos;
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.ScrollBarVertexRadiusScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   VisualSettingsToChange.Vertex.Radius:= ScrollPos;
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.ScrollBarArrowCenterLengthScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   VisualSettingsToChange.Edge.ArrowSettings.CenterLength:= ScrollPos;
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.ScrollBarArrowAngleScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
   VisualSettingsToChange.Edge.ArrowSettings.HalfAngle:= ScrollPos / 100;
   PaintBoxCurrentSettingsPaint(Sender);
end;

function TFormPersonalization.ShowModal: Integer;
begin
   VisualSettingsToChange:= CurrentVisualSettings;
   Result:= inherited;
   if Result = mrOK then
      CurrentVisualSettings:= VisualSettingsToChange;
end;

procedure TFormPersonalization.SetControlsWithVS(Sender: TObject);
begin
   // Veretx Settings
   with VisualSettingsToChange.Vertex do
   begin
      with PaintBoxVertexActiveFill.Canvas do
      begin
         Brush.Color:= ActiveState.FillColor;
         FillRect(ClientRect);
      end;
      with PaintBoxVertexCommonFill.Canvas do
      begin
         Brush.Color:= CommonState.FillColor;
         FillRect(ClientRect);
      end;
      with PaintBoxVertexActiveLine.Canvas do
      begin
         Brush.Color:= ActiveState.Line.Color;
         FillRect(ClientRect);
      end;
      with PaintBoxVertexCommonLine.Canvas do
      begin
         Brush.Color:= CommonState.Line.Color;
         FillRect(ClientRect);
      end;
      ScrollBarVertexActiveLineWidth.Position:= ActiveState.Line.Width;
      ScrollBarVertexCommonLineWidth.Position:= CommonState.Line.Width;
      ScrollBarVertexRadius.Position:= Radius;
   end;
   // Edge Settings
   with VisualSettingsToChange.Edge do
   begin
      with PaintBoxEdgeActiveLine.Canvas do
      begin
         Brush.Color:= ActiveState.Color;
         FillRect(ClientRect);
      end;
      with PaintBoxEdgeCommonLine.Canvas do
      begin
         Brush.Color:= CommonState.Color;
         FillRect(ClientRect);
      end;
      ScrollBarEdgeActiveLineWidth.Position:= ActiveState.Width;
      ScrollBarEdgeCommonLineWidth.Position:= CommonState.Width;
      ScrollBarArrowLineLength.Position:= ArrowSettings.LineLength;
      ScrollBarArrowCenterLength.Position:= ArrowSettings.CenterLength;
      ScrollBarArrowAngle.Position:= Round(ArrowSettings.HalfAngle * 100);
   end;
end;

procedure TFormPersonalization.ButtonCancelClick(Sender: TObject);
begin
   VisualSettingsToChange:= CurrentVisualSettings;
end;

procedure TFormPersonalization.ButtonEdgeActiveFontClick(Sender: TObject);
begin
   with VisualSettingsToChange do
   begin
      ApplyFontSettings(FontDialog.Font, Edge.ActiveState.TextFont);
      if FontDialog.Execute then
      begin
          SaveFontSettings(FontDialog.Font, Edge.ActiveState.TextFont);
          SetControlsWithVS(Sender);
          PaintBoxCurrentSettingsPaint(Sender);
      end;
   end;
end;

procedure TFormPersonalization.ButtonEdgeCommonFontClick(Sender: TObject);
begin
   with VisualSettingsToChange do
   begin
      ApplyFontSettings(FontDialog.Font, Edge.CommonState.TextFont);
      if FontDialog.Execute then
      begin
          SaveFontSettings(FontDialog.Font, Edge.CommonState.TextFont);
          SetControlsWithVS(Sender);
          PaintBoxCurrentSettingsPaint(Sender);
      end;
   end;
end;

procedure TFormPersonalization.ButtonOKClick(Sender: TObject);
begin
   CurrentVisualSettings:= VisualSettingsToChange;
end;

procedure TFormPersonalization.ButtonVertexActiveFontClick(Sender: TObject);
begin
   with VisualSettingsToChange do
   begin
      ApplyFontSettings(FontDialog.Font, Vertex.ActiveState.TextFont);
      if FontDialog.Execute then
      begin
          SaveFontSettings(FontDialog.Font, Vertex.ActiveState.TextFont);
          SetControlsWithVS(Sender);
          PaintBoxCurrentSettingsPaint(Sender);
      end;
   end;
end;

procedure TFormPersonalization.ButtonVertexCommonFontClick(Sender: TObject);
begin
   with VisualSettingsToChange do
   begin
      ApplyFontSettings(FontDialog.Font, Vertex.CommonState.TextFont);
      if FontDialog.Execute then
      begin
          SaveFontSettings(FontDialog.Font, Vertex.CommonState.TextFont);
          SetControlsWithVS(Sender);
          PaintBoxCurrentSettingsPaint(Sender);
      end;
   end;
end;

constructor TFormPersonalization.Create(AOwner: TComponent);
begin
   inherited;
   CurrentVisualSettings:= DefaultVisualSettings;
   VisualSettingsToChange:= CurrentVisualSettings;
   SetControlsWithVS(AOwner);
end;

destructor TFormPersonalization.Destroy;
begin
   FreeAndNil(GraphModelExample);
   FreeAndNil(GraphViewExample);
   inherited;
end;

procedure TFormPersonalization.FormCreate(Sender: TObject);
var
   VertexesModelsPointers: TVertexesModelsPointers;
   X, Y, i: Integer;
begin
   X:= PaintBoxCurrentSettings.Width div 3;
   Y:= PaintBoxCurrentSettings.Height div 3;
   GraphModelExample:= TGraphModel.Create(True, False);
   GraphViewExample:= TGraphView.Create;
   with GraphModelExample, GraphViewExample do
   begin
      with CreateNewVertexModel^ do
         with CreateNewVertexView(FIndex,
           TPoint.Create(X, Y), True) ^ do
            FName:= 'First';
      with CreateNewVertexModel^ do
         CreateNewVertexView(FIndex,
           TPoint.Create(X, Y * 2), True);
      with CreateNewEdgeModel(GetVertexModelPointer(0),
        GetVertexModelPointer(1), DUnidirectional)^ do
            CreateNewEdgeView(FIndex, 0, 1, True);
      with CreateNewVertexModel^ do
         CreateNewVertexView(FIndex,
           TPoint.Create(X * 2, Y * 2), False);
      with CreateNewVertexModel^ do
         with CreateNewVertexView(FIndex,
           TPoint.Create(X * 2, Y), False)^ do
            FName:= 'Forth';
      with CreateNewEdgeModel(GetVertexModelPointer(2),
        GetVertexModelPointer(3), DBidirectional)^ do
            CreateNewEdgeView(FIndex, 2, 3, False);
   end;
   SetControlsWithVS(Sender);
end;

procedure TFormPersonalization.PaintBoxCurrentSettingsPaint(Sender: TObject);
begin
   GraphViewExample.PaintGraphOnCanvas(PaintBoxCurrentSettings.Canvas,
     GraphModelExample, VisualSettingsToChange);
end;

procedure TFormPersonalization.PaintBoxEdgeActiveLineClick(Sender: TObject);
begin
   ColorDialog.Color:= VisualSettingsToChange.Edge.ActiveState.Color;
   if ColorDialog.Execute then
      VisualSettingsToChange.Edge.ActiveState.Color:= ColorDialog.Color;
   SetControlsWithVS(Sender);
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.PaintBoxEdgeCommonLineClick(Sender: TObject);
begin
   ColorDialog.Color:= VisualSettingsToChange.Edge.CommonState.Color;
   if ColorDialog.Execute then
      VisualSettingsToChange.Edge.CommonState.Color:= ColorDialog.Color;
   SetControlsWithVS(Sender);
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.PaintBoxVertexActiveFillClick(Sender: TObject);
begin
   ColorDialog.Color:= VisualSettingsToChange.Vertex.ActiveState.FillColor;
   if ColorDialog.Execute then
      VisualSettingsToChange.Vertex.ActiveState.FillColor:= ColorDialog.Color;
   SetControlsWithVS(Sender);
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.PaintBoxVertexActiveLineClick(Sender: TObject);
begin
   ColorDialog.Color:= VisualSettingsToChange.Vertex.ActiveState.Line.Color;
   if ColorDialog.Execute then
      VisualSettingsToChange.Vertex.ActiveState.Line.Color:= ColorDialog.Color;
   SetControlsWithVS(Sender);
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.PaintBoxVertexCommonFillClick(Sender: TObject);
begin
   ColorDialog.Color:= VisualSettingsToChange.Vertex.CommonState.FillColor;
   if ColorDialog.Execute then
      VisualSettingsToChange.Vertex.CommonState.FillColor:= ColorDialog.Color;
   SetControlsWithVS(Sender);
   PaintBoxCurrentSettingsPaint(Sender);
end;

procedure TFormPersonalization.PaintBoxVertexCommonLineClick(Sender: TObject);
begin
   ColorDialog.Color:= VisualSettingsToChange.Vertex.CommonState.Line.Color;
   if ColorDialog.Execute then
      VisualSettingsToChange.Vertex.CommonState.Line.Color:= ColorDialog.Color;
   SetControlsWithVS(Sender);
   PaintBoxCurrentSettingsPaint(Sender);
end;

end.
