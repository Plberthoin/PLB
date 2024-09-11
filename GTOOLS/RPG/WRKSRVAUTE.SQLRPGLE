**free
// Gestion des Remotes OUTQ
//  Ce programme permet de gérer rapidement vos OUTQs
//  Exemple adresse ip , text , nouvelle OUTQ
      ctl-opt
      DFTACTGRP(*NO) ;
       dcl-f
      WRKSRVAUTE WORKSTN   usropn
      SFILE(sfl01:cle01);
  // les paramètres recus
  //
//dcl-pi *N ;
//  P_DATE char(10);
//end-pi ;
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
         // Teste écran 132
         Monitor ;
            Open WRKSRVAUTE ;
         On-error ;
            dsply ('Nécessite un écran 27 * 132') ;
            *inlr=*on ;
             Return ;
         Endmon;
   exec sql
   select SYSTEM_VALUE into :retention from QSYS2.SYSTEM_VALUE_INFO
    where SYSTEM_VALUE_NAME    = 'QRETSVRSEC'
  ;
  if retention = '1' ;
    *in64 = *on ;
  else    ;
    *in64= *off ;
  endif ;
        // init user        //
              w_cle  =  'GAIA_2017'  ;
              euser = ' '                         ;
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
              exec sql
              call qcmdexc('?ADDSVRAUTE ' ) ;
              other ;
              if cle01 > 0 ;
              readc sfl01  ;
              if not %eof() ;
              if opt01 = '2' ;
              exec sql
              call qcmdexc('?CHGSVRAUTE ' concat :auser concat ' ' concat :aserver) ;
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
