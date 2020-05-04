**free
//-----------------------------------------------------------------------*
//                                                                       *
// Ge programme permet de gérer les démarrage des services TCP           *
// vous devez etre *iosyscfg                                             *
//                                                                       *
//-----------------------------------------------------------------------*
ctl-opt
  DFTACTGRP(*NO)
  ACTGRP(*NEW);
dcl-f
  WRKTCPSTRE WORKSTN
  SFILE(SFL01:CLE01);
//  variable de travail
DCL-S  CLE01 int(5) ;
DCL-S cmdexec char(4096);
DCL-S iosyscfg ind      ;
// prototypage pour programme qcmdexc
DCL-PR cmd  EXTPGM('QCMDEXC') ;
  PR_CmdStr  CHAR(4096) CONST;
  PR_CmdStrLen PACKED(15 : 5) CONST ;
END-PR;
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
Initialisation()                         ;
Chargement()                         ;
Affichage()                         ;
// fin de programme
exec sql
   close curs01                         ;
*inlr = *on                         ;
//
// Initialisation
//
dcl-proc          Initialisation                      ;
  num01 = 1                           ;
  cle01 = 0                           ;
  *in40 = *on                         ;
  opt01 = ' '                         ;
  write ctl01                         ;
  *in40 = *off                        ;
  exec sql
     close curs01                         ;
  // Traitement du curseur
  exec sql
     close curs01                         ;
  exec sql
     declare curs01 cursor for
    SELECT SERVERTYPE, SERVER, AUTOSTART, LIBRARY,  PROGRAM, EXTSTRCMD
    FROM  QATOCSTART
  ;
  exec sql
     open curs01                          ;
 // Controle droit *iosyscfg
  exec sql
    SELECT '1'    into :iosyscfg
       FROM QSYS2.USER_INFO
       WHERE
    AUTHORIZATION_NAME = current user and
    SPECIAL_AUTHORITIES like('%*IOSYSCFG%')  ;
  if  iosyscfg    ;
    *in73 = *on ;
  else ;
    *in73 = *off;
  endif ;
END-PROC                            ;
//
// Chargement
//
DCL-PROC       Chargement                  ;
  dou sqlcode <> 0                    ;
    exec sql
      fetch next
        from curs01 into
     :SERVERTYPE, :SERVER, :AUTOSTART, :LIBRARY, :PROGRAM ,
     :EXTSTRCMD  ;
    if sqlcode <> 0                   ;
      leave                           ;
    endif                             ;
    cle01 = Cle01 + 1                 ;
    if autostart = '*YES' ;
      *in71 = *on  ;
    else;
      *in71 = *off ;
    endif ;
    write sfl01                       ;
  enddo                               ;
END-proc                            ;
//
// Affichage
//
dcl-proc       Affichage                   ;
  *in41 = *on                         ;
  dou *in03 or *in05                  ;
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
    // réaficher
    if *in05                       ;
      Initialisation()             ;
      Chargement()                 ;
      Affichage()                  ;
    else                           ;
      // Création
      if *in06                       ;
      else                           ;
        Traitement()                 ;
      endif                          ;
    endif ;
  enddo                               ;
END-proc                            ;
//
// Traitement
//
dcl-proc       Traitement                 ;
  if cle01 > 0                       ;
    dou %eof                           ;
      readc sfl01                      ;
      if not %eof                      ;
        select ;
        //
        // Création
        //
        when opt01 = '1'  and *in73          ;
          exec sql
           UPDATE QUSRSYS/QATOCSTART SET AUTOSTART = '*YES' WHERE
           server = :server  ;
          AUTOSTART = '*YES' ;
        when opt01 = '4'   and *in73         ;
          exec sql
           UPDATE QUSRSYS/QATOCSTART SET AUTOSTART = '*NO' WHERE
           server = :server  ;
          AUTOSTART = '*NO' ;
          Exec_Cmd() ;
        when opt01 = '5'                     ;
          exfmt fmt02        ;
        when opt01 = 'S'  and *in73          ;
          exec sql
           call qcmdexc('?' concat :EXTSTRCMD) ;
          if sqlcode <> 0 ;
            dsply ('Erreur ' + %subst(EXTSTRCMD : 1 : 40)) ;
          endif ;
        when opt01 = 'E'  and *in73          ;
          exec sql
           call qcmdexc('?END' concat substr(:EXTSTRCMD , 4 , 56));
          if sqlcode <> 0 ;
            dsply ('Erreur ' + %subst(EXTSTRCMD : 1 : 40)) ;
          endif ;
        endsl                            ;
        //
        opt01 = ' '                    ;
        if autostart = '*YES' ;
          *in71 = *on  ;
        else;
          *in71 = *off ;
        endif ;
        update(e) sfl01                   ;
      endif                            ;
      num01 = cle01                  ;
    enddo                              ;
  endif                              ;
END-PROC                            ;
//
// Exécution commande CL
//
dcl-proc       Exec_Cmd                   ;
  monitor ;
    cmd(cmdexec:%LEN(cmdexec))       ;
  On-error;
    Dsply %Status;     // Status = 0202 Command failed
    Dsply 'Erreur sur commande ';
  Endmon;
END-PROC                            ;
