**free
Ctl-Opt DFTACTGRP(*NO) BNDDIR('NEW5250') ;
// declaration NEW5250
/include NEW5250INC ;
// variables de travail
 DCL-S G_SqlStm Char(1024) ;
 DCL-S G_Result Char(45) ;
 DCL-S G_status Char(2) ;
 DCL-S Date1    Date(*iso);
 DCL-S Date2    Date(*iso);
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
 Affichage_Date(Date1 : Date2 )   ;
 dsply Date1   ;

 *inlr = *on   ;
