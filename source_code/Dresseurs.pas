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
    //r�cup�rer donn�es BDD
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
      defaite := '"Vaincu ? J''ai encore du chemin � parcourir avant de devenir ma�tre Geek�mon..."';
      victoire := '"Finalement, je ne me d�brouille pas si mal !"';
    end;

    writeln;
    writeln('"Je suis nouveau dans le dressage de GKMs, mais �a ne veut pas dire que je ne vais pas me battre � fond !"');
    readln;

    //combat
    if combatD()
    then vaincu.guillaume := true;

    setVaincu(vaincu);
  end;

  procedure dresseurJoelle();
  begin
    //r�cup�rer donn�es BDD
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Jo�lle';
      sexe := 'F';
      gkm1 := infoGkm[1][7];
      gkm2 := infoGkm[1][12];
      gkm3 := infoGkm[1][0];
      gkm4 := infoGkm[1][0];
      argent := 65;
      defaite := '"Tu m''as eue ! Je dois redoubler d''efforts !"';
      victoire := '"Je me suis vraiment am�lior�e ces derni�res semaines !"';
    end;

    writeln;
    writeln('"Je ne suis qu''en premi�re ann�e, il faut que je devienne plus forte !"');
    readln;

    //combat
    if combatD()
    then vaincu.joelle := true;

    setVaincu(vaincu);
  end;

  procedure dresseurBenjamin();
  begin
    //r�cup�rer donn�es BDD
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
      defaite := '"J''ai perdu ! Bonne strat�gie !"';
      victoire := '"J''ai gagn�. Je te l''ai dis, j''adopte toujours la meilleure stat�gie contre mes adversaires."';
    end;

    writeln;
    writeln('"On m''appelle Benjamin Malin, parce que ma strat�gie est toujours la meilleure !"');
    readln;

    //combat
    if combatD()
    then vaincu.benjamin := true;

    setVaincu(vaincu);
  end;

  procedure dresseurMarc();
  begin
    //r�cup�rer donn�es BDD
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
      defaite := '"C''est impossible ! Tu as s�rement trich� !"';
      victoire := '"J''esp�re que �a te servira de le�on, minus."';
    end;

    writeln;
    writeln('"Je suis en deuxi�me ann�e, minus, j''ai pas de temps � perdre avec un d�butant comme toi."');
    readln;
    writeln('"Pfiou, tr�s bien, tu vas te prendre une racl�e dans ce cas."');
    readln;

    //combat
    if combatD()
    then vaincu.marc := true;

    setVaincu(vaincu);
  end;

  procedure dresseurMichael();
  begin
    //r�cup�rer donn�es BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'Micha�l';
      sexe := 'M';
      gkm1 := infoGkm[1][8];
      gkm2 := infoGkm[1][16];
      gkm3 := infoGkm[1][11];
      gkm4 := infoGkm[1][10];
      argent := 110;
      defaite := '"Ah ! Pour une surprise, c''est une surprise ! Tu es devenu tr�s fort, gamin, je te f�licite."';
      victoire := '"Sans rancune, j''esp�re, gamin ! Attrape d''autres GKMs et reviens me voir quand tu te sentiras pr�t."';
    end;

    writeln;
    writeln('"Eh, mais c''est ', infoJoueur.nom, ' ! Alors comme �a tu veux te mesurer � moi ?"');
    readln;
    writeln('"Tr�s bien gamin, mais donne tout ce que tu as, parce que quand je me bats, je ne fais pas dans la dentelle !"');
    readln;

    //combat
    if combatD()
    then vaincu.michael := true;

    setVaincu(vaincu);
  end;

  procedure dresseurSerrure();
  begin
  //r�cup�rer donn�es BDD
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
      defaite := '� J''ai perdu contre un �tudiant ? Pff, j''ai mieux � faire, de toute mani�re ! �';
      victoire := '� Allez, du balai, toi ! �';
    end;

    writeln;
    writeln('� Tu me d�ranges, l''�tudiant ! Retourne � ta mis�rable vie ou c''est moi qui t''y renvoie ! �');
    readln;

    //combat
    if combatD()
    then vaincu.serrure := true;

    setVaincu(vaincu);
  end;


  procedure dresseurCassoulet();
  begin
  //r�cup�rer donn�es BDD
    infoJoueur := getInfoJoueur();
    infoGkm := getInfoGkm();
    vaincu := getVaincu();

    With infoDresseur do
    begin
      nom := 'J�r�me Cassoulet';
      sexe := 'M';
      gkm1 := infoGkm[1][8];
      gkm2 := infoGkm[1][16];
      gkm3 := infoGkm[1][11];
      gkm4 := infoGkm[1][10];
      argent := 110;
      defaite := '� Tu m''as eu, le jeune ! Je m''incline ! �';
      victoire := '� Va-t''entrainer, le jeune ! �';
    end;

    writeln;
    writeln('� Qu''est ce qu''il veut, le jeune ? Un combat ? C''est parti ! �');
    readln;

    //combat
    if combatD()
    then vaincu.cassoulet := true;

    setVaincu(vaincu);
  end;


  procedure dresseurParzani();
  begin
  //r�cup�rer donn�es BDD
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
      defaite := '� C''est pas trop mal pour un premier ann�e. �';
      victoire := '� Reviens quand tu seras devenu meilleur, l''�l�ve. �';
    end;

    writeln;
    writeln('� Okay, je ne suis pas contre un petit �chauffement avant mon prochain TP ! �');
    readln;

    //combat
    if combatD()
    then vaincu.parzani := true;

    setVaincu(vaincu);
  end;

  procedure dresseurRival1();
  begin
  //r�cup�rer donn�es BDD
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
      defaite := '� Pff, je viens simplement d''avoir mon GKM, alors que toi tu as entrain� le tiens, gros naze ! On se reverra ! �';
      victoire := '� Haha, prends �a dans les dents, cr�tin ! Mon GKM, c''est le plus fort ! �';
    end;

    combatD();
  end;

  procedure dresseurRival2();
  begin
  //r�cup�rer donn�es BDD
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
      defaite := '� Tu n''as vraiment aucune piti�... mais merci. �';
      victoire := '� Je savais que je n''�tais pas mauvais ! Je t''ai mis une racl�e, cr�tin ! �';
    end;

    combatD();
  end;

  function dresseurSermonet1() : Boolean;
  begin
  //r�cup�rer donn�es BDD
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
      defaite := '� Ce n''est pas possible ! �';
      victoire := '� Dispara�t, mon gar�on. �';
    end;

    if (combatD()) then dresseurSermonet1 := true
    else dresseurSermonet1 := false;
  end;

  procedure dresseurSermonet2();
  begin
  //r�cup�rer donn�es BDD
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
      victoire := '� C''est la fin pour toi, mon gar�on. �';
    end;

    combatD();
  end;

  function getInfoDresseur() : Dresseur;
  begin
    getInfoDresseur := infoDresseur;
  end;
end.
