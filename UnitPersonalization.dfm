object FormPersonalization: TFormPersonalization
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsToolWindow
  Caption = 'Personal settings'
  ClientHeight = 408
  ClientWidth = 828
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBoxCurrentSettings: TPaintBox
    AlignWithMargins = True
    Left = 491
    Top = 3
    Width = 334
    Height = 364
    Align = alClient
    OnPaint = PaintBoxCurrentSettingsPaint
    ExplicitLeft = 57
    ExplicitTop = 9
    ExplicitWidth = 179
    ExplicitHeight = 259
  end
  object PanelVertexSettings: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 238
    Height = 364
    Align = alLeft
    BorderStyle = bsSingle
    Caption = 'PanelVertexSettings'
    ShowCaption = False
    TabOrder = 0
    VerticalAlignment = taAlignTop
    object LabelVertexLineColor: TLabel
      Left = 0
      Top = 132
      Width = 220
      Height = 13
      Alignment = taCenter
      Caption = 'Line Color'
      Constraints.MinWidth = 220
    end
    object LabelVertexFillColor: TLabel
      Left = 0
      Top = 72
      Width = 220
      Height = 13
      Alignment = taCenter
      Caption = 'Fill Color'
      Constraints.MinWidth = 220
    end
    object LabelVertexHeader: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 11
      Width = 226
      Height = 13
      Margins.Top = 10
      Align = alTop
      Alignment = taCenter
      Caption = 'Vertex'
      Constraints.MinWidth = 220
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 220
    end
    object LabelVertexActive: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 30
      Width = 34
      Height = 13
      Margins.Left = 8
      Margins.Right = 8
      Caption = 'Active:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object PaintBoxVertexActiveFill: TPaintBox
      Left = 8
      Top = 60
      Width = 40
      Height = 40
      Cursor = crHandPoint
      OnClick = PaintBoxVertexActiveFillClick
      OnPaint = SetControlsWithVS
    end
    object PaintBoxVertexActiveLine: TPaintBox
      Left = 8
      Top = 120
      Width = 40
      Height = 40
      Cursor = crHandPoint
      OnClick = PaintBoxVertexActiveLineClick
    end
    object LabelVertexCommon: TLabel
      AlignWithMargins = True
      Left = 179
      Top = 30
      Width = 45
      Height = 13
      Margins.Left = 8
      Margins.Right = 8
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Common:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object PaintBoxVertexCommonFill: TPaintBox
      Left = 184
      Top = 60
      Width = 40
      Height = 40
      Cursor = crHandPoint
      OnClick = PaintBoxVertexCommonFillClick
    end
    object PaintBoxVertexCommonLine: TPaintBox
      Left = 184
      Top = 123
      Width = 40
      Height = 40
      Cursor = crHandPoint
      OnClick = PaintBoxVertexCommonLineClick
    end
    object LabelVertesLineWidth: TLabel
      Left = 0
      Top = 176
      Width = 220
      Height = 13
      Alignment = taCenter
      Caption = 'Line Width'
      Constraints.MinWidth = 220
    end
    object LabelVertexRadius: TLabel
      Left = 0
      Top = 301
      Width = 220
      Height = 13
      Alignment = taCenter
      Caption = 'Radius'
      Constraints.MinWidth = 220
    end
    object ScrollBarVertexActiveLineWidth: TScrollBar
      Left = 8
      Top = 202
      Width = 97
      Height = 17
      Cursor = crHandPoint
      Max = 20
      Min = 1
      PageSize = 0
      Position = 1
      TabOrder = 0
      OnScroll = ScrollBarVertexActiveLineWidthScroll
    end
    object ScrollBarVertexCommonLineWidth: TScrollBar
      Left = 128
      Top = 202
      Width = 96
      Height = 17
      Cursor = crHandPoint
      Max = 20
      Min = 1
      PageSize = 0
      Position = 1
      TabOrder = 1
      OnScroll = ScrollBarVertexCommonLineWidthScroll
    end
    object ButtonVertexActiveFont: TButton
      Left = 8
      Top = 251
      Width = 97
      Height = 25
      Cursor = crHandPoint
      Caption = 'Font'
      TabOrder = 2
      OnClick = ButtonVertexActiveFontClick
    end
    object ButtonVertexCommonFont: TButton
      Left = 128
      Top = 251
      Width = 96
      Height = 25
      Cursor = crHandPoint
      Caption = 'Font'
      TabOrder = 3
      OnClick = ButtonVertexCommonFontClick
    end
    object ScrollBarVertexRadius: TScrollBar
      Left = 8
      Top = 324
      Width = 216
      Height = 17
      Cursor = crHandPoint
      Max = 50
      PageSize = 0
      TabOrder = 4
      OnScroll = ScrollBarVertexRadiusScroll
    end
  end
  object PanelSubmit: TPanel
    Left = 0
    Top = 370
    Width = 828
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    object ButtonCancel: TBitBtn
      Left = 744
      Top = 6
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
      OnClick = ButtonCancelClick
    end
    object ButtonOK: TBitBtn
      Left = 648
      Top = 6
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = ButtonOKClick
    end
  end
  object PanelEdgeSettings: TPanel
    AlignWithMargins = True
    Left = 247
    Top = 3
    Width = 238
    Height = 364
    Align = alLeft
    BorderStyle = bsSingle
    Caption = 'PanelEdgeSettings'
    ShowCaption = False
    TabOrder = 2
    VerticalAlignment = taAlignTop
    object LabelEdgeLineColor: TLabel
      Left = 0
      Top = 72
      Width = 220
      Height = 13
      Alignment = taCenter
      Caption = 'Line Color'
      Constraints.MinWidth = 220
    end
    object LabelArrowHeader: TLabel
      AlignWithMargins = True
      Left = -2
      Top = 202
      Width = 220
      Height = 13
      Margins.Top = 10
      Alignment = taCenter
      Caption = 'Arrow'
      Constraints.MinWidth = 220
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LabelEdgeActive: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 30
      Width = 34
      Height = 13
      Margins.Left = 8
      Margins.Right = 8
      Caption = 'Active:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LabelEdgeCommon: TLabel
      AlignWithMargins = True
      Left = 183
      Top = 30
      Width = 45
      Height = 13
      Margins.Left = 8
      Margins.Right = 8
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Common:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
    end
    object LabelEdgeLineWidth: TLabel
      Left = -2
      Top = 106
      Width = 220
      Height = 13
      Alignment = taCenter
      Caption = 'Line Width'
      Constraints.MinWidth = 220
    end
    object LabelArrowSideLength: TLabel
      Left = -2
      Top = 221
      Width = 220
      Height = 13
      Alignment = taCenter
      Caption = 'Side Length'
      Constraints.MinWidth = 220
    end
    object LabelEdgeHeader: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 11
      Width = 226
      Height = 13
      Margins.Top = 10
      Align = alTop
      Alignment = taCenter
      Caption = 'Edge'
      Constraints.MinWidth = 220
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 220
    end
    object LabelArrowMiddleLength: TLabel
      Left = -2
      Top = 263
      Width = 220
      Height = 13
      Alignment = taCenter
      Caption = 'Middle Length'
      Constraints.MinWidth = 220
    end
    object Label1: TLabel
      Left = -2
      Top = 305
      Width = 220
      Height = 13
      Alignment = taCenter
      Caption = 'Angle'
      Constraints.MinWidth = 220
    end
    object PaintBoxEdgeCommonLine: TPaintBox
      Left = 183
      Top = 60
      Width = 40
      Height = 40
      Cursor = crHandPoint
      OnClick = PaintBoxEdgeCommonLineClick
    end
    object PaintBoxEdgeActiveLine: TPaintBox
      Left = 8
      Top = 60
      Width = 40
      Height = 40
      Cursor = crHandPoint
      OnClick = PaintBoxEdgeActiveLineClick
    end
    object ScrollBarEdgeActiveLineWidth: TScrollBar
      Left = 8
      Top = 130
      Width = 97
      Height = 17
      Cursor = crHandPoint
      Max = 20
      Min = 1
      PageSize = 0
      Position = 1
      TabOrder = 0
      OnScroll = ScrollBarEdgeActiveLineWidthScroll
    end
    object ScrollBarEdgeCommonLineWidth: TScrollBar
      Left = 128
      Top = 130
      Width = 93
      Height = 17
      Cursor = crHandPoint
      Max = 20
      Min = 1
      PageSize = 0
      Position = 1
      TabOrder = 1
      OnScroll = ScrollBarEdgeCommonLineWidthScroll
    end
    object ButtonEdgeActiveFont: TButton
      Left = 8
      Top = 164
      Width = 97
      Height = 25
      Cursor = crHandPoint
      Caption = 'Font'
      TabOrder = 2
      OnClick = ButtonEdgeActiveFontClick
    end
    object ButtonEdgeCommonFont: TButton
      Left = 128
      Top = 164
      Width = 95
      Height = 25
      Cursor = crHandPoint
      Caption = 'Font'
      TabOrder = 3
      OnClick = ButtonEdgeCommonFontClick
    end
    object ScrollBarArrowLineLength: TScrollBar
      Left = 8
      Top = 240
      Width = 217
      Height = 17
      Cursor = crHandPoint
      Min = 2
      PageSize = 0
      Position = 2
      TabOrder = 4
      OnScroll = ScrollBarArrowLineLengthScroll
    end
    object ScrollBarArrowCenterLength: TScrollBar
      Left = 8
      Top = 282
      Width = 217
      Height = 17
      Cursor = crHandPoint
      Min = 2
      PageSize = 0
      Position = 2
      TabOrder = 5
      OnScroll = ScrollBarArrowCenterLengthScroll
    end
    object ScrollBarArrowAngle: TScrollBar
      Left = 8
      Top = 324
      Width = 217
      Height = 17
      Cursor = crHandPoint
      Max = 130
      Min = 2
      PageSize = 0
      Position = 2
      TabOrder = 6
      OnScroll = ScrollBarArrowAngleScroll
    end
  end
  object ColorDialog: TColorDialog
    CustomColors.Strings = (
      'ColorA=FFFFFFFF'
      'ColorB=FFFFFFFF'
      'ColorC=FFFFFFFF'
      'ColorD=FFFFFFFF'
      'ColorE=FFFFFFFF'
      'ColorF=FFFFFFFF'
      'ColorG=FFFFFFFF'
      'ColorH=FFFFFFFF'
      'ColorI=FFFFFFFF'
      'ColorJ=FFFFFFFF'
      'ColorK=FFFFFFFF'
      'ColorL=FFFFFFFF'
      'ColorM=FFFFFFFF'
      'ColorN=FFFFFFFF'
      'ColorO=FFFFFFFF'
      'ColorP=FFFFFFFF')
    Left = 544
    Top = 16
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MinFontSize = 8
    MaxFontSize = 20
    Left = 616
    Top = 16
  end
end