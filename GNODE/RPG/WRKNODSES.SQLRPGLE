**free
// gestion des session nodesJS
//
ctl-opt
DFTACTGRP(*NO) ;
dcl-f
  WRKnodses  WORKSTN
  SFILE(sfl01:cle01);
// les paramètres recus
//
dcl-pi *N ;
  P_ENV  char(10);
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
dcl-s w_compt packed(3:0);
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
w_env  =  p_env ;
exec sql
SELECT
        count(*) into :w_compt
FROM TABLE(QSYS2.ACTIVE_JOB_INFO(
            JOB_NAME_FILTER => 'NODE*',
            SUBSYSTEM_LIST_FILTER => 'NODEJS')) X
            where job_type =  'SBS'
        ;
if w_compt > 0 ;
  w_status = 'Démarré' ;
else ;
  w_status = 'Arrêté' ;
endif ;
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
    SELECT
    substr( JOB_NAME, locate_in_string( JOB_NAME, '/', 1, 2 ) + 1 ) as JOBNAME,
    substr( JOB_NAME, locate_in_string( JOB_NAME, '/', 1, 1 ) + 1,
    locate_in_string( JOB_NAME, '/', 1, 2) -
    locate_in_string( JOB_NAME, '/', 1, 1) - 1 ) as JOBUSER,
    substr( JOB_NAME, 1, locate_in_string( JOB_NAME, '/', 1, 1) - 1 ) as JOBNBR,
    substr(job_name, (locate_in_string(job_name, 'NODE', 1, 1) + 4), 4) as port,
     subsystem_library_name
    FROM TABLE(QSYS2.ACTIVE_JOB_INFO(
     JOB_NAME_FILTER => 'NODE*',
     SUBSYSTEM_LIST_FILTER => 'NODEJS')) X
     where job_type <> 'SBS'
    ORDER BY JOB_name DESC
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
        :JOBNAME,
        :JOUSER,
        :JOBNBR,
        :PORT,
        :LIBRARY
      ;
    if  sqlcode =  0                    ;
      exec sql
      SELECT substr(DATA_AREA_VALUE, 27, 30) into :scripte
       FROM TABLE(QSYS2.DATA_AREA_INFO(
                                  DATA_AREA_NAME => :JOBNAME ,
                                  DATA_AREA_LIBRARY => :LIBRARY))
      ;
      if  sqlcode =  0                    ;
      endif;
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
      exec sql
      call qcmdexc('?STRNODSES' ) ;
    other ;
      if cle01 > 0 ;
        readc sfl01  ;
        if not %eof() ;
          if opt01 = '4' ;
            commande = '?ENDNODSES port(' + port + ') env(' + p_env + ')' ;
            exec sql
            call qcmdexc(:commande) ;
            opt01  = ' ' ;
            update sfL01 ;
          endif ;
        endif ;
      endif ;
    endsl                          ;
  enddo                               ;
end-proc ;
