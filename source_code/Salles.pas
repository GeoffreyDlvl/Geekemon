unit Salles;

interface
  uses
    Actions,
    Combat,
    BDD,
    Dresseurs,
    GestionEcran;

  type
    Tposition = (Pcouloir,Psecretariat,Pcafeteria,Pinfirmerie,Petddg);

  procedure couloir();
  procedure secretariat();
  procedure cafeteria();
  procedure infirmerie();
  procedure etddg();
  procedure sR51();
  procedure sR20();
  procedure s121();
  procedure s150();
  procedure s209();
  procedure s249();

  procedure yesRencontre();
  procedure noRencontre();

  function getNomSalle() : String;
  function getPosition() : Tposition;
  procedure setNomSalle(nomSalleP : String);
  procedure setPosition(positionP : Tposition);
  procedure initPosition ();



implementation
  uses
    Menus,
    Evenements;

  var
    sortieInfirmerie : Boolean; // true quand on quitte l'infirmerie, permet de regagner directement le couloir
    joueurGkm : TabJoueurGkm;
    infoJoueur : Joueur;
    nomSalle : String; //nom de la derni�re salle visit�e
    position : Tposition; //position du joueur
    quete : TQuete;

  procedure couloir();
  var
    descr : Integer;
    choixSalle : Integer;
    erreurSaisie : Boolean;
    sortie : Boolean;  // Quitter le jeu -> retour �cran titre

  begin
    //redirection (valeure initiale ou valeur charg�e)
    case position of
      Psecretariat: secretariat();
      Pcafeteria: cafeteria();
      Pinfirmerie: infirmerie();
      Petddg: etddg();
    end;

    randomize;
    erreurSaisie := false;
    sortie := false;
    sortieInfirmerie := false;

    while not(sortie) do
    begin
      quete := getQuete();

      if not(quete.finjeu) then
      begin
        position := Pcouloir;
        nomSalle := 'C O U L O I R';
        effacerEcran;
        enteteMenu(false,false,false);
        if erreurSaisie = false then // Si erreur saisie, on garde la m�me description
        descr := random(5);

        case descr of
        0: writeln('Le couloir est compl�tement d�sert.');
        1: begin
            writeln('Le couloir est presque d�sert. Vous aper�evez quelques �tudiants, s�rement des retardataires qui se dirigent vers ');
            writeln('leur salle de classe.');
          end;
        2: writeln('Le couloir est bond� d''�tudiants qui discutent dans un brouhaha assourdissant.');
        3: begin
            writeln('Il n''y a pas �me qui vive dans le couloir. La lumi�re est �teinte, ce qui cr�� une atmosph�re envoutante mais ');
            writeln('�galement inqui�tante.');
          end;
        4: begin
            writeln('De nombreux �tudiants peuplent le couloir. Certains discutent, d''autres s''occupent de leur GKM favori en ');
            writeln('attendant le d�but de leur classe.');
          end;
        end;

        quete := getQuete();
        writeln; // Menu du couloir avec selection des salles
        writeln('O� souhaitez-vous vous rendre ?');
        writeln;
        writeln(' 1. Caf�t�ria');
        writeln(' 2. Salle R20');
        writeln(' 3. Salle R51');
        writeln(' 4. Secr�tariat');
        writeln(' 5. l''ETDDG');
        writeln(' 6. Salle 121');
        writeln(' 7. Salle 150');
        writeln(' 8. Salle 209');
        writeln(' 9. Salle 249');
        writeln(' 10. Quitter le b�timent');
        if (quete.q06) then writeln(' 11. Bureau de Matthew Sermonet');
        erreurSaisie := false;
        readln(choixSalle);

        case choixSalle of // Selection des salles au clavier
          0: enteteMenu(true,false,false);
          1: cafeteria();
          2: sR20();
          3: sR51();
          4: secretariat();
          5: etddg();
          6: s121();
          7: s150();
          8: s209();
          9: s249();
          10:
          begin
            quitterLeJeu();
            sortie := true;
          end
          else if (quete.q06) and (choixSalle=11) then
          begin
            quete6();
          end;
          begin
            writeln('MAUVAISE SAISIE'); // Mauvaise saisie prit en compte
            erreurSaisie := true;
            readln;
          end;
        end;
      end
      else
      begin
        ecranFinJeu();
        sortie := true;
      end;
    end;
  end;

  procedure secretariat(); // SECRETARIAT
  var
    choix : Integer;
    sortie : Boolean;
  begin
    quete := getQuete();
    sortie := false;
    while not(sortie) do
    begin
      effacerEcran;
      position := Psecretariat;
      nomSalle := 'S E C R E T A R I A T';
      enteteMenu(false,false,false);

      if (quete.evt1 = true) then
      begin
        evenement1();
        etatQuete(quete.evt1);
        sortie := true;
      end

      else
      begin
        writeln('Derri�re le bureau du secr�tariat, Th�r�se est tant�t occup�e � entrer les notes des �valuations de combats GKM');
        writeln('des �tudiants sur son ordinateur, tant�t occup�e � trier des dossiers ou en remplir d�autres.');
        writeln('Elle s�arr�te cependant en vous entendant entrer.');

        writeln('"Oui ?"');
        writeln;
        writeln('1. Pardon, je ne sais pas ce que je fais l�.');
        readln(choix);
        case choix of
          0: enteteMenu(true,false,false);
          1: sortie := true;
          else
          begin
            writeln('MAUVAISE SAISIE');
            readln;
          end;
        end;
      end;
    end;
  end;

  procedure cafeteria(); //CAFETERIA -->  combats contre des dresseurs
  var
    choix : Integer;
    sortie : Boolean;
    vaincu : TVaincu;
  begin
    quete := getQuete();
    position := Pcafeteria;
    nomSalle := 'C A F E T E R I A ';
    sortie := false;

    while not(sortie) do
    begin
      effacerEcran;
      enteteMenu(false,false,false);

      if (quete.q01a = true) or (quete.q01b = true) then
      begin
        writeln('Vous p�n�trez dans la caf�t�ria.');
        writeln('Il n''a pas �me qui vive ici. Les tables sont empil�es au fond de la pi�ce et les lumi�res sont �teintes.');
        writeln('Il n''y a pas grand chose � faire ici � cette heure de la journ�e, peut-�tre devriez-vous repasser plus tard ?');
        readlnE;
        quete.q01a := false;
        quete.q01b := true;
        setQuete(quete);
        sortie := true;
      end

      else if (quete.q02 = true) then
      begin
        writeln('Vous p�n�trez dans la caf�t�ria.');
        writeln('Il y a enfin de la lumi�re mais toujours tr�s peu de monde ici. Les tables ont �t� dispos�e au fond de la pi�ce, mais un grand espace vide a �t� am�nag�.');
        writeln('Vous vous demandez bien pourquoi.');
        writeln('Quelques �tudiants fond la queue pour acheter une vienoiserie. Vous n''avez pas faim et de toute mani�re, vous devez vous rendre en salle R20.');
        readlnE;
        sortie := true;
      end

      else if (quete.q03 = true) then
      begin
        vaincu:= getVaincu();

        writeln('Vous p�n�trez dans la caf�t�ria.');
        writeln('Au fond de la pi�ce, vous remarquez quelques tables o� les �tudiants peuvent manger. N�anmoins, la majeure partie de la pi�ce a �t� am�nag�e en une ar�ne o� des dresseurs de GKMs peuvent se battre.');
        writeln('Vous apercevez un certain nombre de dresseurs qui semblent attendre une �me assez t�m�raire pour les d�fier en combat.');
        writeln;
        writeln('Vous avez enfin l''opportunit� de montrer de quoi vous �tes capables.');
        writeln('Contre quel dresseur voulez-vous vous battre ?');
        writeln;
        if  vaincu.guillaume = true then couleurTexte(2);
        writeln(' 1. Guillaume');
        couleurTexte(15);
        if vaincu.joelle = true then couleurTexte(2);
        writeln(' 2. Jo�lle');
        couleurTexte(15);
        if vaincu.benjamin = true then couleurTexte(2);
        writeln(' 3. Benjamin');
        couleurTexte(15);
        if vaincu.marc = true then couleurTexte(2);
        writeln(' 4. Marc');
        couleurTexte(15);
        if vaincu.michael = true then couleurTexte(2);
        writeln(' 5. Micha�l');
        couleurTexte(15);
        writeln(' 6. Se diriger vers le couloir.');
        readln(choix);

        case choix of
          0: enteteMenu(true,false,false);
          1: dresseurGuillaume();
          2: dresseurJoelle();
          3: dresseurBenjamin();
          4: dresseurMarc();
          5: dresseurMichael();
          6: sortie := true;
          else
          begin
            writeln('MAUVAISE SAISIE');
            readln;
          end;
        end;

        if  sortieInfirmerie = true then
        begin
          sortie := true;
        end;

        if (vaincu.guillaume) and (vaincu.joelle) and (vaincu.benjamin)
          and (vaincu.marc) and (vaincu.michael) then
        begin
          etatQuete(quete.q03); //true->false
          etatQuete(quete.q04); //false->true
          setQuete(quete);
        end;
      end

      else if (quete.q04 = true) then
      begin
        writeln('Les dresseurs que vous avez vaincu ne sont plus l�.');
        writeln('C''est la fin de matin�e mais quelques �tudiants sont d�j� en train d''engloutir leur repas. Quoiqu''il en soit, il n''y a pas de dresseurs avec qui vous entra�ner.');
        writeln('De toute mani�re, vous devez imp�rativement vous rendre en salle 121.');
        readlnE;
        sortie := true;
      end

      else if(quete.q05 = true) then
      begin
        vaincu:= getVaincu();

        writeln('Vous p�n�trez dans la caf�t�ria.');
        writeln('Vous remarquez les professeurs en train de manger. Parmi eux, Klarine Serrure et J�r�me Cassoulet.');
        readlnE;
        writeln('Il est temps de montrer de quoi vous �tes capables.');
        writeln('Contre quel dresseur voulez-vous vous battre ?');
        writeln;
        if  vaincu.parzani = true then couleurTexte(2);
        writeln(' 1. Francesco Parzani');
        couleurTexte(15);
        if vaincu.serrure = true then couleurTexte(2);
        writeln(' 2. Klarine Serrure');
        couleurTexte(15);
        if vaincu.cassoulet then couleurTexte(2);
        writeln(' 3. J�r�me Cassoulet');
        couleurTexte(15);
        writeln(' 4. Se diriger vers le couloir.');
        readln(choix);

        case choix of
          0: enteteMenu(true,false,false);
          1: dresseurParzani();
          2: dresseurSerrure();
          3: dresseurCassoulet();
          4: sortie := true;
          else
          begin
            writeln('MAUVAISE SAISIE');
            readln;
          end;
        end;

        if  sortieInfirmerie = true then
        begin
          sortie := true;
        end;

        if (vaincu.parzani) and (vaincu.serrure) and (vaincu.cassoulet) then
        begin
          quete5();
        end;
      end

      else if (quete.q06 = true) then
      begin
        writeln('Apr�s le tumulte que vous avez caus�, tout le monde a d�guerpi d''ici.');
        writeln('Vous n''avez rien � faire � la caf�t�ria, Matthew Sermonet s''est retranch� quelque part dans le b�timent, et vous comptez bien le trouver.');
        sortie := true;
      end;

    end;
  end;

  procedure infirmerie(); // INFIRMERIE --> regain PVs apr�s d�faite
  var
    sortie : Boolean;
    choix : Integer;
  begin

      sortie := false;
      position := Pinfirmerie;
      nomSalle := 'I N F I R M E R I E';
      while not(sortie) do
      begin
        effacerEcran;
        enteteMenu(false,false,false);
        soinGkm();
        write('Vous vous r�veillez � l''infirmerie. Que s''est-il pass� ?');
        readln;
        write('.');
        attendre(500);
        write('.');
        attendre(500);
        writeln('.');
        attendre(500);
        writeln('Vous vous rappelez soudain : vous avez �t� vaincu.');
        writeln;
        writeln('Il est peut-�tre temps d�attraper de nouveaux GKMs.');
        writeln;
        writeln(' 1. Se rendre dans le couloir.');
        readln(choix);
        case choix of
          0: enteteMenu(true,false,false);
          1: sortie := true;
          else
          begin
            writeln('MAUVAISE SAISIE');
            readln;
          end;
        end;

      sortieInfirmerie:= true;
    end;
  end;

  procedure etddg(); // ETDDG --> achat potions / GKBs, soin GKMs
  var
    choix : Integer;
    sortie : Boolean;
  begin
    quete := getQuete();
    position := Petddg;
    nomSalle := 'E T D D G';
    sortie := false;

    if (quete.q01b = true) then quete1()

    else
    begin
      while not(sortie) do
      begin
        {///////////////////////
      ajoutGkm(3, 1,51);
      ajoutGkm(2,2,40);
      ajoutGkm(4,3,30);
      ajoutGkm(4,4,22);
      ajoutGkm(4,5,22);
      ajoutGkm(4,6,22);
      ajoutGkm(4,7,22);
        //////////////////////}
        effacerEcran;
        enteteMenu(false,false,false);
        writeln('L�ETDDG est une pi�ce assez insalubre mais o� il fait finalement bon vivre.');
        writeln('Vous ne remarquez m�me plus les innombrables t�ches et autres emballages qui tra�nent partout. Certains dresseurs autour de vous sont occup�s � soigner leurs GKM, d�autres jouent � Mario Kart sur Super NES.');
        writeln;
        writeln('Vous remarquez un distributeur o� vous pouvez acheter des potions et des GKBs. Il y a �galement un vieil oridnateur qui prend la poussi�re dans un coin de la pi�ce.');
        writeln;
        writeln('Le canap� semble �galement tr�s confortable, vous �tes certain que vous y d�tendre quelques minutes avec vos GKMs vous feraient � tous le plus grand bien.');
        writeln(' 1.	Acheter des potions.');
        writeln(' 2.	Acheter des GKBs.');
        writeln(' 3.	Utiliser "PC de ???"');
        writeln(' 4.	S�asseoir sur le canap�');
        writeln(' 5.	Regagner le couloir');
        readln(choix);
        case choix of //diff�rentes actions selon choix du joueur
          0: enteteMenu(true,false,false);
          1: achatPotion(20);
          2: achatGkb(15);
          3: pcDe();
          4:  begin
                writeln('Accompagn� de vos GKMs, vous vous installez sur le canap�.');
                writeln('Vous d�cidez de fermer les yeux quelques instants...');
                soinGkm();
                readln;
                write('.');
                attendre(500);
                write('.');
                attendre(500);
                writeln('.');
                attendre(500);
                writeln('Vous ouvrez les yeux. Vous ne savez pas combien de temps s''est �coul�.');
                writeln('Quoiqu''il en soit, vous et vos GKMs vous sentez tout � fait repos�s et �tes pr�ts � reprendre votre aventure.');
                readln;
              end;
          5: sortie := true;
          else
          begin
            writeln('MAUVAISE SAISIE');
            readln;
          end;
        end;
      end;
    end;
  end;

  procedure sR51(); // Salle R31 --> combats al�toires
  begin
    nomSalle := 'S A L L E    R 5 1';
    effacerEcran;
    enteteMenu(false,false,false);
    writeln('Vous entrez dans la salle R51.');
    writeln('Il s�agit d�une petite salle munie de nombreux ordinateurs. La lumi�re est allum�e et l�endroit semble plut�t s�r.');
    writeln('Vous regardez attentivement autour de vous.');
    readln;

    if rencontre(35,1) = true then
      yesRencontre()
    else
      noRencontre();
  end;

  procedure sR20(); // Salle R20 --> combats al�toires
  begin
    quete := getQuete();
    nomSalle := 'S A L L E    R 2 0';
    if quete.q02 = true then quete2()

    else
    begin
      effacerEcran;
      enteteMenu(false,false,false);
      writeln('Vous entrez dans la salle R20.');
      writeln('La lumi�re est �teinte et la salle est plong�e dans la p�nombre. Les volets entrouverts strient la pi�ce de coupures');
      writeln('de soleils si nettes qu�elles semblent ac�r�es.');
      writeln('Sur vos gardes, vous regardez attentivement autour de vous.');
      readln;

      if rencontre(75,1) = true then
        yesRencontre()
      else
        noRencontre();
    end;

  end;

  procedure s121(); // Salle 121 --> possibilit� de combatre
  begin
    nomSalle := 'S A L L E    S 1 2 1';
    effacerEcran;
    enteteMenu(false,false,false);
    writeln('Vous entrez dans la salle 121.');
    writeln('Il vous semble apercevoir une ombre entre les ordinateurs qui occupent cette pi�ce. Est-ce votre imagination ? ');
    writeln('La main pr�te � saisir votre GKB, vous regardez attentivement autour de vous.');
    readln;

    if rencontre(85,2) = true then
      yesRencontre
    else
      noRencontre;
  end;

  procedure s150(); // Salle 150 --> combats al�toires
  begin
    nomSalle := 'S A L L E    S 1 5 0';
    effacerEcran;
    enteteMenu(false,false,false);
    if (quete.evt2 = true) then
    begin
      evenement2();
      etatQuete(quete.evt2); //true->false
      setQuete(quete);
    end
    else
    begin
      writeln('Vous entrez dans la salle 150.');
      writeln('L�endroit est spacieux et lumineux, mais l�odeur de transpiration excessive trahit le fait que la salle a r�cemment ');
      writeln('servie de classe � des dresseurs de GKM.');
      writeln('Vous regardez attentivement autour de vous');
      readln;

      if rencontre(60,2) = true then
        yesRencontre()
      else
        noRencontre();
    end;
  end;

  procedure s209(); // Salle 209 --> combats al�toires
  begin
    nomSalle := 'S A L L E    S 2 0 9';
    effacerEcran;
    enteteMenu(false,false,false);
    writeln('La pi�ce est litt�ralement d�serte. Il n�y aucune table, juste un tableau noir. L''endroit est plong� dans');
    writeln('la p�nombre et vous ne savez pas ce qui peut vous attendre dans les recoins obscurs.');
    writeln('Alerte et pr�t � bondir, vous regardez attentivement autour de vous');
    readln;

    if rencontre(60,3) = true then
      yesRencontre()
    else
      noRencontre();
  end;

  procedure s249(); // Salle 249
  begin
    quete := getQuete();
    nomSalle := 'S A L L E    S 2 4 9';
    effacerEcran;
    enteteMenu(false,false,false);
    if (quete.q04 = true) then
    begin
      quete4();
    end
    else
    begin
      writeln('Vous apercevez des GKMs se battre fi�rement, leurs dresseurs respectifs se tenant derri�re eux, les poings');
      writeln('serr�s, hurlant des ordres.');
      writeln('Un professeur semblait �tre en train de les �valuer, mais ce dernier se retourne vers vous en vous entendant');
      writeln('entrer.');
      writeln('Il y a cours ici, oups !');
      readlnE;
    end;
  end;

  procedure yesRencontre();
  begin
    if sortieinfirmerie = false then
    begin
      effacerEcran;
      enteteMenu(false,false,false);
      writeln('Quel combat ! Vous rappelez votre GKM dans sa GKB et rejoignez le couloir.');
      readln;
    end;
  end;

  procedure noRencontre();
  begin
    writeln('Il semblerait qu''aucun GKM sauvage ne r�de dans les environs.');
    readln;
    writeln('Vous regagnez le couloir.');
    readln;
  end;

  function getNomSalle() : String;
  begin
    getNomSalle := nomSalle;
  end;

  function getPosition() : Tposition;
  begin
    getPosition := position;
  end;

  procedure setNomSalle(nomSalleP : String);
  begin
    nomSalle := nomSalleP;
  end;

  procedure setPosition(positionP : Tposition);
  begin
    position := positionP;
  end;

  procedure initPosition ();
  begin
    position := Pcouloir;
  end;



end.
