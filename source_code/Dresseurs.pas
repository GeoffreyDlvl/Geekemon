unit Dresseurs;

interface
  uses
    BDD;

  type
    Dresseur = record        //infos relatives aux dresseurs
    nom : String;
    sexe : Char;
    gkm1 : Gkm;
    gkm2 : Gkm;
    gkm3 : Gkm;
    gkm4 : Gkm;
    argent : Integer;
    defaite : String;
    victoire : String;

    end;

  procedure dresseurGuillaume();
  procedure dresseurJoelle();
  procedure dresseurBenjamin();
  procedure dresseurMarc();
  procedure dresseurMichael();
  procedure dresseurSerrure();
  procedure dresseurCassoulet();
  procedure dresseurParzani();
  procedure dresseurRival1();
  procedure dresseurRival2();
  function dresseurSermonet1() : Boolean;
  procedure dresseurSermonet2();

  //FONCTION GET
  function getInfoDresseur() : Dresseur;


implementation
  uses
    Combat;

  var
    infoDresseur : Dresseur;
    infoGkm : TabInfoGkm;
    infoJoueur : Joueur;
    nomRival : String;
    vaincu : TVaincu;

  procedure dresseurGuillaume();
  begin
    //récupérer données BDD
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Guillaume';
      sexe := 'M';
      gkm1 := infoGkm[1][9];
      gkm2 := infoGkm[1][0];
      gkm3 := infoGkm[1][0];
      gkm4 := infoGkm[1][0];
      argent := 40;
      defaite := '"Vaincu ? J''ai encore du chemin à parcourir avant de devenir maître Geekémon..."';
      victoire := '"Finalement, je ne me débrouille pas si mal !"';
    end;

    writeln;
    writeln('"Je suis nouveau dans le dressage de GKMs, mais ça ne veut pas dire que je ne vais pas me battre à fond !"');
    readln;

    //combat
    if combatD()
    then vaincu.guillaume := true;

    setVaincu(vaincu);
  end;

  procedure dresseurJoelle();
  begin
    //récupérer données BDD
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Joëlle';
      sexe := 'F';
      gkm1 := infoGkm[1][7];
      gkm2 := infoGkm[1][12];
      gkm3 := infoGkm[1][0];
      gkm4 := infoGkm[1][0];
      argent := 65;
      defaite := '"Tu m''as eue ! Je dois redoubler d''efforts !"';
      victoire := '"Je me suis vraiment améliorée ces dernières semaines !"';
    end;

    writeln;
    writeln('"Je ne suis qu''en première année, il faut que je devienne plus forte !"');
    readln;

    //combat
    if combatD()
    then vaincu.joelle := true;

    setVaincu(vaincu);
  end;

  procedure dresseurBenjamin();
  begin
    //récupérer données BDD
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Benjamin';
      sexe := 'M';
      gkm1 := infoGkm[1][7];
      gkm2 := infoGkm[1][6];
      gkm3 := infoGkm[1][13];
      gkm4 := infoGkm[1][14];
      argent := 90;
      defaite := '"J''ai perdu ! Bonne stratégie !"';
      victoire := '"J''ai gagné. Je te l''ai dis, j''adopte toujours la meilleure statégie contre mes adversaires."';
    end;

    writeln;
    writeln('"On m''appelle Benjamin Malin, parce que ma stratégie est toujours la meilleure !"');
    readln;

    //combat
    if combatD()
    then vaincu.benjamin := true;

    setVaincu(vaincu);
  end;

  procedure dresseurMarc();
  begin
    //récupérer données BDD
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Marc';
      sexe := 'M';
      gkm1 := infoGkm[1][5];
      gkm2 := infoGkm[1][15];
      gkm3 := infoGkm[1][4];
      gkm4 := infoGkm[1][0];
      argent := 150;
      defaite := '"C''est impossible ! Tu as sûrement triché !"';
      victoire := '"J''espère que ça te servira de leçon, minus."';
    end;

    writeln;
    writeln('"Je suis en deuxième année, minus, j''ai pas de temps à perdre avec un débutant comme toi."');
    readln;
    writeln('"Pfiou, très bien, tu vas te prendre une raclée dans ce cas."');
    readln;

    //combat
    if combatD()
    then vaincu.marc := true;

    setVaincu(vaincu);
  end;

  procedure dresseurMichael();
  begin
    //récupérer données BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Michaël';
      sexe := 'M';
      gkm1 := infoGkm[1][8];
      gkm2 := infoGkm[1][16];
      gkm3 := infoGkm[1][11];
      gkm4 := infoGkm[1][10];
      argent := 110;
      defaite := '"Ah ! Pour une surprise, c''est une surprise ! Tu es devenu très fort, gamin, je te félicite."';
      victoire := '"Sans rancune, j''espère, gamin ! Attrape d''autres GKMs et reviens me voir quand tu te sentiras prêt."';
    end;

    writeln;
    writeln('"Eh, mais c''est ', infoJoueur.nom, ' ! Alors comme ça tu veux te mesurer à moi ?"');
    readln;
    writeln('"Très bien gamin, mais donne tout ce que tu as, parce que quand je me bats, je ne fais pas dans la dentelle !"');
    readln;

    //combat
    if combatD()
    then vaincu.michael := true;

    setVaincu(vaincu);
  end;

  procedure dresseurSerrure();
  begin
  //récupérer données BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Klarine Serrure';
      sexe := 'F';
      gkm1 := infoGkm[1][8];
      gkm2 := infoGkm[1][16];
      gkm3 := infoGkm[1][11];
      gkm4 := infoGkm[1][10];
      argent := 110;
      defaite := '« J''ai perdu contre un étudiant ? Pff, j''ai mieux à faire, de toute manière ! »';
      victoire := '« Allez, du balai, toi ! »';
    end;

    writeln;
    writeln('« Tu me déranges, l''étudiant ! Retourne à ta misérable vie ou c''est moi qui t''y renvoie ! »');
    readln;

    //combat
    if combatD()
    then vaincu.serrure := true;

    setVaincu(vaincu);
  end;


  procedure dresseurCassoulet();
  begin
  //récupérer données BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Jérôme Cassoulet';
      sexe := 'M';
      gkm1 := infoGkm[1][8];
      gkm2 := infoGkm[1][16];
      gkm3 := infoGkm[1][11];
      gkm4 := infoGkm[1][10];
      argent := 110;
      defaite := '« Tu m''as eu, le jeune ! Je m''incline ! »';
      victoire := '« Va-t''entrainer, le jeune ! »';
    end;

    writeln;
    writeln('« Qu''est ce qu''il veut, le jeune ? Un combat ? C''est parti ! »');
    readln;

    //combat
    if combatD()
    then vaincu.cassoulet := true;

    setVaincu(vaincu);
  end;


  procedure dresseurParzani();
  begin
  //récupérer données BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Franscesco Parzani';
      sexe := 'M';
      gkm1 := infoGkm[1][8];
      gkm2 := infoGkm[1][16];
      gkm3 := infoGkm[1][11];
      gkm4 := infoGkm[1][10];
      argent := 110;
      defaite := '« C''est pas trop mal pour un premier année. »';
      victoire := '« Reviens quand tu seras devenu meilleur, l''élève. »';
    end;

    writeln;
    writeln('« Okay, je ne suis pas contre un petit échauffement avant mon prochain TP ! »');
    readln;

    //combat
    if combatD()
    then vaincu.parzani := true;

    setVaincu(vaincu);
  end;

  procedure dresseurRival1();
  begin
  //récupérer données BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();
    nomRival := getNomRival();

    With infoDresseur do
    begin
      nom := nomRival;
      gkm1 := infoGkm[1][8];
      gkm2 := infoGkm[1][16];
      gkm3 := infoGkm[1][11];
      gkm4 := infoGkm[1][10];
      argent := 110;
      defaite := '« Pff, je viens simplement d''avoir mon GKM, alors que toi tu as entrainé le tiens, gros naze ! On se reverra ! »';
      victoire := '« Haha, prends ça dans les dents, crétin ! Mon GKM, c''est le plus fort ! »';
    end;

    combatD();
  end;

  procedure dresseurRival2();
  begin
  //récupérer données BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();
    nomRival := getNomRival();

    With infoDresseur do
    begin
      nom := nomRival;
      gkm1 := infoGkm[1][8];
      gkm2 := infoGkm[1][16];
      gkm3 := infoGkm[1][11];
      gkm4 := infoGkm[1][10];
      argent := 110;
      defaite := '« Tu n''as vraiment aucune pitié... mais merci. »';
      victoire := '« Je savais que je n''étais pas mauvais ! Je t''ai mis une raclée, crétin ! »';
    end;

    combatD();
  end;

  function dresseurSermonet1() : Boolean;
  begin
  //récupérer données BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();

    With infoDresseur do
    begin
      nom := 'Matthew Sermonet';
      gkm1 := infoGkm[1][8];
      gkm2 := infoGkm[1][16];
      gkm3 := infoGkm[1][11];
      gkm4 := infoGkm[1][10];
      argent := 110;
      defaite := '« Ce n''est pas possible ! »';
      victoire := '« Disparaît, mon garçon. »';
    end;

    if (combatD()) then dresseurSermonet1 := true
    else dresseurSermonet1 := false;
  end;

  procedure dresseurSermonet2();
  begin
  //récupérer données BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();

    With infoDresseur do
    begin
      nom := 'Matthew Sermonet';
      gkm1 := infoGkm[20][17];
      gkm2 := infoGkm[1][0];
      gkm3 := infoGkm[1][0];
      gkm4 := infoGkm[1][0];
      argent := 110;
      victoire := '« C''est la fin pour toi, mon garçon. »';
    end;

    combatD();
  end;

  function getInfoDresseur() : Dresseur;
  begin
    getInfoDresseur := infoDresseur;
  end;
end.
