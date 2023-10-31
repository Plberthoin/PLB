**free
// Ce Programme crée un Menubar
// Source RPGLE
// Source DDS
//
ctl-opt
DFTACTGRP(*NO) ;
// paramètres recus
Dcl-Pi *N;
  P_MBR       CHAR(10);  // Nom du membre écran
  P_MNU1      CHAR(10);  // Nom du menu1
  P_MNU1OPT1  CHAR(10);  // Option 1
  P_MNU1OPT2  CHAR(10);  // Option 2
  P_MNU1OPT3  CHAR(10);  // Option 3
  P_MNU2      CHAR(10);  // Nom du menu2
  P_MNU2OPT1  CHAR(10);  // Option 1
  P_MNU2OPT2  CHAR(10);  // Option 2
  P_MNU2OPT3  CHAR(10);  // Option 3
End-Pi;
// Déclaration fichiers
dcl-ds *N PSDS;
  current_user CHAR(10)POS(358);
end-ds;



// Option SQL
EXEC SQL
    Set Option
      Naming    = *Sys,
      Commit    = *None,
      UsrPrf    = *User,
      DynUsrPrf = *User,
      Datfmt    = *eur,
      CloSqlCsr = *EndMod;
// Génération du source DDS
Source_DDS();
// Génération du source RPG
Source_RPG();
*inlr = *on ;
//
// Procédures
//
//
// Ecriture du source RPG
//
dcl-proc ecriture_RPG ;
  Dcl-Pi *n;
    p_srcdta Char(100) Const;
  End-Pi;
  // ecriture
  exec sql
  insert into RPG VALUES(0, 0, :P_srcdta) ;
  if sqlcode = 0  ;
  ENDIF;
end-proc ;
//
// Ecriture du source DDS
//
dcl-proc ecriture_DDS ;
  Dcl-Pi *n;
    p_srcdta Char(100) Const;
  End-Pi;
  // ecriture
  exec sql
  insert into DDS VALUES(0, 0, :P_srcdta) ;
  if sqlcode = 0  ;
  ENDIF;
end-proc ;
// Génération du source DDS
dcl-proc  Source_DDS ;
  ecriture_DDS('     A* Généré par GENMNUBAR                  ') ;
  ecriture_DDS('     A* le  :' + %char(%date()) );
  ecriture_DDS('     A* par : ' + current_user) ;
  ecriture_DDS('     A* ');
  ecriture_DDS('     A                                      DSPSIZ(27 132 *DS4)') ;
  ecriture_DDS('     A                                      MNUCNL(CA12) ') ;
  ecriture_DDS('     A                                      CA03(03 ''EXIT'')') ;
  ecriture_DDS('     A* déclaration du menu') ;
  ecriture_DDS('     A          R MB                        MNUBAR ') ;
  ecriture_DDS('     A            MNUFLD         2Y 0B  1  2') ;
  ecriture_DDS('     A                                      MNUBARCHC(1 ' + %trim(P_MNU1) +  ' +');
  ecriture_DDS('     A                                                ''' +  %trim(P_MNU1) + ''')');
  ecriture_DDS('     A                                      MNUBARCHC(2 ' + %trim(P_MNU2) +  ' +');
  ecriture_DDS('     A                                                ''' +  %trim(P_MNU2) + ''')');
  ecriture_DDS('     A                                      MNUBARSEP((*CHAR ''_''))') ;
  ecriture_DDS('     A* déclaration du menu dans le format') ;
  ecriture_DDS('     A          R FMT01                                                 ') ;
  ecriture_DDS('     A                                      MNUBARDSP(MB &MNUCHC &PULL) ') ;
  ecriture_DDS('     A                                 11 10''// ici vos textes''') ;
  ecriture_DDS('     A            MNUCHC         2Y 0H       ') ;
  ecriture_DDS('     A            PULL           2S 0H   ') ;
  ecriture_DDS('     A* Déclaration du bas de page') ;
  ecriture_DDS('     A            F1B            2Y 0B 26  2PSHBTNFLD') ;
  ecriture_DDS('     A                                      PSHBTNCHC(1 ''F3=>Exit'' CA03)') ;
  ecriture_DDS('     A                                      PSHBTNCHC(2 ''E>nter'' ENTER)') ;
  ecriture_DDS('     A* déclaration des options de menu') ;
  ecriture_DDS('     A          R ' + P_MNU1 + '                   PULLDOWN ') ;
  ecriture_DDS('     A            F1             2Y 0B  1 02SNGCHCFLD(*AUTOENT)   ') ;
  ecriture_DDS('     A                                      CHOICE(1 ''' + %trim(P_MNU1OPT1) +
      ''')') ;
  ecriture_DDS('     A                                      CHCCTL(1 &C11)   ') ;
  ecriture_DDS('     A                                      CHOICE(2 ''' + %trim(P_MNU1OPT2) +
       ''')') ;
  ecriture_DDS('     A                                      CHCCTL(2 &C12)  ') ;
  ecriture_DDS('     A                                      CHOICE(3 ''' + %trim(P_MNU1OPT3) +
       ''')') ;
  ecriture_DDS('     A                                      CHCCTL(3 &C13)  ') ;
  ecriture_DDS('     A            C11            1Y 0H ') ;
  ecriture_DDS('     A            C12            1Y 0H ') ;
  ecriture_DDS('     A            C13            1Y 0H ') ;
  ecriture_DDS('     A          R ' + P_MNU2 + '                   PULLDOWN ') ;
  ecriture_DDS('     A            F1             2Y 0B  1 02SNGCHCFLD(*AUTOENT)   ') ;
  ecriture_DDS('     A                                      CHOICE(1 ''' + %trim(P_MNU2OPT1) +
      ''')') ;
  ecriture_DDS('     A                                      CHCCTL(1 &C21)   ') ;
  ecriture_DDS('     A                                      CHOICE(2 ''' + %trim(P_MNU2OPT2) +
       ''')') ;
  ecriture_DDS('     A                                      CHCCTL(2 &C22)  ') ;
  ecriture_DDS('     A                                      CHOICE(3 ''' + %trim(P_MNU2OPT3)  +
      ''')') ;
  ecriture_DDS('     A                                      CHCCTL(3 &C23)  ') ;
  ecriture_DDS('     A            C21            1Y 0H ') ;
  ecriture_DDS('     A            C22            1Y 0H ') ;
  ecriture_DDS('     A            C23            1Y 0H ') ;
end-proc ;
// Génération du source RPG
dcl-proc  Source_Rpg ;
  ecriture_rpg('**free                                              ');
  ecriture_rpg(' // Généré par GENMNUBAR                              '                   );
  ecriture_rpg('     // le  :' + %char(%date()) );
  ecriture_rpg('     // par : ' + current_user) ;
  ecriture_rpg('     // ');
  ecriture_rpg('       Dcl-F '+ P_MBR + '  WORKSTN ;                                     ');
  ecriture_rpg('       CLEAR FMT01 ;                                                       ');
  ecriture_rpg('       DoW Not *IN03 ;                                                  ');
  ecriture_rpg('         Exfmt FMT01;                                                      ');
  ecriture_rpg('         If NOT *IN03;                                                   ');
  ecriture_rpg(' // traitement menu 1                                                    ');
  ecriture_rpg('           if MNUCHC > 0 ;                                                 ');
  ecriture_rpg('             Select ;                                                      ');
  ecriture_rpg('             when MNUCHC = 1 ;                                             ');
  ecriture_rpg('              DSPLY ''Menu_1'' ;                                             ');
  ecriture_rpg('               If PULL > 0;                                                ');
  ecriture_rpg('                 Select ;                                                  ');
  ecriture_rpg('                 When  PULL = 1;                                           ');
  ecriture_rpg('                   DSPLY ''Menu_1 option_1'';                              ');
  ecriture_rpg('                 When  PULL = 2;                                           ');
  ecriture_rpg('                   DSPLY ''Menu_1 option_2'';                              ');
  ecriture_rpg('                 when  PULL = 3;                                           ');
  ecriture_rpg('                   DSPLY ''Menu_1 option_3'';                              ');
  ecriture_rpg('                 Endsl;                                                    ');
  ecriture_rpg('               EndIf;                                                      ');
  ecriture_rpg(' // traitement menu 2                                                   ');
  ecriture_rpg('             when MNUCHC = 2 ;                                             ');
  ecriture_rpg('              DSPLY ''Menu_2'' ;                                             ');
  ecriture_rpg('               If PULL > 0;                                                ');
  ecriture_rpg('                 Select ;                                                  ');
  ecriture_rpg('                 When  PULL = 1;                                           ');
  ecriture_rpg('                   DSPLY ''Menu_2 option_1'';                              ');
  ecriture_rpg('                 When  PULL = 2;                                           ');
  ecriture_rpg('                   DSPLY ''Menu_2 option_2'';                              ');
  ecriture_rpg('                 when  PULL = 3;                                           ');
  ecriture_rpg('                   DSPLY ''Menu_2 option_3'';                              ');
  ecriture_rpg('                 Endsl;                                                    ');
  ecriture_rpg('               EndIf;                                                      ');
  ecriture_rpg('             endsl ;                                                       ');
  ecriture_rpg('           endif;                                                          ');
  ecriture_rpg('         EndIf;                                                            ');
  ecriture_rpg('       EndDo;                                                              ');
  ecriture_rpg('       *INLR = *On;                                                        ');
end-proc ;
