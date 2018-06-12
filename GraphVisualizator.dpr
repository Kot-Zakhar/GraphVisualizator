program GraphVisualizator;

{$R *.dres}

uses
  Vcl.Forms,
  UnitMainForm in 'UnitMainForm.pas' {FormMain},
  UnitTGraphModel in 'UnitTGraphModel.pas',
  UnitTGraphView in 'UnitTGraphView.pas',
  UnitTypeAndConst in 'UnitTypeAndConst.pas',
  UnitAlgorithms in 'UnitAlgorithms.pas',
  UnitVertexModelEdit in 'UnitVertexModelEdit.pas' {FormVertexEdit},
  UnitSourceStrings in 'UnitSourceStrings.pas',
  UnitFiles in 'UnitFiles.pas',
  UnitEdgeEdit in 'UnitEdgeEdit.pas' {FormEdgeEdit},
  UnitIncidenceMatrix in 'UnitIncidenceMatrix.pas' {FormIncidenceMatrix},
  UnitAdjacencyMatrix in 'UnitAdjacencyMatrix.pas' {FormAdjacencyMatrix},
  UnitAdjacencyList in 'UnitAdjacencyList.pas' {FormAdjacencyList},
  UnitAboutUs in 'UnitAboutUs.pas' {FormAboutUs},
  UnitPersonalization in 'UnitPersonalization.pas' {FormPersonalization};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAboutUs, FormAboutUs);
  Application.Run;
end.
