unit Combat;

interface
  uses
    BDD,
    Dresseurs,
    GestionEcran;

  function rencontre(probaRencontre : Integer ; difficulte : Integer) : Boolean;
  procedure combatS(difficulte : Integer);
  function combatD() : Boolean;
  function initiativeSpd(spdJ : Integer ; spdA : Integer) : Boolean;
  function attaquer(atk : Integer) : Integer;
  function seDefendre(def : Integer) : Integer;
  function attraper(pv : Real; pvMax : Real) : Boolean;
  function utiliserPotion() : Boolean;
  procedure enteteCombat(lvl, indGkmEnnemi, indGkmJ, pvEnnemi, pvJ : Integer; sauvage : Boolean);
  function envoyerNvGkm (combatDresseur : Boolean) : Integer;
  procedure recevoirXp(xp : Integer ; dresseur : Boolean);

  //FONCTION GET
  function getDernGkmUtilise(): Integer;

  //PROCEDURE SET
  procedure setDernGkmUtilise(dernGkmUtiliseP : Integer);

implementation
  uses
    Salles, Menus;

  var
    dernGkmUtilise : Integer; //stocke l'indice de joueurGkm du dernier GKM utilisé
    infoGkm : TabInfoGkm;
    joueurGkm : TabJoueurGkm;
    infoJoueur : Joueur;
    nomSalle : String;
    succes : TSucces;
    critJoueur : Boolean; //indique si le coup critique est infligé par le joueur
    quete : TQuete;

  function rencontre(probaRencontre : Integer ; difficulte : Integer) : Boolean;
    var
      nbAlea : Integer;  //stocke nb aléa 1-100
    begin
      randomize;
      nbAlea := random (100) + 1;

      if nbAlea < probaRencontre then
      begin
        combatS(difficulte); //lance le combat
        rencontre := true;
      end
      else
      begin
        rencontre := false;
      end;

    end;

  procedure combatS(difficulte : Integer);
    var
      indGkm : Integer;  //indice du GKM sauvage
      lvl : Integer; //niveau du GKM sauvage
      pvS, pvMaxS, pvJ, pvMaxJ : Integer;   //pv/pvMax du GKM sauvage (S) et du joueur (J)
      pDDeg : Integer; //points de dégats infligés
      pDDef : Integer; //points de défenses, réduisent les dégats subits au tour suivant
      initiative : Boolean; //détermine le tour. true=joueur / false=ennemi
      sortieAttraper : Boolean; //détermine si le GKM est capturé -> fin du combat
      sortieFuite : Boolean; //si fuite succès -> fin du combat
      choix : Integer;
      nouveauRound : Integer; //valeur renvoyée par la fonction envoyerNvGkm, détermine
                                //si un nouveau round a lieu selon le choix du joueur
                                //et s'il lui reste des GKMs en vie
      finCombat : Boolean; //défini si le combat se termine

    begin
      //INITIALISATION
      //récupérer données BDD
      infoGkm := getInfoGkm();
      infoJoueur := getInfoJoueur();
      joueurGkm := getJoueurGkm();
      nomSalle := getNomSalle();

      effacerEcran;
      enteteMenu(false,false,false);

      randomize;
      //niveau gkm sauvage aléatoire
      if difficulte = 1
      then lvl := random(3) + 1      //1 à 3

      else if difficulte = 2
      then lvl := random(4) + 4   //4 à 7

      else lvl := random(3) + 8;    //8 à 10

      //selection aléat GKM indice 4 à max (exclusion starter)
      indGkm := random(high(infoGKM[1])-3) +3;

      finCombat := false;
      sortieAttraper := false;
      sortieFuite := false;
      choix := 0;
      pvMaxS := infoGkm[lvl][indGkm].pv;
      pvS := pvMaxS;
      pvMaxJ := joueurGkm[dernGkmUtilise].pvMax;
      pvJ := joueurGkm[dernGkmUtilise].pv;
      pDDeg := 0;
      pDDef := 0;


      writeln('Un Geekemon sauvage apparaît !');
      writeln;
      writeln(infoGkm[lvl][indGkm].nom, ' sauvage semble féroce!');
      readlnE;
      writeln('...');
      writeln;
      writeln(joueurGkm[dernGkmUtilise].nom, ', en avant !');
      readlnE;
      effacerEcran();

      repeat      //fin combat
        initiative := initiativeSpd(joueurGkm[dernGkmUtilise].spd, infoGkm[lvl][indGkm].spd);

        repeat      //fin round
          enteteMenu(false, true,false);
          enteteCombat(lvl, indGkm, dernGkmUtilise, pvS, pvJ, true);
          joueurGkm := getJoueurGkm();

          if initiative = true then         //tour du joueur
          begin
            writeln('Que souhaitez-vous faire ?');
            writeln('1. Attaquer      2. Se défendre      3. Utiliser une potion     4. Lancer une Geekéball      5. Fuir');
            readln(choix);

            if choix = 1 then  //ATTAQUER
            begin
              writeln(joueurGkm[dernGkmUtilise].nom, ' attaque de toutes ses forces !');
              readlnE;
              critJoueur := true;
              pDDeg := attaquer(joueurGkm[dernGkmUtilise].atk); //calcul pdd
              pvS := pvS - pDDeg;
              if pDDeg = 0 then
              begin
                writeln('Son attaque a échouée !');
              end
              else
              begin
                writeln('Il inflige ', pDDeg, ' points de dégât !');
                if pvS < 0 then
                  pvS := 0;
              end;

              critJoueur := false;
              initiative := false;
            end

            else if choix = 2 then  //SE DEFENDRE
            begin
              writeln('Vous vous défendez!');
              pDDef := seDefendre(joueurGkm[dernGkmUtilise].def);
              initiative := false;
            end

            else if choix = 3 then    //UTILISER POTION
            begin
              if utiliserPotion() then
              begin
                pvJ := joueurGkm[dernGkmUtilise].pv;
                initiative := false;
              end;
              setInfoJoueur(infoJoueur);
            end

            else if choix = 4 then  //ATTRAPER
            begin
              if infoJoueur.nbGeekeball > 0 then
              begin
                writeln('Vous lancez une GKB en direction de ', infoGkm[lvl][indGkm].nom, ' !');
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
                if attraper(pvS, pvMaxS) = true then
                begin
                  writeln('*clic*');
                  readlnE;
                  writeln('Félicitation, vous avez attrapé ', infoGkm[lvl][indGkm].nom, ' sauvage !');
                  ajoutGkm(lvl, indGkm, pvS);
                  sortieAttraper := true;

                  joueurGkm := getJoueurGkm();
                end
                else
                begin
                  writeln('Oh, non ! ', infoGkm[lvl][indGkm].nom, ' sauvage est sorti de la GKB !');
                  initiative := false;
                end;

                infoJoueur.nbGeekeball := infoJoueur.nbGeekeball - 1;
                setInfoJoueur(infoJoueur);
              end
              else
                writeln('Vous n''avez pas de Geekéball.');
            end

            else if choix = 5 then  //FUIR
            begin
              writeln('Vous tentez de prendre la fuite !');
              readlnE;
              if random(3) = 0 then //echec fuite (1 chance sur 3)
              begin
                writeln(infoGkm[lvl][indGkm].nom, ' vous bloque le chemin !');
                initiative := false;
              end
              else
              begin
                writeln('Vous fuyez le combat.');
                sortieFuite := true;
              end;
            end

            else      //MAUVAISE SAISIE
            begin
              writeln('MAUVAISE SAISIE');
            end;

            readlnE;
            effacerEcran();
          end

          else            //tour de l'adversaire
          begin
            writeln(infoGkm[lvl][indGkm].nom, ' sauvage attaque !');
            readlnE;

            pDDeg := attaquer(infoGkm[lvl][indGkm].atk);

            if pDDeg = 0 then
            begin
              writeln('L''attaque échoue !');
            end

            else
            begin
              pDDeg := pDDeg - pDDef;
              if pDDeg < 0 then
                pDDeg := 0;

              pvJ := pvJ - pDDeg;
              writeln(joueurGkm[dernGkmUtilise].nom, ' subit ', pDDeg, ' points de dégats !');
              if pvJ < 0 then
                pvJ := 0
            end;

            pDDef := 0;
            readlnE;
            effacerEcran();

            initiative := true;
          end;

          joueurGkm[dernGkmUtilise].pv := pvJ;
        until (pvS = 0) OR (sortieAttraper) OR (sortieFuite) OR (pvJ = 0);

        enteteMenu(false,false,false);

        if pvS = 0 then   //VICTOIRE
        begin
          writeln(infoGkm[lvl][indGkm].nom, ' s''effondre sur le sol.');
          readlnE;
          recevoirXp(infoGkm[lvl][indGkm].xpGive, false);
          writeln('Vous avez vaincu ', infoGkm[lvl][indGkm].nom, ' sauvage!');
          readlnE;
          writeln;
          infoJoueur.gkmVaincu := infoJoueur.gkmVaincu + 1;
          //VERIF SUCCES OBTENU
          if infoJoueur.gkmVaincu = 10 then
          begin
            succes := getSucces();
            etatSucces(succes.gkm10); //false->true
            setSucces(succes);
          end;
          if infoJoueur.gkmVaincu = 50 then
          begin
            succes := getSucces();
            etatSucces(succes.gkm50); //false->true
            setSucces(succes);
          end;
          finCombat := true;
        end

        else if pvJ = 0 then             //GKM JOUEUR VAINCU
        begin
          writeln(joueurGkm[dernGkmUtilise].nom, ' a été vaincu !');
          setJoueurGkm(joueurGkm);
          writeln;

          nouveauRound := envoyerNvGkm(false);

          if nouveauRound = -1 then     //COMBAT PERDU
            begin
              writeln('Tous vos Geekémons ont été mis hors-combats, vous vous évanouissez...');
              finCombat := true;
            end
          else if nouveauRound = -2 then     //FUITE
            begin
              writeln('Vous fuyez le combat.');
              finCombat := true;
            end

          else                            //NOUVEAU ROUND AVEC UN AUTRE GKM JOUEUR
          begin
            dernGkmUtilise := nouveauRound;
            pvJ := joueurGkm[dernGkmUtilise].pv;
            writeln;
            writeln(joueurGkm[dernGkmUtilise].nom, ', en avant !');
            pvMaxJ := joueurGkm[dernGkmUtilise].pvMax;
            readlnE;
            effacerEcran();
          end;

          readlnE;
        end

        else     //GKM SAUVAGE ATTRAPE
        begin
          finCombat := true;
        end

      until finCombat = true;

      //renvoyer données BDD
      setInfoJoueur(infoJoueur);
      setJoueurGkm(joueurGkm);

      if nouveauRound = -1 then   //INFIRMERIE
      begin
        infirmerie();
      end;
    end;

  function combatD() : Boolean;
  var
      indGkm : Integer;  //indice du GKM dresseur
      lvl : Integer; //niveau du GKM dresseur
      pvD, pvMaxD, pvJ, pvMaxJ : Integer;   //pv/pvMax du GKM dresseur (D) et du joueur (J)
      pDDeg : Integer; //points de dégats infligés
      pDDef : Integer; //points de défenses, réduisent les dégats subits au tour suivant
      initiative : Boolean; //détermine le tour. true=joueur / false=ennemi
      choix : Integer;
      nouveauRound : Integer; //valeur renvoyée par la fonction envoyerNvGkm, détermine
                                //si un nouveau round a lieu selon le choix du joueur
                                //et s'il lui reste des GKMs en vie
      finCombat : Boolean; //défini si le combat se termine
      infoDresseur : Dresseur;

  begin
    //INITIALISATION
    //récupérer données unité Dresseurs
    infoDresseur := getInfoDresseur();
    //récupérer données BDD
    infoJoueur := getInfoJoueur();
    joueurGkm := getJoueurGkm();
    infoGkm := getInfoGkm();

    effacerEcran;
    enteteMenu(false, false,false);
    randomize;
    finCombat := false;
    choix := 0;
    indGkm := infoDresseur.gkm1.id; //indice du premier GKM du dresseur
    pvMaxD := infoDresseur.gkm1.pv;
    pvD := pvMaxD;
    pvMaxJ := joueurGkm[dernGkmUtilise].pvMax;
    pvJ := joueurGkm[dernGkmUtilise].pv;
    pDDeg := 0;
    pDDef := 0;

    writeln('Le dresseur ', infoDresseur.nom, ' vous défie !');
    writeln(infoDresseur.nom, ' envoie ', infoDresseur.gkm1.nom, ' au combat !');
    readlnE;
    writeln('...');
    writeln;
    writeln(joueurGkm[dernGkmUtilise].nom, ', go !');
    readlnE;
    effacerEcran();

    repeat      //fin combat
      lvl := infoDresseur.gkm1.lvl;
      initiative := initiativeSpd(joueurGkm[dernGkmUtilise].spd, infoGkm[lvl][indGkm].spd);

      repeat      //fin round
        enteteMenu(false,true,false);
        enteteCombat(lvl, indGkm, dernGkmUtilise, pvD, pvJ, false);

        if initiative = true then         //tour du joueur
        begin
          writeln('Que souhaitez-vous faire ?');
          writeln('1. Attaquer      2. Se défendre      3. Utiliser une potion      4.Lancer une Geekéball      5. Fuir');
          readln(choix);

          if choix = 1 then  //ATTAQUER
          begin
            writeln(joueurGkm[dernGkmUtilise].nom, ' attaque de toutes ses forces !');
            critJoueur := true;
            pDDeg := attaquer(joueurGkm[dernGkmUtilise].atk); //calcul pdd
            pvD := pvD - pDDeg;
            readlnE;
            if pDDeg = 0 then
            begin
              writeln('Son attaque a échouée !');
            end
            else
            begin
              writeln('Il inflige ', pDDeg, ' points de dégât !');
              if pvD < 0 then
                pvD := 0;
            end;

            critJoueur := false;
            initiative := false;
          end

          else if choix = 2 then  //SE DEFENDRE
          begin
            writeln('Vous vous défendez!');
            pDDef := seDefendre(joueurGkm[dernGkmUtilise].def);
            initiative := false;
          end

          else if choix = 3 then    //UTILISER POTION
          begin
            if utiliserPotion() then
            begin
              pvJ := joueurGkm[dernGkmUtilise].pv;
              initiative := false;
            end;
            setInfoJoueur(infoJoueur);
          end

          else if choix = 4 then  //ATTRAPER
          begin
            if infoJoueur.nbGeekeball > 0 then
            begin
              writeln('Vous lancez une GKB en direction de ', infoGkm[lvl][indGkm].nom, ' !');
              readlnE;
              writeln(infoDresseur.nom, ' s''avance et dévie votre GKB !');
              readlnE;
              writeln;
              writeln(infoDresseur.nom, ' : "Eh! Qu''est ce que tu fais ?!"');
              readlnE;
              infoJoueur.nbGeekeball := infoJoueur.nbGeekeball - 1;
              setInfoJoueur(infoJoueur);
            end;
              writeln('Vous ne pouvez pas attraper un GKM qui appartient déjà à un dresseur.');
              initiative := false;
          end

          else if choix = 5 then      //FUIR
          begin
            writeln('Vous ne pouvez pas fuir un combat de dresseurs !');
          end

          else      //MAUVAISE SAISIE
          begin
            writeln('MAUVAISE SAISIE');
          end;

          readlnE;
          effacerEcran();

        end

        else            //tour de l'adversaire
        begin
          pDDeg := attaquer(infoGkm[lvl][indGkm].atk);

          writeln(infoGkm[lvl][indGkm].nom, ' ennemi attaque !');
          readlnE;

          if pDDeg = 0 then
          begin
            writeln('L''attaque échoue !');
          end

          else
          begin
            pDDeg := pDDeg - pDDef;
            if pDDeg < 0 then
              pDDeg := 0;

            pvJ := pvJ - pDDeg;
            writeln(joueurGkm[dernGkmUtilise].nom, ' subit ', pDDeg, ' points de dégats !');
            if pvJ < 0 then
              pvJ := 0
          end;

          pDDef := 0;
          readlnE;
          effacerEcran();

          initiative := true;
        end;

        joueurGkm[dernGkmUtilise].pv := pvJ;
      until (pvD = 0) OR (pvJ = 0);

      if pvD = 0 then   //NOUVEAU GKM DRESSEUR
      begin
        enteteMenu(false,false,false);
        writeln(infoGkm[lvl][indGkm].nom, ' s''effondre sur le sol.');
        infoJoueur.gkmVaincu := infoJoueur.gkmVaincu + 1;
        //VERIF SUCCES OBTENU
        if infoJoueur.gkmVaincu = 10 then
        begin
          succes := getSucces();
          etatSucces(succes.gkm10); //false->true
          setSucces(succes);
        end;
        if infoJoueur.gkmVaincu = 50 then
        begin
          succes := getSucces();
          etatSucces(succes.gkm50); //false->true
          setSucces(succes);
        end;
        readlnE;
        recevoirXp(infoGkm[lvl][indGkm].xpGive, true);
        joueurGkm := getJoueurGkm();

        begin
          if (infoDresseur.gkm2.id <> 0) then
          begin
            indGkm := infoDresseur.gkm2.id;
            lvl := infoDresseur.gkm2.lvl;
            pvMaxD := infoDresseur.gkm2.pv;
            pvD := pvMaxD;
            infoDresseur.gkm2 := infoGkm[1][0];
            writeln('Mais ', infoDresseur.nom, ' n''a pas dit sont dernier mot !');
            readlnE;
            if infoDresseur.sexe = 'F'
            then write('Elle ')
            else write('Il ');
            writeln('envoie ', infoGkm[lvl][indGkm].nom, ' sur le terrain !');
            readlnE;
            effacerEcran;
          end
          else if (infoDresseur.gkm3.id <> 0) then
          begin
            indGkm := infoDresseur.gkm3.id;
            lvl := infoDresseur.gkm3.lvl;
            pvMaxD := infoDresseur.gkm3.pv;
            pvD := pvMaxD;
            infoDresseur.gkm3 := infoGkm[1][0];
            writeln('Mais ', infoDresseur.nom, ' n''a pas dit sont dernier mot !');
            readlnE;
            if infoDresseur.sexe = 'F'
            then write('Elle ')
            else write('Il ');
            writeln('envoie ', infoGkm[lvl][indGkm].nom, ' sur le terrain !');
            readlnE;
            effacerEcran;
          end
          else if infoDresseur.gkm4.id <> 0 then
          begin
            indGkm := infoDresseur.gkm4.id;
            lvl := infoDresseur.gkm4.lvl;
            pvMaxD := infoDresseur.gkm4.pv;
            pvD := pvMaxD;
            infoDresseur.gkm4 := infoGkm[1][0];
            writeln('Mais ', infoDresseur.nom, ' n''a pas dit sont dernier mot !');
            readlnE;
            if infoDresseur.sexe = 'F'
            then write('Elle ')
            else write('Il ');
            writeln('envoie ', infoGkm[lvl][indGkm].nom, ' sur le terrain !');
            readlnE;
            effacerEcran;
          end
          else
          begin
            effacerEcran;
            enteteMenu(false,false,false);
            writeln('Tous les GKMs de ', infoDresseur.nom, ' sont hors-jeux !');
            readlnE;
            writeln('Vous avez vaincu ', infoDresseur.nom, ' !');
            readlnE;
            writeln(infoDresseur.nom, ' : ', infoDresseur.defaite);
            readlnE;
            writeln('Vous gagnez ', infoDresseur.argent, ' Bitcoins.');
            readlnE;
            infoJoueur.dressVaincu := infoJoueur.dressVaincu + 1;
            if infoJoueur.dressVaincu = 5 then
            begin
              succes := getSucces();
              etatSucces(succes.drss5); //false->true
              setSucces(succes);
            end;
            if infoJoueur.dressVaincu = 10 then
            begin
              succes := getSucces();
              etatSucces(succes.drss10); //false->true
              setSucces(succes);
            end;
            combatD := true;
            infoJoueur.argent := infoJoueur.argent + infoDresseur.argent;
            finCombat := true;
          end;

          initiative := true;

        end;
      end

      else if pvJ = 0 then             //GKM JOUEUR VAINCU
      begin
        writeln(joueurGkm[dernGkmUtilise].nom, ' a été vaincu !');
        setJoueurGkm(joueurGkm);
        writeln;
        nouveauRound := envoyerNvGkm(true);

        if nouveauRound = -1 then     //COMBAT PERDU
        begin
          quete := getQuete();
          if not(quete.finjeu) then
          begin
            writeln(infoDresseur.nom, ' : ', infoDresseur.victoire);
            readlnE;
            writeln;
            writeln('------------------------');
            writeln('Tous vos Geekémons ont été mis hors-combat, vous vous évanouissez...');
            readlnE;
            combatD := false;
            infirmerie();
            finCombat := true;
          end
          else
          begin
            finCombat := true;
          end;
        end
        else                            //NOUVEAU ROUND AVEC UN AUTRE GKM
        begin
          dernGkmUtilise := nouveauRound;
          pvJ := joueurGkm[dernGkmUtilise].pv;
          writeln;
          writeln(joueurGkm[dernGkmUtilise].nom, ', en avant !');
          pvMaxJ := joueurGkm[dernGkmUtilise].pvMax;
          readlnE;
          effacerEcran();
        end;
      end

    until finCombat = true;

    //renvoyer données BDD
    setInfoJoueur(infoJoueur);
    setJoueurGkm(joueurGkm);
  end;

  function initiativeSpd(spdJ : Integer ; spdA : Integer) : Boolean; //true: initiative Joueur ; false: initiative Adversaire
  begin
    if spdJ >= spdA
    then initiativeSpd := true
    else initiativeSpd := false;
  end;

  function attaquer(atk : Integer) : Integer;  //fonction qui renvoie le nb de PDD infligés
  var
    echec : Integer; //chance d'infliger 0 pdd
    coupCrit : Integer; //chance d'infliger un coup critique
    minAtk : Integer; //seuil mini PDD
    maxAtk : Integer; //seuil maxi PDD
  begin
    randomize;
    echec :=  random(100) + 1;
    coupCrit := random(100) + 1;

    //seuil : +/- 20% ATK
    minAtk := round(atk * 0.8);
    maxAtk := round(atk * 1.2);

    if echec < 15 then           //15% chance echec
    begin
      attaquer := 0;
    end

    else
    begin
      if coupCrit < 10 then  //10% chance critique
      begin
        attaquer := Round(random(maxAtk - minAtk + 1) + minAtk * 1.5); //coup critique : ATK +/- 50%
        writeln('Coup critique !');
        if critJoueur then infoJoueur.nbCrit := infoJoueur.nbCrit + 1;
        //VERIF SUCCES CP CRIT
        if (infoJoueur.nbCrit = 50) then
        begin
          succes := getSucces();
          etatSucces(succes.cpCrit); //false->true
          setSucces(succes);
        end;

      end
      else
      begin
        attaquer := random(maxAtk - minAtk + 1) + minAtk; //attaque normale : ATK +/- 20%
      end;
    end;
  end;

  function seDefendre(def : Integer) : Integer;  //fonction qui renvoie le nb de PDDef
  var
    minDef : Integer; //seuil mini PDDef
    maxDef : Integer; //seuil maxi PDDef

  begin
    randomize;
    //seuil : =/- 50% DEF
    minDef := round(def * 0.5);
    maxDef := def;
    seDefendre := random(maxDef - minDef + 1) + minDef; //defense: DEF =/- 50%
  end;

  function attraper(pv : Real; pvMax : Real) : Boolean;
  var
    proba : Real; //proba d'attraper le GKM, en %
    probaInt : Integer;
  begin
    randomize;
    proba := (pv / pvMax) * 100 - 15;   //+ 15% chances
    if proba < random(100)+1 then
      begin
        attraper := true;
        infoJoueur.nbAttr := infoJoueur.nbAttr + 1;
        if infoJoueur.nbAttr = 1 then
        begin
          succes := getSucces();
          etatSucces(succes.gkmAttr); //false->true
          setSucces(succes);
        end;
      end
    else
      begin
        attraper := false;
      end;
  end;

  function utiliserPotion() : Boolean;     //UTILISATION D'UNE POTION
  var
    choix : Integer;
  begin
    choix := 0;
    if infoJoueur.nbPotion > 0 then
    begin
      while (choix <> 1) AND (choix <> 2) do
      begin
        writeln('Vous avez ', infoJoueur.nbPotion, ' potion(s) dans votre sac.');
        writeln('Voulez-vous utiliser une potion sur ', joueurGkm[dernGkmUtilise].nom, ' ?');
        writeln('1. Oui     2. Non');
        readln(choix);

        if choix = 1 then
        begin
          joueurGkm[dernGkmUtilise].pv := joueurGkm[dernGkmUtilise].pv + 50;
          writeln(joueurGkm[dernGkmUtilise].nom, ' récupère 50 PVs !');

          if joueurGkm[dernGkmUtilise].pv > joueurGkm[dernGkmUtilise].pvMax then
          begin
            joueurGkm[dernGkmUtilise].pv := joueurGkm[dernGkmUtilise].pvMax;
          end;

          infoJoueur.nbPotion := infoJoueur.nbPotion -1;
          utiliserPotion := true;
        end

        else if (choix <> 1) AND (choix <> 2) then
        begin
          writeln('MAUVAISE SAISIE');
          readlnE;
        end

        else
        begin
          utiliserPotion := false;
          writeln('Vous n''utilisez pas de potion.');
        end;
      end;
    end

    else
    begin
      writeln('Vous n''avez pas de potion sur vous !');
      utiliserPotion := false;
    end;
  end;

  {procedure statutGkm(lvl, indGkmEnnemi, indGkmJ, pvEnnemi, pvMaxEnnemi, pvJ, pvMaxJ : Integer; sauvage : Boolean);
  begin
    if sauvage = true then  //AFFICHAGE COMBATS GKM SAUVAGE
    begin
      writeln('> ', infoGkm[lvl][indGkmEnnemi].nom, ' sauvage lvl ', lvl, ' : ', pvEnnemi, '/', pvMaxEnnemi, ' PVs');
      writeln(joueurGkm[indGkmJ].nom, ' lvl ', joueurGkm[indGkmJ].lvl, ' : ', pvJ, '/', pvMaxJ, ' PVs <');
      writeln('------');
      writeln;
    end
    else        //AFFICHACHE COMBATS GKM DRESSEUR
    begin
      writeln('> ', infoGkm[lvl][indGkmEnnemi].nom, ' : ', pvEnnemi, '/', pvMaxEnnemi, ' PVs');
      writeln(joueurGkm[indGkmJ].nom, ' : ', pvJ, '/', pvMaxJ, ' PVs <');
      writeln('------');
      writeln;
    end;
  end;  }

  procedure enteteCombat(lvl, indGkmEnnemi, indGkmJ, pvEnnemi, pvJ : Integer; sauvage : Boolean);
  var
    ecrirePos : coordonnees;
  begin
    infoGkm := getInfoGkm();
    joueurGkm := getJoueurGkm;
    ecrirePos.x := 6;
    ecrirePos.y := 2;
    dessinerCadreXY(4,1,28,5,simple,15,0);
    dessinerCadreXY(23,4,47,8,simple,15,0);
    ecrireEnPosition(ecrirePos, infoGkm[lvl][indGkmEnnemi].nom);
    ecrirePos.y := ecrirePos.y + 1;
    deplacerCurseur(ecrirePos);
    writeln('lvl. ', infoGkm[lvl][indGkmEnnemi].lvl);
    ecrirePos.y := ecrirePos.y + 1;
    deplacerCurseur(ecrirePos);
    writeln(' ', pvEnnemi,'/',infoGkm[lvl][indGkmEnnemi].pvMax);
    ecrirePos.x := 25;
    ecrirePos.y := 5;
    ecrireEnPosition(ecrirePos, joueurGkm[indGkmJ].nom);
    ecrirePos.y := ecrirePos.y + 1;
    deplacerCurseur(ecrirePos);
    writeln('lvl. ', joueurGkm[indGkmJ].lvl);
    ecrirePos.y := ecrirePos.y + 1;
    deplacerCurseur(ecrirePos);
    writeln(' ', pvJ,'/',joueurGkm[indGkmJ].pvMax);
    writeln;
    writeln;
  end;

  function envoyerNvGkm (combatDresseur : Boolean) : Integer;
  var
    choix1 : Integer; //envoyer un nv gkm ou pas
    choix2 : Integer; // quel GKM envoyer
    indGkm : Integer;
  begin
    choix1 := 0;
    choix2 := 0;
    indGkm := 0;

    if (joueurGkm[0].pv = 0) AND (joueurGkm[1].pv = 0) AND (joueurGkm[2].pv = 0) AND (joueurGkm[3].pv = 0) then
    begin
      envoyerNvGkm := -1; //tous morts
    end

    else
    begin
      repeat
        if combatDresseur = false then
        begin
          writeln('Envoyer un nouveau Geekemon au combat ?');
          writeln('1. Oui     2. Non');
          readln(choix1);
        end

        else
        begin
          writeln('Vous devez envoyer un autre GKM au combat.');
          readlnE;
          choix1 := 1;
        end;

        if choix1 = 1 then
        begin
          repeat
            writeln('Quel GKM envoyer ?');
            if joueurGkm[0].id <> 0 then
              writeln('1. ', joueurGkm[0].nom, ' ', joueurGkm[0].pv, '/', joueurGkm[0].pvMax );
            if joueurGkm[1].id <> 0 then
              writeln('2. ', joueurGkm[1].nom, ' ', joueurGkm[1].pv, '/', joueurGkm[1].pvMax );
            if joueurGkm[2].id <> 0 then
              writeln('3. ', joueurGkm[2].nom, ' ', joueurGkm[2].pv, '/', joueurGkm[2].pvMax );
            if joueurGkm[3].id <> 0 then
              writeln('4. ', joueurGkm[3].nom, ' ', joueurGkm[3].pv, '/', joueurGkm[3].pvMax );
            readln(choix2);
            indGkm := choix2 - 1;

            if joueurGkm[indGkm].id = 0 then
              choix2 := 0
            else if joueurGkm[indGkm].pv = 0 then
              begin
              writeln('Ce GKM n''est pas en état de combattre.');
              choix1 := 0;
              readlnE;
              effacerEcran();
              enteteMenu(false,true,false)
              end
            else
            begin
              envoyerNvGkm := indGkm;
            end;
          until (choix2 = 1) OR (choix2 = 2) OR (choix2 = 3) OR (choix2 = 4);
        end

        else if choix1 = 2 then
        begin
          envoyerNvGkm := -2;   //fin combat
          if joueurGkm[0].pv > 0
          then dernGkmUtilise := 0
          else if joueurGkm[1].pv > 0
          then dernGkmUtilise := 1
          else if joueurGkm[2].pv > 0
          then dernGkmUtilise := 2
          else dernGkmUtilise := 3;
        end

        else
          writeln('Mauvaise saisie');
      until (choix1 = 1) OR (choix1 = 2);
    end;
  end;

  procedure recevoirXp(xp : Integer ; dresseur : Boolean);
  var
    finRecevoirXp : Boolean;
    resteXp : Integer; //supplément d'xp quand lvl up
    coordCadre : coordonnees;
    ecrirePos : coordonnees;
  begin
    finRecevoirXp := false;
    writeln(joueurGkm[dernGkmUtilise].nom, ' reçoit ', xp, ' points d''expériences.');
    readlnE;
    //calcul du reste (positif si lvl up)
    resteXp := (joueurGkm[dernGkmUtilise].xpHave + xp) - joueurGkm[dernGkmUtilise].xpToNxt;
    //GKM RECOIT XP: +50% si dresseur
    if  dresseur
    then joueurGkm[dernGkmUtilise].xpHave := Round(joueurGkm[dernGkmUtilise].xpHave + xp * 1.5)
    else joueurGkm[dernGkmUtilise].xpHave := joueurGkm[dernGkmUtilise].xpHave + xp;

    while not(finRecevoirXp) do
    begin
      //LVL UP
      if joueurGkm[dernGkmUtilise].xpHave >= joueurGkm[dernGkmUtilise].xpToNxt then
      begin
        joueurGkm[dernGkmUtilise] := infoGkm[joueurGkm[dernGkmUtilise].lvl+1][joueurGkm[dernGkmUtilise].id];
        joueurGkm[dernGkmUtilise].xpHave := resteXp;
        writeln(joueurGkm[dernGkmUtilise].nom, ' passe au niveau ', joueurGkm[dernGkmUtilise].lvl, ' !');
        readlnE;
        //CADRE CARAC +
        coordCadre := positionCurseur();
        coordCadre.x := 1;
        dessinerCadreXY(coordCadre.x,coordCadre.y,coordCadre.x+25,coordCadre.y+10,simple,15,0);
        ecrirePos := positionCurseur();
        ecrirePos.x := ecrirePos.x - 24;
        ecrirePos.y := ecrirePos.y - 9;
        deplacerCurseur(ecrirePos);
        writeln(joueurGkm[dernGkmUtilise].nom);
        writeln;
        ecrirePos.y := ecrirePos.y + 1;
        deplacerCurseur(ecrirePos);
        writeln('LVL ', infoGkm[joueurGkm[dernGkmUtilise].lvl-1][joueurGkm[dernGkmUtilise].id].lvl, ' --> ', joueurGkm[dernGkmUtilise].lvl);
        ecrirePos.y := ecrirePos.y + 1;
        deplacerCurseur(ecrirePos);
        writeln('PVMAX ', infoGkm[joueurGkm[dernGkmUtilise].lvl-1][joueurGkm[dernGkmUtilise].id].pvMax, ' --> ', joueurGkm[dernGkmUtilise].pvMax);
        writeln;
        ecrirePos.y := ecrirePos.y + 2;
        deplacerCurseur(ecrirePos);
        writeln('ATK ', infoGkm[joueurGkm[dernGkmUtilise].lvl-1][joueurGkm[dernGkmUtilise].id].atk, ' --> ', joueurGkm[dernGkmUtilise].atk);
        ecrirePos.y := ecrirePos.y + 1;
        deplacerCurseur(ecrirePos);
        writeln('DEF ', infoGkm[joueurGkm[dernGkmUtilise].lvl-1][joueurGkm[dernGkmUtilise].id].def, ' --> ', joueurGkm[dernGkmUtilise].def);
        ecrirePos.y := ecrirePos.y + 1;
        deplacerCurseur(ecrirePos);
        writeln('SPD ', infoGkm[joueurGkm[dernGkmUtilise].lvl-1][joueurGkm[dernGkmUtilise].id].spd, ' --> ', joueurGkm[dernGkmUtilise].spd);
        ecrirePos.y := ecrirePos.y + 2;
        deplacerCurseur(ecrirePos);
        writeln('Prochain lvl: ', joueurGkm[dernGkmUtilise].xpToNxt, ' XP');
        ecrirePos := positionCurseur();
        ecrirePos.x := 0;
        ecrirePos.y := ecrirePos.y +2;
        deplacerCurseur(ecrirePos);
        readlnE;
      end;

      if joueurGkm[dernGkmUtilise].xpHave < joueurGkm[dernGkmUtilise].xpToNxt
      then finRecevoirXp := true;
    end;

    setJoueurGkm(joueurGkm);
  end;

  function getDernGkmUtilise(): Integer;
  begin
    getDernGkmUtilise := dernGkmUtilise;
  end;

  procedure setDernGkmUtilise(dernGkmUtiliseP : Integer);
  begin
    dernGkmUtilise := dernGkmUtiliseP;
  end;
end.
