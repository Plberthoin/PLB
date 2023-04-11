**free
ctl-opt
   DFTACTGRP(*NO) ;
 // pour compiler le fichier sqlliste doit exister dans la *LIBL
 // CREATE TABLE PLB/SQLLISTE (IDSQL CHAR ( 7) NOT NULL WITH DEFAULT,
 // CMDSQL CHAR (2048) NOT NULL WITH DEFAULT)
// Variables de travail
Dcl-S  WW264  Char(2048);
Dcl-S  W32  Char(32);
dcl-s w_deb_sql   ind ;
DCL-DS W_sqlliste  EXTNAME('SQLLISTE')
END-DS ;
dcl-s w_idsql  char(7) ;
dcl-s w_pos  PACKED(7:0);
dcl-s w_len  PACKED(7:0);
// options SQL
EXEC SQL
              Set Option
                Naming    = *Sys,
                Commit    = *None,
                UsrPrf    = *User,
                DynUsrPrf = *User,
                Datfmt    = *iso,
                CloSqlCsr = *EndMod;
// preparation du curseur
exec sql
      close curs01                         ;
EXEC SQL
     declare curs01 cursor  for
  SELECT substr( w132 , 88 , 32 ) FROM w132
  ;
exec sql
   open curs01                          ;
//
dou   sqlcode <> 0      ;
  exec sql
    fetch
      from curs01
      into     :w32 ;
  if sqlcode <> 0    ;
    leave ;
  endif ;
  // Début des instructions SQL
  // Avant les instrcutions SQL
  //
  if not w_deb_sql  ;
    ww264 =  w32    ;
  else ;
    ww264 =  %trim(ww264) + w32    ;
  endif ;
  If %scan(' SQL': ww264) > 0;
    // Début des instructions SQL
    if not w_deb_sql  ;
      w_deb_sql = *on ;
    endif ;
  endif ;
  // On traite  si instruction SQL
  if w_deb_sql  ;
    // Extraction de L'ID
    // recherche id SQL  et SQL complet SQLXXXX
    w_pos = %scan(' SQL': WW264) ;
    If ( w_pos > 0)  and (%subst(ww264:( w_pos+ 4): 1) <> ' ')
      and (%subst(ww264:( w_pos+ 5): 1) <> ' ')
      and (%subst(ww264:( w_pos+ 6): 1) <> ' ')
      and (%subst(ww264:( w_pos+ 7): 1) <> ' ') ;
      idsql= w_idsql ;
      w_idsql= %subst(ww264 : (%scan(' SQL': ww264) + 1) : 7) ;
      // on prend du début au SQLXXXX
      cmdsql = %subst(ww264 : 1 :   %scan(' SQL': ww264) - 1)      ;
      if idsql <> ' ';
        ecriture();
      endif;
      // On commence la suite de chaine
      // On prend après le SQLXXXX  jusqu'à la fin
      w_pos  = (%scan(' SQL': ww264) + 8) ;
      w_len  = (%size(%trim(ww264)) - (%scan(' SQL': ww264) ))  ;
      ww264= %subst(ww264 : w_pos : w_len);
    // si dernier caractére à blanc
    endif ;
  endif ;
enddo ;
*inlr = *on ;
//
//  Ecriture résultat
//
dcl-proc ecriture ;
  // ecriture
  exec sql
  insert into sqlliste VALUES(:idsql, :cmdsql) ;
  if sqlcode = 0  ;
  endif;
end-proc ;
