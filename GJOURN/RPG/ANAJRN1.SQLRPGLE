**free
// -----------------------------------------------------
//  Ce programme cree un fichier de travail composé
//  des zones du fichiers base de données est des zones spécifiques au
//  dspjrn *outfile
//  Le fichier généré s'appelle analyse dans qtemp
// -----------------------------------------------------
Ctl-Opt DFTACTGRP(*NO);
Dcl-PI *N     ;
  Fichier        Char(10);
  Biblio         Char(10);
End-PI;
//Zones de travail
Dcl-S sqlzon       Char(80);
Dcl-S sqlstm       Char(800);
EXEC SQL
        Set Option
          Naming    = *Sys,
          Commit    = *None,
          UsrPrf    = *User,
          DynUsrPrf = *User,
          Datfmt    = *iso,
          CloSqlCsr = *EndMod;
//------------------------------------------
// Création table  avec les attributs du fichier à  analyser
//------------------------------------------
sqlstm = 'DROP   VIEW QTEMP/ANAJRN  ';
EXEC SQL
 EXECUTE IMMEDIATE :SQLSTM ;
sqlstm = 'drop   table qtemp/analyse';
EXEC SQL
 EXECUTE IMMEDIATE :SQLSTM ;
sqlstm = 'create table qtemp/analyse like '
          + %trim(Biblio) + '/' + %trim(Fichier)     ;
EXEC SQL
 EXECUTE IMMEDIATE :SQLSTM ;
//------------------------------------------
// Ajout des Zones liées à la journalisation
//------------------------------------------
SQLZON =  'JOENTL NUMERIC(5, 0) NOT NULL DEFAULT 0 ' ;
creat()    ;
SQLZON =  'JOSEQN NUMERIC(10, 0) NOT NULL DEFAULT 0 ';
creat()    ;
SQLZON =  'JOCODE CHAR(1) CCSID 297 NOT NULL DEFAULT ''''';
creat()    ;
SQLZON =  'JOENTT CHAR(2) CCSID 297 NOT NULL DEFAULT ''''';
creat()    ;
SQLZON =  'JOJOB CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;
creat()    ;
SQLZON =  'JOUSER CHAR(10) CCSID 297 NOT NULL DEFAULT ''''';
creat()    ;
SQLZON =  'JONBR NUMERIC(6, 0) NOT NULL DEFAULT 0' ;
creat()    ;
SQLZON =  'JOPGM CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;
creat()    ;
SQLZON =  'JOOBJ CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;
creat()    ;
SQLZON =  'JOLIB CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;
creat()    ;
SQLZON =  'JOMBR CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;
creat()    ;
SQLZON =  'JOCTRR NUMERIC(10, 0) NOT NULL DEFAULT 0' ;
creat()    ;
SQLZON =  'JOFLAG CHAR(1) CCSID 297 NOT NULL DEFAULT ''''' ;
creat()    ;
SQLZON =  'JOCCID NUMERIC(10, 0) NOT NULL DEFAULT 0';
creat()    ;
SQLZON =  'JOUSPF CHAR(10) CCSID 297 NOT NULL DEFAULT ''''';
creat()    ;
SQLZON =  'JOSYNM CHAR(8) CCSID 297 NOT NULL DEFAULT ''''';
creat()    ;
SQLZON =  'JOINCDAT CHAR(1) CCSID 297 NOT NULL DEFAULT ''''' ;
creat()    ;
SQLZON =  'JODATE CHAR(6) CCSID 297 NOT NULL DEFAULT '' ''' ;
creat()    ;
SQLZON =  'JOTIME NUMERIC(6, 0) NOT NULL DEFAULT 0';
creat()    ;
SQLZON =  'JOMINESD CHAR(1) CCSID 297 NOT NULL DEFAULT ''''' ;
creat()    ;
// -------------------------------------
// Mise en place des commentaires
//    sur les zones issus du journal
//--------------------------------------
commentaire();
//--------------------------------------
// Création de la vue avec les info de journalisations
//--------------------------------------
Vue_jrn() ;
// -------------------------------------
// Fin du programme
//--------------------------------------
*inlr = *on ;
//--------------------------------------
// Création des zones du journal
//--------------------------------------
dcl-proc creat;
  sqlstm = 'ALTER TABLE  qtemp/analyse ADD COLUMN '
           + sqlzon  ;
  EXEC SQL
   EXECUTE IMMEDIATE :SQLSTM ;
end-proc ;
//--------------------------------------
// Mise en place des commentaires
//--------------------------------------
dcl-proc commentaire ;
  sqlstm ='LABEL ON COLUMN ANALYSE (+
  JOSEQN TEXT IS ''Numéro de séquence'', +
  JOCODE TEXT IS ''Code du poste'',+
  JOENTT TEXT IS ''Type du poste'', +
  JOJOB  TEXT IS ''Nom du job'', +
  JOUSER TEXT IS ''User du job'', +
  JONBR  TEXT IS ''Numéro du job'', +
  JOPGM  TEXT IS ''Nom du programme'', +
  JOOBJ  TEXT IS ''Nom du fichier'', +
  JOLIB  TEXT IS ''Nom de la bibliothèque'', +
  JOMBR  TEXT IS ''Nom du membre'', +
  JODATE TEXT IS ''Date du job'', +
  JOTIME TEXT IS ''Heure du job'')' ;
  EXEC SQL
   EXECUTE IMMEDIATE :SQLSTM ;
end-proc;
//--------------------------------------
// Création d'une vue avec les infos de journalisation
//--------------------------------------
dcl-proc Vue_jrn     ;
  sqlstm ='CREATE VIEW QTEMP/ANAJRN  +
   AS SELECT JOENTT, JOJOB, JOUSER, JONBR, +
  JOPGM, JOCTRR, JODATE, JOTIME +
  FROM QTEMP/ANALYSE' ;
  EXEC SQL
   EXECUTE IMMEDIATE :SQLSTM ;
end-proc ;
