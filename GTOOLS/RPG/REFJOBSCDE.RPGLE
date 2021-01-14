**free
     // Ce programme référence dans un fichier sortie de DSPPGMREF
     // La liste des programmes du scheduler (WRJOBSCDE) en
     // Créant un poste de type *JOBSCDE
     //
      ctl-opt
      DFTACTGRP(*NO) ;
      // pramètre recu
      Dcl-Pi *N;
       p_fichier          Char(10);
       p_biblio           Char(10);
      End-Pi;
        dcl-s w_Pgm      char(10) ;
        dcl-s w_Lib      char(10) ;
        dcl-s w_Txt      char(50) ;
        dcl-s w_Sql      char(400) ;
        dcl-s w_Sqlcode  like(SQLCODE);
      //
        dcl-s w_Cmd      char(512) ;
        dcl-s w_Job      char(10) ;
        dcl-s pos1     PACKED(4 : 0) ;
        dcl-s pos2     PACKED(4 : 0) ;
        dcl-s pos3     PACKED(4 : 0) ;
         exec sql
         Set Option  CloSqlCsr = *EndMod,
                     commit = *none ;
         // liste des job plannifiés avec un call
         // qui ne sont pas holdés
         exec sql
         declare curs01 cursor for
         SELECT SCHEDULED_JOB_NAME,
                UPPER(COMMAND_STRING),
                ifnull(DESCRIPTION, '*NONE')
         FROM SCHEDULED_JOB_INFO WHERE STATUS <> 'HELD'
              and upper(COMMAND_STRING) like('%CALL%') ;
         exec sql
          open curs01 ;
         dou   w_sqlcode <> 0   ;
         exec sql
         fetch  curs01 into :w_job , :w_cmd , :w_txt ;
           w_sqlcode = sqlcode ;
         if sqlcode <> 0;
           leave          ;
         endif ;
         // traitement d'un programme
            trait_call()                     ;
            ecrit_call()                     ;
         enddo ;
         *inlr = *on ;
       //--------------------------------------------
       // procédures
       //--------------------------------------------
       // Extraction du pgm  et de la bibliothèque
          dcl-proc trait_call      ;
       pos1 = %scan('PGM(' : w_cmd  : 1) ;
       if (pos1 > 0) ;
        // recherche premier /  pour bibliothèque
        pos2   =  %scan('/' : w_cmd  : pos1)  ;
        // si bibliothèque   ou *LIBL
        if (pos2 > 0) ;
          pos3   =  %scan(')' : w_cmd  : 1) ;
          if pos3 > pos2 ;
            // si le / est avant le premier slach
            w_lib  = %subst(w_cmd  : (pos1 + 4) : (pos2 - (pos1 + 4 ) )) ;
          else ;
            // si le / est après la )
            w_lib = '*LIBL' ;
            pos2 = (pos1 + 3) ;
          endif;
        else ;
          // si pas de bibliothèque
          w_lib = '*LIBL' ;
          pos2 = (pos1 + 3) ;
        endif ;
        // recherche premiere )
        pos1   =  %scan(')' : w_cmd  : 1) ;
        // si ) est la première
        w_pgm   = %subst(w_cmd  : (pos2 +1)  : (pos1 - (pos2 + 1) ));
      else ;
        w_pgm  ='*Erreur*' ;
        w_lib  ='*Erreur*' ;
      endif                ;
          end-proc ;
       // Ecriture dans le fichier dsppgmref
          dcl-proc ecrit_call    ;
        // WHFNAM
         w_sql = 'insert into ' + %trim(p_BIBLIO) + '/' + %trim(p_FICHIER) +
         ' (WHLIB, WHPNAM, WHFNAM, WHLNAM, WHTEXT , WHOTYP) +
          values(''*JOB'' , ''' +
          %trim(w_job) + ''' , ''' +
          %trim(w_pgm) + ''' , ''' + %trim(w_lib) +
           ''' , ''' + %XLATE('''': '"': %trim(w_txt))  + ''' , ''*JOBSCDE'' )' ;
          exec sql
          EXECUTE IMMEDIATE :w_sql ;
          if sqlcode <> 0 ;
          dsply ('Erreur' + w_lib + '/' + w_pgm) ;
          endif ;
          end-proc ;
