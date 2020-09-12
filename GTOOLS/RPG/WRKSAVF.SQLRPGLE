**free
// Modification le 04/08/2019
// controle date paramètre en entrée
      ctl-opt
      DFTACTGRP(*NO) ;
       dcl-f
      WRKSAVF    WORKSTN  indds(DS_Ind)
      SFILE(sfl01:cle01);
  // les paramètres recus
  //
  dcl-pi *N ;
    P_LIB char(10);
  end-pi ;

  // déclaration INDDS
dcl-ds DS_Ind len(99) ;
  Ind_Sortie                        ind pos(3) ;
  Ind_Reaffichage                   ind pos(5) ;
  Ind_SFLCLR                        ind pos(40) ;
  Ind_SFLDSP                        ind pos(41) ;
  Ind_SFLDSPCTL                     ind pos(42) ;
END-DS;

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
        // init user        //
                     w_cle  =  'GAIA_2017'  ;
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
              Ind_SFLCLR = *on                         ;
              write ctl01                         ;
              Ind_SFLCLR = *off                        ;
    end-proc ;
       //
       // Chargement
       //
     dcl-proc Load_SFL        ;
         EXEC SQL
   SELECT count(*) into :nbsavf
     FROM TABLE (QSYS2.OBJECT_STATISTICS(:P_LIB,'*FILE') ) AS X
   WHERE OBJATTRIBUTE = 'SAVF' ;
          exec sql
             close curs01                         ;
         EXEC SQL
              declare curs01 cursor  for
   SELECT objname, objlib, ifnull(objtext, ' ') as objtext
     FROM TABLE (QSYS2.OBJECT_STATISTICS(:P_LIB,'*FILE') ) AS X
   WHERE OBJATTRIBUTE = 'SAVF'
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
      :savf, :slib, :stext  ;
              if  sqlcode =  0                    ;
                  cle01 = Cle01 + 1                 ;
                  maxcle01 = Cle01    ;
                  write sfl01                       ;
      // si sous fichier plein
                  if cle01 = 9999 ;
                    dsply 'Sous fichier plein' ;
                    leave ;
                  endif ;
                endif         ;
              enddo                               ;

    end-proc ;
       //
       // Display
       //
    dcl-proc Display_SFL     ;
              Ind_SFLDSP = *on                         ;
              dou Ind_Sortie                          ;
              if cle01 > 0                        ;
                Ind_SFLDSPCTL = *on                       ;
              else                                ;
                Ind_SFLDSPCTL = *off                      ;
              endif                               ;
                 write fmt01                      ;
                 exfmt ctl01                      ;
                   if Ind_Sortie                   ;
                     leave                        ;
          //       affichage du detail
                   endif                          ;
                   select                         ;
          // raffraichissage des infos
                   when Ind_Reaffichage                       ;
                   Init_SFL()                     ;
                   Load_SFL()                     ;
                   Display_SFL()                  ;
                   other                          ;
          //       affichage du detail
                   if Ind_SFLDSPCTL ;
                   readc sfl01                    ;
                   if not %eof() ;
                   select                         ;
                   when opt01 = '2'                 ;
                   exec sql
                   call qcmdexc('?chgsavf ' concat trim(:slib)
                   concat '/' concat trim(:savf));
                   when opt01 = '4'                 ;
                   exec sql
                   call qcmdexc('?dltf ' concat trim(:slib)
                   concat '/' concat trim(:savf));
                   when opt01 = '5'                 ;
                   exec sql
                   call qcmdexc('?dspsavf ' concat trim(:slib)
                   concat '/' concat trim(:savf));
                   when opt01 = '6'                 ;
                   exec sql
                   call qcmdexc('?clrsavf ' concat trim(:slib)
                   concat '/' concat trim(:savf));
                   when opt01 = '8'               ;
                   exec sql
                   call qcmdexc('?dspobjd ' concat trim(:slib)
                   concat '/' concat trim(:savf) concat ' *file');
                   when opt01 = '9'                 ;
                   exec sql
                   call qcmdexc('?savsavfdta ' concat trim(:slib)
                   concat '/' concat trim(:savf));
                   endsl ;
                   opt01 = ' '                    ;
                   update(e) sfl01                ;
                   else ;
                      Init_SFL()                     ;
                      Load_SFL()                     ;
                      Display_SFL()                  ;
                   endif ;
                   else ;
                      Init_SFL()                     ;
                      Load_SFL()                     ;
                      Display_SFL()                  ;
                   endif ;
                   endsl                          ;
              enddo                               ;
    end-proc ;
