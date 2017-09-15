unit Actions;

interface
  uses
    BDD,
    Combat;

    procedure ajoutPotion(n : Integer);
    procedure ajoutGkb(n : Integer);
    procedure achatPotion(prix : Integer);
    procedure achatGkb(prix : Integer);
    procedure soinGkm();

implementation
  var
    infoJoueur : Joueur;
    joueurGkm : TabJoueurGkm;

  procedure ajoutPotion(n : Integer);
  begin
    //r�cup�rer donn�es BDD
    infoJoueur := getInfoJoueur();

    infoJoueur.nbPotion := infoJoueur.nbPotion + n;
    writeln('Vous obtenez ', n, ' potions !');

    //renvoyer donn�es BDD
    setInfoJoueur(infoJoueur);
  end;

  procedure ajoutGkb(n : Integer);
  begin
    //r�cup�rer donn�es BDD
    infoJoueur := getInfoJoueur();

    infoJoueur.nbGeekeball := infoJoueur.nbGeekeball + n;
    writeln('Vous obtenez ', n, ' GKBs !');

    //renvoyer donn�es BDD
    setInfoJoueur(infoJoueur);
  end;

  procedure achatPotion(prix : Integer);
  var
    n : Integer; //nb de potions
    choix : Integer;
  begin
    //r�cup�rer donn�es BDD
    infoJoueur := getInfoJoueur();

    n := 0;
    choix := 0;

    writeln('Argent : ', infoJoueur.argent, ' bitcoins.');
    writeln('Nombre de potions poss�d�es : ', infoJoueur.nbPotion);
    writeln('Prix � l''unit� : ', prix);
    writeln('Combien de potion(s) souhaitez-vous acheter ?');
    readln(n);

    if n = 0 then
    begin
      writeln('Vous n''achetez aucune potion.');
      readln;
    end

    else if infoJoueur.argent >= (prix * n) then
    begin
      writeln('Prix total : ', prix*n);
      while (choix <> 1) AND (choix <> 2) do
      begin
      writeln('Etes-vous s�rs ?');
        writeln('1. Oui     2. Non');
        readln(choix);
        if choix = 1 then
        begin
          writeln('Vous achetez ', n, ' potion(s).');
          infoJoueur.nbPotion := infoJoueur.nbPotion + n;
          infoJoueur.argent := infoJoueur.argent - (prix * n);
          readln;
        end;
      end;
    end

    else
    begin
      writeln('Vous n''avez pas assez de cr�dit.');
      readln;
    end;

    //renvoyer donn�es BDD
    setInfoJoueur(infoJoueur);
  end;

  procedure achatGkb(prix : Integer);
  var
    n : Integer; //nb de GKBs
    choix : Integer;
  begin
    //r�cup�rer donn�es BDD
    infoJoueur := getInfoJoueur();

    n := 0;
    choix := 0;

    writeln('Argent : ', infoJoueur.argent, ' bitcoins.');
    writeln('Nombre de GKB(s) poss�d�e(s) : ', infoJoueur.nbGeekeball);
    writeln('Prix � l''unit� : ', prix);
    writeln('Combien de GKB(s) souhaitez-vous acheter ?');
    readln(n);

    if n = 0 then
    begin
      writeln('Vous n''achetez aucune GKB.');
    end

    else if infoJoueur.argent >= (prix * n) then
    begin
      writeln('Prix total : ', prix*n);
      while (choix <> 1) AND (choix <> 2) do
      begin
      writeln('Etes-vous s�rs ?');
        writeln('1. Oui     2. Non');
        readln(choix);
        if choix = 1 then
        begin
          writeln('Vous achetez ', n, ' GKB(s).');
          infoJoueur.nbGeekeball := infoJoueur.nbGeekeball + n;
          infoJoueur.argent := infoJoueur.argent - (prix * n);
          readln;
        end;
      end;
    end

    else
    begin
      writeln('Vous n''avez pas assez de cr�dit.');
      readln;
    end;

    //renvoyer donn�es BDD
    setInfoJoueur(infoJoueur);
  end;

  procedure soinGkm();
  begin
    //r�cup�rer donn�es BDD
    joueurGkm := getJoueurGkm();

    joueurGkm[0].pv := joueurGkm[0].pvMax;
    joueurGkm[1].pv := joueurGkm[1].pvMax;
    joueurGkm[2].pv := joueurGkm[2].pvMax;
    joueurGkm[3].pv := joueurGkm[3].pvMax;

    //renvoyer donn�es BDD
    setJoueurGkm(joueurGkm);
  end;
end.
