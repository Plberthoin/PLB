**free
// Modification le 14/07/2019
// Ajout des jobs sécurisés QZDASSINIT
// ajout option 8 Log du travail
      ctl-opt
      DFTACTGRP(*NO) ;
       dcl-f
      WRKSQLJOB  WORKSTN
      SFILE(sfl01:cle01);
  // les paramètres recus
  //
  dcl-pi *N ;
    P_DATE char(10);
  end-pi ;
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
              *in40 = *on                         ;
              write ctl01                         ;
              *in40 = *off                        ;
    end-proc ;
       //
       // Chargement
       //
     dcl-proc Load_SFL        ;
     exec sql
     Drop table QTEMP/DUMP_CACHE ;
     exec sql
     CALL QSYS2.DUMP_PLAN_CACHE (fileschema =>  'QTEMP' ,
                                 Filename  =>  'DUMP_CACHE') ;
          exec sql
             close curs01                         ;
         EXEC SQL
              declare curs01 cursor  for
With job_act (JOB_NAME_SHORT, JOB_USER, JOB_NUMBER, JOB_USER_IDENTITY)
as (SELECT JOB_NAME_SHORT, JOB_USER, JOB_NUMBER,JOB_USER_IDENTITY
FROM TABLE (QSYS2/ACTIVE_JOB_INFO(DETAILED_INFO => 'ALL')) X
where substr(job_user_identity, 1, 1) <>  'Q')
Select  qqjob, ifnull(qvc102, ' '), qqjnum,  ifnull(qqi6, 0) ,
        substr(qq1000, 1, 30)  ,
        substr(qq1000, 1, 1000)  ,
        qquser
  from QTEMP/DUMP_CACHE a join job_act b on
QQJOB = JOB_NAME_SHORT and  QQUSER =  JOB_USER and  QQJNUM = JOB_NUMBER
where ucase(QQ1000)  Like('%SELECT %')
      and qvc102 IS NOT NULL
order by qqi6 desc
        ;
          exec sql
             open curs01                          ;
       // des utilisateurs
       //
              dou   sqlcode <> 0      ;
              exec sql
                fetch from curs01
                  into
                :QQJOB  ,
                :QVC102  ,
                :QQJNUM   ,
                :QQI6     ,
                :REQ30    ,
                :REQ1000  ,
                :QQUSER
                 ;
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
              other ;
              if cle01 > 0 ;
              readc sfl01  ;
              if not %eof() ;
              select ;
              when opt01 = '5' ;
              exec sql
              call qcmdexc('WRKJOB JOB(' concat trim(:QQJNUM) concat '/'
                                      concat trim(:qquser) concat '/'
                                      concat trim(:QQJOB) concat ')' )  ;
              when opt01 = '8' ;
              exfmt fmt02    ;
              endsl ;
              opt01  = ' ' ;
              update(e) sfL01 ;
              endif ;
              endif ;
                   endsl                          ;
              enddo                               ;
    end-proc ;
