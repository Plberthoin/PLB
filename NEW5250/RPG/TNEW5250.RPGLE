**free
//
// Exemple d'utilisation des fonctions de NEW5250
//
Ctl-Opt DFTACTGRP(*NO) BNDDIR('NEW5250') ;
// déclaration NEW5250
/include NEW5250INC ;
 dcl-ds *N PSDS;
   JOB CHAR(10)  POS(244);
 end-ds;
// variables de travail
 DCL-S G_SqlStm Char(1024) ;
 DCL-S G_Result Char(45) ;
 DCL-S G_status Char(2) ;
 DCL-S Date1    Date(*iso);
 DCL-S W_type   char(10) ;
 //
 //  Controle taille de l'écran
 //
 W_type = Getdevtype('*')   ;
 dsply W_type ;
 //
 //  Exemple Box
 //
 Affichage_Box('Opération DB' : 'Mise à jour effectuée')   ;
 //
 //  Exemple Validation
 //
 Affichage_Valid('Confirmer' : 'Veuillez confirmer' :
                   'La supression de ..:' : ' ' : G_status) ;
     if G_status = 'OK' ;
     dsply 'Validation Ok' ;
     else ;
     dsply 'Validation Ko' ;
     endif;
 //
 //  Exemple Liste
 //
 G_sqlstm = ' SELECT  OPTION  concat ''!'' +
                concat substr(COMMAND , 1 , 50) From QAUOOPT' ;

 Affichage_Liste(G_sqlstm : 'Les commandes PDM ' : g_result)   ;
 dsply g_result ;
 //
 //  Exemple calendrier
 //
 Affichage_Date(Date1)   ;
 dsply Date1;
 //
 //  Exemple commande IBMi
 //
 Ligne_Commande(' ')  ;

 *inlr = *on   ;
