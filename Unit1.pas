unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;

    procedure OnCreate(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    panels: array[0..3, 0..3] of TPanel;
    colorsMaps: array[0..3, 0..3] of Boolean;
    offsetLeft: Integer;
    offsetTop: Integer;
    widthPanels: Integer;
    heightPanels: Integer;
    counterTurn: Integer;  
    primaryColor: TColor;
    secondaryColor: TColor;
    score: TLabel;
  public

     procedure PanelsClick(Sender: TObject);
     procedure PaintPanels();
     procedure RandomizeColorMaps();
     procedure TurnOverPanels(x: integer; y: integer);
     procedure CheckWin();

  end;

var
  form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.OnCreate(Sender: TObject);
var
  i, j: integer;
begin
  self.offsetLeft := 100;
  self.offsetTop := 0;
  self.widthPanels := 150;
  self.heightPanels := 150;
  self.primaryColor := clWhite;
  self.secondaryColor := clBlue;
  self.counterTurn := 0;

  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      self.panels[i, j] := TPanel.Create(self);
      self.panels[i, j].parent := self;
      self.panels[i, j].left := i * self.widthPanels + self.offsetLeft;
      self.panels[i, j].top := j * self.heightPanels + self.offsetTop;
      self.panels[i, j].width := self.widthPanels;
      self.panels[i, j].height := self.heightPanels;
      self.panels[i, j].OnClick := self.PanelsClick;
    end;
  end;
  self.score:= TLabel.Create(self);
  self.score.parent := self;
  self.score.left := self.widthPanels * 4 + self.offsetLeft + 20;
  self.score.top := Round( self.heightPanels / 2 );
  self.score.font.size := 40;
  self.score.caption := '0';  
  self.RandomizeColorMaps();
  self.PaintPanels();
end;

procedure TForm1.PanelsClick(Sender: TObject);
var
i, j: integer;
panel: TPanel;
begin
  panel := (Sender as TPanel);
  i := Round((panel.left - self.offsetLeft) / self.widthPanels);
  j := Round((panel.top - self.offsetTop) / self.heightPanels);
  TurnOverPanels(i, j);

end;

procedure TForm1.PaintPanels();                                                                                   
var
i, j: integer;
begin
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      if (self.colorsMaps[i, j] = true) then begin
        self.panels[i, j].color := self.primaryColor;
      end else begin
        self.panels[i, j].color := self.secondaryColor;
      end;
    end;
  end;
end;

procedure TForm1.RandomizeColorMaps();
var
i, j, value: integer;
begin
  randomize;
  
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      value := random(2);
      if (value = 0) then
        self.colorsMaps[i, j] := false;
      if (value = 1) then
        self.colorsMaps[i, j] := true;
    end;
  end;
  {self.colorsMaps[0, 0] := false;
  self.colorsMaps[0, 1] := false;
  self.colorsMaps[0, 2] := false;
  self.colorsMaps[0, 3] := false;

  self.colorsMaps[1, 0] := false;
  self.colorsMaps[1, 1] := true;
  self.colorsMaps[1, 2] := true;
  self.colorsMaps[1, 3] := true;

  self.colorsMaps[2, 0] := false;
  self.colorsMaps[2, 1] := true;
  self.colorsMaps[2, 2] := true;
  self.colorsMaps[2, 3] := true;

  self.colorsMaps[3, 0] := false;
  self.colorsMaps[3, 1] := true;
  self.colorsMaps[3, 2] := true;
  self.colorsMaps[3, 3] := true;  }

end;

procedure TForm1.TurnOverPanels(x: integer; y: integer);
var
i, j : integer;
begin
  for i := 0 to 3 do begin
    self.colorsMaps[i, y] := not self.colorsMaps[i, y];
  end;
  for j := 0 to 3 do begin
    self.colorsMaps[x, j] := not self.colorsMaps[x, j];
  end;
  self.counterTurn := self.counterTurn + 1;
  self.colorsMaps[x, y] := not self.colorsMaps[x, y];
  self.score.caption := IntToStr(StrToInt(self.score.caption) + 1);
  self.PaintPanels();
  self.CheckWin();
end;

procedure TForm1.CheckWin();
var
result, i, j: integer;
begin
  result := 0;
  for i := 0 to 3 do begin
    for j := 0 to 3 do begin
      result := result + Integer(self.colorsMaps[i, j]);
    end;
  end;
  if ((result = 0) or (result = 16)) then begin
    ShowMessage('������� �� ��������! ��� ��������� ' + IntToStr(self.counterTurn) + ' ���(�/��)');
    self.counterTurn := 0;
    self.RandomizeColorMaps();
    self.PaintPanels();
    self.score.caption := '0';
  end;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  ShowMessage('��� ���� ��� �� ��������, ��������� �� ������� ������, �������� ���, ��� �� ��� ������ ���� ������ �����');
end;

end.
