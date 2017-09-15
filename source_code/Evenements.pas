unit Evenements;

interface
  uses
    BDD,
    Actions,
    Salles,
    Menus,
    GestionEcran;

  procedure combatTuto();
  function combatRival() : Boolean;
  procedure prelude();
  procedure quete1();
  procedure quete2();
  procedure quete4();
  procedure quete5();
  procedure quete6();
  procedure evenement1();
  procedure evenement2();
  procedure choixStarter();


implementation
  uses
    Combat,
    Dresseurs;

  var
    infoGkm : TabInfoGkm;
    infoJoueur : Joueur;
    joueurGkm : TabJoueurGkm;
    nomRival : String;
    //VARIABLES DE QUETES
    quete : TQuete;

  procedure combatTuto();
  var
    indGkm : Integer;  //indice du GKM sauvage
    lvl : Integer; //niveau du GKM sauvage
    pvS, pvMaxS, pvJ, pvMaxJ : Integer;   //pv/pvMax du GKM sauvage (S) et du joueur (J)
    choix : Integer;
    sortie : Boolean;
  begin
    //INITIALISATION
    //récupérer données BDD
    infoGkm := getInfoGkm();

    effacerEcran;
    sortie := false;
    indGkm := 14;
    lvl := 2;
    pvMaxS := infoGkm[lvl][indGkm].pvMax;
    pvS := pvMaxS;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS,0,false);

    //ENVOI GKM
    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Ok, fiston, prépare toi pour ton premier combat de GKMs !');
    readlnE;
    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Commence par envoyer Guybrush Threepwood sur le terrain.');
    readlnE;

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS,pvJ,true);
    writeln;
    joueurGkm[0] := infoGkm[1][17];
    setJoueurGkm(joueurGkm);
    pvMaxJ := joueurGkm[0].pvMax;
    pvJ := pvMaxJ;
    writeln('Guybrush, en avant !');
    readlnE;
    enteteCombat(lvl,indGkm,0,pvS,pvJ,true);

    //ATTAQUER
    dessinerCadreXY(4,15,83,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Très bien ! Guy'' ne devrait faire qu''une bouchée de ce Chandler Bing.');
    readlnE;
    dessinerCadreXY(4,15,83,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Demande à Guybrush d''attaquer !');
    readlnE;

    while not(sortie) do
    begin
      effacerEcran;
      enteteMenu(false,true,true);
      enteteCombat(lvl,indGkm,0,pvS,pvJ,true);

      writeln;
      writeln;
      writeln('Que souhaitez-vous faire ?');
      writeln('1. Attaquer');
      readln(choix);

      if choix <> 1 then
      begin
        dessinerCadreXY(4,15,80,18,simple,15,0);
        deplacerCurseurXY(5,16);
        write('PAPA: Non, attaque-le, fiston !');
        readlnE;
      end
      else sortie := true;
    end;

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS,pvJ,true);
    writeln;
    writeln('Guybrush Threepwood attaque de toutes ses forces !');
    readlnE;
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ,true);
    writeln;
    writeln('Il inflige 12 points de dégat !');
    readlnE;

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvMaxJ,true);
    writeln;
    writeln('Chandler Bing sauvage attaque !');
    readlnE;
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-30,true);
    writeln;
    writeln('Coup critique !');
    readlnE;
    writeln('Guybrush Threepwood subit 30 points de dégats !');
    readlnE;

    //SE DEFENDRE
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-30,true);
    writeln;

    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Aîe, ce GKM est féroce !');
    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Le prochain coup risque d''être fatal si tu ne te défends pas !');
    readlnE;
    sortie := false;

    while not(sortie) do
    begin
      effacerEcran;
      enteteMenu(false,true,true);
      enteteCombat(lvl,indGkm,0,pvS-12,pvJ-30,true);

      writeln;
      writeln;
      writeln('Que souhaitez-vous faire ?');
      writeln('1. Attaquer      2. Se défendre');
      readln(choix);

      if choix <> 2 then
      begin
        dessinerCadreXY(4,15,80,18,simple,15,0);
        deplacerCurseurXY(5,16);
        write('PAPA: Non, défends toi, fiston !');
        readlnE;
      end
      else sortie := true;
    end;

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-30,true);
    writeln;
    writeln('Guybrush Threepwood se défends !');
    readlnE;

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-30,true);
    writeln;
    writeln('Chandler Bing sauvage attaque !');
    readlnE;
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-32,true);
    writeln('Guybrush Threepwood subit 2 points de dégats !');
    readlnE;

    //UTILISER POTION
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-32,true);
    writeln;

    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Ce n''est pas passé loin !');
    readlnE;
    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Il faut que tu soignes Guy'' à présent. Prends cette potion !');
    readlnE;
    infoJoueur.nbPotion := infoJoueur.nbPotion + 1;
    setInfoJoueur(infoJoueur);
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-32,true);
    writeln('Vous obtenez une potion !');
    readlnE;
    sortie := false;

    while not(sortie) do
    begin
      effacerEcran;
      enteteMenu(false,true,true);
      enteteCombat(lvl,indGkm,0,pvS-12,pvJ-32,true);

      writeln;
      writeln;
      writeln('Que souhaitez-vous faire ?');
      writeln('1. Attaquer      2. Se défendre      3. Utiliser potion');
      readln(choix);

      if choix <> 3 then
      begin
        dessinerCadreXY(4,15,80,18,simple,15,0);
        deplacerCurseurXY(5,16);
        write('PAPA: Non, il faut que tu soignes Guy'', fiston !');
        readlnE;
      end
      else sortie := true;
    end;

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-32,true);
    writeln;
    writeln('Vous utilisez une potion sur Guybrush Threepwood.');
    readlnE;
    infoJoueur.nbPotion := infoJoueur.nbPotion-1;
    setInfoJoueur(infoJoueur);

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ,true);
    writeln;
    writeln('Il récupère 50 PVs !');
    readlnE;

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ,true);
    writeln;
    writeln('Chandler Bing sauvage attaque !');
    readlnE;
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-8,true);
    writeln('Guybrush Threepwood subit 8 points de dégats !');
    readlnE;

    //ATTRAPER
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-8,true);
    writeln;

    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Très bien, fiston, il est temps d''en finir !');
    readlnE;
    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Attrape ce satané GKM ! Prends cette GKB !');
    readlnE;
    infoJoueur.nbGeekeball := infoJoueur.nbGeekeball + 1;
    setInfoJoueur(infoJoueur);
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-8,true);
    writeln('Vous obtenez une GKB !');
    readlnE;
    sortie := false;

    while not(sortie) do
    begin
      effacerEcran;
      enteteMenu(false,true,true);
      enteteCombat(lvl,indGkm,0,pvS-12,pvJ-8,true);

      writeln;
      writeln;
      writeln('Que souhaitez-vous faire ?');
      writeln('1. Attaquer      2. Se défendre      3. Utiliser potion      4. Lancer GKB');
      readln(choix);

      if choix <> 4 then
      begin
        dessinerCadreXY(4,15,80,18,simple,15,0);
        deplacerCurseurXY(5,16);
        write('PAPA: Attrape ce GKM, fiston !');
        readlnE;
      end
      else sortie := true;
    end;

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-8,true);
    writeln;
    writeln('Vous lancez une GKB en direction de Chandler Bing !');
    readlnE;
    attendre(500);
    writeln('...');
    writeln;
    attendre(1000);
    writeln('...');
    writeln;
    attendre(1000);
    writeln('...');
    writeln;
    attendre(1000);
    writeln('*clic*');
    readlnE;
    writeln('Félicitation, vous avez attrapé Chandler Bing sauvage !');
    infoJoueur.nbGeekeball := infoJoueur.nbGeekeball -1;
    setInfoJoueur(infoJoueur);
    readlnE;
    dessinerCadreXY(4,22,84,25,simple,15,0);
    deplacerCurseurXY(5,23);
    write('PAPA: Bravo, mon fils ! Tu es officiellement un dresseur de GKMs à présent !');
    readlnE;
    joueurGkm[0] := infoGkm[1][0];
    setJoueurGkm(joueurGkm);
  end;

   //SAISIE DU NOM DU RIVAL
  procedure saisirNomRival();
  var
    sortie : Boolean;
    choix : Integer;
  begin
    sortie := false;
    while not(sortie) do
    begin
      write('Nom du rival : ');
      readln(nomRival);
      writeln('Est-ce bien ', nomRival, ' ?');
      writeln;
      writeln(' 1. Oui      2. Non');
      readln(choix);
      if (choix = 1)
      then sortie := true
      else if (choix <> 1) and (choix <> 2)
      then writeln('MAUVAISE SAISIE');
    end;
  end;

  procedure enteteCombatRival(pvMaxRival, pvRival, pvMaxJoueur, pvJoueur : Integer);
  var
    ecrirePos : coordonnees;
  begin
    ecrirePos.x := 6;
    ecrirePos.y := 2;
    dessinerCadreXY(4,1,28,5,simple,15,0);
    dessinerCadreXY(23,4,47,8,simple,15,0);
    ecrireEnPosition(ecrirePos, nomRival);
    ecrirePos.y := ecrirePos.y + 1;
    deplacerCurseur(ecrirePos);
    writeln('lvl. 1');
    ecrirePos.y := ecrirePos.y + 1;
    deplacerCurseur(ecrirePos);
    writeln(' ', pvRival,'/',pvMaxRival);
    ecrirePos.x := 25;
    ecrirePos.y := 5;
    ecrireEnPosition(ecrirePos, '???');
    ecrirePos.y := ecrirePos.y + 1;
    deplacerCurseur(ecrirePos);
    writeln('lvl. 1');
    ecrirePos.y := ecrirePos.y + 1;
    deplacerCurseur(ecrirePos);
    writeln(' ', pvJoueur,'/',pvMaxJoueur);
    writeln;
    writeln;
  end;

  function combatRival() : Boolean;
  var
    pvMaxRival, pvRival, pvMaxJoueur, pvJoueur : Integer;
    initiative : Boolean;
    finCombat : Boolean;
    choix : Integer;
    pDDeg : Integer;
  begin
    randomize;
    finCombat := false;
    pvMaxRival := 7;
    pvRival := pvMaxRival;
    pvMaxJoueur := 10;
    pvJoueur := pvMaxJoueur;
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombatRival(pvMaxRival,pvRival,pvMaxJoueur,pvJoueur);
    writeln;
    writeln('C''est le moment de donner une bonne raclée à ', nomRival, ' !');
    readlnE;

    repeat      //fin combat
      initiative := true;

        repeat      //fin round
          effacerEcran;
          enteteMenu(false, true, true);
          enteteCombatRival(pvMaxRival,pvRival,pvMaxJoueur,pvJoueur);

          if initiative = true then         //tour du joueur
          begin
            writeln('Que souhaitez-vous faire ?');
            writeln('1. Attaquer');
            readln(choix);

            if choix = 1 then  //ATTAQUER
            begin
              writeln('Vous décrochez un coup de point dans la mâchoire de ',nomRival, ' !');
              readlnE;
              pDDeg := random(3)+1; //calcul pdd
              pvRival := pvRival - pDDeg;
              writeln;
              writeln('Vous lui infligez ', pDDeg, ' points de dégats ! Prends ça !');
              if pvRival < 0
              then pvRival := 0;

              initiative := false;
            end
            else writeln('MAUVAISE SAISIE');

            readlnE;
            effacerEcran();
          end

          else            //tour de l'adversaire
          begin
            writeln(nomRival, ' vous donne un coup !');
            readlnE;

            pDDeg := random(3)+1;

            pvJoueur := pvJoueur - pDDeg;
            writeln('Vous subissez ', pDDeg, ' points de dégats ! Ouch !');
              if pvJoueur < 0 then
                pvJoueur := 0;

            readlnE;
            initiative := true;
          end;
        until (pvRival = 0) OR (pvJoueur = 0);

        enteteMenu(false,false,false);

        if pvRival = 0 then   //VICTOIRE
        begin
          writeln(nomRival, ' met un genou à terre !');
          readlnE;
          writeln('Vous avez vaincu ', nomRival, ' ! Youpi !');
          readlnE;
          finCombat := true;
          combatRival := true;
        end

        else if pvJoueur = 0 then             //DEFAITE
        begin
          writeln('Vous avez été vaincu par ', nomRival, '...');
          writeln;
          readlnE;
          combatRival := false;
        end
    until finCombat = true;
  end;

  procedure introduction();
  var
    choix : Integer;
    sortieBoucle : Boolean; //permet de sortir des boucles de vérification de saisie correcte
  begin
    infoJoueur := getInfoJoueur();
    quete := getQuete();

    choix := 0;
    sortieBoucle := false;
    effacerEcran;
    setNomSalle('S E C R E T A R I A T');
    enteteMenu(false,false,true);

    writeln('Vous poussez la porte du secrétariat.');
    writeln('La pièce ressemble exactement à ce que l''on attendrait d''un secrétariat, et la petite dame derrière le bureau ressemble exactement à ce que l''on imagine d''une secrétaire.');
    writeln;
    writeln('"Bonjour, je peux vous aider ?"');
    readlnE;
    writeln('"Oh, vous êtes un nouvel étudiant, c''est ça ?"');
    readlnE;
    writeln('La petite dame se penche dans un tiroir. Quelques instants plus tard, elle vous tend un formulaire en souriant.');
    writeln;
    writeln('"Il faut que vous me le remplissiez."');
    readlnE;
    while sortieBoucle = false do
    begin
      write('Sur le formulaire, on vous demande votre ');
      couleurTexte(11);
      write('nom: ');
      couleurTexte(15);
      readln(infoJoueur.nom);
      if infoJoueur.nom <> '' then
        sortieBoucle := true;
    end;
    sortieBoucle := false;
    writeln('Vous rendez finalement le document à la secrétaire.');
    readlnE;
    writeln('"Vous vous appelez ', infoJoueur.nom, ', c''est bien ça?"');
    writeln;
    while (choix <> 1) AND (choix <> 2) do
    begin
      writeln('1. Oui, c''est exact.');
      writeln('2. Oh, désolé, j''ai dû commettre une erreur...');
      readln(choix);
      if choix = 2 then
      begin
        while choix = 2 do
        begin
          while sortieBoucle = false do
          begin
            write('Vous récupérez le document et corrigez votre ');
            couleurTexte(11);
            write('nom: ');
            couleurTexte(15);
            readln(infoJoueur.nom);
            if infoJoueur.nom <> '' then
              sortieBoucle := true;
          end;
          sortieBoucle := false;
          writeln;
          writeln('"Ne vous inquiétez pas. Vous êtes donc ', infoJoueur.nom, ' ?"');
          writeln;
          writeln('1. Pas d''erreur cette fois-çi !');
          writeln('2. Je suis vraiment confus...');
          readln(choix);
          if (choix <> 1) AND (choix <> 2) then
          begin
            writeln('"Pardon... Je ne comprends pas."');
            writeln;
            choix := 2;
          end;
        end;
      end
      else if (choix <> 1) AND (choix <> 2) then
      begin
        writeln('"Pardon... Je ne comprends pas."');
        writeln;
      end;

    end;
    writeln('La secrétaire examine une dernière fois le forumulaire et vous sourit à nouveau.');
    writeln;
    writeln('"Je pense que tout est en ordre."');
    writeln('"Enchantée, ', infoJoueur.nom, ', je suis Thérèse, la secrétaire du département DDG de cet établissement."');
    readlnE;
    writeln('"Comme tu le sais sans doute, le département Dressage De Geekémons t''offre ton tout premier Geekémon !"');
    readlnE;
    writeln('"Mais ce n''est pas moi qui m''occupe de ça. Dirige-toi vers l''ETDDG, dans le couloir juste à coté..."');
    readlnE;
    writeln('"Choisis bien, ou tu ne seras ni le premier, ni le dernier à me demander si tu peux changer de geekémon..."');
    readlnE;
    writeln('"...Mais ce ne sera pas possible !"');
    readlnE;
    writeln('"Ne t''inquiète pas, tu pourras en attraper plein d''autres. Mais n''oublie pas que ton premier Geekémon est unique."');
    readlnE;
    writeln('"Bonne chance alors ! Et bienvenue dans le monde du dressage de geekémons !"');
    readlnE;
    effacerEcran;

    writeln('A peine êtes-vous sorti du secrétariat qu''un jeune garçon, plus loin dans le couloir, vous fait de grands signes.');
    writeln;
    writeln('"Eh, toi, par ici!"');
    readlnE;
    writeln('"J''te connais pas, t''es nouveaux non ?"');
    writeln('"Je suis membre de l''ETDDG, et mon petit doigt me dis que t''as pas encore de geekémon."');
    readlnE;
    writeln('"Suis-moi, l''ETDDG, c''est par là."');
    readlnE;
    writeln('Le garçon vous guide vers une salle que vous n''auriez pas manquée même sans sons aide : une énorme pancarte ''ETDDG'' figure accrochée à la porte.');
    writeln;
    writeln('"Moi, c''est Michaël. Je suis un dresseur de Geekémons."');
    writeln('"Et je suis assez balèze d''alleurs ! Viens faire un tour à la cafèt'' si tu veux te mesurer à moi."');
    readlnE;
    writeln('"Mais en attendant..."');
    readlnE;
    effacerEcran;
    writeln('Vous pénétrez dans la salle de l''ETDDG. La pièce semble confortable, malgré les innombrables déchets qui ornent le sol ainsi que l''odeur de transpiration.');
    writeln('Il ne fait aucun doute, cette pièce est véritablement habitée par des dresseurs de Geekémons.');
    writeln;
    writeln('"... On va te trouver ton premier Geekémon !"');
    readlnE;
    effacerEcran;
    writeln('"Laisse-moi t''expliquer en quelques mots ce dans quoi tu t''embarques, gamin."');
    readlnE;
    writeln('"En décidant d''intégrer le département DDG de cette école, tu es entré dans un monde vraiment fantastique... mais');
    writeln('également très dangereux."');
    readlnE;
    writeln('"Les différentes salles de cet établissement sont infestées de Geekémons sauvages."');
    writeln('"La direction et l''ETDDG essaient de se débarrasser d''eux, mais ils semblent toujours revenir d''on ne sait où."');
    writeln('"Dans quelques instants, tu pourras choisir ton premier Geekémon. Voici aussi quelques potions et crédits pour bien');
    writeln('commencer l''année."');
    readlnE;
    setInfoJoueur(infoJoueur);
    ajoutPotion(5);
    infoJoueur := getInfoJoueur();
    readlnE;
    infoJoueur.argent := 0;
    writeln('Vous obtenez 100 Bitcoins !');
    infoJoueur.argent := infoJoueur.argent + 100;
    setInfoJoueur(infoJoueur);
    readlnE;
    writeln('"Le grand moment est arrivé, gamin ! Tu vas enfin choisir ton premier Geekémon !"');
    readlnE;
    writeln('Michael sort un trousseau de clés de sa poche, et ouvre un petit placard qui se situe dans un angle de la pièce.');
    writeln('Il sort une petite boîte métallique fermée par un cadenas dont il compose le code.');
    writeln;
    writeln('La boite s''ouvre.');
    readlnE;
    choixStarter();
    joueurGkm := getJoueurGkm();
    writeln('Michaël semble approuver votre choix.');
    writeln;
    writeln('"',joueurGkm[0].nom, ', hein ?"');
    readlnE;
    writeln('"C''est un très bon choix. T''as du potentiel, gamin."');
    readlnE;
    writeln('"Bon, il est temps pour moi de te laisser. Tu peux te promener dans le bâtiment, même s''il n''y a pas grand chose à y');
    writeln('faire à cette heure de la journée."');
    readlnE;
    writeln('"Reviens ici pour te reposer, acheter des potions ou des Geekéballs. Tu peux aussi explorer les salles alentours, mais');
    writeln('attention aux Geekémons sauvages !"');
    readlnE;
    writeln('"Et surtout, viens faire un tour à la cafèt'' pour te mesurer à moi, et à bien d''autres ! On t''attends de pied ferme."');
    readlnE;
    writeln('Michaël vous donne une grande tape amicale dans le dos alors qu''il quitte la pièce.');
    readlnE;
    writeln('Vous vous dirigez vers la porte qui mène au couloir. Vous vous demandez où vous pourriez bien aller à présent.');
    readlnE;
    etatQuete(quete.q01a); //false->true
    setQuete(quete);
    couloir();
  end;

  procedure prelude();
  var
    choix1, choix2, choix3, choix4, choix5,choix51, choix52, choix6,choix61,choix62, choix7,choix8,choix9,choix10,choix11 : Integer;
    sortie1, sortie2, sortie3, sortie4, sortie5,sortie51,sortie52, sortie6,sortie61,sortie62, sortie7,sortie8,sortie9,sortie10 : Boolean;
    leveTard : Boolean;
  begin
    //INITIALISATION DE CERTAINES VARIABLES BOOLEENES DU JEU
    initPcGkmCase();
    initPosition();
    initSucces();
    initVaincu();
    initQuetes();
    remplirJoueurGkm();
    remplirInfoJoueur();

    effacerEcran;
    infoGkm := getInfoGkm();
    quete := getQuete();
    leveTard := false;
    sortie1 := false;
    sortie2 := false;
    sortie3 := false;
    sortie4 := false;
    sortie5 := false;
    sortie51 := false;
    sortie52 := false;
    sortie6 := false;
    sortie7 := false;
    sortie8 := false;
    sortie9 := false;
    sortie10 := false;


    setNomSalle('C H A M B R E');
    enteteMenu(false,false,true);
    writeln('Le coq de monsieur Tourvier vous réveille en sursaut. Vous maudissez l’animal avant de plonger votre visage dans l’oreiller.');
    writeln('Vous avez sommeil, mais l’abondance de lumière qui passe par votre fenêtre vous indique qu’il serait peut-être temps de vous lever…');
    while not(sortie1) do
    begin
      writeln(' 1.  Fermer les yeux, juste quelques secondes de plus...');
      writeln(' 2.  Se lever');
      readln(choix1);
      if choix1 = 1 then
      begin
        writeln('Quand vous rouvrez les yeux, vous êtes en pleine forme ! Vous jetez un coup d’œil à votre radio réveil. Il est presque midi ! Heureusement qu’il n’y a pas école aujourd’hui…');
        sortie1 := true;
        leveTard := true;
      end
      else if choix1 = 2 then
      begin
        writeln('Malgré qu’il n’y a pas école aujourd’hui et qu’il soit encore relativement tôt, vous décidez de vous lever. Après tout, le monde appartient à ceux qui se lèvent tôt, parait-il…');
        sortie1 := true;
      end
      else writeln('MAUVAISE SAISIE');
    end;
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Vous mettez les jambes hors du lit et vous levez d’un bond. Vous scrutez la chambre et remarquez qu’elle est en désordre, maman risque de ne pas être contente, elle vous avait demandé de ranger hier soir');
    while not(sortie2) do
    begin
      writeln(' 1.  Ranger la chambre ');
      writeln(' 2.  Jouer à la N64 ');
      writeln(' 3.  Descendre directement ');

      readln(choix2);
      case choix2 of
        1:
        begin
          writeln('Vous prenez votre courage à deux mains et commencez à ranger mais finalement, vous glissez le plus gros du désordre sous votre lit. Toute cette peine de bon matin vous a grandement ouvert l’appétit, vous décidez de rejoindre maman dans la cuisine.');
          sortie2 := true;
        end;
        2:
        begin
          writeln('Oh, vous pouvez bien faire une petite partie avant descendre, non ? Vous allumez la console et lancez Banjo Kazoïe.');
          writeln('Après quelques minutes, vous vous rappelez pourquoi vous vous étiez couchés si tard la veille : impossible de passer ce niveau ! Vous décidez que vous réessaieraient plus tard, il est l’heure d’aller prendre votre petit déjeuner !');
          writeln('Vous rejoignez maman dans la cuisine.');
          sortie2 := true;
        end;
        3:
        begin
          writeln('Vous avez trop faim pour vous soucier de ranger votre chambre ou même de jouer à la console, vous décidez d’aller rejoindre maman dans la cuisine.');
          sortie2 := true;
        end;
        else writeln('MAUVAISE SAISIE');
      end;
    end;
    readlnE;
    effacerEcran;
    setNomSalle('C U I S I N E');
    enteteMenu(false,false,true);
    write('« Bonjour, mon chéri !');
      if leveTard
      then write(' Eh bien, il était temps que tu te lèves !');
    writeln('»');
    readlnE;
    writeln('Maman vous sourit et vous embrasse sur le front. Maman est vraiment une femme adorable. Vous aimeriez tant que papa le soit autant. Il n’est pas méchant, mais il travaille beaucoup.');
    writeln('Et quand il est à la maison, vous avez l’impression qu’il est trop fatigué pour vous porter de l’attention…');
    readlnE;
    writeln('« Prends-ton assiette, mange quelque chose ! »');
    readlnE;
    writeln('Vous vous demandez pourquoi maman est si pressante.');
    readlnE;
    writeln('« J’ai quelque chose à te dire. Ton père ne travaille pas aujourd’hui. »');
    readlnE;
    writeln('On a beau être dimanche, papa travaille souvent le dimanche.');
    readlnE;
    while not(sortie3) do
    begin
      writeln(' 1.  Mais alors, pourquoi il n’est pas à la maison ?');
      writeln(' 2.  Je m’en fiche… ');
      readln(choix3);
      case choix3 of
        1:
        begin
          writeln('« Parce qu’il a une surprise pour toi. Ton père t’aime beaucoup, tu sais. Il n’est juste pas très doué pour te le montrer. Je pense que tu vas être content. Il m’a demandé de te dire de le rejoindre au lac, à l’autre bout du village. »');
          sortie3 := true;
        end;
        2:
        begin
          writeln('« Oh, mon chéri. Je peux comprendre que tu sois en colère. Mais ton père t’aime sincèrement, tu sais. Il n’est juste pas très doué pour te le montrer. Et c’est ce qu’il va essayer de faire aujourd’hui, je pense, puisqu’il a une surprise pour toi !');
          writeln('Il m’a demandé de te dire de le rejoindre au lac, à l’autre bout du village. »');
          sortie3 := true;
        end;
        else writeln('MAUVAISE SAISIE');
      end;
    end;
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('« Alors avale ton petit-déjeuner et oust ! Va le rejoindre ! »');
    readlnE;
    writeln('Après avoir fini votre assiette, vous regardez autour de vous. Maman dit toujours que papa travaille beaucoup, mais que c’est grâce à ça qu’on a une si jolie maison. Et il est vrai qu’elle est jolie, votre maison.');
    writeln('Mais vous préfèreriez vivre dans une petite maison comme Sophie, la voisine, qui a pour habitude d’aller pêcher avec son père les dimanches ensoleillés comme aujourd’hui.');
    readlnE;
    writeln('Maman est sortie, elle discute avec la mère de Sophie. Papa peut bien attendre quelques minutes de plus…');
    writeln('Que voulez-vous faire ?');
    while not(sortie4) do
    begin
      writeln(' 1.  Regarder la télévision');
      writeln(' 2.  Remonter dans votre chambre');
      writeln(' 3.  Faire coucou à maman');
      writeln(' 4.  Sortir');
      readln(choix4);
      case choix4 of
        1:
        begin
          writeln('Vous vous installez dans votre canapé et regardez les dessins animés. Que serait une matinée sans école sans dessins animés ?');
        end;
        2:
        begin
          writeln('Vous vous apprêtez à remonter dans votre chambre, bien décidé à finir ce niveau sur Banjo Kazoie qui vous énerve tant. Mais papa vous attends au lac… Peut-être n’est-ce pas une bonne idée, finalement');
        end;
        3:
        begin
          writeln('Vous tapez à la fenêtre pour attirer l’attention de maman, qui discute toujours avec la mère de Sophie. Quand elle vous remarque enfin, elle vous fait un grand signe. Vous lui souriez.');
        end;
        4:
        begin
          writeln('Vous enfilez votre casquette Geekémon, vos chaussures de courses (celles qui font courir vite !) et sortez de la maison.');   //CONTINUER ICI
          sortie4 := true;
        end;
        else writeln('MAUVAISE SAISIE');
      end;
    end;
    readlnE;
    setNomSalle('V I L L A G E');
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('A quelques pas de chez vous, sur le chemin qui mène au lac, vous apercevez le vieux fermier, monsieur Tourvier, qui fume sa pipe en regardant le ciel.');
    writeln('Plus loin un peu plus loin se trouve madame Tourvier (que tout le monde appelle vieille Madeleine, vous n’avez jamais compris pourquoi), en train de courir après des poules qui semblent s’être échappées de leur enclos.');
    readlnE;

    while not (sortie5) do
    begin
      writeln(' 1.  Bonjour, monsieur Tourvier ! ');
      writeln(' 2.  Comment allez-vous, vieille Madeleine ?');
      writeln(' 3.  Se diriger vers le lac');
      readln(choix5);

      case (choix5) of
        1:
        begin
          writeln('Monsieur Tourvier met quelques secondes à sortir de l’état rêveur dans lequel il se trouvait avant de vous remarquer.');
          readlnE;
          writeln('« Eh, salut, gamin. Qu’est-ce qui t’amène ? »');

          while not(sortie51) do
          begin
            writeln(' 1. Je rejoins mon père au lac ');
            writeln(' 2. Je me promène simplement, monsieur');
            readln(choix51);

            case (choix51) of
              1:
              begin
                effacerEcran;
                enteteMenu(false,false,true);
                writeln('« Vraiment ? Brave homme, que ton père. Je l’ai connu tout gamin comme toi, tu sais. A l’époque, il voulait devenir dresseur de GKMs. Ah, ce rêve ! Tous les gamins ne parlaient que de ça.');
                writeln('Mais ce n’est pas ce qui remplit ton assiette ni celle de ta famille, et ton père l’a bien compris. Les choses étaient plus simples quand j’étais jeune, tu sais. C’était une époque où on pouvait devenir dresseur de GKM.');
                writeln(' Tu sais que j’ai été un dresseur reconnu, en mon temps ?');
                writeln('Ecoute, gamin, j’aimerais te raconter le jour où je me suis fait surprendre par un Dale Cooper alors que le seul GKM que j’avais sur moi ne tenait déjà presque plus debout, … »');
                sortie51 := true;
              end;
              2:
              begin
                effacerEcran;
                enteteMenu(false,false,true);
                writeln('Vraiment ? C’est une bonne chose, gamin. Aujourd’hui, les jeunes passent bien trop de temps derrière leurs écrans,');
                writeln('à combattre des GKMs virtuels au lieu de découvrir le monde et VRAIMENT se mesurer à un GKM sauvage !');
                writeln('T''ai-je déjà raconté la fois où je me promenais près d’Ecclesia, la capitale, et où j’ai été surpris par un Blackadder assoiffé de sang … »');
                sortie51 := true;
              end;
              else writeln('MAUVAISE SAISIE');
            end;
          end;

          readlnE;
          effacerEcran;
          enteteMenu(false,false,true);
          writeln('Evidemment, vous connaissez déjà cette histoire, mais la réécouter ne vous dérangeait pas le moins du monde. Vous êtes passionnés de GKMs et tout ce qui se rapporte à ces créatures fascinantes vous émerveille.');
          writeln('Après avoir raconté son histoire, monsieur Tourvier retourne à son occupation favorite : fumer sa pipe en se remémorant ses jeunes jours de dresseur de GKMs.');
          readlnE;
        end;
        2:
        begin
          writeln('La vieille Madeleine vous regarde toute essoufflée. Son regard se pose se votre casquette.');
          writeln('« Drôle de chapeau, petit. »');
          readlnE;
          writeln;

          while not(sortie52) do
          begin
            writeln('1. C’est la même casquette de Masha…  ');
            readln(choix52);
            case (choix52) of
              1:
              begin
                effacerEcran;
                enteteMenu(false,false,true);
                writeln('Vous expliquez à la vieille Madeleine que Masha est votre héros de dessins animés préféré : il est dresseur de GKM et parcourt le monde en compagnie de ses amis.');
                readlnE;
                writeln('« Ah, les GKMs. Drôles de bêtes que ces bêtes-là. Tu sais, petit, quand ma grand-mère était enfant, ça n’existait pas. C’est comme s’ils étaient apparus avec premières télévisions. C’est curieux, non ? »');
                sortie52 := true;
                readlnE;
              end;
              else writeln('MAUVAISE SAISIE');
            end;
          end;
            effacerEcran;
            enteteMenu(false,false,true);
        end;
        3:
        begin
          effacerEcran;
          sortie5 := true;
        end
        else writeln('MAUVAISE SAISIE');
      end;
    end;

    setNomSalle('R O U T E  D U  L A C');
    enteteMenu(false,false,true);
    writeln('Vous continuez votre route vers le lac. Vous vous éloignez du grand chemin et empruntez une petit route terreuse et irrégulière. Au loin, vous apercevez un garçon que vous détestez.');
    writeln('La dernière fois que vous aviez croisé sa route, vous aviez tous les deux finis dans le bureau du maire car vous vous étiez battus. Un comble quand on sait qu’il est le fils du maire.');
    writeln('Evidemment, votre punition a été bien plus sévère que la sienne.');
    readlnE;
    writeln('Quel est son nom, déjà ?');
    saisirNomRival();
    setNomRival(nomRival);

    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Ah, oui, ', nomRival, '. Vous serrez les points alors que vous croisez sa route. Vous remarquez qu’il serre également les siens. Il finit par vous interpeller.');
    writeln('« Eh, crétin, mon père te passe le bonjour. N’hésite pas à passer le voir si tu veux une autre punition. » ');
    readlnE;
    writeln(nomRival, ' ricane bêtement. Vous décidez de l’ignorer.');
    readlnE;
    writeln('« Allez, je rigole ! Je veux bien te prêter mon père, comme ton papounet n’est jamais là ! Mais je ne suis pas persuadé qu’il t’aime plus que le tient ! »');
    readlnE;
    writeln('Il ricane à nouveau, l’air mauvais.');
    readlnE;
    writeln(' 1.  L’ignorer et continuer votre route.');
    writeln(' 2.  Lui rentrer dedans');
    while not(sortie6) do
    begin
      readln(choix6);
      case (choix6) of
        1:
        begin
          writeln('Vous ignorez ', nomRival, ' et vous passez votre chemin');
          sortie6 := true;
          readlnE;
        end;
        2:
        begin
          writeln('Trop, c''est trop ! Vous vous jetez sur ', nomRival, ' !' );
          readlnE;
          if combatRival() then
          begin
            //victoire
            writeln('L’air mauvais mais mal en point,', nomRival, ' vous dit qu’il dira tout à son père et part en disant des mots que vous ne connaissez même pas. ');
            writeln('Vous lui avez donné une bonne leçon ! C’est très content que vous vous dirigez vers le lac.');
            readlnE;
            sortie6 := true;
          end
          else
          begin
            //defaite
            writeln(nomRival, ' vous regarde de haut alors que vous êtes les fesses dans la boue.');
            writeln;
            writeln('« Bien fait pour toi, crétin, ah ! » ');
            readlnE;
            writeln('Il glousse comme un abruti alors qu’il se dirige vers le village. Rouge de honte et de colère, vous décidez de vers diriger vers le lac.');
            readlnE;
            sortie6 := true;
          end;
        end;
        else writeln('MAUVAISE SAISIE');
      end;
    end;
    effacerEcran;
    setNomSalle('L A C');
    enteteMenu(false,false,true);
    writeln('Vous arrivez finalement au lac. Sur l’autre rive, vous apercevez tout de suite Sophie et son père en train de pêcher. Aucune trace de papa. ');
    writeln('Après quelques minutes, déçus, alors que vous vous apprêtez à rebrousser chemin, vous entendez :');
    writeln('« Eh, par ici, fiston ! »');
    readlnE;
    writeln('Vous êtes habituellement en colère contre papa, mais l’entendre vous appeler fiston vous réchauffe le cœur, et c’est le sourire aux lèvres que vous vous dirigez vers lui.');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Vous passez une bonne partie de la journée avec papa. Vous jouez avec lui, il vous apprend à pêcher. Vous passez un peu de temps avec Sophie et son père et vous pêchez ensemble.');
    readlnE;
    writeln('Le père de Sophie est un collègue de papa mais curieusement, ils ne parlent pas de travail. Le père de Sophie semble un peu bizarre et vous ne comprenez pas pourquoi papa se comporte comme ça, mais vous vous en fichez. Vous êtes heureux.');
    readlnE;
    writeln('A la fin de la journée, papa vous annonce qu’il a une surprise.');
    readlnE;
    writeln('« Je pense que tu vas aimer ce que j’ai trouvé, fiston. »');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('C’est en jubilant qu’il plonge sa main dans son sac. C’est bizarre de voir papa comme ça, on dirait un enfant, comme vous.');
    writeln('Il sort une...');
    readlnE;
    writeln('Vous n’en croyez pas vos yeux ! ');
    readlnE;
    writeln('Une Geekéball !');
    readlnE;
    writeln('« Ecoute-moi bien, mon fils. Je m’apprête à te confier un GKM extrêmement rare. Il m’est très précieux, et je veux que tu en prennes soin. Je l’ai avec moi depuis quelques années maintenant, c’est un meilleurs amis, tu sais.');
    writeln('Les gens se moquent de moi quand je leur dis que mon meilleur ami est un GKM, mais je m’en fiche. Il est à toi maintenant. »');
    readlnE;
    writeln('Il ouvre la GKB et le GKM qui en sort ne ressemble à aucun autre. Vous pensiez pourtant tous les connaître !');
    readlnE;
    writeln('Le GKM face à vous arbore une chevelure dorée et un air badaud. Il vous regarde, hagard, puis se retourne et aperçoit pas papa. Son regard s’illumine alors.');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('« Eh, salut, Guy’ ! »');
    readlnE;
    writeln('« Fiston, je te présente Guybrush Threepwood. C’est un GKM un peu spécial, tu vois, il n’en existe aucun comme celui-là. »');
    readlnE;
    writeln('C’est étrange, en effet... Il ne semble pas appartenir au même monde que les autres GKM. ');
    readlnE;
    writeln('« Guy’, je te présent mon fils. C’est lui qui va s’occuper de toi, à partir d’aujourd’hui. Vous allez devenir meilleurs amis, vous aussi, j’en suis persuadé ! »');
    readlnE;
    writeln('Vous êtes incapable d’exprimer votre joie. Papa ne s’occupe jamais de vous, et les cadeaux qu’il vous fait tout le temps ne sont toujours que des jouets bien trop chers pour un petit garçon de votre âge. Mais cette fois,');
    writeln('il vous a offert le meilleur cadeau que vous puissiez imaginer ! ');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Tout à coup, vous entendez un cri depuis l’autre rive du lac. ');
    readlnE;
    writeln('Oh, non !');
    writeln('Sophie et son père semblent avoir été surpris par un GKM sauvage alors qu’ils rangeaient leur matériel et s’apprêtaient à rentrer au village. Accompagné de papa et de Guybrush, vous courez en leur direction ! ');
    readlnE;
    writeln('« Ok, Guy’, c’est le moment de montrer à mon fils de quoi tu es capable ! Fiston, Guybrush est ton GKM, à présent, c’est donc toi qui va aider Marc et Sophie. »');
    readlnE;
    writeln('Face à votre air anxieux, il ajoute : ');
    writeln('« Mais je serais derrière-toi pour te donne un coup de main, ne t’en fais pas ! »');
    readlnE;
    combatTuto;
    effacerEcran;
    setNomSalle('? ? ?');
    enteteMenu(false,false,true);
    writeln('Soulagés, vous rentrez au village. Tous racontent comme vous êtes fièrement battus. Vous vous sentez bien. ');
    readlnE;
    writeln('Vous êtes heureux, ça oui. Vous devenez rapidement amis avec Guybrush.');
    readlnE;
    writeln('Une semaine passe, vous apprenez que papa est malade. ');
    readlnE;
    writeln('Papa passe alors beaucoup de temps chez le docteur et à l’hopital. Personne ne veut vous dire ce qu’il a, mais maman semble inquiète. Vous essayez de ne pas y penser et passez tout votre temps avec Guybrush, votre nouvel ami.');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Un mois plus tard, papa meurt dans la nuit.');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Les années passent. Vous et Guybrush êtes plus proches que jamais. ');
    readlnE;
    setNomSalle('R O U T E  D U  L A C');
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Un jour, alors que vous revenez du lac, Guybrush sur vos pas, vous apercevez trois curieux personnages au bord de la route. Un d’eux s’avance vers vous et vous sourit.');
    readlnE;
    writeln('« Bonjour, mon garçon. »');
    writeln(' 1. Saluer l''homme');
    writeln(' 2. Ignorer l''homme');
    writeln;
    while not (sortie7) do
      begin
        readln(choix7);
        case (choix7) of
          1:
          begin
            writeln('Derrière l’homme qui vous a abordé, un tout petit homme avec un curieux accent prend la parole :');
            sortie7 := true;
          end;
          2:
          begin
            writeln('Derrière l’homme qui vous a abordé, un tout petit homme avec un curieux accent s’avance et vous coupe la route :');
            sortie7 := true;
          end;
          else writeln('MAUVAISE SAISIE');
        end;
      end;

      writeln('« Salut, le jeune. C’est un bien curieux GKM que tu as là ! »');
      readlnE;
      writeln('Le troisième personnage, une dame, réplique alors :');
      writeln('« Tais-toi Jérôme, laisse faire Matthew. »');
      readlnE;
      writeln('Le leader du groupe continue alors :');
      writeln('« Klarine a raison, Jérôme. Tu risques de faire peur au garçon. Et surtout à son... GKM... »');
      readlnE;
      writeln('L’homme s’avance vers vous mais son regard reste posé sur votre ami Guybrush. ');
      writeln('« Je suis Matthew Sermonet et j’enseigne à l’école de dressage de Geekémons de Nojid. Tu vas peut être penser que je suis stupide de dire tout ça juste avant ce que je m’apprête à faire,');
      writeln('mais sache que nous formons la TEAM ALGO et que nous sommes intouchables. Contacte les autorités si ça te chante, il ne nous arrivera rien. »');
      writeln('Durant tout ce temps, son regard est resté fixé sur Guy’...');
      readlnE;
      writeln('« Ton GKM est étrange, mon garçon. Et je le veux, donc je vais le prendre. Je dois l’étudier. Donc tu vas gentiment me le donner sans opposer de résistance et il ne t’arrivera rien. »');
      readlnE;
      writeln('Vous n’en croyez pas vos oreilles. Qui sont ces gens ? De soit-disants professeurs qui oeuvrent dans le crime pendant leur congés ?!');
      readlnE;
      writeln('Il n’est pas question de vous séparer de Guybrush, votre meilleur ami. ');
      readlnE;
      writeln('Alors que vous vous apprêtez à dire à Guybrush d’attaquer le leader du groupe, ce dernier sort un... étrange appareil. Vous en avez déjà vu à la télévision… ');
      readlnE;
      writeln('Il le pointe vers vous. C’est un pistolet ! ');
      readlnE;
      writeln('« Laisse tomber, petit. »');
      readlnE;
      writeln('Guybrush grogne, bouillonne de rage. Matthew Sermonet s’adresse à lui :');
      readlnE;
      writeln('« Toi, reste où tu es ou je m’occupe de ton précieux ami. Tu vas me suivre sans opposer de résistance, à présent. »');
      readlnE;
      writeln('Vous regardez Guybrush, qui vous regarde à son tour. La colère et la panique se lisent clairement dans ses yeux. Vous entendez un bruit sourd, ressentez une douleur à l’arrière du crâne, puis plus rien.');
      readlnE;
      effacerEcran;
      attendre(2000);
      setNomSalle('? ? ?');
      enteteMenu(false,false,true);
      writeln('D’autres années passent. Vous ne vous êtes jamais vraiment remis d’avoir perdu votre ami. Vous maudissez chaque jour la team ALGO et préparez votre revanche. Matthieu Simonet avait raison, la police n’a été d’aucun secours.');
      readlnE;
      writeln('Votre seule solution est d’intégrer l’école de dressage de Geekémons de Nojid afin de récupérer vous-même Guybrush Threepwood. Chaque jour, vous pensez à Guy’, et à votre père. Il serait tellement déçu… ');
      readlnE;
      writeln('Mais il ne sert à rien de ruminer aujourd’hui ! Nous sommes en septembre, et c’est le jour de votre rentrée à l’école de dressage de Geekémons ! ');
      readlnE;
      introduction;
  end;

  procedure choixStarter();
  var
    choixGkm, choixConfirm : Integer;  //choix GKM
    sortie, confirmation : boolean;
  begin
    //récupérer données BDD
    infoGkm := getInfoGkm();
    joueurGkm := getJoueurGkm();

    choixGkm := 0;
    choixConfirm := 0;
    sortie := false; //sortie de la boucle choix GKM

    while sortie = false do
    begin
      confirmation := false; //sortie de la boucle de confirmation du GKM
      effacerEcran;
      writeln('---CHOISI TON PREMIER GKM !---');
      writeln;
      writeln;
      writeln;
      writeln('1.     ', infoGkm[3][1].nom, '   |      Breakin Bad');
      writeln('2.     ', infoGkm[3][2].nom, '    |      True Detective');
      writeln('3.     ', infoGkm[3][3].nom, '  |      Série du même nom');
      writeln;
      writeln('Quel GKM choisis-tu ?');
      readln(choixGkm);

      if (choixGkm <> 1) AND (choixGkm <> 2) AND (choixGkm <> 3) then
      begin
        writeln('MAUVAISE SAISIE');
        readlnE;
      end

      else
      begin
        while confirmation = false do
        begin
        case choixGkm of
        1: writeln('Etes-vous certain de vouloir ', infoGkm[3][1].nom, ' ?');
        2: writeln('Etes-vous certain de vouloir ', infoGkm[3][2].nom, ' ?');
        3: writeln('Etes-vous certain de vouloir ', infoGkm[3][3].nom, ' ?');
        end;

          writeln('1. Oui     2. Non');
          readln(choixConfirm);
          if choixConfirm = 1 then
          begin
            sortie := true;
            confirmation := true;
          end
          else if choixConfirm = 2 then
          begin
            writeln;
            writeln('Choississez un autre GKM.');
            readlnE;
            confirmation := true;
          end
          else
          begin
            writeln('MAUVAISE SAISIE.');
          end;
        end;
      end;
    end;

    case choixGkm of
    1: joueurGkm[0] := infoGkm[3][1];
    2: joueurGkm[0] := infoGkm[3][2];
    3: joueurGkm[0] := infoGkm[3][3];
    end;

    writeln('Vous choisissez ', joueurGkm[0].nom,' !');
    readlnE;

    //renvoyer données BDD
    setJoueurGkm(joueurGkm);

    effacerEcran;
  end;

  procedure quete1();
  begin
    quete := getQuete();
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Alors que vous entrez dans l’ETDDG, vous êtes abordé par un groupe d’étudiants.');
    writeln('« Eh, salut, comment tu t’appelles ? ', infoJoueur.nom ,' ? Content de te connaître ! »');
    readlnE;
    writeln('Une fille prend la parole.');
    writeln('« Enchantée, je suis... »');
    readlnE;
    writeln('Mais elle est coupée par un autre étudiant, vouté sur le pc.');
    writeln('« Eh, notre emploi du temps est en ligne !! »');
    readlnE;
    writeln('Les étudiants se ruent tous sur l’ordinateur, vous suivez le mouvement.');
    writeln('Péniblement, vous parvenez à trouver un petit espace entre les corps agglutinés autour de l’écran pour voir votre emploi du temps.');
    readlnE;
    writeln('Votre cours se déroulera en salle R20. Vous ne parvenez pas à lire l’intitulé du cours, mais ça vous importe finalement assez peu.');
    writeln('Vous n’êtes pas là en tant que simple étudiant, mais pour faire tomber la TEAM ALGO.');
    readlnE;
    writeln('Vous vous dirigez vers le couloir. Vous pourriez rester ici et discuter avec les autres, mais vous n’êtes pas là pour vous faire des amis.');
    writeln('Cela fait des années que vous n’avez pas revu votre meilleur ami, et vous n’avez jamais été aussi proche de le retrouver.');
    readlnE;
    etatQuete(quete.q01b);
    etatQuete(quete.q02);
    setQuete(quete);
  end;

  procedure quete2();
  begin
    quete := getQuete();
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Vous entrez dans la salle R20 et vous installez sur une chaise. D’autres étudiants affluent également dans la pièce, visiblement très excités d’avoir leur tout premiers cours. ');
    readlnE;
    writeln('Un garçon qui semble sympathique vous aborde également, mais vous décidez de ne pas lui répondre.');
    writeln('Bientôt, vous serez sans doute désolé de vous être comporté de la sorte, mais pour le moment vous avez les yeux rivés sur la porte.');
    readlnE;
    writeln('Finalement, une femme entre dans la classe.');
    readlnE;
    writeln('Vous la reconnaissez ! Malgré les années, elle n’a pas beaucoup changé. Il s’agit évidemment de Klarine Serrure, un des membres de la TEAM ALGO.');
    readlnE;
    writeln('Le cours commence. Il semble s’agir d’un cours de Culture Geekémon, mais vous êtes incapable de vous concentrer sur ce que dit cette femme.');
    writeln('Elle débite, insouciante, à un rythme impressionnant, une succession de syllabes. ');
    readlnE;
    writeln('Vous n’avez qu’une envie : vous lever et vous jeter sur elle. Mais ce serait bien entendu stupide, et vous réalisez en cet instant que vous n’avez aucun plan. ');
    readlnE;
    writeln('Toutes ces années, vous avez vécu avec l’objectif d’entrer dans cet école et faire tomber la TEAM ALGO. Mais à aucun moment vous ne vous êtes demandé comment vous y prendre, ni même si vous en étiez capable.');
    writeln('En effet, peut-être n’en êtes-vous pas capable…');
    readlnE;
    writeln('Non, si c’est le cas, vous devez le devenir. Vous devez ça à Guybrush.');
    readlnE;
    writeln('Klarine Serrure vous tire soudain de vos pensées : ');
    writeln('« Allez, le cours est terminé, retournez à vos vies misérables les geeks. »');
    readlnE;
    writeln('Pendant un moment, les autres élèves se demandent s’il s’agissait d’humour. Tout le monde sort de la salle et vous vous demandez quoi faire.');
    writeln('« Eh, mais c’est le crétin ! »');
    readlnE;
    writeln('Vous vous retournez. ', nomRival, ' ! Quelles étaient les chances pour qu’il soit dans cette école ? Vous décidez de l’ignorer.');
    writeln('« Je me demande bien comment tu as pu entrer dans une école aussi prestigieuse. Grace à mon père, je n’ai eu aucun problème à entrer ici, tu vois. »');
    readlnE;
    writeln(nomRival,' n’a décidément pas changé. Il ne réalise même pas qu’en vantant les connexions qu’a son père, il laisse simplement entendre que le mérite seul ne lui aurait pas suffit à entrer dans cette école.');
    readlnE;
    writeln('Nous sommes dans le milieu de la matinée et vous n’avez toujours aucune idée de la suite du plan.');
    writeln('Votre prochain cours est dans une heure et en passant devant la cafétéria, vous remarquez que ce lieu semble être un lieu de rencontre et de combats entre dresseurs de GKM. Si vous voulez être capable de vaincre la TEAM ALGO,');
    writeln('il faut que vous deveniez plus fort.');
    readlnE;
    writeln('Vous décidez que vaincre tous les dresseurs présents seraient un excellent moyen tester vos capacités.');
    readlnE;
    etatQuete(quete.q02);
    etatQuete(quete.q03);
    setQuete(quete);
  end;

  procedure quete4();
  begin
    quete := getQuete();
    writeln('Vous vous installez sur une chaise de libre en attendant le début du cours. ');
    writeln('Vous avez vaincu tous ces dresseurs, vous êtes persuadé d’être capable de vaincre la TEAM ALGO à présent. Vous attendez patiemment. Vous vous sentez étonnamment calme, serein, et confiant.');
    readlnE;
    writeln('C’est alors que le professeur entre dans la pièce. ');
    readlnE;
    writeln('Le sentiment qui vous berçait alors s’évanouit complètement.');
    readlnE;
    writeln('Face à vous se dresse Matthew Sermonet, l’homme qui vous arraché, il y a plusieurs années de cela, votre meilleur ami, le meilleur ami de votre père, le GKM dont vous aviez juré de prendre soin.');
    writeln(' Cet homme qui a gâché votre vie se trouve à présent devant vous.');
    readlnE;
    writeln('Vous pensez à vous lever pour lui sauter à la gorge, puis vous vous rendez compte à quel point ce serait stupide. Que se passerait-il ensuite ?');
    readlnE;
    writeln('Non, vous devez attirer toute l’attention de l’homme, le forcer à s’intéresser à vous afin de le faire parler. ');
    readlnE;
    writeln('L’heure passe et le cours se termine.');
    readlnE;
    writeln('Vous avez réfléchi et décidez que le meilleur moyen d’avoir toute l’attention de Matthew Sermonet est de mettre une raclée au reste de la TEAM ALGO.');
    readlnE;
    writeln('C’est l’heure du déjeuner, il ne fait aucun doute que vous pourrez trouver Klarine Serrure et Jérôme Cassoulet à la cafétéria. Il est l’heure de mettre votre plan à exécution. ');
    readlnE;

    etatQuete(quete.q04); //true->false
    etatQuete(quete.evt2);  //false->true
    etatQuete(quete.q05); //false->true
    setQuete(quete);
  end;

  procedure quete5();
  var nomRival : String;
  begin
    nomRival := getNomRival;
    writeln('Le vacarme fut énorme, tous yeux sont rivés sur vous. ');
    writeln('« Qu’est-ce que tout cela signifie ? »');
    readlnE;
    writeln('Matthew Sermonet se dresse face à vous, il vous regarde avec fureur. ');
    writeln('Le moment tant attendu se présente enfin. Vous expliquez à Matthew Sermonet pourquoi vous êtes ici. Vous lui dîtes que vous êtes venu trouver un ami qui vous a été enlevé.');
    writeln('Tout un tas d’expressions traversent le visage de Matthew Sermonet. Quand il semble enfin comprendre qui vous êtes, il éclate de rire, un rire puissant et diabolique.');
    readlnE;
    writeln('« Pauvre fou ! Venir me défier, dans mon propre repère?! »');
    readlnE;
    writeln('Vous êtes surpris de le voir parler si ouvertement face à des dizaines d’étudiants. Vous les regardez, aucun ne semble surpris. Ce qu’on lit sur les visages ressemble plus à de l’excitation. ');
    writeln('« A quoi penses-tu mon garçon ? Pourquoi regardes-tu tes camarades comme ça ? »');
    readlnE;
    writeln('Il y a un moment où le silence s’installe.');
    readlnE;
    writeln('« Oh. »');
    readlnE;
    writeln('Et Matthew Sermonet se remet à rire de plus belle, d’une voix plus tonitruante que jamais');
    writeln('« A quoi t’attendais-tu en venant ici, hein, mon garçon ? Qu’est-ce que tu espérais en me provoquant face à tous mes élèves ? Crois-tu qu’ils ne sachent pas qui je suis ? »');
    readlnE;
    writeln('Les visages autour de vous peu à peu se transforment. Les visages excités laissent place à des regards furieux. Vous sentez le poids de leur haine qui vous étouffe.');
    writeln('Vous avez envie de vous enfuir en courant, mais ce n’est pas possible. Pas en étant si proche du but. ');
    writeln('« C’est un combat que tu veux, c’est ce que tu auras. Prépare tes meilleurs GKMs, mon garçon, car je ne vais pas retenir mes coups ! »');
    readlnE;

    if (dresseurSermonet1) then
    begin
      effacerEcran;
      enteteMenu(false,false,false);
      writeln('« AAAAAAARG ! » ');
      writeln('Matthew Sermonet tombe sur le sol.');
      readlnE;
      writeln('Vous vous approchez de lui. ');
      readlnE;
      writeln('C’est alors que ',nomRival,' s’extirpe de la masse informe d’étudiants et se jette sur vous.');
      readlnE;
      writeln('« Partez, monsieur Sermonet, je retiens ce crétin ! »');
      readlnE;
      writeln('Matthew Sermonet saisit l’occasion, il se lève péniblement et s’enfuit en direction des escaliers tandis que vous vous débattez pour vous sortir de l’étreinte de ',nomRival,'.');
      readlnE;
      writeln('Après quelques coups de genoux et autres coups de poings, ',nomRival,' lâche enfin prise. Votre lèvre est ouverte et vous avez le gout métallique du sang dans la bouche. Mais qu’importe, vous devez retrouver Matthew Sermonet et en finir.');
      readlnE;
      etatQuete(quete.q05); //true->false
      etatQuete(quete.q06); //false->true
      setQuete(quete);
    end;

  end;

  procedure quete6();
  var
    sortie : Boolean;
    choix : Integer;
  begin
    quete := getQuete();
    sortie := false;
    effacerEcran;
    enteteMenu(false,false,false);
    writeln('Vous entrez dans le bureau de Matthew Sermonet.');
    writeln('Ce dernier a le visage enfuie dans ce qui semble être un coffre-fort. ');
    readlnE;
    writeln('Il en extirpe finalement une GKB. ');
    readlnE;
    writeln('Il la lance au centre de la pièce.');
    readlnE;
    writeln('D’abord informe, la silhouette qui apparaît hors de la GKB prend rapidement forme.');
    writeln('Guybrush Threepwood ! ');
    readlnE;
    writeln('Votre souffle se coupe et votre cœur s’emplit de joie à la vue de votre ami retrouvé. Vous voulez le prendre dans vos bras, mais quelque chose cloche. ');
    writeln('Le regarde de Guy’ n’est plus le même. Que lui ont fait la TEAM ALGO durant toutes années ? ');
    writeln('« Attaque-le, Guybrush, tu vas n’en faire qu’une bouchée ! »');
    readlnE;
    writeln('C’est alors que Guybrush vous attaque.');
    readlnE;
    etatQuete(quete.finjeu); //false->true
    setQuete(quete);
    dresseurSermonet2();
    writeln('Guybrush ne fait qu’une bouchée de vos GKM. Il s’avance alors vers vous.');
    writeln('« Porte lui le coup final, Guybrush ! »');
    readlnE;
    writeln('Ce n’est pas possible ! Jamais un GKM n’a blessé d’être humain. Si Guy’ devait vous porter un coup, ce serait à coup sûr un coup fatal. ');
    writeln('Vous ne reconnaissez pas votre ami qui progresse vers vous. Il lève le bras, puis…');
    readlnE;
    writeln('Sa main retombe et se tends vers vous. Vous la saisissez.');
    readlnE;
    writeln('Matthew laisse alors apparaître une télécommande qui était cachée dans sa manche. Il appuie sur un bouton et Guy’ est comme électrisé. Il est pris de légères convulsions puis se retourne vers le chef de la TEAM ALGO, furieux.');
    writeln('« Mais comment est-ce possible ?! Ce lavage de cerveau n’avait jamais failli auparavant ! »');
    readlnE;
    writeln('C’est vers Matthew Sermonet que Guy’ s’avance à présent. ');
    writeln('Puis Guy’ se retourne et vous regarde.');
    writeln('C’est le moment de faire un ultime choix. Quel sera-t-il ?');
    while not(sortie) do
    begin
      writeln(' 1.  Attaquer Matthew Sermonet');
      writeln(' 2.  Epargner Mattew Sermonet');
      readln(choix);
      case choix of
        1:
        begin
          writeln('Guy’ porte un ultime coup au chef de la TEAM ALGO qui s’effondre sur le dos, inerte.');
          readlnE;
          writeln('Vous avez vaincu la TEAM ALGO et récupéré votre ami, mais à quel prix ? Vous rentrez chez vous, accompagné de Guy’.');
          readlnE;
          writeln('Si vous vous sentez heureux en franchissant le seuil de votre porte, vous savez que le choix que vous avez pris restera à jamais gravé en vous.');
          sortie := true;
        end;
        2:
        begin
          writeln('Guy’ assomme le chef de la TEAM ALGO et, une demi-heure plus tard, le voilà menotté par la police. Vous avez vaincu la TEAM ALGO et récupéré votre ami, mais Matthew Sermonet ne restera pas bien longtemps en prison.');
          writeln('Ses relations lui permettent de sortir après quelques jours et, malgré la joie que vous avez d’avoir retrouvé votre ami, vous vivez chaque jour avec la peur de croiser à nouveau la route de trois curieux personnages.');
          sortie := true;
        end;
      end;
    end;

  end;

  procedure evenement1();
  var
    choix: Integer;
    sortie: Boolean;
  begin
    quete := getQuete();
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('« Eh, gros noob ! »');
    readlnE;
    writeln('Vous vous retourner. Encore NOMRIVAL. Quand vous étiez plus jeune, vous preniez ses insultes très à cœur, mais vous avez bien plus important à vous soucier aujourd’hui.');
    readlnE;
    writeln('Thérèse intervient.');
    writeln('« Surveille ton langage, jeune homme. Pas ce ça dans mon bureau. Si vous voulez vous chamailler, c’est dehors. Allez, hop ! »');
    readlnE;
    writeln('Vous voilà à nouveau dans le couloir.');
    writeln('« Pff, quelle vieille peau. »');
    readlnE;
    writeln('« Alors, t’as déjà eu ton premier GKM ? »');
    readlnE;

    while not(sortie) do
    begin
      writeln(' 1.  Dire la vérité');
      writeln(' 2.	Mentir');
      readln(choix);

      case choix of
        1:
        begin
          writeln('« Super, moi aussi ! T’as pas le choix, du coup,', infoJoueur.nom, ' tu vas devoir te mesurer à moi. Je vais te ridiculiser, ah ! »');
          dresseurRival1();
          sortie := true;
        end;
        2:
        begin
          writeln('« Pff, t’es vraiment à la traîne, crétin. Presque tout le monde dans la classe est allé choisir le sien. Allez, ciao le naze. »');
          sortie := true;
        end;
        else
        begin
          writeln('MAUVAISE SAISIE');
          readlnE;
        end;
      end;
      readlnE;
    end;

    writeln(nomRival, ' repart de son côté et vous pouvez enfin vous concentrer à nouveau sur votre quête.');
    readlnE;
    etatQuete(quete.evt1);
    setQuete(quete);
  end;

  procedure evenement2();
  var
    choix1 : Integer;
    choix11 : Integer;
    sortie1 : Boolean;
    sortie11 : Boolean;
    infoJoueur : Joueur;
  begin
    sortie1 := false;
    sortie11 := false;
    infoJoueur := getInfoJoueur();
    nomRival := getNomRival();
    quete := getQuete();
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Alors que vous explorez cette salle de classe à la recherche d’un GKM sauvage à affronter, vous êtes surpris de remarquer une ombre au fond de la pièce sombre. La silhouette s’avère être cette de ',nomRival,'. Il vous remarque et dit d’une voix chevrotante.');
    readlnE;
    writeln('« Qu’est-ce que tu fais là, crétin ? Laisse-moi tranquille ! »');
    readlnE;
    writeln('Vous vous apprêtez à quitter la pièce quand ',nomRival,' ajoute.');
    writeln('« Non,',infoJoueur.nom,' attends ! » ');
    readlnE;
    writeln(nomRival,' sort de l’ombre et s’avance vers vous. Son air dépité et ses yeux ronges et gonflés indiquent que quelque chose ne va pas du tout. Vous ne l’aviez jamais vu dans cet état. ');
    writeln('« Je...je... »');
    readlnE;
    writeln('« Non, rien, laisse tomber. »');

    while not(sortie1) do
    begin
      writeln(' 1.  Demander ce qui ne va pas');
      writeln(' 2.  Sortir ');
      readln(choix1);
      if choix1 = 1 then
      begin
        writeln('« Je ne me sens pas à ma place ici. » ');
        readlnE;
        writeln('« Je suis entré grâce à papa, mais depuis ce matin, je suis complètement perdu. J’ai défié un bon nombre d’étudiant en combat, et ils m’ont tous mis une raclée. »');
        readlnE;
        writeln(nomRival,' garde les yeux fixés vers le sol.');
        writeln('« Je déteste avoir à te demander ça mais... tu veux bien te battre contre moi ? Pour l’entrainement, j’entends. » ');

        while not(sortie11) do
        begin
          writeln(' 1.  Accepter');
          writeln(' 2.  Refuser');
          readln(choix11);
          if choix11 = 1 then
          begin
            writeln('« Merci, ', infoJoueur.nom, ', merci... »');
            readlnE;
            dresseurRival2();
            sortie1 := true;
            sortie11 := true;
          end
          else if (choix11 <> 1) and (choix11 <> 2) then writeln('MAUVAISE SAISIE')
          else
          begin
            writeln('Vous n''avez certainement pas de temps à perdre avec ', nomRival,'.');
            writeln('Vous décidez de sortir de la pièce dans un regard de plus pour lui.');
            readlnE;
            sortie1 := true;
            sortie11 := true;
          end;
        end;
      end
      else if (choix1 <> 1) and (choix1 <> 2) then writeln('MAUVAISE SAISIE')
      else
      begin
        writeln('Vous n''avez certainement pas de temps à perdre avec ', nomRival,'.');
        writeln('Vous décidez de sortir de la pièce dans un regard de plus pour lui.');
        readlnE;
        sortie1 := true;
      end;

      etatQuete(quete.evt2); //true->false
      setQuete(quete);
    end;
    setInfoJoueur(infoJoueur);
    setNomRival(nomRival);
  end;

end.
