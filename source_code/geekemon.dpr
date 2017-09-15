program geekemon;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  GestionEcran in 'GestionEcran.pas',
  BDD in 'BDD.pas',
  Menus in 'Menus.pas',
  Evenements in 'Evenements.pas',
  Combat in 'Combat.pas',
  Dresseurs in 'Dresseurs.pas',
  Actions in 'Actions.pas',
  Salles in 'Salles.pas';

begin
  //INITIALISATION
  remplirInfoGkm();
  couleurTexte(15);

  ecranTitre;
end.

