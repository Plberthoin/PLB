**free
      ctl-opt
      DFTACTGRP(*NO) ;
       dcl-f
      GMNU    WORKSTN
      SFILE(sfl01:cle01);
  // les paramètres recus
  //
  dcl-pi *N ;
    P_MSGF char(10);
    P_LIB  char(10);
  end-pi ;
      dcl-s wsecond char(50) ;
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
        if %parms() < 2;
          dsply ('vous devez indiquer le menu à afficher')  ;
          return ;
        endif ;
        msgf = p_msgf ;
        libm = p_lib ;
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
SELECT  MESSAGE_TEXT ,
        ifnull(MESSAGE_SECOND_LEVEL_TEXT , ' '),
        MESSAGE_ID
        FROM QSYS2.MESSAGE_FILE_DATA
        Where MESSAGE_FILE_LIBRARY = :libm
          and MESSAGE_FILE = :MSGF
   ;
          exec sql
             open curs01                          ;
       // loop of remotes system
       //
              dou   sqlcode <> 0      ;
              exec sql
                fetch
                  from curs01
                  into
                     :TXTM, :second, :id ;
              if  sqlcode =  0                    ;
       // si pas de texte de 2ème niveau
              if second = ' ' ;
                second = txtm ;
              endif ;
                  cle01 = Cle01 + 1                 ;
                  maxcle01 = Cle01    ;
                  write sfl01                       ;
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
          // invite de commande
                   when *in04                       ;
                   read fmt01 ;
            if cexec <> ' ' ;
              Commande = '?' + cexec ;
              cexec = ' ';
              trt_exec_cmd() ;
            endif ;
          // raffraichissage des infos
                   when *in05                       ;
                   Init_SFL()                     ;
                   Load_SFL()                     ;
                   Display_SFL()                  ;
          // si enter
                   other ;
                   read fmt01   ;
          // si commande à exécuter
                   if cexec <> ' ' ;
            Commande =    cexec ;
            trt_exec_cmd() ;
            cexec = ' ';
                   else ;
                   treatment_SFL()                ;
                   endif ;
                   endsl                          ;
              enddo                               ;
    end-proc ;
    dcl-proc treatment_SFL   ;
       //
        if cle01 > 0                       ;
          readc sfl01                      ;
          if not %eof                      ;
       // Execute
            if Opt01 = '1'                ;
              commande = TXTM ;
              trt_exec_cmd() ;
            endif                 ;
          // modification du message
            if Opt01 = '2'                ;
   // recupération SECLVL
   exec sql
   SELECT  ifnull(MESSAGE_SECOND_LEVEL_TEXT , ' ')
        into :wsecond
        FROM QSYS2.MESSAGE_FILE_DATA
        Where MESSAGE_FILE_LIBRARY = :libm
          and MESSAGE_FILE = :MSGF
          and MESSAGE_ID  = :ID ;
          if sqlcode   <> 0 or wsecond = ' ' ;
            wsecond  = '*SAME' ;
          endif;
    //
             commande = '?CHGMSGD ?*MSGID(' + %trim(id) + ') ?*MSGF(' +
              %trim(libm) + '/' + %trim(msgf)                +
              ') ?*MSG(*SAME) SECLVL(''' + %TRIM(wsecond) + ''')' ;
              trt_exec_cmd() ;
            endif                 ;
            opt01 = ' '                    ;
            num01 = cle01                  ;
            update(e) sfl01                   ;
          endif                            ;
      endif;
    end-proc ;
// Traitement commande avec gestion des erreurs
//
dcl-proc trt_exec_cmd   ;
  error = *off ;
  monitor ;
    Exec_Cmd(commande:%len(commande)) ;
  on-error ;
    error = *on  ;
    dsply 'erreur sur commande';
  endmon ;
end-proc ;
