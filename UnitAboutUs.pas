unit UnitAboutUs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls;

type
  TFormAboutUs = class(TForm)
    BackGround: TImage;
    LabelHeader: TLabel;
    LabelParagraph: TLabel;
    LabelSubHeader: TLabel;
    LabelMail: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAboutUs: TFormAboutUs;

implementation

{$R *.dfm}

end.
