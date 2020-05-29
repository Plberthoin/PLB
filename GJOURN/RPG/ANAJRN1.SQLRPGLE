     h*
     h* Ce programme cree un fichier de travail composÃ©
     h* des zones du fichiers base de donnÃ©es est des zones
     h* dspjrn *outfile
     h* Le fichier s'appelle analyse dans qtemp
     h*
     h DFTACTGRP(*NO)
     D ANAJRN1         PR
     D                               10
     D                               10
     D ANAJRN1         PI
     D Fichier                       10
     D Biblio                        10
     d* Zones de travail
     Dsqlzon           s             80
     Dsqlstm           s            800
      /free

       //******************************************

       // CrÃ©ation table  avec les attributs du fichier Ã  analyser

       //******************************************

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

       //******************************************

       // Mise en place avec les attributs du fichier Ã  analyser

       //******************************************

       SQLZON =  'JOENTL NUMERIC(5, 0) NOT NULL DEFAULT 0 ' ;

        exsr creat ;

       SQLZON =  'JOSEQN NUMERIC(10, 0) NOT NULL DEFAULT 0 ';

        exsr creat ;

       SQLZON =  'JOCODE CHAR(1) CCSID 297 NOT NULL DEFAULT ''''';

        exsr creat ;

       SQLZON =  'JOENTT CHAR(2) CCSID 297 NOT NULL DEFAULT ''''';

        exsr creat ;

       SQLZON =  'JOJOB CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;

        exsr creat ;

       SQLZON =  'JOUSER CHAR(10) CCSID 297 NOT NULL DEFAULT ''''';

        exsr creat ;

       SQLZON =  'JONBR NUMERIC(6, 0) NOT NULL DEFAULT 0' ;

        exsr creat ;

       SQLZON =  'JOPGM CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;

        exsr creat ;

       SQLZON =  'JOOBJ CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;

        exsr creat ;

       SQLZON =  'JOLIB CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;

        exsr creat ;

       SQLZON =  'JOMBR CHAR(10) CCSID 297 NOT NULL DEFAULT ''''' ;

        exsr creat ;

       SQLZON =  'JOCTRR NUMERIC(10, 0) NOT NULL DEFAULT 0' ;

        exsr creat ;

       SQLZON =  'JOFLAG CHAR(1) CCSID 297 NOT NULL DEFAULT ''''' ;

        exsr creat ;

       SQLZON =  'JOCCID NUMERIC(10, 0) NOT NULL DEFAULT 0';

        exsr creat ;

       SQLZON =  'JOUSPF CHAR(10) CCSID 297 NOT NULL DEFAULT ''''';

        exsr creat ;

       SQLZON =  'JOSYNM CHAR(8) CCSID 297 NOT NULL DEFAULT ''''';

        exsr creat ;

       SQLZON =  'JOINCDAT CHAR(1) CCSID 297 NOT NULL DEFAULT ''''' ;

        exsr creat ;

       SQLZON =  'JODATE CHAR(6) CCSID 297 NOT NULL DEFAULT '' ''' ;

        exsr creat ;

       SQLZON =  'JOTIME NUMERIC(6, 0) NOT NULL DEFAULT 0';

        exsr creat ;

       SQLZON =  'JOMINESD CHAR(1) CCSID 297 NOT NULL DEFAULT ''''' ;

        exsr creat ;

        // *************************************

        // Mise en place des commentaires

        //    sur les zones issus du journal

        // *************************************

        exsr commentaire ;

        // *************************************

        // CrÃ©ation de la vue avec les info de journalisation

        // *************************************

        exsr Vue_jrn   ;

        // *************************************

        // Fin du programme

        // *************************************

        *inlr = *on ;

        // ***********************************

        // CrÃ©ation des zones du journal

        // ***********************************

        begsr creat;

        sqlstm = 'ALTER TABLE  qtemp/analyse ADD COLUMN '

                 + sqlzon  ;

        EXEC SQL
         EXECUTE IMMEDIATE :SQLSTM ;
        endsr ;
         begsr commentaire ;

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

        endsr ;

        // ************************************

        // Création d'une vue avec les info de journalisation

        // ************************************

        begsr Vue_jrn     ;

        sqlstm ='CREATE VIEW QTEMP/ANAJRN  +

         AS SELECT JOENTT, JOJOB, JOUSER, JONBR, +

        JOPGM, JOCTRR, JODATE, JOTIME +

        FROM QTEMP/ANALYSE' ;

        EXEC SQL

         EXECUTE IMMEDIATE :SQLSTM ;

        endsr ;

      /end-free
