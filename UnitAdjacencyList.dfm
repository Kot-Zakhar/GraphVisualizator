object FormAdjacencyList: TFormAdjacencyList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeToolWin
  Caption = 'Adjacency list'
  ClientHeight = 251
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object AdjacencyListGrid: TStringGrid
    Left = 0
    Top = 0
    Width = 319
    Height = 251
    Align = alClient
    DefaultColWidth = 50
    DefaultRowHeight = 25
    FixedColor = clSilver
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
    TabOrder = 0
    RowHeights = (
      25
      25
      25
      25
      25)
  end
  object MainMenu: TMainMenu
    Left = 48
    Top = 168
    object MMFile: TMenuItem
      Caption = 'File'
      object MMSaveToFile: TMenuItem
        Caption = 'Save...'
        OnClick = MMSaveToFileClick
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'Text files (*.txt)|*.TXT'
    Left = 248
    Top = 168
  end
end
