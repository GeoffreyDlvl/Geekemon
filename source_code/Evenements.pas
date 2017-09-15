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
    //r�cup�rer donn�es BDD
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
    write('PAPA: Ok, fiston, pr�pare toi pour ton premier combat de GKMs !');
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
    write('PAPA: Tr�s bien ! Guy'' ne devrait faire qu''une bouch�e de ce Chandler Bing.');
    readlnE;
    dessinerCadreXY(4,15,83,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Demande � Guybrush d''attaquer !');
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
    writeln('Il inflige 12 points de d�gat !');
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
    writeln('Guybrush Threepwood subit 30 points de d�gats !');
    readlnE;

    //SE DEFENDRE
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-30,true);
    writeln;

    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: A�e, ce GKM est f�roce !');
    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Le prochain coup risque d''�tre fatal si tu ne te d�fends pas !');
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
      writeln('1. Attaquer      2. Se d�fendre');
      readln(choix);

      if choix <> 2 then
      begin
        dessinerCadreXY(4,15,80,18,simple,15,0);
        deplacerCurseurXY(5,16);
        write('PAPA: Non, d�fends toi, fiston !');
        readlnE;
      end
      else sortie := true;
    end;

    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-30,true);
    writeln;
    writeln('Guybrush Threepwood se d�fends !');
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
    writeln('Guybrush Threepwood subit 2 points de d�gats !');
    readlnE;

    //UTILISER POTION
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-32,true);
    writeln;

    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Ce n''est pas pass� loin !');
    readlnE;
    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Il faut que tu soignes Guy'' � pr�sent. Prends cette potion !');
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
      writeln('1. Attaquer      2. Se d�fendre      3. Utiliser potion');
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
    writeln('Il r�cup�re 50 PVs !');
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
    writeln('Guybrush Threepwood subit 8 points de d�gats !');
    readlnE;

    //ATTRAPER
    effacerEcran;
    enteteMenu(false,true,true);
    enteteCombat(lvl,indGkm,0,pvS-12,pvJ-8,true);
    writeln;

    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Tr�s bien, fiston, il est temps d''en finir !');
    readlnE;
    dessinerCadreXY(4,15,80,18,simple,15,0);
    deplacerCurseurXY(5,16);
    write('PAPA: Attrape ce satan� GKM ! Prends cette GKB !');
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
      writeln('1. Attaquer      2. Se d�fendre      3. Utiliser potion      4. Lancer GKB');
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
    writeln('F�licitation, vous avez attrap� Chandler Bing sauvage !');
    infoJoueur.nbGeekeball := infoJoueur.nbGeekeball -1;
    setInfoJoueur(infoJoueur);
    readlnE;
    dessinerCadreXY(4,22,84,25,simple,15,0);
    deplacerCurseurXY(5,23);
    write('PAPA: Bravo, mon fils ! Tu es officiellement un dresseur de GKMs � pr�sent !');
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
    writeln('C''est le moment de donner une bonne racl�e � ', nomRival, ' !');
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
              writeln('Vous d�crochez un coup de point dans la m�choire de ',nomRival, ' !');
              readlnE;
              pDDeg := random(3)+1; //calcul pdd
              pvRival := pvRival - pDDeg;
              writeln;
              writeln('Vous lui infligez ', pDDeg, ' points de d�gats ! Prends �a !');
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
            writeln('Vous subissez ', pDDeg, ' points de d�gats ! Ouch !');
              if pvJoueur < 0 then
                pvJoueur := 0;

            readlnE;
            initiative := true;
          end;
        until (pvRival = 0) OR (pvJoueur = 0);

        enteteMenu(false,false,false);

        if pvRival = 0 then   //VICTOIRE
        begin
          writeln(nomRival, ' met un genou � terre !');
          readlnE;
          writeln('Vous avez vaincu ', nomRival, ' ! Youpi !');
          readlnE;
          finCombat := true;
          combatRival := true;
        end

        else if pvJoueur = 0 then             //DEFAITE
        begin
          writeln('Vous avez �t� vaincu par ', nomRival, '...');
          writeln;
          readlnE;
          combatRival := false;
        end
    until finCombat = true;
  end;

  procedure introduction();
  var
    choix : Integer;
    sortieBoucle : Boolean; //permet de sortir des boucles de v�rification de saisie correcte
  begin
    infoJoueur := getInfoJoueur();
    quete := getQuete();

    choix := 0;
    sortieBoucle := false;
    effacerEcran;
    setNomSalle('S E C R E T A R I A T');
    enteteMenu(false,false,true);

    writeln('Vous poussez la porte du secr�tariat.');
    writeln('La pi�ce ressemble exactement � ce que l''on attendrait d''un secr�tariat, et la petite dame derri�re le bureau ressemble exactement � ce que l''on imagine d''une secr�taire.');
    writeln;
    writeln('"Bonjour, je peux vous aider ?"');
    readlnE;
    writeln('"Oh, vous �tes un nouvel �tudiant, c''est �a ?"');
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
    writeln('Vous rendez finalement le document � la secr�taire.');
    readlnE;
    writeln('"Vous vous appelez ', infoJoueur.nom, ', c''est bien �a?"');
    writeln;
    while (choix <> 1) AND (choix <> 2) do
    begin
      writeln('1. Oui, c''est exact.');
      writeln('2. Oh, d�sol�, j''ai d� commettre une erreur...');
      readln(choix);
      if choix = 2 then
      begin
        while choix = 2 do
        begin
          while sortieBoucle = false do
          begin
            write('Vous r�cup�rez le document et corrigez votre ');
            couleurTexte(11);
            write('nom: ');
            couleurTexte(15);
            readln(infoJoueur.nom);
            if infoJoueur.nom <> '' then
              sortieBoucle := true;
          end;
          sortieBoucle := false;
          writeln;
          writeln('"Ne vous inqui�tez pas. Vous �tes donc ', infoJoueur.nom, ' ?"');
          writeln;
          writeln('1. Pas d''erreur cette fois-�i !');
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
    writeln('La secr�taire examine une derni�re fois le forumulaire et vous sourit � nouveau.');
    writeln;
    writeln('"Je pense que tout est en ordre."');
    writeln('"Enchant�e, ', infoJoueur.nom, ', je suis Th�r�se, la secr�taire du d�partement DDG de cet �tablissement."');
    readlnE;
    writeln('"Comme tu le sais sans doute, le d�partement Dressage De Geek�mons t''offre ton tout premier Geek�mon !"');
    readlnE;
    writeln('"Mais ce n''est pas moi qui m''occupe de �a. Dirige-toi vers l''ETDDG, dans le couloir juste � cot�..."');
    readlnE;
    writeln('"Choisis bien, ou tu ne seras ni le premier, ni le dernier � me demander si tu peux changer de geek�mon..."');
    readlnE;
    writeln('"...Mais ce ne sera pas possible !"');
    readlnE;
    writeln('"Ne t''inqui�te pas, tu pourras en attraper plein d''autres. Mais n''oublie pas que ton premier Geek�mon est unique."');
    readlnE;
    writeln('"Bonne chance alors ! Et bienvenue dans le monde du dressage de geek�mons !"');
    readlnE;
    effacerEcran;

    writeln('A peine �tes-vous sorti du secr�tariat qu''un jeune gar�on, plus loin dans le couloir, vous fait de grands signes.');
    writeln;
    writeln('"Eh, toi, par ici!"');
    readlnE;
    writeln('"J''te connais pas, t''es nouveaux non ?"');
    writeln('"Je suis membre de l''ETDDG, et mon petit doigt me dis que t''as pas encore de geek�mon."');
    readlnE;
    writeln('"Suis-moi, l''ETDDG, c''est par l�."');
    readlnE;
    writeln('Le gar�on vous guide vers une salle que vous n''auriez pas manqu�e m�me sans sons aide : une �norme pancarte ''ETDDG'' figure accroch�e � la porte.');
    writeln;
    writeln('"Moi, c''est Micha�l. Je suis un dresseur de Geek�mons."');
    writeln('"Et je suis assez bal�ze d''alleurs ! Viens faire un tour � la caf�t'' si tu veux te mesurer � moi."');
    readlnE;
    writeln('"Mais en attendant..."');
    readlnE;
    effacerEcran;
    writeln('Vous p�n�trez dans la salle de l''ETDDG. La pi�ce semble confortable, malgr� les innombrables d�chets qui ornent le sol ainsi que l''odeur de transpiration.');
    writeln('Il ne fait aucun doute, cette pi�ce est v�ritablement habit�e par des dresseurs de Geek�mons.');
    writeln;
    writeln('"... On va te trouver ton premier Geek�mon !"');
    readlnE;
    effacerEcran;
    writeln('"Laisse-moi t''expliquer en quelques mots ce dans quoi tu t''embarques, gamin."');
    readlnE;
    writeln('"En d�cidant d''int�grer le d�partement DDG de cette �cole, tu es entr� dans un monde vraiment fantastique... mais');
    writeln('�galement tr�s dangereux."');
    readlnE;
    writeln('"Les diff�rentes salles de cet �tablissement sont infest�es de Geek�mons sauvages."');
    writeln('"La direction et l''ETDDG essaient de se d�barrasser d''eux, mais ils semblent toujours revenir d''on ne sait o�."');
    writeln('"Dans quelques instants, tu pourras choisir ton premier Geek�mon. Voici aussi quelques potions et cr�dits pour bien');
    writeln('commencer l''ann�e."');
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
    writeln('"Le grand moment est arriv�, gamin ! Tu vas enfin choisir ton premier Geek�mon !"');
    readlnE;
    writeln('Michael sort un trousseau de cl�s de sa poche, et ouvre un petit placard qui se situe dans un angle de la pi�ce.');
    writeln('Il sort une petite bo�te m�tallique ferm�e par un cadenas dont il compose le code.');
    writeln;
    writeln('La boite s''ouvre.');
    readlnE;
    choixStarter();
    joueurGkm := getJoueurGkm();
    writeln('Micha�l semble approuver votre choix.');
    writeln;
    writeln('"',joueurGkm[0].nom, ', hein ?"');
    readlnE;
    writeln('"C''est un tr�s bon choix. T''as du potentiel, gamin."');
    readlnE;
    writeln('"Bon, il est temps pour moi de te laisser. Tu peux te promener dans le b�timent, m�me s''il n''y a pas grand chose � y');
    writeln('faire � cette heure de la journ�e."');
    readlnE;
    writeln('"Reviens ici pour te reposer, acheter des potions ou des Geek�balls. Tu peux aussi explorer les salles alentours, mais');
    writeln('attention aux Geek�mons sauvages !"');
    readlnE;
    writeln('"Et surtout, viens faire un tour � la caf�t'' pour te mesurer � moi, et � bien d''autres ! On t''attends de pied ferme."');
    readlnE;
    writeln('Micha�l vous donne une grande tape amicale dans le dos alors qu''il quitte la pi�ce.');
    readlnE;
    writeln('Vous vous dirigez vers la porte qui m�ne au couloir. Vous vous demandez o� vous pourriez bien aller � pr�sent.');
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
    writeln('Le coq de monsieur Tourvier vous r�veille en sursaut. Vous maudissez l�animal avant de plonger votre visage dans l�oreiller.');
    writeln('Vous avez sommeil, mais l�abondance de lumi�re qui passe par votre fen�tre vous indique qu�il serait peut-�tre temps de vous lever�');
    while not(sortie1) do
    begin
      writeln(' 1.  Fermer les yeux, juste quelques secondes de plus...');
      writeln(' 2.  Se lever');
      readln(choix1);
      if choix1 = 1 then
      begin
        writeln('Quand vous rouvrez les yeux, vous �tes en pleine forme ! Vous jetez un coup d��il � votre radio r�veil. Il est presque midi ! Heureusement qu�il n�y a pas �cole aujourd�hui�');
        sortie1 := true;
        leveTard := true;
      end
      else if choix1 = 2 then
      begin
        writeln('Malgr� qu�il n�y a pas �cole aujourd�hui et qu�il soit encore relativement t�t, vous d�cidez de vous lever. Apr�s tout, le monde appartient � ceux qui se l�vent t�t, parait-il�');
        sortie1 := true;
      end
      else writeln('MAUVAISE SAISIE');
    end;
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Vous mettez les jambes hors du lit et vous levez d�un bond. Vous scrutez la chambre et remarquez qu�elle est en d�sordre, maman risque de ne pas �tre contente, elle vous avait demand� de ranger hier soir');
    while not(sortie2) do
    begin
      writeln(' 1.  Ranger la chambre ');
      writeln(' 2.  Jouer � la N64 ');
      writeln(' 3.  Descendre directement ');

      readln(choix2);
      case choix2 of
        1:
        begin
          writeln('Vous prenez votre courage � deux mains et commencez � ranger mais finalement, vous glissez le plus gros du d�sordre sous votre lit. Toute cette peine de bon matin vous a grandement ouvert l�app�tit, vous d�cidez de rejoindre maman dans la cuisine.');
          sortie2 := true;
        end;
        2:
        begin
          writeln('Oh, vous pouvez bien faire une petite partie avant descendre, non ? Vous allumez la console et lancez Banjo Kazo�e.');
          writeln('Apr�s quelques minutes, vous vous rappelez pourquoi vous vous �tiez couch�s si tard la veille : impossible de passer ce niveau ! Vous d�cidez que vous r�essaieraient plus tard, il est l�heure d�aller prendre votre petit d�jeuner !');
          writeln('Vous rejoignez maman dans la cuisine.');
          sortie2 := true;
        end;
        3:
        begin
          writeln('Vous avez trop faim pour vous soucier de ranger votre chambre ou m�me de jouer � la console, vous d�cidez d�aller rejoindre maman dans la cuisine.');
          sortie2 := true;
        end;
        else writeln('MAUVAISE SAISIE');
      end;
    end;
    readlnE;
    effacerEcran;
    setNomSalle('C U I S I N E');
    enteteMenu(false,false,true);
    write('� Bonjour, mon ch�ri !');
      if leveTard
      then write(' Eh bien, il �tait temps que tu te l�ves !');
    writeln('�');
    readlnE;
    writeln('Maman vous sourit et vous embrasse sur le front. Maman est vraiment une femme adorable. Vous aimeriez tant que papa le soit autant. Il n�est pas m�chant, mais il travaille beaucoup.');
    writeln('Et quand il est � la maison, vous avez l�impression qu�il est trop fatigu� pour vous porter de l�attention�');
    readlnE;
    writeln('� Prends-ton assiette, mange quelque chose ! �');
    readlnE;
    writeln('Vous vous demandez pourquoi maman est si pressante.');
    readlnE;
    writeln('� J�ai quelque chose � te dire. Ton p�re ne travaille pas aujourd�hui. �');
    readlnE;
    writeln('On a beau �tre dimanche, papa travaille souvent le dimanche.');
    readlnE;
    while not(sortie3) do
    begin
      writeln(' 1.  Mais alors, pourquoi il n�est pas � la maison ?');
      writeln(' 2.  Je m�en fiche� ');
      readln(choix3);
      case choix3 of
        1:
        begin
          writeln('� Parce qu�il a une surprise pour toi. Ton p�re t�aime beaucoup, tu sais. Il n�est juste pas tr�s dou� pour te le montrer. Je pense que tu vas �tre content. Il m�a demand� de te dire de le rejoindre au lac, � l�autre bout du village. �');
          sortie3 := true;
        end;
        2:
        begin
          writeln('� Oh, mon ch�ri. Je peux comprendre que tu sois en col�re. Mais ton p�re t�aime sinc�rement, tu sais. Il n�est juste pas tr�s dou� pour te le montrer. Et c�est ce qu�il va essayer de faire aujourd�hui, je pense, puisqu�il a une surprise pour toi !');
          writeln('Il m�a demand� de te dire de le rejoindre au lac, � l�autre bout du village. �');
          sortie3 := true;
        end;
        else writeln('MAUVAISE SAISIE');
      end;
    end;
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('� Alors avale ton petit-d�jeuner et oust ! Va le rejoindre ! �');
    readlnE;
    writeln('Apr�s avoir fini votre assiette, vous regardez autour de vous. Maman dit toujours que papa travaille beaucoup, mais que c�est gr�ce � �a qu�on a une si jolie maison. Et il est vrai qu�elle est jolie, votre maison.');
    writeln('Mais vous pr�f�reriez vivre dans une petite maison comme Sophie, la voisine, qui a pour habitude d�aller p�cher avec son p�re les dimanches ensoleill�s comme aujourd�hui.');
    readlnE;
    writeln('Maman est sortie, elle discute avec la m�re de Sophie. Papa peut bien attendre quelques minutes de plus�');
    writeln('Que voulez-vous faire ?');
    while not(sortie4) do
    begin
      writeln(' 1.  Regarder la t�l�vision');
      writeln(' 2.  Remonter dans votre chambre');
      writeln(' 3.  Faire coucou � maman');
      writeln(' 4.  Sortir');
      readln(choix4);
      case choix4 of
        1:
        begin
          writeln('Vous vous installez dans votre canap� et regardez les dessins anim�s. Que serait une matin�e sans �cole sans dessins anim�s ?');
        end;
        2:
        begin
          writeln('Vous vous appr�tez � remonter dans votre chambre, bien d�cid� � finir ce niveau sur Banjo Kazoie qui vous �nerve tant. Mais papa vous attends au lac� Peut-�tre n�est-ce pas une bonne id�e, finalement');
        end;
        3:
        begin
          writeln('Vous tapez � la fen�tre pour attirer l�attention de maman, qui discute toujours avec la m�re de Sophie. Quand elle vous remarque enfin, elle vous fait un grand signe. Vous lui souriez.');
        end;
        4:
        begin
          writeln('Vous enfilez votre casquette Geek�mon, vos chaussures de courses (celles qui font courir vite !) et sortez de la maison.');   //CONTINUER ICI
          sortie4 := true;
        end;
        else writeln('MAUVAISE SAISIE');
      end;
    end;
    readlnE;
    setNomSalle('V I L L A G E');
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('A quelques pas de chez vous, sur le chemin qui m�ne au lac, vous apercevez le vieux fermier, monsieur Tourvier, qui fume sa pipe en regardant le ciel.');
    writeln('Plus loin un peu plus loin se trouve madame Tourvier (que tout le monde appelle vieille Madeleine, vous n�avez jamais compris pourquoi), en train de courir apr�s des poules qui semblent s��tre �chapp�es de leur enclos.');
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
          writeln('Monsieur Tourvier met quelques secondes � sortir de l��tat r�veur dans lequel il se trouvait avant de vous remarquer.');
          readlnE;
          writeln('� Eh, salut, gamin. Qu�est-ce qui t�am�ne ? �');

          while not(sortie51) do
          begin
            writeln(' 1. Je rejoins mon p�re au lac ');
            writeln(' 2. Je me prom�ne simplement, monsieur');
            readln(choix51);

            case (choix51) of
              1:
              begin
                effacerEcran;
                enteteMenu(false,false,true);
                writeln('� Vraiment ? Brave homme, que ton p�re. Je l�ai connu tout gamin comme toi, tu sais. A l��poque, il voulait devenir dresseur de GKMs. Ah, ce r�ve ! Tous les gamins ne parlaient que de �a.');
                writeln('Mais ce n�est pas ce qui remplit ton assiette ni celle de ta famille, et ton p�re l�a bien compris. Les choses �taient plus simples quand j��tais jeune, tu sais. C��tait une �poque o� on pouvait devenir dresseur de GKM.');
                writeln(' Tu sais que j�ai �t� un dresseur reconnu, en mon temps ?');
                writeln('Ecoute, gamin, j�aimerais te raconter le jour o� je me suis fait surprendre par un Dale Cooper alors que le seul GKM que j�avais sur moi ne tenait d�j� presque plus debout, � �');
                sortie51 := true;
              end;
              2:
              begin
                effacerEcran;
                enteteMenu(false,false,true);
                writeln('Vraiment ? C�est une bonne chose, gamin. Aujourd�hui, les jeunes passent bien trop de temps derri�re leurs �crans,');
                writeln('� combattre des GKMs virtuels au lieu de d�couvrir le monde et VRAIMENT se mesurer � un GKM sauvage !');
                writeln('T''ai-je d�j� racont� la fois o� je me promenais pr�s d�Ecclesia, la capitale, et o� j�ai �t� surpris par un Blackadder assoiff� de sang � �');
                sortie51 := true;
              end;
              else writeln('MAUVAISE SAISIE');
            end;
          end;

          readlnE;
          effacerEcran;
          enteteMenu(false,false,true);
          writeln('Evidemment, vous connaissez d�j� cette histoire, mais la r��couter ne vous d�rangeait pas le moins du monde. Vous �tes passionn�s de GKMs et tout ce qui se rapporte � ces cr�atures fascinantes vous �merveille.');
          writeln('Apr�s avoir racont� son histoire, monsieur Tourvier retourne � son occupation favorite : fumer sa pipe en se rem�morant ses jeunes jours de dresseur de GKMs.');
          readlnE;
        end;
        2:
        begin
          writeln('La vieille Madeleine vous regarde toute essouffl�e. Son regard se pose se votre casquette.');
          writeln('� Dr�le de chapeau, petit. �');
          readlnE;
          writeln;

          while not(sortie52) do
          begin
            writeln('1. C�est la m�me casquette de Masha�  ');
            readln(choix52);
            case (choix52) of
              1:
              begin
                effacerEcran;
                enteteMenu(false,false,true);
                writeln('Vous expliquez � la vieille Madeleine que Masha est votre h�ros de dessins anim�s pr�f�r� : il est dresseur de GKM et parcourt le monde en compagnie de ses amis.');
                readlnE;
                writeln('� Ah, les GKMs. Dr�les de b�tes que ces b�tes-l�. Tu sais, petit, quand ma grand-m�re �tait enfant, �a n�existait pas. C�est comme s�ils �taient apparus avec premi�res t�l�visions. C�est curieux, non ? �');
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
    writeln('Vous continuez votre route vers le lac. Vous vous �loignez du grand chemin et empruntez une petit route terreuse et irr�guli�re. Au loin, vous apercevez un gar�on que vous d�testez.');
    writeln('La derni�re fois que vous aviez crois� sa route, vous aviez tous les deux finis dans le bureau du maire car vous vous �tiez battus. Un comble quand on sait qu�il est le fils du maire.');
    writeln('Evidemment, votre punition a �t� bien plus s�v�re que la sienne.');
    readlnE;
    writeln('Quel est son nom, d�j� ?');
    saisirNomRival();
    setNomRival(nomRival);

    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Ah, oui, ', nomRival, '. Vous serrez les points alors que vous croisez sa route. Vous remarquez qu�il serre �galement les siens. Il finit par vous interpeller.');
    writeln('� Eh, cr�tin, mon p�re te passe le bonjour. N�h�site pas � passer le voir si tu veux une autre punition. � ');
    readlnE;
    writeln(nomRival, ' ricane b�tement. Vous d�cidez de l�ignorer.');
    readlnE;
    writeln('� Allez, je rigole ! Je veux bien te pr�ter mon p�re, comme ton papounet n�est jamais l� ! Mais je ne suis pas persuad� qu�il t�aime plus que le tient ! �');
    readlnE;
    writeln('Il ricane � nouveau, l�air mauvais.');
    readlnE;
    writeln(' 1.  L�ignorer et continuer votre route.');
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
            writeln('L�air mauvais mais mal en point,', nomRival, ' vous dit qu�il dira tout � son p�re et part en disant des mots que vous ne connaissez m�me pas. ');
            writeln('Vous lui avez donn� une bonne le�on ! C�est tr�s content que vous vous dirigez vers le lac.');
            readlnE;
            sortie6 := true;
          end
          else
          begin
            //defaite
            writeln(nomRival, ' vous regarde de haut alors que vous �tes les fesses dans la boue.');
            writeln;
            writeln('� Bien fait pour toi, cr�tin, ah ! � ');
            readlnE;
            writeln('Il glousse comme un abruti alors qu�il se dirige vers le village. Rouge de honte et de col�re, vous d�cidez de vers diriger vers le lac.');
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
    writeln('Vous arrivez finalement au lac. Sur l�autre rive, vous apercevez tout de suite Sophie et son p�re en train de p�cher. Aucune trace de papa. ');
    writeln('Apr�s quelques minutes, d��us, alors que vous vous appr�tez � rebrousser chemin, vous entendez :');
    writeln('� Eh, par ici, fiston ! �');
    readlnE;
    writeln('Vous �tes habituellement en col�re contre papa, mais l�entendre vous appeler fiston vous r�chauffe le c�ur, et c�est le sourire aux l�vres que vous vous dirigez vers lui.');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Vous passez une bonne partie de la journ�e avec papa. Vous jouez avec lui, il vous apprend � p�cher. Vous passez un peu de temps avec Sophie et son p�re et vous p�chez ensemble.');
    readlnE;
    writeln('Le p�re de Sophie est un coll�gue de papa mais curieusement, ils ne parlent pas de travail. Le p�re de Sophie semble un peu bizarre et vous ne comprenez pas pourquoi papa se comporte comme �a, mais vous vous en fichez. Vous �tes heureux.');
    readlnE;
    writeln('A la fin de la journ�e, papa vous annonce qu�il a une surprise.');
    readlnE;
    writeln('� Je pense que tu vas aimer ce que j�ai trouv�, fiston. �');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('C�est en jubilant qu�il plonge sa main dans son sac. C�est bizarre de voir papa comme �a, on dirait un enfant, comme vous.');
    writeln('Il sort une...');
    readlnE;
    writeln('Vous n�en croyez pas vos yeux ! ');
    readlnE;
    writeln('Une Geek�ball !');
    readlnE;
    writeln('� Ecoute-moi bien, mon fils. Je m�appr�te � te confier un GKM extr�mement rare. Il m�est tr�s pr�cieux, et je veux que tu en prennes soin. Je l�ai avec moi depuis quelques ann�es maintenant, c�est un meilleurs amis, tu sais.');
    writeln('Les gens se moquent de moi quand je leur dis que mon meilleur ami est un GKM, mais je m�en fiche. Il est � toi maintenant. �');
    readlnE;
    writeln('Il ouvre la GKB et le GKM qui en sort ne ressemble � aucun autre. Vous pensiez pourtant tous les conna�tre !');
    readlnE;
    writeln('Le GKM face � vous arbore une chevelure dor�e et un air badaud. Il vous regarde, hagard, puis se retourne et aper�oit pas papa. Son regard s�illumine alors.');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('� Eh, salut, Guy� ! �');
    readlnE;
    writeln('� Fiston, je te pr�sente Guybrush Threepwood. C�est un GKM un peu sp�cial, tu vois, il n�en existe aucun comme celui-l�. �');
    readlnE;
    writeln('C�est �trange, en effet... Il ne semble pas appartenir au m�me monde que les autres GKM. ');
    readlnE;
    writeln('� Guy�, je te pr�sent mon fils. C�est lui qui va s�occuper de toi, � partir d�aujourd�hui. Vous allez devenir meilleurs amis, vous aussi, j�en suis persuad� ! �');
    readlnE;
    writeln('Vous �tes incapable d�exprimer votre joie. Papa ne s�occupe jamais de vous, et les cadeaux qu�il vous fait tout le temps ne sont toujours que des jouets bien trop chers pour un petit gar�on de votre �ge. Mais cette fois,');
    writeln('il vous a offert le meilleur cadeau que vous puissiez imaginer ! ');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Tout � coup, vous entendez un cri depuis l�autre rive du lac. ');
    readlnE;
    writeln('Oh, non !');
    writeln('Sophie et son p�re semblent avoir �t� surpris par un GKM sauvage alors qu�ils rangeaient leur mat�riel et s�appr�taient � rentrer au village. Accompagn� de papa et de Guybrush, vous courez en leur direction ! ');
    readlnE;
    writeln('� Ok, Guy�, c�est le moment de montrer � mon fils de quoi tu es capable ! Fiston, Guybrush est ton GKM, � pr�sent, c�est donc toi qui va aider Marc et Sophie. �');
    readlnE;
    writeln('Face � votre air anxieux, il ajoute : ');
    writeln('� Mais je serais derri�re-toi pour te donne un coup de main, ne t�en fais pas ! �');
    readlnE;
    combatTuto;
    effacerEcran;
    setNomSalle('? ? ?');
    enteteMenu(false,false,true);
    writeln('Soulag�s, vous rentrez au village. Tous racontent comme vous �tes fi�rement battus. Vous vous sentez bien. ');
    readlnE;
    writeln('Vous �tes heureux, �a oui. Vous devenez rapidement amis avec Guybrush.');
    readlnE;
    writeln('Une semaine passe, vous apprenez que papa est malade. ');
    readlnE;
    writeln('Papa passe alors beaucoup de temps chez le docteur et � l�hopital. Personne ne veut vous dire ce qu�il a, mais maman semble inqui�te. Vous essayez de ne pas y penser et passez tout votre temps avec Guybrush, votre nouvel ami.');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Un mois plus tard, papa meurt dans la nuit.');
    readlnE;
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Les ann�es passent. Vous et Guybrush �tes plus proches que jamais. ');
    readlnE;
    setNomSalle('R O U T E  D U  L A C');
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Un jour, alors que vous revenez du lac, Guybrush sur vos pas, vous apercevez trois curieux personnages au bord de la route. Un d�eux s�avance vers vous et vous sourit.');
    readlnE;
    writeln('� Bonjour, mon gar�on. �');
    writeln(' 1. Saluer l''homme');
    writeln(' 2. Ignorer l''homme');
    writeln;
    while not (sortie7) do
      begin
        readln(choix7);
        case (choix7) of
          1:
          begin
            writeln('Derri�re l�homme qui vous a abord�, un tout petit homme avec un curieux accent prend la parole :');
            sortie7 := true;
          end;
          2:
          begin
            writeln('Derri�re l�homme qui vous a abord�, un tout petit homme avec un curieux accent s�avance et vous coupe la route :');
            sortie7 := true;
          end;
          else writeln('MAUVAISE SAISIE');
        end;
      end;

      writeln('� Salut, le jeune. C�est un bien curieux GKM que tu as l� ! �');
      readlnE;
      writeln('Le troisi�me personnage, une dame, r�plique alors :');
      writeln('� Tais-toi J�r�me, laisse faire Matthew. �');
      readlnE;
      writeln('Le leader du groupe continue alors :');
      writeln('� Klarine a raison, J�r�me. Tu risques de faire peur au gar�on. Et surtout � son... GKM... �');
      readlnE;
      writeln('L�homme s�avance vers vous mais son regard reste pos� sur votre ami Guybrush. ');
      writeln('� Je suis Matthew Sermonet et j�enseigne � l��cole de dressage de Geek�mons de Nojid. Tu vas peut �tre penser que je suis stupide de dire tout �a juste avant ce que je m�appr�te � faire,');
      writeln('mais sache que nous formons la TEAM ALGO et que nous sommes intouchables. Contacte les autorit�s si �a te chante, il ne nous arrivera rien. �');
      writeln('Durant tout ce temps, son regard est rest� fix� sur Guy�...');
      readlnE;
      writeln('� Ton GKM est �trange, mon gar�on. Et je le veux, donc je vais le prendre. Je dois l��tudier. Donc tu vas gentiment me le donner sans opposer de r�sistance et il ne t�arrivera rien. �');
      readlnE;
      writeln('Vous n�en croyez pas vos oreilles. Qui sont ces gens ? De soit-disants professeurs qui oeuvrent dans le crime pendant leur cong�s ?!');
      readlnE;
      writeln('Il n�est pas question de vous s�parer de Guybrush, votre meilleur ami. ');
      readlnE;
      writeln('Alors que vous vous appr�tez � dire � Guybrush d�attaquer le leader du groupe, ce dernier sort un... �trange appareil. Vous en avez d�j� vu � la t�l�vision� ');
      readlnE;
      writeln('Il le pointe vers vous. C�est un pistolet ! ');
      readlnE;
      writeln('� Laisse tomber, petit. �');
      readlnE;
      writeln('Guybrush grogne, bouillonne de rage. Matthew Sermonet s�adresse � lui :');
      readlnE;
      writeln('� Toi, reste o� tu es ou je m�occupe de ton pr�cieux ami. Tu vas me suivre sans opposer de r�sistance, � pr�sent. �');
      readlnE;
      writeln('Vous regardez Guybrush, qui vous regarde � son tour. La col�re et la panique se lisent clairement dans ses yeux. Vous entendez un bruit sourd, ressentez une douleur � l�arri�re du cr�ne, puis plus rien.');
      readlnE;
      effacerEcran;
      attendre(2000);
      setNomSalle('? ? ?');
      enteteMenu(false,false,true);
      writeln('D�autres ann�es passent. Vous ne vous �tes jamais vraiment remis d�avoir perdu votre ami. Vous maudissez chaque jour la team ALGO et pr�parez votre revanche. Matthieu Simonet avait raison, la police n�a �t� d�aucun secours.');
      readlnE;
      writeln('Votre seule solution est d�int�grer l��cole de dressage de Geek�mons de Nojid afin de r�cup�rer vous-m�me Guybrush Threepwood. Chaque jour, vous pensez � Guy�, et � votre p�re. Il serait tellement d��u� ');
      readlnE;
      writeln('Mais il ne sert � rien de ruminer aujourd�hui ! Nous sommes en septembre, et c�est le jour de votre rentr�e � l��cole de dressage de Geek�mons ! ');
      readlnE;
      introduction;
  end;

  procedure choixStarter();
  var
    choixGkm, choixConfirm : Integer;  //choix GKM
    sortie, confirmation : boolean;
  begin
    //r�cup�rer donn�es BDD
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
      writeln('3.     ', infoGkm[3][3].nom, '  |      S�rie du m�me nom');
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

    //renvoyer donn�es BDD
    setJoueurGkm(joueurGkm);

    effacerEcran;
  end;

  procedure quete1();
  begin
    quete := getQuete();
    effacerEcran;
    enteteMenu(false,false,true);
    writeln('Alors que vous entrez dans l�ETDDG, vous �tes abord� par un groupe d��tudiants.');
    writeln('� Eh, salut, comment tu t�appelles ? ', infoJoueur.nom ,' ? Content de te conna�tre ! �');
    readlnE;
    writeln('Une fille prend la parole.');
    writeln('� Enchant�e, je suis... �');
    readlnE;
    writeln('Mais elle est coup�e par un autre �tudiant, vout� sur le pc.');
    writeln('� Eh, notre emploi du temps est en ligne !! �');
    readlnE;
    writeln('Les �tudiants se ruent tous sur l�ordinateur, vous suivez le mouvement.');
    writeln('P�niblement, vous parvenez � trouver un petit espace entre les corps agglutin�s autour de l��cran pour voir votre emploi du temps.');
    readlnE;
    writeln('Votre cours se d�roulera en salle R20. Vous ne parvenez pas � lire l�intitul� du cours, mais �a vous importe finalement assez peu.');
    writeln('Vous n��tes pas l� en tant que simple �tudiant, mais pour faire tomber la TEAM ALGO.');
    readlnE;
    writeln('Vous vous dirigez vers le couloir. Vous pourriez rester ici et discuter avec les autres, mais vous n��tes pas l� pour vous faire des amis.');
    writeln('Cela fait des ann�es que vous n�avez pas revu votre meilleur ami, et vous n�avez jamais �t� aussi proche de le retrouver.');
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
    writeln('Vous entrez dans la salle R20 et vous installez sur une chaise. D�autres �tudiants affluent �galement dans la pi�ce, visiblement tr�s excit�s d�avoir leur tout premiers cours. ');
    readlnE;
    writeln('Un gar�on qui semble sympathique vous aborde �galement, mais vous d�cidez de ne pas lui r�pondre.');
    writeln('Bient�t, vous serez sans doute d�sol� de vous �tre comport� de la sorte, mais pour le moment vous avez les yeux riv�s sur la porte.');
    readlnE;
    writeln('Finalement, une femme entre dans la classe.');
    readlnE;
    writeln('Vous la reconnaissez ! Malgr� les ann�es, elle n�a pas beaucoup chang�. Il s�agit �videmment de Klarine Serrure, un des membres de la TEAM ALGO.');
    readlnE;
    writeln('Le cours commence. Il semble s�agir d�un cours de Culture Geek�mon, mais vous �tes incapable de vous concentrer sur ce que dit cette femme.');
    writeln('Elle d�bite, insouciante, � un rythme impressionnant, une succession de syllabes. ');
    readlnE;
    writeln('Vous n�avez qu�une envie : vous lever et vous jeter sur elle. Mais ce serait bien entendu stupide, et vous r�alisez en cet instant que vous n�avez aucun plan. ');
    readlnE;
    writeln('Toutes ces ann�es, vous avez v�cu avec l�objectif d�entrer dans cet �cole et faire tomber la TEAM ALGO. Mais � aucun moment vous ne vous �tes demand� comment vous y prendre, ni m�me si vous en �tiez capable.');
    writeln('En effet, peut-�tre n�en �tes-vous pas capable�');
    readlnE;
    writeln('Non, si c�est le cas, vous devez le devenir. Vous devez �a � Guybrush.');
    readlnE;
    writeln('Klarine Serrure vous tire soudain de vos pens�es : ');
    writeln('� Allez, le cours est termin�, retournez � vos vies mis�rables les geeks. �');
    readlnE;
    writeln('Pendant un moment, les autres �l�ves se demandent s�il s�agissait d�humour. Tout le monde sort de la salle et vous vous demandez quoi faire.');
    writeln('� Eh, mais c�est le cr�tin ! �');
    readlnE;
    writeln('Vous vous retournez. ', nomRival, ' ! Quelles �taient les chances pour qu�il soit dans cette �cole ? Vous d�cidez de l�ignorer.');
    writeln('� Je me demande bien comment tu as pu entrer dans une �cole aussi prestigieuse. Grace � mon p�re, je n�ai eu aucun probl�me � entrer ici, tu vois. �');
    readlnE;
    writeln(nomRival,' n�a d�cid�ment pas chang�. Il ne r�alise m�me pas qu�en vantant les connexions qu�a son p�re, il laisse simplement entendre que le m�rite seul ne lui aurait pas suffit � entrer dans cette �cole.');
    readlnE;
    writeln('Nous sommes dans le milieu de la matin�e et vous n�avez toujours aucune id�e de la suite du plan.');
    writeln('Votre prochain cours est dans une heure et en passant devant la caf�t�ria, vous remarquez que ce lieu semble �tre un lieu de rencontre et de combats entre dresseurs de GKM. Si vous voulez �tre capable de vaincre la TEAM ALGO,');
    writeln('il faut que vous deveniez plus fort.');
    readlnE;
    writeln('Vous d�cidez que vaincre tous les dresseurs pr�sents seraient un excellent moyen tester vos capacit�s.');
    readlnE;
    etatQuete(quete.q02);
    etatQuete(quete.q03);
    setQuete(quete);
  end;

  procedure quete4();
  begin
    quete := getQuete();
    writeln('Vous vous installez sur une chaise de libre en attendant le d�but du cours. ');
    writeln('Vous avez vaincu tous ces dresseurs, vous �tes persuad� d��tre capable de vaincre la TEAM ALGO � pr�sent. Vous attendez patiemment. Vous vous sentez �tonnamment calme, serein, et confiant.');
    readlnE;
    writeln('C�est alors que le professeur entre dans la pi�ce. ');
    readlnE;
    writeln('Le sentiment qui vous ber�ait alors s��vanouit compl�tement.');
    readlnE;
    writeln('Face � vous se dresse Matthew Sermonet, l�homme qui vous arrach�, il y a plusieurs ann�es de cela, votre meilleur ami, le meilleur ami de votre p�re, le GKM dont vous aviez jur� de prendre soin.');
    writeln(' Cet homme qui a g�ch� votre vie se trouve � pr�sent devant vous.');
    readlnE;
    writeln('Vous pensez � vous lever pour lui sauter � la gorge, puis vous vous rendez compte � quel point ce serait stupide. Que se passerait-il ensuite ?');
    readlnE;
    writeln('Non, vous devez attirer toute l�attention de l�homme, le forcer � s�int�resser � vous afin de le faire parler. ');
    readlnE;
    writeln('L�heure passe et le cours se termine.');
    readlnE;
    writeln('Vous avez r�fl�chi et d�cidez que le meilleur moyen d�avoir toute l�attention de Matthew Sermonet est de mettre une racl�e au reste de la TEAM ALGO.');
    readlnE;
    writeln('C�est l�heure du d�jeuner, il ne fait aucun doute que vous pourrez trouver Klarine Serrure et J�r�me Cassoulet � la caf�t�ria. Il est l�heure de mettre votre plan � ex�cution. ');
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
    writeln('Le vacarme fut �norme, tous yeux sont riv�s sur vous. ');
    writeln('� Qu�est-ce que tout cela signifie ? �');
    readlnE;
    writeln('Matthew Sermonet se dresse face � vous, il vous regarde avec fureur. ');
    writeln('Le moment tant attendu se pr�sente enfin. Vous expliquez � Matthew Sermonet pourquoi vous �tes ici. Vous lui d�tes que vous �tes venu trouver un ami qui vous a �t� enlev�.');
    writeln('Tout un tas d�expressions traversent le visage de Matthew Sermonet. Quand il semble enfin comprendre qui vous �tes, il �clate de rire, un rire puissant et diabolique.');
    readlnE;
    writeln('� Pauvre fou ! Venir me d�fier, dans mon propre rep�re?! �');
    readlnE;
    writeln('Vous �tes surpris de le voir parler si ouvertement face � des dizaines d��tudiants. Vous les regardez, aucun ne semble surpris. Ce qu�on lit sur les visages ressemble plus � de l�excitation. ');
    writeln('� A quoi penses-tu mon gar�on ? Pourquoi regardes-tu tes camarades comme �a ? �');
    readlnE;
    writeln('Il y a un moment o� le silence s�installe.');
    readlnE;
    writeln('� Oh. �');
    readlnE;
    writeln('Et Matthew Sermonet se remet � rire de plus belle, d�une voix plus tonitruante que jamais');
    writeln('� A quoi t�attendais-tu en venant ici, hein, mon gar�on ? Qu�est-ce que tu esp�rais en me provoquant face � tous mes �l�ves ? Crois-tu qu�ils ne sachent pas qui je suis ? �');
    readlnE;
    writeln('Les visages autour de vous peu � peu se transforment. Les visages excit�s laissent place � des regards furieux. Vous sentez le poids de leur haine qui vous �touffe.');
    writeln('Vous avez envie de vous enfuir en courant, mais ce n�est pas possible. Pas en �tant si proche du but. ');
    writeln('� C�est un combat que tu veux, c�est ce que tu auras. Pr�pare tes meilleurs GKMs, mon gar�on, car je ne vais pas retenir mes coups ! �');
    readlnE;

    if (dresseurSermonet1) then
    begin
      effacerEcran;
      enteteMenu(false,false,false);
      writeln('� AAAAAAARG ! � ');
      writeln('Matthew Sermonet tombe sur le sol.');
      readlnE;
      writeln('Vous vous approchez de lui. ');
      readlnE;
      writeln('C�est alors que ',nomRival,' s�extirpe de la masse informe d��tudiants et se jette sur vous.');
      readlnE;
      writeln('� Partez, monsieur Sermonet, je retiens ce cr�tin ! �');
      readlnE;
      writeln('Matthew Sermonet saisit l�occasion, il se l�ve p�niblement et s�enfuit en direction des escaliers tandis que vous vous d�battez pour vous sortir de l��treinte de ',nomRival,'.');
      readlnE;
      writeln('Apr�s quelques coups de genoux et autres coups de poings, ',nomRival,' l�che enfin prise. Votre l�vre est ouverte et vous avez le gout m�tallique du sang dans la bouche. Mais qu�importe, vous devez retrouver Matthew Sermonet et en finir.');
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
    writeln('Ce dernier a le visage enfuie dans ce qui semble �tre un coffre-fort. ');
    readlnE;
    writeln('Il en extirpe finalement une GKB. ');
    readlnE;
    writeln('Il la lance au centre de la pi�ce.');
    readlnE;
    writeln('D�abord informe, la silhouette qui appara�t hors de la GKB prend rapidement forme.');
    writeln('Guybrush Threepwood ! ');
    readlnE;
    writeln('Votre souffle se coupe et votre c�ur s�emplit de joie � la vue de votre ami retrouv�. Vous voulez le prendre dans vos bras, mais quelque chose cloche. ');
    writeln('Le regarde de Guy� n�est plus le m�me. Que lui ont fait la TEAM ALGO durant toutes ann�es ? ');
    writeln('� Attaque-le, Guybrush, tu vas n�en faire qu�une bouch�e ! �');
    readlnE;
    writeln('C�est alors que Guybrush vous attaque.');
    readlnE;
    etatQuete(quete.finjeu); //false->true
    setQuete(quete);
    dresseurSermonet2();
    writeln('Guybrush ne fait qu�une bouch�e de vos GKM. Il s�avance alors vers vous.');
    writeln('� Porte lui le coup final, Guybrush ! �');
    readlnE;
    writeln('Ce n�est pas possible ! Jamais un GKM n�a bless� d��tre humain. Si Guy� devait vous porter un coup, ce serait � coup s�r un coup fatal. ');
    writeln('Vous ne reconnaissez pas votre ami qui progresse vers vous. Il l�ve le bras, puis�');
    readlnE;
    writeln('Sa main retombe et se tends vers vous. Vous la saisissez.');
    readlnE;
    writeln('Matthew laisse alors appara�tre une t�l�commande qui �tait cach�e dans sa manche. Il appuie sur un bouton et Guy� est comme �lectris�. Il est pris de l�g�res convulsions puis se retourne vers le chef de la TEAM ALGO, furieux.');
    writeln('� Mais comment est-ce possible ?! Ce lavage de cerveau n�avait jamais failli auparavant ! �');
    readlnE;
    writeln('C�est vers Matthew Sermonet que Guy� s�avance � pr�sent. ');
    writeln('Puis Guy� se retourne et vous regarde.');
    writeln('C�est le moment de faire un ultime choix. Quel sera-t-il ?');
    while not(sortie) do
    begin
      writeln(' 1.  Attaquer Matthew Sermonet');
      writeln(' 2.  Epargner Mattew Sermonet');
      readln(choix);
      case choix of
        1:
        begin
          writeln('Guy� porte un ultime coup au chef de la TEAM ALGO qui s�effondre sur le dos, inerte.');
          readlnE;
          writeln('Vous avez vaincu la TEAM ALGO et r�cup�r� votre ami, mais � quel prix ? Vous rentrez chez vous, accompagn� de Guy�.');
          readlnE;
          writeln('Si vous vous sentez heureux en franchissant le seuil de votre porte, vous savez que le choix que vous avez pris restera � jamais grav� en vous.');
          sortie := true;
        end;
        2:
        begin
          writeln('Guy� assomme le chef de la TEAM ALGO et, une demi-heure plus tard, le voil� menott� par la police. Vous avez vaincu la TEAM ALGO et r�cup�r� votre ami, mais Matthew Sermonet ne restera pas bien longtemps en prison.');
          writeln('Ses relations lui permettent de sortir apr�s quelques jours et, malgr� la joie que vous avez d�avoir retrouv� votre ami, vous vivez chaque jour avec la peur de croiser � nouveau la route de trois curieux personnages.');
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
    writeln('� Eh, gros noob ! �');
    readlnE;
    writeln('Vous vous retourner. Encore NOMRIVAL. Quand vous �tiez plus jeune, vous preniez ses insultes tr�s � c�ur, mais vous avez bien plus important � vous soucier aujourd�hui.');
    readlnE;
    writeln('Th�r�se intervient.');
    writeln('� Surveille ton langage, jeune homme. Pas ce �a dans mon bureau. Si vous voulez vous chamailler, c�est dehors. Allez, hop ! �');
    readlnE;
    writeln('Vous voil� � nouveau dans le couloir.');
    writeln('� Pff, quelle vieille peau. �');
    readlnE;
    writeln('� Alors, t�as d�j� eu ton premier GKM ? �');
    readlnE;

    while not(sortie) do
    begin
      writeln(' 1.  Dire la v�rit�');
      writeln(' 2.	Mentir');
      readln(choix);

      case choix of
        1:
        begin
          writeln('� Super, moi aussi ! T�as pas le choix, du coup,', infoJoueur.nom, ' tu vas devoir te mesurer � moi. Je vais te ridiculiser, ah ! �');
          dresseurRival1();
          sortie := true;
        end;
        2:
        begin
          writeln('� Pff, t�es vraiment � la tra�ne, cr�tin. Presque tout le monde dans la classe est all� choisir le sien. Allez, ciao le naze. �');
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

    writeln(nomRival, ' repart de son c�t� et vous pouvez enfin vous concentrer � nouveau sur votre qu�te.');
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
    writeln('Alors que vous explorez cette salle de classe � la recherche d�un GKM sauvage � affronter, vous �tes surpris de remarquer une ombre au fond de la pi�ce sombre. La silhouette s�av�re �tre cette de ',nomRival,'. Il vous remarque et dit d�une voix chevrotante.');
    readlnE;
    writeln('� Qu�est-ce que tu fais l�, cr�tin ? Laisse-moi tranquille ! �');
    readlnE;
    writeln('Vous vous appr�tez � quitter la pi�ce quand ',nomRival,' ajoute.');
    writeln('� Non,',infoJoueur.nom,' attends ! � ');
    readlnE;
    writeln(nomRival,' sort de l�ombre et s�avance vers vous. Son air d�pit� et ses yeux ronges et gonfl�s indiquent que quelque chose ne va pas du tout. Vous ne l�aviez jamais vu dans cet �tat. ');
    writeln('� Je...je... �');
    readlnE;
    writeln('� Non, rien, laisse tomber. �');

    while not(sortie1) do
    begin
      writeln(' 1.  Demander ce qui ne va pas');
      writeln(' 2.  Sortir ');
      readln(choix1);
      if choix1 = 1 then
      begin
        writeln('� Je ne me sens pas � ma place ici. � ');
        readlnE;
        writeln('� Je suis entr� gr�ce � papa, mais depuis ce matin, je suis compl�tement perdu. J�ai d�fi� un bon nombre d��tudiant en combat, et ils m�ont tous mis une racl�e. �');
        readlnE;
        writeln(nomRival,' garde les yeux fix�s vers le sol.');
        writeln('� Je d�teste avoir � te demander �a mais... tu veux bien te battre contre moi ? Pour l�entrainement, j�entends. � ');

        while not(sortie11) do
        begin
          writeln(' 1.  Accepter');
          writeln(' 2.  Refuser');
          readln(choix11);
          if choix11 = 1 then
          begin
            writeln('� Merci, ', infoJoueur.nom, ', merci... �');
            readlnE;
            dresseurRival2();
            sortie1 := true;
            sortie11 := true;
          end
          else if (choix11 <> 1) and (choix11 <> 2) then writeln('MAUVAISE SAISIE')
          else
          begin
            writeln('Vous n''avez certainement pas de temps � perdre avec ', nomRival,'.');
            writeln('Vous d�cidez de sortir de la pi�ce dans un regard de plus pour lui.');
            readlnE;
            sortie1 := true;
            sortie11 := true;
          end;
        end;
      end
      else if (choix1 <> 1) and (choix1 <> 2) then writeln('MAUVAISE SAISIE')
      else
      begin
        writeln('Vous n''avez certainement pas de temps � perdre avec ', nomRival,'.');
        writeln('Vous d�cidez de sortir de la pi�ce dans un regard de plus pour lui.');
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
