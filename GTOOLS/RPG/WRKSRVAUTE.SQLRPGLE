**free
//  Gestion des authentifications de serveurs
//  Ce programme permet de gérer les authentifications pour DRDA
//  C'est les mots de passe qui seront passés avec votre utilsateur à la
//  Vous pouvez utiliser des profils de groupe pour vous connecter
//  Vous pouvez gérer aussi la valeur système QRETSVRSEC
ctl-opt
DFTACTGRP(*NO) ;
dcl-f
  WRKSRVAUTE WORKSTN   usropn
  SFILE(sfl01:cle01);
//
// les paramètres recus
//
//
// les Variables globales
//
dcl-s cle01 PACKED(4 : 0) ;
dcl-s maxcle01 PACKED(4 : 0) ;
dcl-s w_cle    char(20) ;
//
// Les prototypages
//
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
// Teste écran 132
Monitor ;
  Open WRKSRVAUTE ;
On-error ;
  dsply ('Nécessite un écran 27 * 132') ;
  *inlr=*on ;
  Return ;
Endmon;
// init user        //
w_cle  =  'GAIA_2017'  ;
euser = ' '                         ;
// forcage du ccsid pour eviter 65635
exec sql
call qcmdexc('CHGJOB CCSID(1147)');
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
  check_ret() ;
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
    SELECT AUTHORIZATION_NAME,
    SERVER_NAME,
    SERVER_AUTHORIZATION_NAME,
    PASSWORD_STORED
    FROM QSYS2.DRDA_AUTHENTICATION_ENTRY_INFO
    where AUTHORIZATION_NAME >= :euser
    Order by AUTHORIZATION_NAME, SERVER_NAME
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
      :auser,  :aserver , :Aauth , :Apwd  ;
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
    when *in08                       ;
      exec sql
      call qcmdexc('WRKRDBDIRE ' ) ;
    when *in06                       ;
      // Création d'un poste de rétention
      exec sql
      call qcmdexc('?ADDSVRAUTE ' ) ;
    when *in09                       ;
      // Gestion du mode de rétention
      if *in64 ;
        exec sql
        call qcmdexc('CHGSYSVAL SYSVAL(QRETSVRSEC) VALUE(''0'')') ;
      else ;
        exec sql
        call qcmdexc('CHGSYSVAL SYSVAL(QRETSVRSEC) VALUE(''1'')') ;
      endif ;
      Init_SFL()                     ;
      Load_SFL()                     ;
      Display_SFL()                  ;
    other ;
      if cle01 > 0 ;
        readc sfl01  ;
        if not %eof() ;
          if opt01 = '2' ;
            exec sql
            call qcmdexc('?CHGSVRAUTE USRPRF(' concat :auser concat ') SERVER('
               concat :aserver concat ') USRID(' concat :Aauth concat ')') ;
            opt01  = ' ' ;
            update sfL01 ;
          endif ;
          if opt01 = '3' ;
            exec sql
            call qcmdexc('?ADDSVRAUTE USRPRF(' concat :auser concat ') SERVER('
               concat :aserver concat ') USRID(' concat :Aauth concat ')') ;
            opt01  = ' ' ;
            update sfL01 ;
          endif ;
          if opt01 = '4' ;
            exec sql
            call qcmdexc('?RMVSVRAUTE ' concat :auser concat ' ' concat :aserver) ;
            opt01  = ' ' ;
            update sfL01 ;
          endif ;
        endif ;
      endif ;
    endsl                          ;
  enddo                               ;
end-proc ;
//
// Test si rétention activée
//
dcl-proc Check_Ret       ;
  exec sql
  select SYSTEM_VALUE into :retention from QSYS2.SYSTEM_VALUE_INFO
   where SYSTEM_VALUE_NAME    = 'QRETSVRSEC'
    ;
  if retention = '1' ;
    *in64 = *on ;
  else    ;
    *in64= *off ;
  endif ;
end-proc ;
