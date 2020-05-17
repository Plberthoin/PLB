**free
//-----------------------------------------------------------------------*
//                                                                       *
// Gestion des entrées de SVRAUTE                                        *
//                                                                       *
//                                                                       *
//-----------------------------------------------------------------------*
ctl-opt
  DFTACTGRP(*NO)
  ACTGRP(*NEW);
dcl-f
  WRKsvraute WORKSTN
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
  exec sql
     declare curs01 cursor for
     SELECT AUTHORIZATION_NAME as rmtusr ,
            substr(SERVER_NAME, 1, 50)  as dbname ,
            substr(SERVER_AUTHORIZATION_NAME , 1 , 10) as lclusr ,
            PASSWORD_STORED as pasto
          FROM QSYS2.DRDA_AUTHENTICATION_ENTRY_INFO
     ORDER BY SERVER_NAME ;
  exec sql
     open curs01                          ;
 // Controle droit *iosyscfg
  exec sql
  SELECT CURRENT_CHARACTER_VALUE into :consign
    FROM QSYS2.SYSTEM_VALUE_INFO
    WHERE SYSTEM_VALUE_NAME = 'QRETSVRSEC' ;
END-PROC                            ;
//
// Chargement
//
DCL-PROC       Chargement                  ;
  dou sqlcode <> 0                    ;
    exec sql
      fetch next
        from curs01 into
                  :RMTUSR, :DBNAME   , :LCLUSR , :PASTO   ;
    if sqlcode <> 0                   ;
      leave                           ;
    endif                             ;
    cle01 = Cle01 + 1                 ;
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
        when opt01 = '1'                     ;
          exec sql
           call qcmdexc('?addsvraute') ;
          if sqlcode <> 0 ;
            dsply ('Erreur ADDSVRAUTE') ;
          endif ;
          Exec_Cmd() ;
        when opt01 = '2'                     ;
          exec sql
           call qcmdexc('?CHGSVRAUTE USRPRF(' concat  :rmtusr
           concat ') SERVER(' concat :dbname concat ') USRID(' concat
           :lclusr concat  ')') ;
          if sqlcode <> 0 ;
            dsply ('Erreur CHGSVRAUTE')                    ;
          endif ;
        when opt01 = '4'                     ;
          exec sql
           call qcmdexc('?RMVSVRAUTE USRPRF(' concat  :rmtusr
           concat ') SERVER(' concat :dbname concat ')') ;
          if sqlcode <> 0 ;
            dsply ('Erreur RMVSVRAUTE') ;
          endif ;
        endsl                            ;
        //
        opt01 = ' '                    ;
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
