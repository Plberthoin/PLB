**FREE
// *--------------------------------------------------------------------
// *
// * Ce programme est associé au point d'exit et il se déclenche à
// *    Chaque Execution des commandes CRTPRTF, CRTDSPF, CRTPF et CRTLF
// *  Il utilise un programme RTVMBRSRC qui doit se trouver dans la
// *  liste des bibliothèques
// *
// *
// *
// *
// *--------------------------------------------------------------------
// déclaration des paramètres recus
dcl-pi *N ;
  wparam1           Char(32000);
  replace_string    Char(32000);
  replace_length Bindec(9);
end-pi ;
// commande à traiter
Dcl-DS param1 ;
  Exit_point_Name Char(20);
  Exit_point_Format Char(8);
  Command_Name   Char(10);
  Library_Name   Char(10);
  Change         Ind;
  prompt         Ind;
  *N             Char(2);
  Offset         Bindec(9);
  Command_length  Bindec(9);
  command_string  Char(31000);
End-DS;
 // chaine de remplacement
// longueur de la commande renvoyée
// Variables de travail
Dcl-S srcdta       Char(80);
Dcl-S Cmdsql       Char(512);
Dcl-S P_lib       Char(10);
Dcl-S P_fil       Char(10);
Dcl-S p_MBR       Char(10);
Dcl-S  Format_String  Char(32000);
DCL-PR  RTVMBRSRC EXTPGM('RTVMBRSRC');
  p_data   char(3200) ;
  p_lib   char(10) ;
p_fil   char(10) ;
p_mbr   char(10) ;
END-PR;
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
// Récupération de la commande recue
param1 = wparam1 ;
format_string  =  %subst(param1 : (Offset + 1) : Command_length) ;
format_string  = 'QSYS/' + format_string ;
//
// Récupération du membre source
//
RTVMBRSRC(format_string:P_Lib:P_Fil:P_Mbr)   ;
// Si *CURLIB
if   p_lib = '*CURLIB' ;
exec sql
SELECT substr(NAME , 1 , 10) into :P_lib FROM QSYS2.LIBRARY_LIST_INFO WHERE
        type = 'CURRENT' ;
if sqlcode = 100 ;
p_lib = 'QGPL'    ;
ENDIF;
endif;
// Récupération du membre source
cmdsql = 'DROP   ALIAS QTEMP/INPUT';
exec sql
EXECUTE IMMEDIATE :Cmdsql ;
// si *LIBL
if     p_lib = '*LIBL' ;
cmdsql =   'CREATE ALIAS QTEMP/INPUT FOR '  +
     %trim(p_fil) +  ' (' + %trim(p_mbr) + ')' ;
else    ;
cmdsql =   'CREATE ALIAS QTEMP/INPUT FOR ' + %trim(p_lib) + '/' +
%trim(p_fil) + ' (' + %trim(p_mbr) + ')' ;
ENDIF;
exec sql
EXECUTE IMMEDIATE :Cmdsql   ;
exec sql
close curs01                         ;
EXEC SQL
declare curs01 cursor  for
select substr(srcdta, (locate('<COMP>', srcdta) + 6) ,
(( locate('</COMP>', srcdta) - 1) -
 (locate('<COMP>', srcdta) +5) )) as srcdta
  from QTEMP/INPUT
  where srcdta like('%<COMP>%') and  srcdta like('%</COMP>%') ;
exec sql
open curs01                          ;
// boucle de lecture des options de compile
dou   sqlcode <> 0      ;
exec sql
fetch
from curs01
into
:srcdta  ;,
if  sqlcode =  0    ;
format_string = %trim(format_string) + ' ' + %trim(srcdta ) ;
endif;
enddo ;
// Passage variable transformée
replace_string = format_string ;
replace_length  = %len(%trim(replace_string)) ;
// Fin du programme
*inlr = *on ;
