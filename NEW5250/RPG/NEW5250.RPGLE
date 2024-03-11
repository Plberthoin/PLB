**free
// Ce module comporte des éléments graphiques à ajouter à vos écrans
// Box
// Validation
// Liste à cocher
// Calendrier
// Ligne de commande
// Contrôler taille de l'écran
Ctl-Opt nomain;
dcl-f NEW5250   WORKSTN USROPN
 SFILE(SFL01:CLE01)    // sous fichier calendrier
 SFILE(SFL02:CLE02)       // sous fichier liste
indds(DS_Ind)  ;          // nommage des indicateurs
/include DDS_IND ;
// ligne de commande IBMi
DCL-PR Exec_Ligne_Commande     EXTPGM('QUSCMDLN');
END-PR;
 dcl-ds *N PSDS;
   SDSJOB CHAR(10)  POS(244);
 end-ds;

dcl-s nbparms packed(1);
dcl-s id_jour packed(1);
dcl-s nb_jours_now packed(2);
dcl-s nb_jours_before packed(2);
dcl-s date_debut_now date(*ISO);
dcl-s wdate_entree date(*ISO);
dcl-s wdate_sortie date(*ISO);
dcl-s date_debut_before date(*ISO);
dcl-s id_jour_debut packed(1);
dcl-s num_jour packed(2);
dcl-s ind_fin ind;
dcl-s jour_sortie char(2);
dcl-s nom_mois char(10);
EXEC SQL
        Set Option
          Naming    = *Sys,
          Commit    = *None,
          UsrPrf    = *User,
          DynUsrPrf = *User,
          Datfmt    = *iso,
          CloSqlCsr = *EndMod;
// ouverture ecran
dcl-proc Ouverture_ecran      ;
if not %open(new5250) ;
  open(e) new5250 ;
endif ;
// Fermeture ecran
end-proc ;
dcl-proc Fermeture_ecran      ;
if %open(new5250) ;
  close(e) new5250 ;
endif ;
end-proc ;

//-----------------------------------------------
//
// Affichage box
//
// ----------------------------------------------
dcl-proc Affichage_Box export ;
  Dcl-Pi *n;
    P_Titre  Char(30) Const;
    P_Texte  Char(55) Const;
  End-Pi;
  Ouverture_ecran() ;
  // Chargement des zones
  Titre = P_titre ;
  Texte = P_texte ;
  // Affichage du format
  EXFMT   FMT03 ;
  Fermeture_ecran() ;
end-proc ;
//-----------------------------------------------
//
// Affichage Validation
//
// ----------------------------------------------
dcl-proc Affichage_Valid export ;
  Dcl-Pi *n;
    P_Titre  Char(30) Const;
    P_Texte1 Char(55) Const;
    P_Texte2 Char(55) Const;
    P_Texte3 Char(55) Const;
    P_Status char(2) ;
  End-Pi;
  Ouverture_ecran() ;
  // Chargement des zones
  Titre = P_titre ;
  Texte1 = P_texte1 ;
  Texte2 = P_texte2 ;
  Texte3 = P_texte3 ;
  // Affichage du format
  EXFMT   FMT04 ;
   if Valider ;
     P_status = 'OK' ;
   else ;
     P_status = 'KO' ;
   endif;
  Fermeture_ecran() ;
end-proc ;
//----------------------------------------------
//
// Affichage Liste de sélection
//
//----------------------------------------------
dcl-proc Affichage_Liste export ;
  Dcl-Pi *n;
    P_SqlStm Char(1024) Const;
    P_Titre  Char(35) Const;
    P_Result Char(45) ;
  End-Pi;
  Ouverture_ecran() ;
  // Affichage du format
  init(P_SqlStm)      ;
  char(P_Titre)      ;
  affi(P_Result)      ;
  Fermeture_ecran() ;
end-proc ;
//  *--------------------------------------*
//  *  Initialisation                      *
//  *--------------------------------------*
dcl-proc INIT           ;
  Dcl-Pi *n;
    P_SqlStm Char(1024) Const;
  End-Pi;
  dcl-s  L_SqlStm Char(1024) ;
  cle02 = 0                           ;
  rcd02 = 1                           ;
  SFLCLR = *on                         ;
  write(e) ctl02                         ;
  SFLCLR = *off                        ;
     L_SqlStm = p_SqlStm              ;
  // Traitement du curseur
  exec SQL     // Déclaration de la requête
    declare curs02     Cursor
      for sqlstm                           ;
  exec SQL     // Péparation de la requête (sql dynamique)
    prepare sqlstm
       from :L_sqlstm                        ;
  exec SQL     // Création de la fenêtre
      open curs02                          ;
end-proc ;
//  *--------------------------------------*
//  *  Chargement                          *
//  *--------------------------------------*
dcl-proc CHAR           ;
  Dcl-Pi *n;
    P_Titre  Char(35) Const;
  End-Pi;
 tit02 =  P_Titre ;
  dou  Sqlcode <> 0                 ;
    exec sql
      fetch next
        from curs02
        into :det02                     ;
    if  sqlcode =  0                    ;
      cle02 = Cle02 + 1               ;
 //     rcd02 = cle02                   ;
      write sfl02                     ;
    endif                               ;
  enddo                               ;
end-proc ;
//  *--------------------------------------*
//  *  Affichage                           *
//  *--------------------------------------*
dcl-proc AFFI           ;
  Dcl-Pi *n;
    P_Result Char(45) ;
  End-Pi;
  SFLDSPCTL = *on                     ;
 //  dou Annuler  or P_Result <> ' '       ;
    if cle02 > 0                        ;
      SFLDSP = *on                       ;
    else                                ;
      SFLDSP = *off                      ;
    endif                               ;
    tit02 = titre                       ;
    write fmt02                      ;
    exfmt ctl02                      ;
    if Annuler                      ;
      P_Result = ' '                ;
      else ;
      Trai(p_result) ;
    endif                          ;
 //  enddo                               ;
end-proc ;
//  *--------------------------------------*
//  *  Traitement                          *
//  *--------------------------------------*
dcl-proc TRAI           ;
  Dcl-Pi *n;
    P_Result Char(45) ;
  End-Pi;
  if cle02 > 0                       ;
    readc sfl02                    ;
    if not %eof                    ;
      p_result = det02                ;
    else                           ;
      p_result = ' '                  ;
    endif                          ;
  endif                              ;
end-proc ;
//
// Affichage Date
//
dcl-proc Affichage_Date  export ;
  Dcl-Pi *n;
    date_sortie date(*ISO);
    date_entree date(*ISO) options(*NOPASS);
  End-Pi;

  Ouverture_ecran() ;

  // Gestion des paramètres
  nbparms = %parms;

  wdate_sortie = date_sortie;
  if nbparms = 2;
     wdate_entree = date_entree;
  endif;

  // Test de la date d'entrée
  test(e) wdate_entree;
  if %error;
    // Mois en cours en cas de date d'entrée incorrecte
    wdate_entree = %date() - %days(%subdt(%date():*DAYS)) + %days(1);
    ERRORMSG = 'Date d''entrée invalide';
  endif;
  // Déroulement du programme
  INIT_Date();
  CHAR_Date();
  AFFI_Date();
  date_sortie = wdate_sortie;
  Fermeture_ecran() ;
end-proc ;

dcl-proc INIT_Date;
  cle01 = 0;
  rcd01 = 1;
  SFLCLR = *on;
  write(e) ctl01;
  clear sfl01;
  SFLCLR = *off;
end-proc;

dcl-proc CHAR_Date;
  select;
    when INPUTMOIS <> *blanks and INPUTANNEE <> *blanks;
      // Contrôle du mois et de l'année entrés
      if (%dec(INPUTMOIS:2:0) < 13 and %dec(INPUTMOIS:2:0) > 0) and
         (%dec(INPUTANNEE:4:0) <= 9999 and %dec(INPUTANNEE:4:0) >= 1);
        EXEC SQL
          VALUES LPAD(TRIM(:INPUTMOIS), 2, '0') into :INPUTMOIS;
        EXEC SQL
          VALUES LPAD(TRIM(:INPUTANNEE), 4, '0') into :INPUTANNEE;
        date_debut_now = %date(INPUTANNEE + '-' + INPUTMOIS + '-' + '01');
      // Si invalide(s), date par défaut
      else;
        DEFAULT_MONTH();
      endif;
    other;
      // Si mois et/ou année vide, date par défaut
      DEFAULT_MONTH();
  endsl;

  // Affichage du titre du mois en cours
  EXEC SQL
    VALUES MONTHNAME(:date_debut_now)
    INTO :nom_mois;
  titremois = %trim(nom_mois) + ' ' + INPUTANNEE;

  // Calcul du nombre de jours dans le mois
  GET_NB_JOURS(date_debut_now:nb_jours_now);

  // Même calcul pour le mois précédent
  if date_debut_now = %date('0001-01-01');
    // Cas du 1er jour de l'an 1 : valeur en dûr pour éviter une erreur
    nb_jours_before = 31;
  else;
    date_debut_before = date_debut_now-%months(1);
    GET_NB_JOURS(date_debut_before:nb_jours_before);
  endif;

  // Identification du 1er jour (lundi, mardi...?)
  EXEC SQL
     VALUES DAYOFWEEK(:date_debut_now)
     INTO :id_jour_debut;

  // Chargement des six semaines
  dou cle01 = 6;

    // Lundi
    id_jour = 2;
    CHAR_JOUR(id_jour:NUMLUN:Ind_Lundi:Ind_Lundi_Now);

    // Mardi
    id_jour = 3;
    CHAR_JOUR(id_jour:NUMMAR:Ind_Mardi:Ind_Mardi_Now);

    // Mercredi
    id_jour = 4;
    CHAR_JOUR(id_jour:NUMMER:Ind_Mercredi:Ind_Mercredi_Now);

    // Jeudi
    id_jour = 5;
    CHAR_JOUR(id_jour:NUMJEU:Ind_Jeudi:Ind_Jeudi_Now);

    // Vendredi
    id_jour = 6;
    CHAR_JOUR(id_jour:NUMVEN:Ind_Vendredi:Ind_Vendredi_Now);

    // Samedi
    id_jour = 7;
    CHAR_JOUR(id_jour:NUMSAM:Ind_Samedi:Ind_Samedi_Now);

    // Dimanche
    id_jour = 1;
    CHAR_JOUR(id_jour:NUMDIM:Ind_Dimanche:Ind_Dimanche_Now);

    cle01 = cle01 + 1;
    rcd01 = cle01;
    write sfl01;
  enddo;
end-proc;

dcl-proc AFFI_Date;
  SFLDSP = *on;
  dou Annuler;
    if cle01 > 0;
      SFLDSPCTL = *on;
    else;
      SFLDSPCTL = *off;
    endif;
    write footer;
    exfmt ctl01;
    select;
      when Annuler;
        leave;
      when Liste;
        TRAI_Date();
        if ind_fin;
          leave;
        endif;
      when Precedent;
        select;
          when %dec(INPUTMOIS:2:0) = 1 and %dec(INPUTANNEE:4:0) = 1;
            INPUTMOIS = '01';
            INPUTANNEE = '0001';
          when %dec(INPUTMOIS:2:0) = 1;
            INPUTMOIS = '12';
            INPUTANNEE = %char(%dec(INPUTANNEE:4:0)-1);
          other;
            INPUTMOIS = %char(%dec(INPUTMOIS:2:0)-1);
        endsl;
        Precedent = *off;
        ERRORMSG = ' ';
        INIT_Date();
        CHAR_Date();
      when Suivant;
        select;
          when %dec(INPUTMOIS:2:0) = 12 and %dec(INPUTANNEE:4:0) = 9999;
            INPUTMOIS = '12';
            INPUTANNEE = '9999';
          when %dec(INPUTMOIS:2:0) = 12;
            INPUTMOIS = '01';
            INPUTANNEE = %char(%dec(INPUTANNEE:4:0)+1);
          other;
            INPUTMOIS = %char(%dec(INPUTMOIS:2:0)+1);
        endsl;
        Suivant = *off;
        ERRORMSG = ' ';
        INIT_Date();
        CHAR_Date();
      other;
        ERRORMSG = ' ';
        INIT_Date();
        CHAR_Date();
    endsl;
  enddo;
end-proc;

dcl-proc TRAI_Date;
  // Lecture de la date selectionnée
  select;
    when CSRFLD = 'NUMLUN';
      SELECT_JOUR(NUMLUN);
    when CSRFLD = 'NUMMAR';
      SELECT_JOUR(NUMMAR);
    when CSRFLD = 'NUMMER';
      SELECT_JOUR(NUMMER);
    when CSRFLD = 'NUMJEU';
      SELECT_JOUR(NUMJEU);
    when CSRFLD = 'NUMVEN';
      SELECT_JOUR(NUMVEN);
    when CSRFLD = 'NUMSAM';
      SELECT_JOUR(NUMSAM);
    when CSRFLD = 'NUMDIM';
      SELECT_JOUR(NUMDIM);
  endsl;
end-proc;

dcl-proc GET_NUM_JOUR;
  dcl-pi *n;
    id_jour packed(1);
    wnum_jour packed(2);
  end-pi;

  // Semaine 1 (avec jours du mois dernier)
  if cle01 = 0;
    // Jour actuel <> 1er jour
    if id_jour_debut <> id_jour;
      // Avant le 1er jour
      if (id_jour_debut > id_jour or id_jour_debut = 1) and id_jour <> 1;
        // Si 1er jour <> dimanche
        if id_jour_debut <> 1;
          num_jour = id_jour - id_jour_debut + 1 + nb_jours_before;
        // Si 1er jour = dimanche
        else;
          num_jour = id_jour - 8 + 1 + nb_jours_before;
        endif;
      // Après le 1er jour
      else;
        num_jour = num_jour + 1;
      endif;
    // 1er jour
    else;
      num_jour = 1;
    endif;
  // Semaines 2 à 6
  else;
    num_jour = num_jour + 1;
    // Passage au mois suivant si nécessaire
    if num_jour > nb_jours_now;
      num_jour = 1;
    endif;
  endif;
  wnum_jour = num_jour;
end-proc;

dcl-proc GET_NB_JOURS;
  dcl-pi *n;
    wdate date(*ISO);
    nb_jours packed(2);
  end-pi;
  // Nombre de jours dans le mois, prise en compte des années bissextiles
  EXEC SQL
    VALUES  CASE WHEN MONTH(:wdate) IN (1, 3, 5, 7, 8, 10, 12) THEN 31
               WHEN MONTH(:wdate) IN (4, 6, 9, 11) THEN 30
               ELSE CASE WHEN (MOD(YEAR(:wdate), 4)    = 0 AND
                              MOD(YEAR(:wdate), 100) != 0) OR
                             (MOD(YEAR(:wdate), 400)  = 0) THEN 29
                         ELSE 28
                   END
            END INTO :nb_jours;
end-proc;

dcl-proc CHAR_JOUR;
  dcl-pi *n;
    id_jour packed(1);
    wnum_jour packed(2);
    ind_jour ind;
    ind_jour_now ind;
  end-pi;
  GET_NUM_JOUR(id_jour:wnum_jour);
  ind_jour_now = *off;
  if (num_jour > 7 and cle01 = 0) or
     (num_jour < 20 and cle01 > 3);
    ind_jour = *off;
  else;
    ind_jour = *on;
    if %subdt(%date():*YEARS) = %dec(INPUTANNEE:4:0)
      and %subdt(%date():*MONTHS) = %dec(INPUTMOIS:2:0)
      and %subdt(%date():*DAYS) = wnum_jour;
      ind_jour_now = *on;
    endif;
  endif;
end-proc;

dcl-proc SELECT_JOUR;
  dcl-pi *n;
    numjour packed(2);
  end-pi;
  cle01 = ROW - 12;
  chain cle01 sfl01;
  if (numjour > 7 and cle01 = 1) or
     (numjour < 20 and cle01 > 4);
     // On ne prend la date que si elle fait partie du mois
  else;
    EXEC SQL
      VALUES LPAD(TRIM(:numjour), 2, '0') into :jour_sortie;
    wdate_sortie = %date(INPUTANNEE + '-' + INPUTMOIS + '-' + jour_sortie);
    // ind_fin pour sortir du programme
    ind_fin = *on;
  endif;
end-proc;

dcl-proc DEFAULT_MONTH;
  if nbparms = 2;
    // Si date_entree renseignée, utilisation de date_entree par défaut
    if wdate_entree <> %date('0001-01-01');
      date_debut_now = wdate_entree - %days(%subdt(wdate_entree:*DAYS)) + %days(1);
    else;
      date_debut_now = wdate_entree;
    endif;
    INPUTMOIS = %char(%subdt(date_debut_now:*MONTHS));
    EXEC SQL
      VALUES LPAD(TRIM(:INPUTMOIS), 2, '0') into :INPUTMOIS;
    INPUTANNEE = %char(%subdt(date_debut_now:*YEARS));
    EXEC SQL
      VALUES LPAD(TRIM(:INPUTANNEE), 4, '0') into :INPUTANNEE;
  else;
    // Sinon, mois en cours
    date_debut_now = %date() - %days(%subdt(%date():*DAYS)) + %days(1);
    INPUTMOIS = %char(%subdt(date_debut_now:*MONTHS));
    EXEC SQL
      VALUES LPAD(TRIM(:INPUTMOIS), 2, '0') into :INPUTMOIS;
    INPUTANNEE = %char(%subdt(date_debut_now:*YEARS));
  endif;
end-proc;
//
//  Exécution d'une commande
//
dcl-proc Ligne_Commande export ;
  Dcl-Pi *n;
    P_Status char(3);
  End-Pi;
dcl-s L_user char(10) ;
// Récupération de l'utilisateur du job en cours
exec sql
SELECT X.JOB_USER into :L_User
    FROM TABLE (
            QSYS2.ACTIVE_JOB_INFO(JOB_NAME_FILTER => '*')
        ) X   ;
// Vérification Si inscrit à la liste QUSCMDLN
//
exec sql
SELECT AUTHORIZATION_NAME into :L_User
   FROM QSYS2.AUTHORIZATION_LIST_USER_INFO
   WHERE AUTHORIZATION_LIST = 'QUSCMDLN'
   and AUTHORIZATION_NAME = :L_User
   ;
if sqlcode = 0 ;
  Exec_Ligne_Commande() ;
  P_Status = 'OK' ;
else ;
  Affichage_Box('Erreur' : 'User non inscrit a QUSCMDLN') ;
  P_Status = 'KO' ;
endif;
end-proc;
//-----------------------------------------------
//
// Controle taille de l'écran
//
// ----------------------------------------------
 Dcl-Proc GetDevtype Export;
   Dcl-PI Getdevtype           Char(10);
     P_Device                Char(10) Const;
   End-PI;
   // Prototypes  de la l'API  QDCRDEVD récupération des attributs
   // d'une unité
   Dcl-PR QDCRDEVD                 ExtPgm('QDCRDEVD');
     Rcvar                     Like(Rcvar);
     Varlen                    Like(Varlen);
     Format                    Like(Format);
     Device                    Like(Device);
     Apierr                    Like(Apierr);
   End-PR;
   Dcl-DS Apierr;
     Bytprv                 BinDec(8:0) Pos(1) Inz(216);
     Bytavl                 BinDec(8:0) Pos(5) Inz;
     Errorid                  Char(7) Pos(9) Inz;
     Reserved                 Char(1) Pos(16) Inz;
     ErrorDesc                Char(200) Pos(17) Inz;
   End-DS;
   Dcl-S device                Char(10) INZ;
   // Format pour unité écran
   Dcl-S Format                Char(8) Inz('DEVD0600');
   Dcl-S Rcvar                 Char(5000) Inz;
   Dcl-S Varlen              BinDec(4:0) Inz(5000);
   Dcl-S typ_dev               Char(10) INZ;
   // Si * on considère l'écran en cours
   if P_Device = '*' ;
     Device = SDSJOB;   // Attention variable globale
   else ;
     Device = P_Device;
   endif ;
   // Appel API systéme
   CallP QDCRDEVD(
                 Rcvar
                 :Varlen
                 :Format
                 :Device
                 :Apierr
                 );
   If BytAvl = 0;
     // Lecture position du type de DSP
     typ_dev = %Subst(Rcvar:175:10);
   EndIf;
   Return typ_dev;
 End-Proc ;
