**free
     // Zones de L'infds pour un Ecran
     dcl-ds fichierDS;
    nomfichier CHAR(8)   POS(1);
    fichier_open IND     POS(9); // *on = 'Oui'
    fichier_eof  IND     POS(10); // *on = 'Oui'
    fichier_status ZONED(5:0) POS(11); // comme %status
    code_operation CHAR(6)    POS(16);
    routine        CHAR(8)    POS(22);
    numero_sequence  CHAR(8)  POS(30);
    format CHAR(8)            POS(38);
    erreur CHAR(7)            POS(46);
    type_odp CHAR(2)   POS(81);
        // DS = Device, DB = Database, SP = SPool
    fichier_ouvert  CHAR(10)  POS(83);
       // fichier réellement ouvert (EXTFILE ou OVRDBF)
    bibliotheque    CHAR(10)  POS(93);
    SplNbr ZONED(5:0) POS(123);
    lg_maxi INT(10)    POS(125);
    Membre CHAR(10)    POS(129);
    nb_de_lignes INT(5)POS(152);
    nb_de_colonne INT(5) POS(154) ;
    nb_enregs INT(10)    POS(156); // nb de lignes Open
    type_acces CHAR(2)   POS(160); // KU=Keyed Unique,
      // KF=Keyed Fifo, KL=Keyed Lifo, AR=Arrival
    cle_dupliquee CHAR(1) POS(162); // U (unique), D (dup)
    source     CHAR(1)    POS(163); // Y = Oui
    overflow   INT(5)     POS(188);
    nb_write  INT(10) POS(243);
    nb_read   INT(10) POS(247);
    nb_exfmt  INT(10) POS(251);
    autreio   INT(10) POS(255);
    dernier_format  CHAR(10) POS(261);
    classe_unite    CHAR(2)  POS(271);
    nom_unite       CHAR(10) POS(273);
    lg_dernier      INT(10)  POS(283);
    Touche_Ecran CHAR(1)  POS(369);
    ligne    INT(3) POS(370); // curseur : ligne
    colonne  INT(3) POS(371); // curseur : colonne
    rang_sfl INT(5) POS(376);
    premier_rang_affiche INT(5) POS(378);
     // placé dans SFLRCNBR on réaffiche même page !
    nbrcd_sfl INT(5) POS(380);
    wlico     INT(5) POS(382);
    // position curseur, mais dans la fenêtre active
  end-ds;
