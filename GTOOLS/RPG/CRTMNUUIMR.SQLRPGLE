**free
//
// Création d'un menu en UIM
// En partant du fichier des messages crée dans QTEMP
//
ctl-opt
DFTACTGRP(*NO) ;
// Paramètres recus
  Dcl-Pi *N;
    p_lib              Char(10);
    p_msg              char(10);
    p_soc              Char(30);
  End-Pi;
// Variables
dcl-s SRCSEQ  Zoned(6:2);
dcl-s SRCDAT  Zoned(6:0);
dcl-s SRCDTA  Char(100);
dcl-s w_sqlcode like(sqlcode)               ;
dcl-s w_txt char(50);
dcl-s id char(2) ;
dcl-s cmd char(132) ;
dcl-s opt char(80) ;
// paramétres SQL
EXEC SQL
  Set Option Naming = *Sys,
             Commit = *None,
             UsrPrf = *User,
             DynUsrPrf = *User,
             Datfmt = *iso,
             CloSqlCsr = *EndMod;
  //
          exec sql
             close curs01                         ;
         EXEC SQL
              declare curs01 cursor  for
SELECT  MESSAGE_TEXT ,  MESSAGE_SECOND_LEVEL_TEXT ,
        substr(MESSAGE_ID , 6 , 2)
        FROM QSYS2.MESSAGE_FILE_DATA
        Where MESSAGE_FILE_LIBRARY = 'QGPL'
          and MESSAGE_FILE = :p_msg
   ;
          exec sql
             open curs01                          ;
srcdta = ':PNLGRP.' ;
Ecriture() ;
srcdta = ':COPYR.' ;
Ecriture() ;
srcdta = '(@) COPYRIGHT ' + p_soc ;
Ecriture() ;
srcdta = ':VAR      NAME=ZMENU.' ;
Ecriture() ;
srcdta = ':KEYL     NAME=MENUKEYS' ;
Ecriture() ;
srcdta = '          HELP=KEYL.';
Ecriture() ;
srcdta = ':KEYI     KEY=F1';
Ecriture() ;
srcdta = '          HELP=HELPF1';
Ecriture() ;
srcdta = '          ACTION=HELP.';
Ecriture() ;
srcdta = ':KEYI     KEY=F3';
Ecriture() ;
srcdta = '          HELP=EXIT';
Ecriture() ;
srcdta = '          ACTION=''EXIT SET''' ;
Ecriture() ;
srcdta = '          VARUPD=NO.';
Ecriture() ;
srcdta = 'F3=Exit' ;
Ecriture() ;
srcdta = ':KEYI     KEY=F4' ;
Ecriture() ;
srcdta = '          HELP=PROMPT' ;
Ecriture() ;
srcdta = '          ACTION=PROMPT.';
Ecriture() ;
srcdta = 'F4=Prompt';
Ecriture() ;
srcdta = ':KEYI     KEY=F9';
Ecriture() ;
srcdta = '          HELP=RETRIEVE';
Ecriture() ;
srcdta = '          ACTION=RETRIEVE.';
Ecriture() ;
srcdta ='F9=Retrieve';
Ecriture() ;
srcdta = ':KEYI     KEY=F12';
Ecriture() ;
srcdta = '          HELP=CANCEL';
Ecriture() ;
srcdta = '          ACTION=''CANCEL SET''';
Ecriture() ;
srcdta = '          VARUPD=NO.';
Ecriture() ;
srcdta = 'F12=Cancel';
Ecriture() ;
srcdta = ':KEYI     KEY=F24';
Ecriture() ;
srcdta = '          HELP=MOREKEYS';
Ecriture() ;
srcdta = '          ACTION=MOREKEYS.';
Ecriture() ;
srcdta = 'F24=More keys';
Ecriture() ;
srcdta = ':KEYI     KEY=ENTER';
Ecriture() ;
srcdta = '          HELP=enter';
Ecriture() ;
srcdta = '          ACTION=ENTER.';
Ecriture() ;
srcdta = ':KEYI     KEY=HELP'     ;
Ecriture() ;
srcdta = '          HELP=HELP' ;
Ecriture() ;
srcdta = '          ACTION=HELP.';
Ecriture() ;
srcdta = ':KEYI     KEY=HOME';
Ecriture() ;
srcdta = '          HELP=HOME';
Ecriture() ;
srcdta = '          ACTION=HOME.';
Ecriture() ;
srcdta = ':KEYI     KEY=PAGEDOWN';
Ecriture() ;
srcdta = '          HELP=PAGEDOWN';
Ecriture() ;
srcdta = '          ACTION=PAGEDOWN.';
Ecriture() ;
srcdta = ':KEYI     KEY=PAGEUP';
Ecriture() ;
srcdta = '          HELP=PAGEUP';
Ecriture() ;
srcdta = '          ACTION=PAGEUP.';
Ecriture() ;
srcdta = ':KEYI     KEY=PRINT';
Ecriture() ;
srcdta = '          HELP=PRINT';
Ecriture() ;
srcdta = '          ACTION=PRINT.';
Ecriture() ;
srcdta = ':EKEYL.';
Ecriture() ;
srcdta = ':PANEL    NAME=MENU2';
Ecriture() ;
srcdta = '          HELP=''MENU/HELP''';
Ecriture() ;
srcdta = '          KEYL=MENUKEYS';
Ecriture() ;
srcdta = '          ENTER=''MSG CPD9817 QCPFMSG''';
Ecriture() ;
srcdta = '          PANELID=ZMENU';
Ecriture() ;
srcdta = '          TOPSEP=SYSNAM.';
Ecriture() ;
// recupération texte
exec sql
    SELECT ifnull(objtext, OBJNAME)  into :w_txt
        FROM TABLE(QSYS2.OBJECT_STATISTICS('QGPL' ,
                                           '*MSGF',
                       OBJECT_NAME =>  :p_msg)) A   ;
srcdta = w_txt ;
Ecriture() ;
srcdta =':MENU     DEPTH=''*''';
Ecriture() ;
srcdta ='          SCROLL=NO';
Ecriture() ;
srcdta ='          BOTSEP=SPACE.';
Ecriture() ;
srcdta =':TOPINST.Sélectionnez une option:';
Ecriture() ;
// Boucle des options
              dou w_sqlcode <> 0      ;
              exec sql
                fetch
                  from curs01
                  into
                     :cmd , :opt , :id ;
              w_sqlcode = sqlcode  ;
              if w_sqlcode =  0                    ;
srcdta =':MENUI    OPTION=' + id + ' ACTION=''CMD ' + %trim(CMD) + '''';
Ecriture() ;
srcdta ='          HELP=''MENU/OPTION' + id + '''.';
Ecriture() ;
srcdta = opt        ;
Ecriture() ;
              endif;
              enddo ;
// fin de boucle
srcdta =':EMENU.';
Ecriture() ;
srcdta =':CMDLINE SIZE=short.Paramètre et commande';
Ecriture() ;
srcdta =':EPANEL.';
Ecriture() ;
srcdta =':HELP     NAME=KEYL.';
Ecriture() ;
srcdta ='FUNCTION KEYS - HELP';
Ecriture() ;
srcdta =':XH3.FUNCTION KEYS';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=HELPF1.';
Ecriture() ;
srcdta =':PARML.' ;
Ecriture() ;
srcdta =':PT.F1=HELP';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Aide sur l''utilisation du menu.';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=EXIT.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.F3=EXIT';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Sortie de ce menu';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=PROMPT.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.F4=PROMPT';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Invite de commande';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=RETRIEVE.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.F9=RETRIEVE';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Liste des commandes précédentes';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=CANCEL.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.F12=CANCEL';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Retours à la commande précédente.';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta = ':HELP     NAME=MOREKEYS.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.F24=MORE KEYS';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Touches supplémentaires.';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=ENTER.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.ENTER';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Soumettre une commande ...';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=HELP.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.HELP';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Aide complémentaire sur l''affichage.';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=HOME.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.HOME';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Affichage.';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=PAGEDOWN.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.PAGE DOWN (ROLL DOWN)';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Options suivantes.';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=PAGEUP.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.PAGE UP (ROLL UP)';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Options précédentes.';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=PRINT.';
Ecriture() ;
srcdta =':PARML.';
Ecriture() ;
srcdta =':PT.PRINT';
Ecriture() ;
srcdta =':PD.';
Ecriture() ;
srcdta ='Impression des informations en cours.';
Ecriture() ;
srcdta =':EPARML.';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
srcdta =':HELP     NAME=''MENU/HELP''.';
Ecriture() ;
srcdta = %trim(w_txt) + ' - HELP' ;
Ecriture() ;
srcdta =':P.';
Ecriture() ;
srcdta ='Ce menu vous permet de ...';
Ecriture() ;
srcdta =':XH3.';
Ecriture() ;
srcdta ='Comment utiliser ce menu';
Ecriture() ;
srcdta =':P.';
Ecriture() ;
srcdta ='Selectionner une option, ou tapez une commande et presser ENTER.';
Ecriture() ;
srcdta =':P.';
Ecriture() ;
srcdta ='Pour utiliser les commandes, vous pouvez demander une invite par <F4>';
Ecriture() ;
srcdta =' et <F9> Pour rappeler une commande historisé.';
Ecriture() ;
srcdta =':P.';
Ecriture() ;
srcdta ='Vous pouvez lancer un autre menu par GO';
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
// boucle de lecture
          exec sql
             close curs01                         ;
          exec sql
             open  curs01                         ;
              dou  W_SQLCODE <> 0      ;
              exec sql
                fetch
                  from curs01
                  into
                     :cmd , :opt , :id ;
              w_sqlcode = sqlcode;
              if  w_sqlcode =  0                    ;
srcdta =':HELP     NAME=''MENU/OPTION'+ ID +'''.';
Ecriture() ;
srcdta ='OPTION ' + ID + ' - HELP';
Ecriture() ;
srcdta =':XH3.OPTION ' + ID + '.' + %trim(cmd) ;
Ecriture() ;
srcdta =':P.';
Ecriture() ;
srcdta ='Sélectionnez cette option ...';
Ecriture() ;
srcdta =':P.';
Ecriture() ;
srcdta ='Cette option, ' + opt ;
Ecriture() ;
srcdta =':EHELP.';
Ecriture() ;
endif ;
enddo ;
srcdta =':EPNLGRP.';
Ecriture() ;
// Fin de programme
*inlr = *on ;
//
// Ecriture dans le Fichier
//
dcl-proc ecriture          ;
  srcseq = srcseq + 05 ;
  exec sql
    insert into Qmnusrc  values(:srcseq, :srcdat, :srcdta) ;
end-proc;
