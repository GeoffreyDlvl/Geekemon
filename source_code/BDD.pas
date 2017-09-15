unit BDD;


interface
  uses
    GestionEcran;

  type
    Gkm = record    //type record qui regroupe les informations relatives aux GKMs
      id : Integer;
      lvl : Integer;
      nom : String;
      pv : Integer;
      pvMax : Integer;
      atk : Integer;
      def : Integer;
      spd : Integer;
      xpGive : Integer;
      xpHave : Integer;
      xpToNxt : Integer;
    end;

    Joueur = record     //infos relatives au joueur
      nom : String;
      argent : Integer;
      nbPotion : Integer;
      nbGeekeball : Integer;
      gkmVaincu : Integer;
      dressVaincu : Integer;
      nbCrit : Integer;
      nbAttr : Integer;
    end;

    TQuete = record
      q01a : Boolean;
      q01b : Boolean;
      q02 : Boolean;
      q03 : Boolean;
      q04 : Boolean;
      q05 : Boolean;
      q06 : Boolean;
      q07 : Boolean;
      evt1 : Boolean;
      evt2 : Boolean;
      finjeu : Boolean;
    end;

    TVaincu = record
      guillaume, joelle, benjamin, marc, michael, serrure, cassoulet, parzani : Boolean;
    end;

    TSucces = record
      gkm10, gkm50, drss5, drss10, cpCrit, gkmAttr : Boolean;
    end;

    TabInfoGkm  = array[1..20, 0 .. 17] of Gkm;

    TabJoueurGkm = array[0..4] of Gkm;

    TabPcGkm = array of Gkm;


  procedure initPcGkmCase();
  procedure initQuetes(); //initialise tous les booléens de quêtes sur faux
  procedure initSucces(); //initialise tous les succès sur faux
  procedure initVaincu(); //initialise les boolens de dresseurs vaincus sur faux

  //PROCEDURES DE CHANGEMENT D'ETAT DES QUETES
  procedure etatQuete(var queteP : Boolean);
  procedure etatSucces(var succesP : Boolean);

  procedure remplirInfoGkm ();
  procedure remplirJoueurGkm ();
  procedure remplirInfoJoueur();
  procedure ajoutGkm(lvl : Integer ; ind : Integer ; pv : Integer);
  procedure echangePcJoueur(emplacementJ : Integer ; emplacementPc : Integer);
  procedure save();
  procedure load();

  //FONCTIONS GET
  function getInfoGkm() : TabInfoGkm;
  function getJoueurGkm() : TabJoueurGkm;
  function getInfoJoueur() : Joueur;
  function getPcGkm() : TabPcGkm;
  function getNomRival() : String;
  function getQuete() : TQuete;
  function getSucces() : TSucces;
  function getVaincu() : TVaincu;

  //PROCEDURES SET
  procedure setJoueurGkm (joueurGkmP : TabJoueurGkm);
  procedure setInfoJoueur(infoJoueurP : Joueur);
  procedure setNomRival(nomRivalP : String);
  procedure setQuete(queteP : TQuete);
  procedure setSucces(succesP : TSucces);
  procedure setVaincu(vaincuP : TVaincu);

implementation
  uses
    Combat,
    Salles;


  var
    infoGkm : TabInfoGkm;    //tableau de type TabInfoGkm (indicé 0 à 16)
                                        //0: pas de GKM
    joueurGkm : TabJoueurGkm;    //tableau de type TabJoueurGkm, contiendra les GKM possédés par le joueur
                                        //id= 0: emplacement vide
    infoJoueur : Joueur;
    dernGkmUtilise : Integer;

    nomRival : String;

    pcGkm : TabPcGkm;
    pcGkmCase : Integer; //nb de cases dans le tableau pcGkm. Incrémenté pour permettre l'allocation dynamique

    position : Tposition;
    positionS : String; //position sous forme de ch de car

    //VARIABLES DE QUETES
    quete : TQuete;
    //VARIABLES DRESSEURS VAINCU
    vaincu: TVaincu;
    //VARIABLES DE SUCCES
    succes : TSucces;

    saveF : Text;


  procedure initPcGkmCase(); //permet l'initialisation du nb de cases à 0
  begin
    SetLength(pcGkm,1);
    pcGkmCase := 1;
  end;

  procedure initQuetes();
  begin
    quete.q01a := false;
    quete.q01b := false;
    quete.q02 := false;
    quete.q03 := false;
    quete.q04 := false;
    quete.q05 := false;
    quete.q06 := false;
    quete.q07 := false;
    quete.evt1 := false;
    quete.evt2 := false;
    quete.finjeu := false;
  end;

  procedure initSucces();
  begin
    succes.gkm10 := false;
    succes.gkm50 := false;
    succes.drss5 := false;
    succes.drss10 := false;
    succes.cpCrit := false;
    succes.gkmAttr := false;
  end;

  procedure initVaincu();
  begin
    vaincu.guillaume := false;
    vaincu.joelle := false;
    vaincu.benjamin := false;
    vaincu.marc := false;
    vaincu.michael := false;
    vaincu.serrure := false;
    vaincu.cassoulet := false;
    vaincu.parzani := false;
  end;

  procedure etatQuete(var queteP : Boolean); //modifie la valeur booléenne d'une var de quete
  begin
    if queteP = true then queteP := false
    else queteP := true;
  end;

  procedure etatSucces(var succesP : Boolean);
  begin
    if succesP = true then succesP := false
    else succesP := true;
  end;

  procedure remplirInfoGkm ();
  var
    lvl, id : Integer; //variables de boucle qui donneront leur valeur aux sous-variable
                  //lvl et id de infoGkm
  begin
    for lvl := low(infoGkm) to high(infoGkm) do  //boucles de remplissage de infoGkm
    begin
      for id := low(infoGkm[lvl]) to high(infoGkm[lvl]) do
      begin
        infoGkm[lvl][id].id := id;  //id du GKM
        infoGkm[lvl][id].lvl := lvl;  //niveau du GKM
        infoGkm[lvl][id].xpHave := 0; //init à 0 partout
      end;
    end;

    //remplir infos GKMs : LVL 1 (initialisation)
    With infoGkm[1][0] do
    begin
      nom := 'NULL';
    end;

    With infoGkm[1][1] do
    begin
      nom := 'Heinsenberg';
      pvMax := 30;
      pv := pvMax;
      atk :=8;
      def :=8;
      spd :=8;
      xpGive := 20;
      xpToNxt := 10;
    end;

    With infoGkm[1][2] do
    begin
      nom := 'Rust Cohle';
      pvMax := 30;
      pv := pvMax;
      atk :=8;
      def :=8;
      spd :=8;
      xpGive := 20;
      xpToNxt := 10;
    end;

    With infoGkm[1][3] do
    begin
      nom := 'Arsène Lupin';
      pvMax := 30;
      pv := pvMax;
      atk :=8;
      def :=8;
      spd :=8;
      xpGive := 20;
      xpToNxt := 10;
    end;

    With infoGkm[1][4] do
    begin
      nom := 'Ricke Grimes';
      pvMax := 25;
      pv := pvMax;
      atk :=7;
      def :=6;
      spd :=6;
      xpGive := 9;
      xpToNxt := 12;
    end;

    With infoGkm[1][5] do
    begin
      nom := 'Jon Snow';
      pvMax := 20;
      pv := pvMax;
      atk :=6;
      def :=7;
      spd :=6;
      xpGive := 8;
      xpToNxt := 9;
    end;

    With infoGkm[1][6] do
    begin
      nom := 'Tony Soprano';
      pvMax := 15;
      pv := pvMax;
      atk :=5;
      def :=10;
      spd :=4;
      xpGive :=7;
      xpToNxt :=12;
    end;

    With infoGkm[1][7] do
    begin
      nom := 'Malcolm';
      pvMax := 12;
      pv := pvMax;
      atk :=4;
      def :=5;
      spd :=10;
      xpGive := 5;
      xpToNxt := 8;
    end;

    With infoGkm[1][8] do
    begin
      nom := 'Michael Kyle';
      pvMax := 24;
      pv := pvMax;
      atk :=5;
      def :=8;
      spd :=6;
      xpGive := 10;
      xpToNxt := 11;
    end;

    With infoGkm[1][9] do
    begin
      nom := 'Mr. Robot';
      pvMax := 19;
      pv := pvMax;
      atk :=4;
      def :=10;
      spd :=5;
      xpGive := 8;
      xpToNxt := 10;
    end;

    With infoGkm[1][10] do
    begin
      nom := 'Ragnar Lodbrok';
      pvMax := 15;
      pv := pvMax;
      atk :=11;
      def :=8;
      spd :=2;
      xpGive := 12;
      xpToNxt := 14;
    end;

    With infoGkm[1][11] do
    begin
      nom := 'Starbuck';
      pvMax := 28;
      pv := pvMax;
      atk :=6;
      def :=8;
      spd :=5;
      xpGive := 11;
      xpToNxt := 13;
    end;

    With infoGkm[1][12] do
    begin
      nom := 'Saul Goodman';
      pvMax := 13;
      pv := pvMax;
      atk :=4;
      def :=5;
      spd :=10;
      xpGive := 6;
      xpToNxt := 9;
    end;

    With infoGkm[1][13] do
    begin
      nom := 'Blackadder';
      pvMax := 13;
      pv := pvMax;
      atk :=4;
      def :=4;
      spd :=11;
      xpGive := 7;
      xpToNxt := 9;
    end;

    With infoGkm[1][14] do
    begin
      nom := 'Chandler Bing';
      pvMax := 12;
      pv := pvMax;
      atk :=5;
      def :=7;
      spd :=7;
      xpGive := 8;
      xpToNxt := 8;
    end;

    With infoGkm[1][15] do
    begin
      nom := 'Dale Cooper';
      pvMax := 25;
      pv := pvMax;
      atk :=8;
      def :=4;
      spd :=8;
      xpGive := 12;
      xpToNxt := 11;
    end;

    With infoGkm[1][16] do
    begin
      nom := 'Lorne Malvo';
      pvMax := 27;
      pv := pvMax;
      atk :=7;
      def :=6;
      spd :=5;
      xpGive := 11;
      xpToNxt := 12;
    end;

    With infoGkm[1][17] do
    begin
      nom := 'Guybrush Threepwood';
      pvMax := 35;
      pv := pvMax;
      atk :=10;
      def :=10;
      spd :=10;
      xpGive := 20;
      xpToNxt := 10;
    end;

    //remplir infos GKMs: LVL 2 à 20
    for lvl := 2 to 20 do
    begin
      for id := 1 to 17 do
      begin
        infoGkm[lvl][id].id := infoGkm[lvl-1][id].id;
        infoGkm[lvl][id].nom := infoGkm[lvl-1][id].nom;
        infoGkm[lvl][id].pv := Round(infoGkm[lvl-1][id].pv*1.3);  //+30%
        infoGkm[lvl][id].pvMax := infoGkm[lvl][id].pv;
        infoGkm[lvl][id].atk := Round(infoGkm[lvl-1][id].atk*1.3); //+30%
        infoGkm[lvl][id].def := Round(infoGkm[lvl-1][id].def*1.3); //+30%
        infoGkm[lvl][id].spd := Round(infoGkm[lvl-1][id].spd*1.3); //+30%
        infoGkm[lvl][id].xpGive := Round(infoGkm[lvl-1][id].xpGive*1.3);  //+30%
        infoGkm[lvl][id].xpToNxt := Round(infoGkm[lvl-1][id].xpToNxt*1.5);  //+50%
      end;
    end;

  end;

  procedure remplirJoueurGkm ();
  begin
    joueurGkm[0] := infoGkm[1][0];
    joueurGkm[1] := infoGkm[1][0];
    joueurGkm[2] := infoGkm[1][0];
    joueurGkm[3] := infoGkm[1][0];

    with joueurGkm[4] do
    begin
    nom:= 'MAX';
    end;
  end;

  procedure remplirInfoJoueur();  //INIT SOUS VARIABLES JOUEUR A 0
  begin
    infoJoueur.argent := 0;
    infoJoueur.nbPotion := 0;
    infoJoueur.nbGeekeball := 0;
  end;

  procedure ajoutGkm(lvl : Integer ; ind : Integer ; pv : Integer);
  var
  dernInd : Integer;   //vérifie si l'écriture est possible, càd s'il reste un emplacement de libre
  sortie : Boolean;     //condition de sortie
  pos : Integer;
  envoyerPc : Boolean;
  begin
    sortie := false;
    envoyerPc := true;

      for pos := 1 to 3 do
      begin
        if (joueurGkm[pos].id = 0) AND not(sortie) then
        begin
          joueurGkm[pos] := infoGkm[lvl][ind];   //remplir tableau avec GKM passé en paramètre
          joueurGkm[pos].pv := pv;
          envoyerPc := false;
          sortie := true;
        end;
      end;

      if envoyerPc then
      begin
        writeln('Vous n''avez plus de place sur vous pour porter plus de GKMs.');
        readlnE;
        writeln(infoGkm[lvl][ind].nom, ' est envoyé au PC !');
        readlnE;
        pcGkmCase := pcGkmCase +1;
        SetLength(pcGkm,pcGkmCase);
        pcGkm[high(pcGkm)] := infoGkm[lvl][ind];
      end;



    {while not(sortie) do
    begin
      if joueurGkm[dernInd].id = 0 then  //si à l'indice du tableau, l'id vaut 0, ajouter GKM
      begin
        joueurGkm[dernInd] := infoGkm[lvl][ind];   //remplir tableau avec GKM passé en paramètre
        joueurGkm[dernInd].pv := pv;
        sortie := true;
      end
      else if joueurGkm[dernInd].nom = 'MAX' then  //sinon si, + de 4 GKMs
        begin
        writeln('Vous ne pouvez pas attraper plus de GKMs.');
        sortie := true;
        end
      else    //sinon, essayer l'indice suivant
        dernInd := dernInd+1;
    end;   }


  end;

  procedure echangePcJoueur(emplacementJ : Integer ; emplacementPc : Integer);
  var temp : Gkm;
  begin
    temp := joueurGkm[emplacementJ];
    joueurGkm[emplacementJ] := pcGkm[emplacementPC];
    pcGkm[emplacementPC] := temp;

  end;

  function positionStr() : String;
  begin
    case position of
      Pcouloir: positionStr := 'couloir';
      Psecretariat: positionStr := 'secretariat';
      Pcafeteria: positionStr := 'cafeteria';
      Pinfirmerie: positionStr := 'infirmerie';
      Petddg: positionStr := 'etddg';
    end;
  end;


  procedure save();
  var
    i, j : Integer;
  begin
    //récupérer données
    dernGkmUtilise := getDernGkmUtilise;
    position := getPosition;

    assign(saveF, 'save\save');
    rewrite(saveF);

    //SAUVER POSITION DU JOUEUR
    positionS := positionStr();
    writeln(saveF,positionS);

    //SAUVER DONNEES JOUEUR
    writeln(saveF,infoJoueur.nom);
    writeln(saveF,infoJoueur.argent);
    writeln(saveF,infoJoueur.nbPotion);
    writeln(saveF,infoJoueur.nbGeekeball);
    writeln(saveF,dernGkmUtilise);

    //SAUVER DONNEES JOUEUR GKMs
    for i := low(joueurGkm) to high(joueurGkm) do
    begin
      writeln(saveF,joueurGkm[i].id);
      writeln(saveF,joueurGkm[i].lvl);
      writeln(saveF,joueurGkm[i].nom);
      writeln(saveF,joueurGkm[i].pv);
      writeln(saveF,joueurGkm[i].pvMax);
      writeln(saveF,joueurGkm[i].atk);
      writeln(saveF,joueurGkm[i].def);
      writeln(saveF,joueurGkm[i].spd);
      writeln(saveF,joueurGkm[i].xpGive);
      writeln(saveF,joueurGkm[i].xpHave);
      writeln(saveF,joueurGkm[i].xpToNxt);
    end;

    //SAUVER DONNEES PC GKM
    writeln(saveF,pcGkmCase);
    for j := 1 to high(pcGkm) do
    begin
      writeln(saveF,pcGkm[j].id);
      writeln(saveF,pcGkm[j].lvl);
      writeln(saveF,pcGkm[j].nom);
      writeln(saveF,pcGkm[j].pv);
      writeln(saveF,pcGkm[j].pvMax);
      writeln(saveF,pcGkm[j].atk);
      writeln(saveF,pcGkm[j].def);
      writeln(saveF,pcGkm[j].spd);
      writeln(saveF,pcGkm[j].xpGive);
      writeln(saveF,pcGkm[j].xpHave);
      writeln(saveF,pcGkm[j].xpToNxt);
    end;

    //SAUVER BOOLEENS DRESSEURVAINCU
    writeln(saveF,vaincu.guillaume);
    writeln(saveF,vaincu.joelle);
    writeln(saveF,vaincu.benjamin);
    writeln(saveF,vaincu.marc);
    writeln(saveF,vaincu.michael);
    writeln(saveF,vaincu.serrure);
    writeln(saveF,vaincu.cassoulet);
    writeln(saveF,vaincu.parzani);


    //SAUVER DONNEES BOOLEENS DE QUETES
    writeln(saveF,quete.q01a);
    writeln(saveF,quete.q01b);
    writeln(saveF,quete.q02);
    writeln(saveF, quete.q03);
    writeln(saveF, quete.q04);
    writeln(saveF, quete.q05);
    writeln(saveF, quete.q06);
    writeln(saveF, quete.q07);
    writeln(saveF, quete.evt1);
    writeln(saveF, quete.evt2);

    close(saveF);
  end;

  procedure load();
  var
  i,j : Integer;
  q01a, q01b, q02, q03, q04, q05, q06, q07, evt1, evt2 : String;
  guillaume, joelle, benjamin, marc, michael, serrure, cassoulet, parzani : String;
  begin
    effacerEcran;

    assign(saveF, 'save\save');
    reset(saveF);

    //CHARGER POSITION JOUEUR
    readln(saveF, positionS);

    //CHARGER DONNEES JOUEUR
    readln(saveF, infoJoueur.nom);
    readln(saveF, infoJoueur.argent);
    readln(saveF, infoJoueur.nbPotion);
    readln(saveF, infoJoueur.nbGeekeball);
    readln(saveF, dernGkmUtilise);

    //CHARGER DONNEES JOUEUR GKMs
    for i := low(joueurGkm) to high(joueurGkm) do
    begin
      readln(saveF,joueurGkm[i].id);
      readln(saveF,joueurGkm[i].lvl);
      readln(saveF,joueurGkm[i].nom);
      readln(saveF,joueurGkm[i].pv);
      readln(saveF,joueurGkm[i].pvMax);
      readln(saveF,joueurGkm[i].atk);
      readln(saveF,joueurGkm[i].def);
      readln(saveF,joueurGkm[i].spd);
      readln(saveF,joueurGkm[i].xpGive);
      readln(saveF,joueurGkm[i].xpHave);
      readln(saveF,joueurGkm[i].xpToNxt);
    end;


    //CHARGER DONNEES PC GKMs
    readln(saveF,pcGkmCase); //charger longueur tableau dynamique
    setLength(pcGkm,pcGkmCase); //allouer cet espace au tableau
    for j := 1 to high(pcGkm) do
    begin
      readln(saveF,pcGkm[j].id);
      readln(saveF,pcGkm[j].lvl);
      readln(saveF,pcGkm[j].nom);
      readln(saveF,pcGkm[j].pv);
      readln(saveF,pcGkm[j].pvMax);
      readln(saveF,pcGkm[j].atk);
      readln(saveF,pcGkm[j].def);
      readln(saveF,pcGkm[j].spd);
      readln(saveF,pcGkm[j].xpGive);
      readln(saveF,pcGkm[j].xpHave);
      readln(saveF,pcGkm[j].xpToNxt);
    end;

    //CHARGER BOOLEENS DRESSEURVAINCU
    readln(saveF,guillaume);
    readln(saveF,joelle);
    readln(saveF,benjamin);
    readln(saveF,marc);
    readln(saveF,michael);
    readln(saveF,serrure);
    readln(saveF,cassoulet);
    readln(saveF,parzani);

    //CHARGER BOOLEENS DE QUETES
    readln(saveF,q01a);
    readln(saveF,q01b);
    readln(saveF,q02);
    readln(saveF,q03);
    readln(saveF,q04);
    readln(saveF,q05);
    readln(saveF,q06);
    readln(saveF,q07);
    readln(saveF,evt1);
    readln(saveF,evt2);

    close(saveF);

    //AFFECTATION VALEUR AUX BOOLEENS DRESSEURS VAINCU
    if (guillaume = 'TRUE') then vaincu.guillaume := true
    else vaincu.guillaume := false;
    if (joelle = 'TRUE') then vaincu.joelle := true
    else vaincu.joelle := false;
    if (benjamin = 'TRUE') then vaincu.benjamin := true
    else vaincu.benjamin := false;
    if (marc = 'TRUE') then vaincu.marc := true
    else vaincu.marc:= false;
    if (michael = 'TRUE') then vaincu.michael := true
    else vaincu.michael := false;
    if (serrure = 'TRUE') then vaincu.serrure := true
    else vaincu.serrure := false;
    if (cassoulet = 'TRUE') then vaincu.cassoulet := true
    else vaincu.cassoulet := false;
    if (parzani = 'TRUE') then vaincu.parzani := true
    else vaincu.parzani := false;

    //AFFECTATION VALEUR AUX BOOLEENS DE QUETES
    if (q01a = 'TRUE') then quete.q01a := true
    else quete.q01a := false;
    if (q01b = 'TRUE') then quete.q01b := true
    else quete.q01b := false;
    if (q02 = 'TRUE') then quete.q02 := true
    else quete.q02 := false;
    if (q03 = 'TRUE') then quete.q03 := true
    else quete.q03 := false;
    if (q04 = 'TRUE') then quete.q04 := true
    else quete.q04 := false;
    if (q05 = 'TRUE') then quete.q05 := true
    else quete.q05 := false;
    if (q06 = 'TRUE') then quete.q06 := true
    else quete.q06 := false;
    if (q07 = 'TRUE') then quete.q07 := true
    else quete.q07 := false;
    if (evt1 = 'TRUE') then quete.evt1 := true
    else quete.evt1 := false;
    if (evt2 = 'TRUE') then quete.evt2 := true
    else quete.evt2 := false;

    //ENVOYER JOUEUR A SA DERNIERE POSITION:
    if positionS = 'couloir' then position := Pcouloir
    else if positionS = 'secretariat' then position := Psecretariat
    else if positionS = 'cafeteria' then position := Pcafeteria
    else if positionS = 'infirmerie' then position := Pinfirmerie
    else if positionS = 'etddg' then position := Petddg;

    setPosition(position);
    couloir();
    readln;
  end;



  //FONCTIONS GET
  function getInfoGkm() : TabInfoGkm;
  begin
    getInfoGkm := infoGkm;
  end;

  function getJoueurGkm() : TabJoueurGkm;
  begin
    getJoueurGkm := JoueurGkm;
  end;

  function getInfoJoueur() : Joueur;
  begin
    getInfoJoueur := infoJoueur;
  end;

  function getPcGkm() : TabPcGkm;
  begin
    getPcGkm := pcGkm;
  end;

  function getNomRival() : String;
  begin
    getNomRival := nomRival;
  end;

  function getQuete() : TQuete;
  begin
    getQuete := quete;
  end;

  function getSucces() : TSucces;
  begin
    getSucces := succes;
  end;

  function getVaincu() : TVaincu;
  begin
    getVaincu := vaincu;
  end;

  //PROCEDURES SET
  procedure setInfoJoueur(infoJoueurP : Joueur);
  begin
    infoJoueur := infoJoueurP;
  end;

  procedure setJoueurGkm (joueurGkmP : TabJoueurGkm);
  begin
    joueurGkm := joueurGkmP;
  end;

  procedure setNomRival(nomRivalP : String);
  begin
    nomRival := nomRivalP;
  end;

  procedure setQuete(queteP : TQuete);
  begin
    quete := queteP;
  end;

  procedure setSucces(succesP : TSucces);
  begin
    succes := succesP;
  end;

  procedure setVaincu(vaincuP : TVaincu);
  begin
    vaincu := vaincuP;
  end;

end.
