**free
//
// Ce programme permet d'afficher un dashbord
// des traductions CVTRPGSRC d'une bibliothèque
//
ctl-opt
DFTACTGRP(*NO) ;
dcl-f
  WRKRPG4    WORKSTN
  SFILE(sfl01:cle01);
Dcl-Pi *N;
  p_lib              Char(10);
End-Pi;
dcl-s cle01 PACKED(4 : 0) ;
dcl-s maxcle01 PACKED(4 : 0) ;
dcl-s texte    char(30) ;
dcl-s w_cle    char(20) ;
dcl-s commande CHAR(400) ;
dcl-s error ind ;
DCL-PR  Touche_F4 EXTPGM('TOUCHE_F4');
  p_Sql char(1024) ;
  p_Titre char(35);
  p_Ret    char(45);
END-PR;
dcl-s  w_Sql char(1024) ;
dcl-s w_Titre char(35);
dcl-s w_Ret    char(45);
dcl-s requete char(200);
dcl-s SRCDTA char(100);
dcl-c APOS const('''');
// sql diagnostics
dcl-s MessageId        char(10) ;
dcl-s MessageId1       varchar(7) ;
dcl-s MessageId2       like(MessageId1) ;
dcl-s MessageLength    int(5) ;
dcl-s MessageText      varchar(32740) ;
dcl-s ReturnedSQLCode  char(5) ;
dcl-s ReturnedSQLState char(5) ;
dcl-s RowsCount        int(10) ;
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
Init_SFL() ;
Load_SFL() ;
Display_SFL() ;
//
*inlr = *on ;
//
// Initialisation
//
dcl-proc Init_SFL ;
  num01 = 1 ;
  cle01 = 0 ;
  *in40 = *on ;
  opt01 = ' ' ;
  write ctl01 ;
  *in40 = *off ;
end-proc ;
//
// Chargement
//
dcl-proc Load_SFL ;
*in43 = *OFF ;
  exec sql
     close curs01 ;
  EXEC SQL
       declare curs01 cursor  for
    select LGFRFL , LGFRLB  , LGFRMR, LGTOFL, LGTOLB, LGFRMT, LGTOMR,
    LGSTAT, LGDATE , LGTIME, LGUSER
      from   QRNCVTLG
           order by LGFRFL , LGFRLB  , LGFRMR, LGDATE desc , LGTIME desc ;
  exec sql
     open curs01 ;
  //
  dou   sqlcode <> 0 ;
    exec sql
      fetch
        from curs01
        into
          :LGFRFL ,:LGFRLB  ,:LGFRMR,:LGTOFL,:LGTOLB, :LGFRMT,:LGTOMR,
   :LGSTAT, :LGDATE , :LGTIME, :LGUSER  ;
    if  sqlcode =  0 ;
 // si erreur
   if LGSTAT  >= '30' ;
     *in64 = *on ;
   else ;
     *in64 = *off;
   endif ;
      cle01 = Cle01 + 1 ;
      maxcle01 = Cle01 ;
      write sfl01 ;
    else ;
    *in43 = *on ;
    endif ;
  enddo ;

end-proc ;
//
// Display
//
dcl-proc Display_SFL ;
  *in41 = *on ;
  dou *in03 ;
    if cle01 > 0 ;
      *in42 = *on ;
    else ;
      *in42 = *off ;
    endif ;
    write fmt01 ;
    exfmt ctl01 ;
    if *in03 ;
      leave ;
    endif ;
    select ;
    // raffraichissage des infos
    when *in05 ;
      Init_SFL() ;
      Load_SFL() ;
      Display_SFL() ;
    other ;
      treatment_SFL() ;
    endsl ;
  enddo ;
end-proc ;
//
// treatment
//
dcl-proc treatment_SFL   ;
  //
  if cle01 > 0 ;
    readc sfl01 ;
    if not %eof ;

      select ;
      // Execute


      when Opt01 = '2' ; // --------------------------------------------------
    exec sql
    call qcmdexc('STRSEU  SRCFILE(' concat trim(:LGTOLB) concat '/'
      concat trim(:LGTOFL) concat  ')  SRCMBR(' concat :LGTOMR concat ')') ;
    if sqlcode <> 0 ;
    dsply ('Accès source impossible') ;
    endif;
      when Opt01 = '4' ; // Supression ligne ---------------------------------
    exec sql
    delete from
      QRNCVTLG
    where    LGFRFL=:LGFRFL and
             LGFRLB=:LGFRLB and
             LGFRMR=:LGFRMR and
             LGDATE=:LGDATE and
             LGTIME=:LGTIME   ;
    if sqlcode <> 0 ;
      dsply ('Supression impossible') ;
    else ;
      LGFRFL  = 'Supprimé' ;
      LGFRLB  = 'Supprimé' ;
      LGFRMR  = 'Supprimé' ;
    endif;

      when Opt01 = '5' ; // --------------------------------------------------
      texte = 'Affichage   ' ;
      exfmt fmt02   ;
      when Opt01 = '8' ; // --------------------------------------------------
    exec sql
    call qcmdexc('DSPPFM FILE(' concat trim(:LGTOLB) concat '/QLOGRPG4) MBR(' concat +
      :LGTOMR concat ')') ;
    if sqlcode <> 0 ;
    dsply ('Accès Log impossible') ;
    endif;
      when Opt01 = '9' ; // --------------------------------------------------
    exec sql
    call qcmdexc('STRSEU  SRCFILE(' concat trim(:LGFRLB) concat '/'
      concat trim(:LGFRFL) concat  ')  SRCMBR(' concat :LGFRMR concat ')') ;
    if sqlcode <> 0 ;
    dsply ('Accès source impossible') ;
    endif;
      endsl ;

    endif ;
    opt01 = ' ' ;
    num01 = cle01 ;
 // si erreur
   if LGSTAT  >= '30' ;
     *in64 = *on ;
   else ;
     *in64 = *off;
   endif ;
    update(e) sfl01 ;
  endif ;
end-proc ;
