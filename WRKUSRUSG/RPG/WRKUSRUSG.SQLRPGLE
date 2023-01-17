**free
// Gestion des utilisateurs d'une fonction ID
//
ctl-opt
DFTACTGRP(*NO) ;
dcl-f
  WRKUSRUSG  WORKSTN
  SFILE(sfl01:cle01);
// les paramètres recus
//
dcl-pi *N ;
  P_FUNCT char(30);
end-pi ;
dcl-s cle01 PACKED(4 : 0) ;
dcl-s maxcle01 PACKED(4 : 0) ;
dcl-s w_cle    char(20) ;
dcl-s commande CHAR(400) ;
dcl-s error ind ;
dcl-pr  Exec_Cmd EXTPGM('QCMDEXC');
  cde CHAR(200) CONST;
  cdl PACKED(15 : 5) CONST;
end-pr;
DCL-PR  Touche_F4 EXTPGM('TOUCHE_F4');
  p_Sql char(1024) ;
  p_Titre char(35);
  p_Ret    char(45);
END-PR;
dcl-s  w_Sql char(1024) ;
dcl-s w_Titre char(35);
dcl-s w_Ret    char(45);
dcl-s w_date   date;
dcl-s w_pos packed(3:0);
dcl-s user_usage char(8);
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
// init user        //
w_cle  =  'GAIA_2017'  ;
//
Init_SFL()                     ;
Load_SFL()                     ;
Display_SFL()                  ;
//
*inlr = *on                         ;
//
// Initialisation
//
dcl-proc Init_SFL       ;
  exec sql
  SELECT
         SUBSTR(FUNCTION_NAME_MESSAGE_TEXT, 1, 50) AS texte,
         IFNULL(DEFAULT_USAGE, ' ') AS usage,
         IFNULL(ALLOBJ_INDICATOR, ' ') AS allobj
         into  :funct, :usage, :allobj
      FROM QSYS2.FUNCTION_INFO
      WHERE Function_id = :p_funct     ;
  if sqlcode <> 0 ;
    funct = 'Inconnu'  ;
    usage = 'Inconnu'  ;
    allobj =  'Inconnu'  ;
  else ;
    // usage utilisateur inverse du groupe
    if usage = 'ALLOWED' ;
      user_usage = '*DENIED' ;
    else ;
      user_usage = '*ALLOWED';
    endif ;
  endif ;
  num01 = 1                           ;
  cle01 = 0                           ;
  *in40 = *on                         ;
  write ctl01                         ;
  *in40 = *off                        ;
end-proc ;
//
// Chargement
//
dcl-proc Load_SFL        ;
  exec sql
     close curs01                         ;
  EXEC SQL
       declare curs01 cursor  for
    SELECT a.user_name,
    IFNULL(b.TEXT_DESCRIPTION, ' ')
    FROM QSYS2.FUNCTION_USAGE a
      JOIN qsys2.user_info b
          ON b.AUTHORIZATION_NAME = a.user_name
    WHERE Function_id = :p_funct;
  exec sql
     open curs01                          ;
  // des utilisateurs
  //
  dou   sqlcode <> 0      ;
    exec sql
      fetch
        from curs01
        into
      :user ,  :text   ;
    if  sqlcode =  0                    ;
      cle01 = Cle01 + 1                 ;
      maxcle01 = Cle01    ;
      write sfl01                       ;
      if cle01 = 9999 ;
        dsply 'Sous fichier plein.'  ;
        leave                        ;
      endif           ;
    endif         ;
  enddo                               ;

end-proc ;
//
// Display
//
dcl-proc Display_SFL     ;
  *in41 = *on                         ;
  dou *in03                           ;
    if cle01 > 0                        ;
      *in42 = *on                       ;
    else                                ;
      *in42 = *off                      ;
    endif                               ;
    write fmt01                      ;
    exfmt ctl01                      ;
    if *in03                       ;
      leave                        ;
    endif                          ;
    select                         ;
    // raffraichissage des infos
    when *in05                       ;
      Init_SFL()                     ;
      Load_SFL()                     ;
      Display_SFL()                  ;
    when *in06                       ;
      // ajout d'un utilisateur
      w_Sql =
              '?CHGFCNUSG ?*FCNID(' + p_funct + ') ?*DEFAULT(*'  +
                                        usage + ') ?*ALLOBJAUT(*'  +
                                        allobj +  ') USAGE('  +
                                        user_usage + ')' ;

      exec sql
       call qcmdexc(:w_sql) ;
       if sqlcode = 0 ;
         *in64 = *off ;
         result = 'Utilisateur ajouté'    ;
         exfmt fmt03 ;
       else ;
         *in64 = *on  ;
         result = 'Impossible d''ajouter l''utilisateur'  ;
         exfmt fmt03 ;
       ENDIF;
   // Réglage de la fonction
   // à ajouter cacher la zone profil + usage
    when *in10                       ;
      w_Sql =
              '?CHGFCNUSG ?*FCNID(' + p_funct + ') DEFAULT(*'  +
                                        usage + ') ALLOBJAUT(*'  +
                                        allobj + ') ?-USER() ?-USAGE(*ALLOWED)'
                 ;
      exec sql
       call qcmdexc(:w_sql) ;
       if sqlcode = 0 ;
         *in64 = *off ;
         result  = 'Fonction modifiée'   ;
         exfmt fmt03 ;
       else ;
         *in64 = *on  ;
         result = 'Impossible de modifier la fonction'  ;
         exfmt fmt03 ;
       ENDIF;
    other ;
      if cle01 > 0 ;
        readc sfl01  ;
        if not %eof() ;
          if opt01 = '4' ;
            w_Sql =
              'CHGFCNUSG FCNID(' + p_funct + ') USER(' +
                                              user + ') USAGE(*NONE) DEFAULT(*'  +
                                              usage + ') ALLOBJAUT(*' +
                                              allobj + ')'
            ;
            exec sql
             call qcmdexc(:w_sql) ;
       if sqlcode = 0 ;
       *in64 = *off ;
       result  = 'Utilisateur retiré'   ;
       exfmt fmt03;
       else ;
       *in64 = *on  ;
       result = 'Impossible de retirer l''utilisateur'  ;
       exfmt fmt03;
       ENDIF;
            opt01  = ' ' ;
            update sfL01 ;
          endif ;
        endif ;
      endif ;
    endsl                          ;
  enddo                               ;
end-proc ;
