**free
// Gestion des utilisateurs rootés
//
ctl-opt
DFTACTGRP(*NO) ;
dcl-f
  DSPPLNPRD WORKSTN
  infds(ScreenSize)
  usropn
  SFILE(sfl01:cle01);
// les paramètres recus
//
dcl-ds ScreenSize           ;
  Rows   int(5) pos(152) ;
  Columns  int(5) pos(154) ;
end-ds ;

dcl-pi *N ;
  P_DATE char(10);
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
// test taille  de l'ecran
open(e)  DSPPLNPRD  ;
if %error ;
  dsply 'Ecran 132*27 obligatoire' ;
  *inlr = *on ;
else ;
  // init user        //
  w_cle  =  'GAIA_2017'  ;
  //
  Init_SFL()                     ;
  Load_SFL()                     ;
  Display_SFL()                  ;
  //
  *inlr = *on                         ;
endif ;
//
// Initialisation
//
dcl-proc Init_SFL       ;
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
   drop   table qtemp/logdujour    ;
  exec sql
    create table  qtemp/logdujour as (
    SELECT * FROM TABLE(QSYS2.HISTORY_LOG_INFO(CURRENT DATE)) X)
    with data
  ;
  exec sql
     close curs01                         ;
  EXEC SQL
      declare curs01 cursor  for
    select
    a.SCHEDULED_JOB_NAME as nom_travail, a.SCHEDULED_TIME as   HEURE_prev ,
    ifnull(b.MESSAGE_TIMESTAMP,  '2911-11-11-00.00.00.00000') as Heure_debut ,
    ifnull(c.MESSAGE_TIMESTAMP,  '2911-11-11-00.00.00.00000') as heure_fin,
                           ifnull(c.SEVERITY,'99') as code_sev ,
    ifnull(replace(
    substr(C.MESSAGE_SECOND_LEVEL_TEXT, (locate('achèvement',
    C.MESSAGE_SECOND_LEVEL_TEXT) + 11) , 2) , '.' , '0') , '99')
             as code_fin,
    ifnull(b.From_job , ' ') as name_job
    from         plnprdprv a
    Left outer join   logdujour b
    on B.MESSAGE_ID ='CPF1124' and B.FROM_JOB like('%' concat
    A.SCHEDULED_JOB_NAME concat '%')
    Left outer join  logdujour c
    on C.MESSAGE_ID ='CPF1164' and C.FROM_JOB like('%' concat
    A.SCHEDULED_JOB_NAME concat '%')
    order by a.SCHEDULED_TIME
    ;




  exec sql
     open curs01                          ;
  // des utilisateurs
  //
  dou   sqlcode <> 0      ;
    exec sql
      fetch
        from curs01
        into
    :NOM_T00001,
    :HEURE_PREV  ,
    :HEURE00001,
    :HEURE_FIN,
    :CODE_sev,
    :CODE_FIN,
    :name_job;


    if  sqlcode =  0                    ;
      cle01 = Cle01 + 1                 ;
      maxcle01 = Cle01    ;
           *in60 = *off  ;
           *in61 = *off  ;
           *in62 = *off  ;
      // erreur
      select ;
      // erreur  de traitement
      when code_fin <>  '00' and code_fin <> '99' ;
        *in60 = *on ;
        *in61 = *off  ;
        *in62 = *off  ;
      // pas encore tourné
      when code_fin  =  '99'  ;
        *in60 = *off ;
        *in61 = *on ;
        *in62 = *off  ;
      when HEURE00001 > HEURE_FIN;
        *in60 = *off ;
        *in61 = *off ;
        *in62 = *on ;
 //
      endsl ;
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
      dsply '*in06' ;
    other ;
      if cle01 > 0 ;
        readc sfl01  ;
        if not %eof() ;
          if opt01 = '5' ;
            exec sql call qcmdexc('WRKJOB ' concat :name_job) ;
            opt01  = ' ' ;
            update sfL01 ;
          endif ;
        endif ;
      endif ;
    endsl                          ;
  enddo                               ;
end-proc ;
