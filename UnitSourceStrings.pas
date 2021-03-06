unit UnitSourceStrings;

interface

ResourceString
   // Messages
   MsgEmptyFields = 'Some fields are empty.';
   MsgAreYouExit = 'Are you sure you want to exit?';
   MsgAreYouDelete = 'Are you sure you want to delete selected?';
   MsgWontSave = 'Your changes wont be saved.';
   MsgShouldContinue = 'You sure you want to continue?';
   MsgToCreateEdge = 'To create an edge select two vertexes with CTRL.';
//   MsgSelectEdgeToDelete = 'Select an edge you want to delete.';
//   MsgSelectVertexToDelete = 'Select a vertex you want to delete.';
   MsgEdgeExists = 'Edge between current vertexes already exists. Edit current one by double-clicking on it.';
   MsgGraphSaved = 'Your Graph successfully saved.';
   MsgFileExists = 'Such file already exists.';
   MsgWouldLikeOverwrite = 'Would you like to overwrite it?';
   MsgGraphNotSaved = 'Your Graph is not saved.';
   MsgWouldLikeSave = 'Would you like to save current graph?';
   MsgWrongExtention = 'Wrong extention of the file.';
   MsgCannotOpenFile = 'Can''t open the file.';
   MsgSelectVertexToEdit = 'Select single vertex to edit it.';
   MsgSelectEdgeToEdit = 'Select single edge to edit it.';
   MsgSaved = 'Successfully saved.';
   MsgNoPath = 'There is no path.';
   MsgSelectTwoVertexesToFindPath = 'You need to select two vertexes to find path between them.';

   EditEdgeValueHint = 'Graph is not weighted.' + #13#10 + 'You can''t change this value.';

   MsgMapModeInfo = 'Map mode - useful mode when working with maps.' + #13#10 +
      'It automaticly calculates edges'' values basing on their lengthes.' + #13#10 +
      'The coefficient shows amount of units per pixel.' + #13#10 +
      'You can change the coefficient manually by clicking ''Set coefficient'' in Map mode menu.';
   MsgMapModeCoeffError = 'Map mode coefficient must be real.';
   MsgMapModeMustWeight = 'To use map mode graph needs to be weighted.';
   MsgMapModeIsOff = 'Map mode is Off.';
   MsgShortcuts =
      'Working with file functions:' + #13#10 +
      #32#32#32 + 'Ctrl+N - Create new graph' + #13#10 +
      #32#32#32 + 'Ctrl+O - Open graph from file ( *.graph)' + #13#10 +
      #32#32#32 + 'Ctrl+S - Save graph to file ( *.graph)' + #13#10 +
      #32#32#32 + 'Ctrl+I - Save graph as image' + #13#10 +
      'Edit functions:' + #13#10 +
      #32#32#32 + 'Ctrl+A - Sellect all the objects' + #13#10 +
      #32#32#32 + 'Ctrl+V - Create new vertex on the place of cursor' + #13#10 +
      #32#32#32 + 'Ctrl+E - Create new edge between all the selected vertexes' + #13#10 +
      #32#32#32 + 'Ctrl+Alt+V - Edit selected vertex' + #13#10 +
      #32#32#32 + 'Ctrl+Alt+E - Edit selected edge' + #13#10 +
      #32#32#32 + 'Ctrl+Del - Delete all the selected vertices' + #13#10 +
      #32#32#32 + 'Shift+Del - Delete all the selected edges' + #13#10 +
      'Background functions:' + #13#10 +
      #32#32#32 + 'Ctrl+B - Load background image' + #13#10 +
      #32#32#32 + 'Ctrl+Alt+B - Clear background' + #13#10 +
      'Useful windows:' + #13#10 +
      #32#32#32 + 'Ctrl+Alt+A - Adjacency matrix window' + #13#10 +
      #32#32#32 + 'Ctrl+Alt+L - Adjacency list window' + #13#10 +
      #32#32#32 + 'Ctrl+Alt+I - Incidence matrix window' + #13#10 +
      #32#32#32 + 'F10 - View settings window' + #13#10 +
      'Convertations:' + #13#10 +
      #32#32#32 + 'Ctrl+Alt+O - Convertation to oriented/nonoriented graph' + #13#10 +
      #32#32#32 + 'Ctrl+Alt+W - Convertation to weighted/not weighted graph' + #13#10 +
      'Map mode:' + #13#10 +
      #32#32#32 + 'Ctrl+M - Toggle a map mode' + #13#10 +
      #32#32#32 + 'Ctrl+Alt+M - Set map coefficient' + #13#10 +
      'Help:' + #13#10 +
//      #32#32#32 + 'F1 - Basic instruction Manual' + #13#10 +
      #32#32#32 + 'F11 - Shortcuts window' + #13#10 +
      #32#32#32 + 'F12 - Information about authors' + #13#10;

implementation

end.
