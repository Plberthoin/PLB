**free
// Ce programme s'utilise associé à la touche ATTN
// il permet de gérer une liste de commandes par utilisatur
// chaque utilisateurs peut gérer ces options
// le fichier db est attnmnut
// attnusr utilisateur ibm i
// attncmd commande à exécuter
// attntxt texte à afficher dans le menu
//
ctl-opt
DFTACTGRP(*NO) BNDDIR('NEW5250') ;
Dcl-F ATTNMNU     WORKSTN
SFILE(sfl01:cle01)
indds(DS_Ind)      // nommage des indicateurs
                   // indara(*yes) obligatoire sur le DSPF
usropn ;           // Prise en compte de l'ouverture du fichier
// Nommage des indicateurs
/include DDS_IND ;
dcl-ds *N PSDS;
  current_user CHAR(10)POS(358);
end-ds;
// Prototypage des procédures de NEW5250
/include NEW5250INC ;
// Déclaration Variables globales
dcl-s pagsiz packed(2:0) inz(20) ;
dcl-s maxcle01 like(cle01);              // clé maximum
//
// initialisation des options de compile sql
//
EXEC SQL
        Set Option
          Naming    = *Sys,
          Commit    = *None,
          UsrPrf    = *User,
          DynUsrPrf = *User,
          Datfmt    = *iso,
          CloSqlCsr = *EndMod;
// Ouverture ecran
// si erreur on assimile à la taille de l'écran
//
open(e) ATTNMNU ;
if %error ;
  dsply 'Vous devez être en 132*27' ;
else ;
  //
  attnusr =  current_user ;
  Init_SFL() ;
  Load_SFL() ;
  Display_SFL() ;
endif ;
*INLR = *On;
//
// Initialisation du sous fichier
//
dcl-proc Init_SFL ;
  exec sql
     select count(*) into :sflsiz
      from ATTNMNUT
           WHERE ATTNUSR = :current_user  ;
  num01 = 1 ;
  cle01 = 0 ;
  SFLCLR = *on ;
  write ctl01 ;
  SFLCLR = *off ;
end-proc ;
//
// Ouverture du curseur selection des enregistrements
//
dcl-proc Load_SFL     ;
  exec sql
     close curs01 ;
  EXEC SQL
       declare curs01 cursor  for
    select
             ATTNTXT ,
             ATTNCMD ,
             ATTNUSR
      from   ATTNMNUT
           WHERE ATTNUSR = :current_user
           ORDER BY ATTNTXT
           OPTIMIZE FOR 20 ROWS   ;
  exec sql
     open curs01 ;
  //
  dou sqlcode <> 0 ;
    exec sql
      fetch from curs01 into :ATTNTXT , :ATTNCMD , :ATTNUSR ;
    if sqlcode = 0 ;
      cle01 = Cle01 + 1 ;
      maxcle01 = Cle01 ;
      write sfl01 ;
    endif ;
  enddo ;
  // positionnement sflend
  if Maxcle01 <= pagsiz ;
    SFLEND = *on ;
  else ;
    SFLEND = *off;
  endif ;
end-proc ;
//
// Display
//
dcl-proc Display_SFL ;
  SFLDSPCTL = *on ;
  dou Sortie;
    if cle01 > 0 ;
      SFLDSP = *on ;
    else ;
      SFLDSP = *off ;
    endif ;
    write fmt01 ;
    exfmt ctl01 ;
    If NOT Sortie;
      if   Reaffichage ;
        Init_SFL() ;
        Load_SFL();
      else         ;

        //
        // traitement des menus
        //
        // traitement menu 1
        if MNUCHC > 0 ;
          Select ;
          when MNUCHC = 1 ;
            If PULL > 0;
              Select ;
              When  PULL = 1;
                EXEC SQL
                CALL QCMDEXC('WRKSPLF');
              When  PULL = 2;
                EXEC SQL
                CALL QCMDEXC('WRKJOB');
              when  PULL = 3;
                EXEC SQL
                CALL QCMDEXC('DSPJOBLOG') ;
              Endsl;
            EndIf;
          // traitement menu 2
          when MNUCHC = 2 ;
            If PULL > 0;
              Select ;
              When  PULL = 1;
                EXEC SQL
                CALL QCMDEXC('WRKLNK') ;
              When  PULL = 2;
                EXEC SQL
                CALL QCMDEXC('?SNDSMTPEMM') ;
              when  PULL = 3;
                EXEC SQL
                CALL QCMDEXC('STRSQL') ;
              Endsl;
            EndIf;
          endsl ;
          else ;
        //
        // Traitement du sous fichier
        //
        if cle01 > 0 ;
          readc sfl01 ;
          if not %eof() ;
            if Editer ;
              exfmt fmt02 ;
              if not Sortie and not Annuler ;
                traitement() ;
              ENDIF;
            else ;
              EXEC SQL
              CALL QCMDEXC(:attncmd) ;
              if sqlcode <> 0 ;
                Affichage_Box('Action' : 'Exécution commande impossible ')   ;
              endif;
            endif ;
          else ;
    // Création
            clear fmt02 ;
            attnusr =  current_user ;
            exfmt fmt02 ;
              if not Sortie and not Annuler ;
                traitement() ;
              endif;
          endif ;
        EndIf;
      EndIf;
        endif;
    EndIf;
  EndDo;
end-proc ;
//
//  Gestion des options
//   Mise à jour du fichier ATTNMNUT
//
dcl-proc Traitement  ;
  dcl-s found  char(1)      ;
  dcl-s L_Status  char(2)   ;
  // Supression
  if supprimer ;
  // confirmation
    Affichage_Valid('Action   ' : 'Veuillez confirmer' :
                      'La supression de ..:' : attncmd : L_Status) ;
    if L_Status = 'OK' ;
      exec sql
      delete from attnmnut where attnusr = :attnusr and attncmd = :attncmd ;
      if sqlcode = 0 ;
        Affichage_Box('Gestion options  ' : 'Suppression  effectuée ')   ;
        attntxt = '* supprimé *' ;
        update(e) SFL01 ;
      else ;
        Affichage_Box('Gestion options  ' : 'Suppression  en erreur ')   ;
      endif;
    // si modification ou création
    else ;
      Affichage_Box('Gestion options  ' : 'Suppression  annulée   ')   ;
    endif ;
  else ;
    exec sql
    select '1' into :found from attnmnut
           where attnusr = :attnusr and attncmd = :attncmd ;
    if sqlcode = 0 ;
      exec sql
      update attnmnut set attntxt = :attntxt
             where attnusr = :attnusr and attncmd = :attncmd ;
      if sqlcode = 0 ;
        Affichage_Box('Gestion options  ' : 'Mise à jour effectuée ')   ;
        update(e) SFL01 ;
      else ;
        Affichage_Box('Gestion options  ' : 'Mise à jour en erreur ')   ;
      endif ;
    else ;
      exec sql
      insert  into attnmnut values(:attnusr , :attncmd , :attntxt) ;
      if sqlcode = 0 ;
        Affichage_Box('Gestion options  ' : 'Insertion effectuée ')   ;
        cle01 = Maxcle01 + 1 ;
        write(e) sfl01 ;
      else ;
        Affichage_Box('Gestion options  ' : 'Insertion en erreur ')   ;
      endif ;
    endif ;
  endif ;
end-proc ;
