unit Menus;

interface
  uses
    GestionEcran,
    BDD,
    Combat,
    Salles;

  procedure ecranTitre();
  procedure enteteMenu(selection : Boolean ; combat : Boolean ; evenement : Boolean);
  procedure menuGkms();
  procedure menuGkmsEchanger(nomGkmPc : String ; emplacementGkmPc : Integer);
  function carte() : Boolean;
  function carte2() : Boolean;
  function carte3() : Boolean;
  procedure pcDe();
  procedure quitterLeJeu();
  procedure ecranFinJeu();

implementation
  uses
    Evenements;

  var
    infoJoueur : Joueur;
    joueurGkm : TabJoueurGkm;
    dernGkmUtilise : Integer;
    succes : TSucces;
    quete : TQuete;

  procedure ecranTitre();
  var
    choix : Integer;
    sortieMenu : Boolean;
  begin
    sortieMenu := false;
    quete := getQuete();
    while sortieMenu = false do
    begin
      if quete.finjeu then quete.finjeu := false;
      effacerEcran;
      writeln;
      writeln;
      writeln;
      writeln;
      writeln;
      writeln;
      writeln;
      writeln;
      writeln;
      writeln('                         ██████╗ ███████╗███████╗██╗  ██╗███████╗███╗   ███╗ ██████╗ ███╗   ██╗');
      writeln('                        ██╔════╝ ██╔════╝██╔════╝██║ ██╔╝██╔════╝████╗ ████║██╔═══██╗████╗  ██║');
      writeln('                        ██║  ███╗█████╗  █████╗  █████╔╝ █████╗  ██╔████╔██║██║   ██║██╔██╗ ██║');
      writeln('                        ██║   ██║██╔══╝  ██╔══╝  ██╔═██╗ ██╔══╝  ██║╚██╔╝██║██║   ██║██║╚██╗██║');
      writeln('                        ╚██████╔╝███████╗███████╗██║  ██╗███████╗██║ ╚═╝ ██║╚██████╔╝██║ ╚████║');
      writeln('                         ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═══╝');
      writeln;
      writeln;
      writeln('                                 1. Nouvelle partie      2. Charger      3. Quitter');
      deplacerCurseurXY(28,19);
      write('> ');
      readln(choix);

      case choix of
        1 :
        begin
          prelude();
        end;
        2 :
        begin
         load();
        end;

        3 : sortieMenu := true;
        else
        begin
          writeln('MAUVAISE SAISIE');
        end;
      end;

    end;
  end;

  procedure succesMenu();
  var
    ecrirePos : coordonnees;
  begin
    //récupérer données BDD
    infoJoueur := getInfoJoueur();
    succes := getSucces();

    effacerEcran;
    ecrirePos.x := 53;
    ecrirePos.y := 2;
    dessinerCadreXY(48,1,68,3,double,15,0);
    ecrireEnPosition(ecrirePos,'S U C C E S');
    ecrirePos.x := 1;
    ecrirePos.y := 4;
    ecrireEnPosition(ecrirePos,'----------------------------------------------------------------------------------------------------------------------');
    ecrirePos.x := 2;
    ecrirePos.y := 15;
    ecrireEnPosition(ecrirePos,' - Vaincre 10 Geekemons ');
    ecrirePos.x := 2;
    ecrirePos.y := 16;
    ecrireEnPosition(ecrirePos,' - Vaincre 50 Geekemons ');
    ecrirePos.x := 2;
    ecrirePos.y := 17;
    ecrireEnPosition(ecrirePos,' - Vaincre 5 fois un dresseur ');
    ecrirePos.x := 2;
    ecrirePos.y := 18;
    ecrireEnPosition(ecrirePos,' - Vaincre 10 fois un dresseur ');
    ecrirePos.x := 2;
    ecrirePos.y := 19;
    ecrireEnPosition(ecrirePos,' - Faire 25 coups critiques ');
    ecrirePos.x := 2;
    ecrirePos.y := 20;
    ecrireEnPosition(ecrirePos,' - Attraper 5 Geekemons ');

    //succes vaincre 10 geekemons
    if infoJoueur.gkmVaincu >= 10 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 15;
      ecrireEnPosition(ecrirePos,'|Succès accompli');
    end
    else if infoJoueur.gkmVaincu < 10 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 15;
      ecrireEnPosition(ecrirePos,'|Succès non accompli    ');
      write(infoJoueur.gkmVaincu,'/10');
    end;

    //succes vaincre 50 geekemons
    if infoJoueur.gkmVaincu >= 50 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 16;
      ecrireEnPosition(ecrirePos,'|Succès accompli');
    end
    else if infoJoueur.gkmVaincu < 50 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 16;
      ecrireEnPosition(ecrirePos,'|Succès non accompli    ');
      write(infoJoueur.gkmVaincu,'/50');
    end;

    //Battre 5 fois un dresseur
    if infoJoueur.dressVaincu >= 5 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 17;
      ecrireEnPosition(ecrirePos,'|Succès accompli');
    end
    else if infoJoueur.dressVaincu < 5 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 17;
      ecrireEnPosition(ecrirePos,'|Succès non accompli    ');
      write(infoJoueur.dressVaincu,'/5');
    end;

    //Battre 10 fois un dresseur
    if infoJoueur.dressVaincu >= 10 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 18;
      ecrireEnPosition(ecrirePos,'|Succès accompli');
    end
    else if infoJoueur.dressVaincu < 10 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 18;
      ecrireEnPosition(ecrirePos,'|Succès non accompli    ');
      write(infoJoueur.dressVaincu,'/10');
    end;

    //Reussir 50 coup critique
    if infoJoueur.nbCrit >= 25 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 19;
      ecrireEnPosition(ecrirePos,'|Succès accompli');
    end
    else if infoJoueur.nbCrit < 25 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 19;
      ecrireEnPosition(ecrirePos,'|Succès non accompli    ');
      write(infoJoueur.nbCrit,'/25');
    end;

    //Attraper 5 gkm
    if infoJoueur.nbAttr >= 5 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 20;
      ecrireEnPosition(ecrirePos,'|Succès accompli');
    end
    else if infoJoueur.nbAttr < 5 then
    begin
      ecrirePos.x := 50;
      ecrirePos.y := 20;
      ecrireEnPosition(ecrirePos,'|Succès non accompli    ');
      write(infoJoueur.nbAttr,'/5');
    end;

    //RECOMPENSES
    if (succes.gkm10 = true) then
    begin
      dessinerCadreXY(10,7,60,12,double,15,0);
      deplacerCurseurXY(12,9);
      writeln('<VAINCRE 10 GKMs>');
      deplacerCurseurXY(12,10);
      write('Succès accompli, vous obtenez 100 bitcoins !');
      infoJoueur.argent := infoJoueur.argent + 100;
      readlnE;
      succes.gkm10 := false;
      setSucces(succes);
      setInfoJoueur(infoJoueur);
      succesMenu();
    end;

    if (succes.gkm50 = true) then
    begin
      dessinerCadreXY(10,7,60,12,double,15,0);
      deplacerCurseurXY(12,9);
      writeln('<VAINCRE 50 GKMs>');
      deplacerCurseurXY(12,10);
      writeln('Succès accompli, vous obtenez 200 bitcoins !');
      infoJoueur.argent := infoJoueur.argent + 200;
      readlnE;
      succes.gkm50 := false;
      setSucces(succes);
      setInfoJoueur(infoJoueur);
      succesMenu();
    end;

    if (succes.drss5 = true) then
    begin
      dessinerCadreXY(10,7,60,12,double,15,0);
      deplacerCurseurXY(12,9);
      writeln('<VAINCRE 5 FOIS UN DRESSEUR>');
      deplacerCurseurXY(12,10);
      writeln('Succès accompli, vous obtenez 100 bitcoins !');
      infoJoueur.argent := infoJoueur.argent + 100;
      readlnE;
      succes.drss5 := false;
      setSucces(succes);
      setInfoJoueur(infoJoueur);
      succesMenu();
    end;

    if (succes.drss10 = true) then
    begin
      dessinerCadreXY(10,7,60,12,double,15,0);
      deplacerCurseurXY(12,9);
      writeln('<VAINCRE 10 FOIS UN DRESSEUR>');
      deplacerCurseurXY(12,10);
      writeln('Succès accompli, vous obtenez 200 bitcoins !');
      infoJoueur.argent := infoJoueur.argent + 200;
      readlnE;
      succes.drss10 := false;
      setSucces(succes);
      setInfoJoueur(infoJoueur);
      succesMenu();
    end;

    if (succes.cpCrit = true) then
    begin
      dessinerCadreXY(10,7,60,12,double,15,0);
      deplacerCurseurXY(12,9);
      writeln('<EFFECTUER 50 COUPS CRITIQUES>');
      deplacerCurseurXY(12,10);
      writeln('Succès accompli, vous obtenez 200 bitcoins !');
      infoJoueur.argent := infoJoueur.argent + 200;
      readlnE;
      succes.cpCrit := false;
      setSucces(succes);
      setInfoJoueur(infoJoueur);
      succesMenu();
    end;

    if (succes.gkmAttr = true) then
    begin
      dessinerCadreXY(10,7,60,12,double,15,0);
      deplacerCurseurXY(12,9);
      writeln('<ATTRAPER 10 GKMs>');
      deplacerCurseurXY(12,10);
      writeln('Succès accompli, vous obtenez 100 bitcoins !');
      infoJoueur.argent := infoJoueur.argent + 200;
      readlnE;
      succes.gkmAttr := false;
      setSucces(succes);
      setInfoJoueur(infoJoueur);
      succesMenu();
    end;

    readlnE;
  end;

  procedure descrQ();
  begin
    quete := getQuete();
    if quete.q01a = true then write ('Se promener dans le bâtiment')
    else if quete.q01b = true then write ('Se promener dans le bâtiment')
    else if quete.q02 = true then write('Se rendre en R20')
    else if quete.q03 = true then write('Vaincre les dresseurs à la cafétéria')
    else if quete.q04 = true then write('Se rendre en S249 pour votre prochain cours')
    else if quete.q05 = true then write('Vaincre la TEAM ALGO à la cafétéria')
    else if quete.q06 = true then write('Vaincre Matthew Sermonet')
    else if quete.q07 = true then write('Vaincre Matthew Sermonet');

  end;

  procedure enteteMenu(selection : Boolean ; combat : Boolean ; evenement : Boolean);
  var
    i,j,k : Integer;
    ecrirePos : coordonnees;
    saisie : coordonnees;
    choix : Char;
    argent : String;
    potions : String;
    gkbs : String;
    nomSalle : String;
  begin
    //récupérer données BDD
    infoJoueur := getInfoJoueur();
    nomSalle := getNomSalle();

    //INITIALISER VARIABLES
    Str(infoJoueur.argent,argent);
    Str(infoJoueur.nbPotion,potions);
    Str(infoJoueur.nbGeekeball,gkbs);

    //INITIALISER ESPACE ENTETE
    if not(selection) then
    begin
      for i := 1 to 7 do
        writeln;
      for j := 1 to 119 do
        write('-');
    end;

    if not(combat) then
    begin
      //DESSINER CADRE
      dessinerCadreXY(2,2,90,4,double,15,0);
        //nom salle
      ecrirePos.x := 40;
      ecrirePos.y := 3;
      ecrireEnPosition(ecrirePos, nomSalle);
    end
    else
    begin
      //DESSINER CADRE
      dessinerCadreXY(60,2,90,4,double,15,0);
        //nom salle
      ecrirePos.x := 67;
      ecrirePos.y := 3;
      ecrireEnPosition(ecrirePos, nomSalle);
    end;

    //DESSINER CADRE MENU
    if selection
    then dessinerCadreXY(95,0,118,6,simple,15,3)
    else dessinerCadreXY(95,0,118,6,simple,15,0);

    if not(combat) and not(evenement) then
    begin
      //TEXTE
      //boite menu
      ecrirePos.x := 97;
      ecrirePos.y := 1;
      ecrireEnPosition(ecrirePos,'0. SAISIR');
      ecrirePos.y := ecrirePos.y + 1;
      ecrireEnPosition(ecrirePos,'--------------------');
      ecrirePos.y := ecrirePos.y + 1;
      ecrireEnPosition(ecrirePos,'[g] GKMs');
      ecrirePos.y := ecrirePos.y + 1;
      ecrireEnPosition(ecrirePos,'[m] Carte');
      ecrirePos.x := ecrirePos.x + 11;
      ecrireEnPosition(ecrirePos,'[s] Succès');

    end
    else
    begin
      couleurTexte(7);
      ecrirePos.x := 102;
      ecrirePos.y := 1;
      ecrireEnPosition(ecrirePos,'indisponible');
      couleurTexte(15)
    end;
    //mot MENU sur cadre
    ecrirePos.x := 113;
    ecrirePos.y := 6;
    ecrireEnPosition(ecrirePos, 'MENU');

    //infos joueur
    couleurTexte(7);
    couleurFond(0);
     //argent joueur
    ecrirePos.x := 58;
    ecrirePos.y := 6;
    ecrireEnPosition(ecrirePos, 'Bitcoins: ');
    ecrirePos := positionCurseur();
    ecrireEnPosition(ecrirePos, argent);
     //nb GKB joueur
    ecrirePos.x := 87;
    ecrirePos.y := 6;
    ecrireEnPosition(ecrirePos, 'GKBs: ');
    ecrirePos := positionCurseur();
    ecrireEnPosition(ecrirePos, gkbs);
     //nb potions joueur
    ecrirePos.x := 73;
    ecrirePos.y := 6;
    ecrireEnPosition(ecrirePos, 'Potions: ');
    ecrirePos := positionCurseur();
    ecrireEnPosition(ecrirePos, potions);
    couleurTexte(15);
    if not(combat) then
    begin
      //objectif
      ecrirePos.x := 4;
      ecrirePos.y :=6;
      couleurTexte(7);
      deplacerCurseur(ecrirePos);
      write('>');
      descrQ();
      write('<');
      couleurTexte(15);
    end;
    //SAISIE MENU
    if selection then
    begin
      //position curseur
      saisie.x := 99;
      saisie.y := 5;
      couleurFond(3);
      ecrireEnPosition(saisie, 'Ouvrir: ');
      saisie.x := saisie.x + 8;
      deplacerCurseur(saisie);
      readln(choix);

      //selection
      if (choix = 'm') or (choix = 'M')
      then carte()
      else if (choix = 'g') or (choix = 'G')
      then menuGkms()
      else if (choix = 's') or (choix = 'S')
      then succesMenu();

    end;

    //CALIBRER TEXTE
    writeln;
    writeln;

  end;


  procedure menuGkms();
  var
    bordure : TypeBordure;
    i : Integer;
    x1,x2 : Integer;
    ecrireX : Integer;
    ecrirePos : coordonnees;
    choixMenu, choixLeader : Integer;
    sortie : Boolean;

  begin
    sortie := false;

    while not(sortie) do
    begin
      effacerEcran;
      //recupérer données BDD
      joueurGkm := getJoueurGkm();
      dernGkmUtilise := getDernGkmUtilise();

      x1 := 1;
      x2 := 26;
      ecrireX := 3;

      for i := 0 to 3 do
      begin
        if dernGkmUtilise = i
        then bordure := double
        else bordure := simple;

        ecrirePos.x := ecrireX;
        ecrirePos.y := 5;
        dessinerCadreXY(x1,4,x2,14,bordure,15,0);

        if joueurGkm[i].nom <> 'NULL' then
        begin
          deplacerCurseur(ecrirePos);
          writeln(joueurGkm[i].nom);
          writeln;
          ecrirePos.y := ecrirePos.y + 1;
          deplacerCurseur(ecrirePos);
          writeln('Lvl. ', joueurGkm[i].lvl);
          ecrirePos.y := ecrirePos.y + 1;
          deplacerCurseur(ecrirePos);
          writeln('PVs: ', joueurGkm[i].pv, '/', joueurGkm[i].pvMax);
          writeln;
          ecrirePos.y := ecrirePos.y + 2;
          deplacerCurseur(ecrirePos);
          writeln(' ATK ', joueurGkm[i].atk);
          ecrirePos.y := ecrirePos.y + 1;
          deplacerCurseur(ecrirePos);
          writeln(' DEF ', joueurGkm[i].def);
          ecrirePos.y := ecrirePos.y + 1;
          deplacerCurseur(ecrirePos);
          writeln(' SPD ', joueurGkm[i].spd);
          writeln;
          ecrirePos.y := ecrirePos.y + 2;
          deplacerCurseur(ecrirePos);
          writeln('XP ', joueurGkm[i].xpHave, '/', joueurGkm[i].xpToNxt);

        end
        else
        begin
          ecrirePos.y := 9;
          ecrireEnPosition(ecrirePos, '   EMPLACEMENT VIDE');
        end;

        x1 := x1 + 26;
        x2 := x2 + 26;
        ecrireX := ecrireX + 26;
      end;

      //ENTETE
      dessinerCadreXY(5,1,30,3,simple,15,0);
      ecrirePos.x := 10;
      ecrirePos.y := 2;
      ecrireEnPosition(ecrirePos, 'M E S    G K M s');

      deplacerCurseurXY(0,16);
      writeln(' 1. Choisir GKM leader');
      writeln(' 2. Sortir menu');
      readln(choixMenu);

      if choixMenu = 1 then
      begin
        repeat
          writeln('Quel GKM sera le premier envoyé en combat ?');
          writeln(' 1. ', joueurGkm[0].nom);
          if joueurGkm[1].nom <> 'NULL'
          then writeln(' 2. ', joueurGkm[1].nom);
          if joueurGkm[2].nom <> 'NULL'
          then writeln(' 3. ', joueurGkm[2].nom);
          if joueurGkm[3].nom <> 'NULL'
          then writeln(' 4. ', joueurGkm[3].nom);

          readln(choixLeader);

          if joueurGkm[choixLeader-1].nom = 'NULL'
          then choixLeader := 0;

          dernGkmUtilise := choixLeader-1;
        until (choixLeader = 1) OR(choixLeader = 2) OR (choixLeader = 3) OR (choixLeader = 4);
      end
      else if choixMenu = 2
      then sortie := true
      else
      begin
        writeln('MAUVAISE SAISIE');
        readlnE;
      end;

      setDernGkmUtilise(dernGkmUtilise);
    end;
  end;


  procedure menuGkmsEchanger(nomGkmPc : String ; emplacementGkmPc : Integer);
  var
    bordure : TypeBordure;
    i : Integer;
    x1,x2 : Integer;
    ecrireX : Integer;
    ecrirePos : coordonnees;
    choixMenu, choixEchange : Integer;
    sortie : Boolean;

  begin
    sortie := false;
    joueurGkm := getJoueurGkm;

    while not(sortie) do
    begin
      effacerEcran;
      //recupérer données BDD
      joueurGkm := getJoueurGkm();

      x1 := 1;
      x2 := 26;
      ecrireX := 3;

      for i := 0 to 3 do
      begin

        ecrirePos.x := ecrireX;
        ecrirePos.y := 5;
        dessinerCadreXY(x1,4,x2,14,bordure,15,0);

        deplacerCurseur(ecrirePos);
        writeln(joueurGkm[i].nom);
        writeln;
        ecrirePos.y := ecrirePos.y + 1;
        deplacerCurseur(ecrirePos);
        writeln('Lvl. ', joueurGkm[i].lvl);
        ecrirePos.y := ecrirePos.y + 1;
        deplacerCurseur(ecrirePos);
        writeln('PVs: ', joueurGkm[i].pv, '/', joueurGkm[i].pvMax);
        writeln;
        ecrirePos.y := ecrirePos.y + 2;
        deplacerCurseur(ecrirePos);
        writeln(' ATK ', joueurGkm[i].atk);
        ecrirePos.y := ecrirePos.y + 1;
        deplacerCurseur(ecrirePos);
        writeln(' DEF ', joueurGkm[i].def);
        ecrirePos.y := ecrirePos.y + 1;
        deplacerCurseur(ecrirePos);
        writeln(' SPD ', joueurGkm[i].spd);
        writeln;
        ecrirePos.y := ecrirePos.y + 2;
        deplacerCurseur(ecrirePos);
        writeln('XP ', joueurGkm[i].xpHave, '/', joueurGkm[i].xpToNxt);


        x1 := x1 + 26;
        x2 := x2 + 26;
        ecrireX := ecrireX + 26;
      end;

      //ENTETE
      dessinerCadreXY(5,1,30,3,simple,15,0);
      ecrirePos.x := 6;
      ecrirePos.y := 2;
      ecrireEnPosition(ecrirePos, 'P C <--> M E S  G K M s');

      deplacerCurseurXY(0,16);
      writeln(' 1. Echanger');
      writeln(' 2. Sortir menu');
      readln(choixMenu);

      if choixMenu = 1 then
      begin
        repeat
          writeln('Quel GKM souhaitez vous échanger avec ', nomGkmPc, ' ?');
          writeln(' 1. ', joueurGkm[0].nom);
          writeln(' 2. ', joueurGkm[1].nom);
          writeln(' 3. ', joueurGkm[2].nom);
          writeln(' 4. ', joueurGkm[3].nom);

          readln(choixEchange);
        until (choixEchange >=1) and (choixEchange <= 4);

        echangePcJoueur(choixEchange-1, emplacementGkmPc);
        writeln('transfert effectué avec succès.');
        readlnE;
        sortie := true;

      end
      else if choixMenu = 2
      then sortie := true
      else
      begin
        writeln('MAUVAISE SAISIE');
        readlnE;
      end;
    end;
  end;


function carte() : Boolean;
  var
    ecrirePos : coordonnees;
    choix : Integer;
  begin
    effacerEtColorierEcran(0);
    dessinerCadreXY(10,1,110,30,double,12,0);
    ecrirePos.x := 93;
    ecrirePos.y := 3;
    dessinerCadreXY(92,2,108,4,double,12,0);
    ecrireEnPosition(ecrirePos,'Rez de chaussée');

    //Cafet
    ecrirePos.x := 23;
    ecrirePos.y := 8;
    couleurTexte(15);
    dessinerCadreXY(20,5,35,11,simple,15,0);
    ecrireEnPosition(ecrirePos,'Cafeteriat');
    ecrirePos.x := 26;
    ecrirePos.y := 11;
    ecrireEnPosition(ecrirePos,'   ');

    //Hall
    ecrirePos.x := 26;
    ecrirePos.y := 17;
    couleurTexte(15);
    dessinerCadreXY(15,12,40,22,simple,15,0);
    ecrireEnPosition(ecrirePos,'Hall');
    ecrirePos.x := 26;
    ecrirePos.y := 12;
    ecrireEnPosition(ecrirePos,'   ');
    ecrirePos.x := 40;
    ecrirePos.y := 18;
    ecrireEnPosition(ecrirePos,' ');

    //couloir rez de chaussé
    ecrirePos.x := 67;
    ecrirePos.y := 17;
    couleurTexte(10);
    dessinerCadreXY(41,16,100,19,simple,10,0);
    ecrireEnPosition(ecrirePos,'Couloir');
    ecrirePos.x := 48;
    ecrirePos.y := 16;
    ecrireEnPosition(ecrirePos,'   ');
    ecrirePos.x := 41;
    ecrirePos.y := 18;
    ecrireEnPosition(ecrirePos,' ');
    ecrirePos.x := 67;
    ecrirePos.y := 19;
    ecrireEnPosition(ecrirePos,'   ');
    ecrirePos.x := 47;
    ecrirePos.y := 19;
    ecrireEnPosition(ecrirePos,'   ');

    //Salle R20
    ecrirePos.x := 48;
    ecrirePos.y := 12;
    couleurTexte(14);
    dessinerCadreXY(44,9,60,15,simple,14,0);
    ecrireEnPosition(ecrirePos,'Salle R20');
    ecrirePos.x := 48;
    ecrirePos.y := 15;
    ecrireEnPosition(ecrirePos,'   ');

    //salle R51
    ecrirePos.x := 68;
    ecrirePos.y := 23;
    couleurTexte(14);
    dessinerCadreXY(64,20,80,26,simple,14,0);
    ecrireEnPosition(ecrirePos,'Salle R51');
    ecrirePos.x := 67;
    ecrirePos.y := 20;
    ecrireEnPosition(ecrirePos,'   ');

    //Legende
    ecrirePos.x := 93;
    ecrirePos.y := 23;
    couleurTexte(12);
    dessinerCadreXY(90,22,109,28,simple,12,0);
    ecrireEnPosition(ecrirePos,'Legende');
    ecrirePos.x := 91;
    ecrirePos.y := 24;
    ecrireEnPosition(ecrirePos,'------------------');
    ecrirePos.x := 91;
    ecrirePos.y := 25;
    couleurTexte(15);
    ecrireEnPosition(ecrirePos,'. Salle Speciale');
    ecrirePos.x := 91;
    ecrirePos.y := 26;
    couleurTexte(14);
    ecrireEnPosition(ecrirePos,'. Salle de combat');
    ecrirePos.x := 91;
    ecrirePos.y := 27;
    couleurTexte(10);
    ecrireEnPosition(ecrirePos,'. Couloir');

    //escalier
    ecrirePos.x := 45;
    ecrirePos.y := 21;
    dessinerCadreXY(44,20,59,27,simple,15,0);
    ecrireEnPosition(ecrirePos,'Escalier');
    ecrirePos.x := 47;
    ecrirePos.y := 20;
    ecrireEnPosition(ecrirePos,'   ');
    ecrirePos.x := 45;
    ecrirePos.y := 22;
    ecrireEnPosition(ecrirePos,'--------------');
    ecrirePos.x := 45;
    ecrirePos.y := 23;
    couleurTexte(15);
    ecrireEnPosition(ecrirePos,'1.Monter');
    ecrirePos.x := 45;
    ecrirePos.y := 24;
    couleurTexte(7);
    ecrireEnPosition(ecrirePos,'2.Indisponible');
    ecrirePos.x := 45;
    ecrirePos.y := 25;
    couleurTexte(15);
    ecrireEnPosition(ecrirePos,'3.Quitter');
    ecrirePos.x := 45;
    ecrirePos.y := 26;
    ecrireEnPosition(ecrirePos,'');




    readln(choix);
    if choix = 1 then
      carte2
    else if choix = 3 then
        begin
        couleurTexte(15);
        carte := true;
        end
    else
      carte;
  end;

  function carte2() : Boolean;
    var
      ecrirePos : coordonnees;
      choix : Integer;
    begin
      effacerEtColorierEcran(0);
      dessinerCadreXY(10,1,110,30,double,12,0);
      ecrirePos.x := 100;
      ecrirePos.y := 3;
      dessinerCadreXY(99,2,108,4,double,12,0);
      couleurTexte(12);
      ecrireEnPosition(ecrirePos,'Etage 1');

      //Salle Secrete
      ecrirePos.x := 27;
      ecrirePos.y := 12;
      dessinerCadreXY(20,9,35,15,simple,15,0);
      couleurTexte(15);
      ecrireEnPosition(ecrirePos,'?');
      ecrirePos.x := 28;
      ecrirePos.y := 15;
      ecrireEnPosition(ecrirePos,'   ');

      //Secretariat
      ecrirePos.x := 21;
      ecrirePos.y := 23;
      dessinerCadreXY(19,20,35,26,simple,15,0);
      couleurTexte(15);
      ecrireEnPosition(ecrirePos,'Secretariat');
      ecrirePos.x := 24;
      ecrirePos.y := 20;
      ecrireEnPosition(ecrirePos,'   ');

      //couloir Etage1
      ecrirePos.x := 55;
      ecrirePos.y := 17;
      couleurTexte(10);
      dessinerCadreXY(18,16,100,19,simple,10,0);
      ecrireEnPosition(ecrirePos,'Couloir');
      ecrirePos.x := 24;
      ecrirePos.y := 19;
      ecrireEnPosition(ecrirePos,'   ');
      ecrirePos.x := 41;
      ecrirePos.y := 18;
      ecrireEnPosition(ecrirePos,' ');
      ecrirePos.x := 67;
      ecrirePos.y := 19;
      ecrireEnPosition(ecrirePos,'   ');
      ecrirePos.x := 48;
      ecrirePos.y := 16;
      ecrireEnPosition(ecrirePos,'   ');
      ecrirePos.x := 28;
      ecrirePos.y := 16;
      ecrireEnPosition(ecrirePos,'   ');
      ecrirePos.x := 92;
      ecrirePos.y := 16;
      ecrireEnPosition(ecrirePos,'   ');
      ecrirePos.x := 47;
      ecrirePos.y := 19;
      ecrireEnPosition(ecrirePos,'   ');

      //ETDDG
      ecrirePos.x := 50;
      ecrirePos.y := 12;
      dessinerCadreXY(44,9,60,15,simple,15,0);
      couleurTexte(15);
      ecrireEnPosition(ecrirePos,'ETDDG');
      ecrirePos.x := 48;
      ecrirePos.y := 15;
      ecrireEnPosition(ecrirePos,'   ');

      //Salle 150
      ecrirePos.x := 68;
      ecrirePos.y := 23;
      dessinerCadreXY(64,20,80,26,simple,14,0);
      couleurTexte(14);
      ecrireEnPosition(ecrirePos,'Salle 150');
      ecrirePos.x := 67;
      ecrirePos.y := 20;
      ecrireEnPosition(ecrirePos,'   ');

      //Salle 121
      ecrirePos.x := 84;
      ecrirePos.y := 12;
      dessinerCadreXY(80,9,96,15,simple,14,0);
      couleurTexte(14);
      ecrireEnPosition(ecrirePos,'Salle 121');
      ecrirePos.x := 92;
      ecrirePos.y := 15;
      ecrireEnPosition(ecrirePos,'   ');

      //Legende
      ecrirePos.x := 93;
      ecrirePos.y := 23;
      couleurTexte(12);
      dessinerCadreXY(90,22,109,28,simple,12,0);
      ecrireEnPosition(ecrirePos,'Legende');
      ecrirePos.x := 91;
      ecrirePos.y := 24;
      ecrireEnPosition(ecrirePos,'------------------');
      ecrirePos.x := 91;
      ecrirePos.y := 25;
      couleurTexte(15);
      ecrireEnPosition(ecrirePos,'. Salle Speciale');
      ecrirePos.x := 91;
      ecrirePos.y := 26;
      couleurTexte(14);
      ecrireEnPosition(ecrirePos,'. Salle de combat');
      ecrirePos.x := 91;
      ecrirePos.y := 27;
      couleurTexte(10);
      ecrireEnPosition(ecrirePos,'. Couloir');

      //escalier
      ecrirePos.x := 45;
      ecrirePos.y := 21;
      dessinerCadreXY(44,20,56,27,simple,15,0);
      couleurTexte(15);
      ecrireEnPosition(ecrirePos,'Escalier');
      ecrirePos.x := 47;
      ecrirePos.y := 20;
      ecrireEnPosition(ecrirePos,'   ');
      ecrirePos.x := 45;
      ecrirePos.y := 22;
      ecrireEnPosition(ecrirePos,'-----------');
      ecrirePos.x := 45;
      ecrirePos.y := 23;
      couleurTexte(15);
      ecrireEnPosition(ecrirePos,'1.Monter');
      ecrirePos.x := 45;
      ecrirePos.y := 24;
      ecrireEnPosition(ecrirePos,'2.Descendre');
      ecrirePos.x := 45;
      ecrirePos.y := 25;
      ecrireEnPosition(ecrirePos,'3.Quitter');
      ecrirePos.x := 45;
      ecrirePos.y := 26;
      ecrireEnPosition(ecrirePos,'');

      readln(choix);
      if choix = 1 then
        carte3
      else if choix = 2 then
        carte
      else if choix = 3 then
        couleurTexte(15);
        carte2 := true;


    end;

  function carte3() : Boolean;
    var
      ecrirePos : coordonnees;
      choix : Integer;
    begin
        effacerEtColorierEcran(0);
        dessinerCadreXY(10,1,110,30,double,12,0);
        ecrirePos.x := 100;
        ecrirePos.y := 3;
        dessinerCadreXY(99,2,108,4,double,12,0);
        ecrireEnPosition(ecrirePos,'Etage 2');

        //couloir Etage2
        ecrirePos.x := 67;
        ecrirePos.y := 17;
        couleurTexte(10);
        dessinerCadreXY(41,16,100,19,simple,10,0);
        ecrireEnPosition(ecrirePos,'Couloir');
        ecrirePos.x := 48;
        ecrirePos.y := 16;
        ecrireEnPosition(ecrirePos,'   ');
        ecrirePos.x := 67;
        ecrirePos.y := 19;
        ecrireEnPosition(ecrirePos,'   ');
        ecrirePos.x := 47;
        ecrirePos.y := 19;
        ecrireEnPosition(ecrirePos,'   ');

        //Salle 209
        ecrirePos.x := 48;
        ecrirePos.y := 12;
        couleurTexte(14);
        dessinerCadreXY(44,9,60,15,simple,14,0);
        ecrireEnPosition(ecrirePos,'Salle 209');
        ecrirePos.x := 48;
        ecrirePos.y := 15;
        ecrireEnPosition(ecrirePos,'   ');

        //Salle 249
        ecrirePos.x := 68;
        ecrirePos.y := 23;
        couleurTexte(14);
        dessinerCadreXY(64,20,80,26,simple,14,0);
        ecrireEnPosition(ecrirePos,'Salle 249');
        ecrirePos.x := 67;
        ecrirePos.y := 20;
        ecrireEnPosition(ecrirePos,'   ');

        //Legende
        ecrirePos.x := 93;
        ecrirePos.y := 23;
        couleurTexte(12);
        dessinerCadreXY(90,22,109,28,simple,12,0);
        ecrireEnPosition(ecrirePos,'Legende');
        ecrirePos.x := 91;
        ecrirePos.y := 24;
        ecrireEnPosition(ecrirePos,'------------------');
        ecrirePos.x := 91;
        ecrirePos.y := 25;
        couleurTexte(15);
        ecrireEnPosition(ecrirePos,'. Salle Speciale');
        ecrirePos.x := 91;
        ecrirePos.y := 26;
        couleurTexte(14);
        ecrireEnPosition(ecrirePos,'. Salle de combat');
        ecrirePos.x := 91;
        ecrirePos.y := 27;
        couleurTexte(10);
        ecrireEnPosition(ecrirePos,'. Couloir');

        //escalier
        ecrirePos.x := 45;
        ecrirePos.y := 21;
        couleurTexte(15);
        dessinerCadreXY(44,20,59,27,simple,15,0);
        ecrireEnPosition(ecrirePos,'Escalier');
        ecrirePos.x := 47;
        ecrirePos.y := 20;
        ecrireEnPosition(ecrirePos,'   ');
        ecrirePos.x := 45;
        ecrirePos.y := 22;
        ecrireEnPosition(ecrirePos,'--------');
        ecrirePos.x := 45;
        ecrirePos.y := 23;
        couleurTexte(7);
        ecrireEnPosition(ecrirePos,'1.Indisponible');
        ecrirePos.x := 45;
        ecrirePos.y := 24;
        couleurTexte(15);
        ecrireEnPosition(ecrirePos,'2.Descendre');
        ecrirePos.x := 45;
        ecrirePos.y := 25;
        ecrireEnPosition(ecrirePos,'3.Quitter');
        ecrirePos.x := 45;
        ecrirePos.y := 26;
        ecrireEnPosition(ecrirePos,'');

        readln(choix);
        if choix = 2 then
          carte2
        else if choix = 3 then
          begin
          couleurTexte(15);
          carte3 := true;
          end
        else
          carte3;
    end;

  procedure pcDe();
  var
    pcGkm : TabPcGkm;
    i : Integer;
    ecrirePos : Coordonnees;
    choixMenu, choixGkm : Integer;
    sortie1, sortie2 : Boolean;
    afficherInit : Boolean;
  begin
    effacerEcran;
    sortie1 := false;
    sortie2 := false;
    afficherInit := true;


    while not(sortie1) do
    begin
    //récupérer données BDD
    pcGkm := getPcGkm();

    //DESSINER ECRAN
    dessinerCadreXY(1,0,101,29,simple,15,0);
    dessinerCadreXY(2,1,100,26,simple,15,0);
    dessinerCadreXY(95,27,97,28,double,12,0);
    dessinerCadreXY(93,28,93,28,double,7,0);
    dessinerCadreXY(91,28,91,28,double,7,0);
    ecrirePos.x := 47;
    ecrirePos.y := 27;
    ecrireEnPosition(ecrirePos,'GKScreen');
    ecrirePos.x := 7;
    ecrirePos.y := 3;
    dessinerCadreXY(4,2,19,4,double,15,0);
    ecrireEnPosition(ecrirePos,'PC DE ???');

    //AFFICHER MESSAGE INIT
    if afficherInit then
    begin
      deplacerCurseurXY(3,5);
      attendre(500);
      write('>D');
      attendre(100);
      write('E');
      attendre(200);
      write('M');
      attendre(100);
      write('A');
      attendre(200);
      write('R');
      attendre(100);
      write('R');
      attendre(300);
      write('A');
      attendre(200);
      write('G');
      attendre(100);
      writeln('E');
      attendre(500);
      writeln;
      deplacerCurseurXY(3,6);
      write('>C');
      attendre(100);
      write('o');
      attendre(200);
      write('n');
      attendre(50);
      write('n');
      attendre(200);
      write('e');
      attendre(300);
      write('x');
      attendre(200);
      write('i');
      attendre(100);
      write('o');
      attendre(400);
      write('n');
      attendre(100);
      write(' ');
      attendre(200);
      write('s');
      attendre(50);
      write('e');
      attendre(200);
      write('r');
      attendre(100);
      write('v');
      attendre(300);
      write('e');
      attendre(100);
      write('u');
      attendre(100);
      write('r');
      attendre(500);
      write('.');
      attendre(200);
      write('.');
      attendre(100);
      write('.');
      attendre(500);
      deplacerCurseurXY(3,7);
      writeln('DONE !');
      deplacerCurseurXY(3,8);
      readlnE;
      deplacerCurseurXY(3,9);
      writeln('Bonjour, utilisateur ', infoJoueur.nom, '.');
      deplacerCurseurXY(3,10);
      writeln('Bienvenue dans votre espace de stockage de GKMs.');
      deplacerCurseurXY(3,11);
      readlnE;
      deplacerCurseurXY(3,12);
      write('Utilisez cet espace pour gérer vos GKMs en stock.');
      deplacerCurseurXY(3,13);
      readlnE;
    end;

    //EFFACER ECRAN PC
    for i := 5 to 12 do
    begin
      deplacerCurseurXY(3,i);
      writeln('                                                          ');
    end;

      deplacerCurseurXY(3,5);
      write('GKMs en stock :');
      ecrirePos.x := 3;
      ecrirePos.y := 7;

      for i := 1 to high(pcGkm) do     //MAX 45 EMPLACEMENTS
      begin
        if i <= 15 then
        begin
          deplacerCurseur(ecrirePos);
          writeln(i, '. ', pcGkm[i].nom, ' lvl.', pcGkm[i].lvl);
          ecrirePos.y := ecrirePos.y + 1;
        end
        else if i = 16 then
        begin
          ecrirePos.x := 33;
          ecrirePos.y := 7;
          deplacerCurseur(ecrirePos);
          writeln(i, '. ', pcGkm[i].nom, ' lvl.', pcGkm[i].lvl);
          ecrirePos.y := ecrirePos.y + 1;
        end
        else if (i > 15) and (i <= 30) then
        begin
          deplacerCurseur(ecrirePos);
          writeln(i, '. ', pcGkm[i].nom, ' lvl.', pcGkm[i].lvl);
          ecrirePos.y := ecrirePos.y + 1;
        end
        else if i = 31 then
        begin
          ecrirePos.x := 62;
          ecrirePos.y := 7;
          deplacerCurseur(ecrirePos);
          writeln(i, '. ', pcGkm[i].nom, ' lvl.', pcGkm[i].lvl);
          ecrirePos.y := ecrirePos.y + 1;
        end
        else if (i > 31) and (i <= 45) then
        begin
          deplacerCurseur(ecrirePos);
          writeln(i, '. ', pcGkm[i].nom, ' lvl.', pcGkm[i].lvl);
          ecrirePos.y := ecrirePos.y + 1;
        end
      end;

      ecrirePos.x:=3;
      ecrirePos.y:= 22;
      ecrireEnPosition(ecrirePos, '>Selectionnez le GKM (0: Quitter): ');
      ecrirePos.y:= ecrirePos.y + 1;
      deplacerCurseur(ecrirePos);
      sortie2 := false;
      while not(sortie2) do
        begin
        ecrirePos.y := 22;
        //EFFACER BAS ECRAN
        for i := 1 to 3 do
        begin
          ecrirePos.y := ecrirePos.y +1;
          deplacerCurseur(ecrirePos);
          writeln('                                                                              ');
        end;
        ecrirePos.x:=3;
        ecrirePos.y:= 23;
        deplacerCurseur(ecrirePos);
        write('>');
        readln(choixGkm);
        if (choixGkm > 0) and (choixGkm <= high(pcGkm)) then
        begin
          deplacerCurseurXY(3,24);
          write(pcGkm[choixGkm].nom, '       GKM lvl.', pcGkm[choixGkm].lvl, '        PVs: ', pcGkm[choixGkm].pv,'/',pcGkm[choixGkm].pvMax);
          deplacerCurseurXY(3,25);
          write('Commande utilisateur [(1)Placer dans l''équipe / (2)Sortir] : ');
          readln(choixMenu);
          if choixMenu = 1 then
          begin
            menuGkmsEchanger(pcGkm[choixGkm].nom, choixGkm);
            sortie2 := true;
            afficherInit := false;
            effacerEcran;
          end
        end
        else if choixGkm = 0 then
        begin
          deplacerCurseurXY(3,24);
          write('EXIT');
          deplacerCurseurXY(3,25);
          readlnE;
          sortie1 := true;
          sortie2 := true;
        end
        else
        begin
          deplacerCurseurXY(3,24);
          write('ERREUR SAISIE');
          deplacerCurseurXY(3,25);
          readlnE;
        end;
      end;
    end;
  end;

  procedure quitterLeJeu();
  var
    choix : Integer;
    sortie : Boolean;
  begin
    sortie := false;
    while not(sortie) do
    begin
      effacerEcran;
      sortie := false;
      dessinerCadreXY(5,2,77,10,double,15,0);
      dessinerCadreXY(6,3,76,8,simple,15,0);
      deplacerCurseurXY(7,4);
      writeln('Souhaitez-vous sauvegarder votre progression avant de quitter ?');
      deplacerCurseurXY(14,7);
      writeln('1. OUI             2. NON');
      deplacerCurseurXY(13,9);
      write('>');
      readln(choix);


        case choix of
          1:
          begin
            save();
            deplacerCurseurXY(18,9);
            couleurTexte(2);
            write('JEU SAUVEGARDé AVEC SUCCèS');
            couleurTexte(15);
            sortie := true;
          end;
          2:
          begin
            sortie := true;
            deplacerCurseurXY(18,9);
            write('QUITTER LE JEU');
          end
          else
          begin
            deplacerCurseurXY(18,9);
            writeln('MAUVAISE SAISIE');
          end;
          readlnE;
        end;
    end;
  end;

  procedure ecranFinJeu();
  begin
    effacerEcran;
    writeln('M E R C I    D '' A V O I R    J O U é    !');
    readlnE;
  end;

end.
