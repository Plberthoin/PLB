**free
// Ce programme convertit un fichier DB2 en JSON
// Le fichier généré s'appellera
//       fichier_bibliothèque.json
// Le fichier sql de génération
//       CVTFICJSON.SQL
// le buffer est limité à 32000 vous pouvez passer sur du Blob
//
// Paramètres de compile
//
ctl-opt dftactgrp(*no) ;
//
// Paramètres recus
//
dcl-pi *n ;
  p_QualFile    char(20)  const ;  // Bibliothèque + fichier
  p_Agreg       char(4) const ;    // Agrégé les données
  p_Script      char(4) const ;    // garder le scripte
end-pi ;

// Variables globales
dcl-s g_Lib  char(10) ;
dcl-s g_File char(10) ;
dcl-s position  int(10)      ;
dcl-s nom       varchar(10) ;
dcl-s type      varchar(8)  ;
dcl-s length    int(10)     ;
dcl-s numscl    int(10)      ;
dcl-s nullable  char(1)     ;
dcl-s precision int(10)      ;
dcl-s ccsid     int(10)      ;
dcl-s g_sqlStmt char(9999) inz('') ;
dcl-s g_first   char(1) inz('O') ;
// Controle des paramétres recus
if %parms() < 3 ;
 //  snd-msg *ESCAPE %MSG('CPF9898' : 'QCPFMSG' : '3 paramètres obligatoires' ) ;
 dsply   '3 paramètres obligatoires'  ;
  return;
else;
  g_Lib  = %upper(%subst(p_QualFile : 11 : 10 )) ;
  g_File = %upper(%subst(p_QualFile :  1 : 10 )) ;
endif ;
 // Vérification existence du fichier BD
 if not chkFile( g_Lib : g_File ) ;
   snd-msg *ESCAPE %MSG('CPF3012' : 'QCPFMSG' : g_File + g_Lib )
    %TARGET(*CALLER:1) ;
   return ;
 endif ;
exec sql
  declare CURS01  cursor for
    select ORDINAL_POSITION,
           SYSTEM_COLUMN_NAME,
           DATA_TYPE,
           LENGTH,
           coalesce(NUMERIC_SCALE, 0),
           IS_NULLABLE ,
           coalesce(NUMERIC_PRECISION, 0) ,
           coalesce(ccsid, 0)
    from qsys2.syscolumns
      where system_table_schema = :g_Lib and
      system_table_name = :g_File
    order by ORDINAL_POSITION
   ;
// formatage requete SQL debut de chaine
g_sqlStmt = 'BEGIN ' +
  'CALL QSYS2.IFS_WRITE_UTF8(PATH_NAME => ''' + %trim(g_lib) + '_' + %trim(g_file) + '.json'', ' +
                       'LINE => '''', ' +
                       'OVERWRITE => ''REPLACE'', ' +
                       'END_OF_LINE => ''NONE''); ' +
  'FOR SELECT  ' +
    'trim(cast('  ;
// Si agregation demandé
if   p_Agreg = '*YES' ;
  g_sqlStmt =  %trim(g_sqlStmt) +
  'JSON_ARRAYAGG('   ;
endif ;
g_sqlStmt = %trim(g_sqlStmt) +
'JSON_OBJECT(' ;
// ligne detail

exec sql open CURS01 ;
dou   sqlcode <> 0 ;
  exec sql   Fetch      CURS01    into
  :position  ,
    :nom       ,
    :type     ,
    :length   ,
    :numscl   ,
    :nullable  ,
    :precision ,
    :ccsid
    ;
  if sqlcode  = 0 ;
    // ajout des zones
    //    '''zone''' VALUE ZONE, '
    if g_first = 'O'  ;
      g_sqlStmt =  %trim(g_sqlStmt) + '''' + %trim(%lower(nom)) +  ''' VALUE ' + NOM ;
      g_first = 'N' ;
    else ;
      g_sqlStmt =  %trim(g_sqlStmt) + ' , ' + '''' + %trim(%lower(nom)) +  ''' VALUE ' + NOM  ;
    endif;
  endif ;
enddo ;
exec sql close CURS01  ;
// Ajout du fin
// Si agregation demandé
if   p_Agreg = '*YES' ;
  g_sqlStmt =  %trim(g_sqlStmt) +
  ')'  ;
endif ;
g_sqlStmt =  %trim(g_sqlStmt) +
  ') as varchar(32000))) AS Line_to_write ' +
  'FROM ' + %trim(g_lib) + '.' + %trim(g_file) + ' DO ' +
  'CALL QSYS2.IFS_WRITE_UTF8(PATH_NAME => ''' + %trim(g_lib) + '_' + %trim(g_file) + '.json'', ' +
                       'LINE => Line_to_write); ' +
'END FOR; ' +
  'END  ' ;
// execution du scripte
exec sql execute immediate :g_sqlStmt  ;
//  Sauvegarde  de la requete sql
if p_script = '*YES' ;
  g_sqlStmt =  %trim(g_sqlStmt) + '  ;'  ;
  exec sql
   CALL QSYS2.IFS_WRITE_UTF8(PATH_NAME => 'CVTFICJSON.SQL',
                         LINE => :g_sqlStmt ,
                         OVERWRITE => 'REPLACE',
                         END_OF_LINE => 'NONE');
endif    ;
// fin de programme
*inlr = *on ;
dcl-proc chkFile ;
  dcl-pi *n ind ;
    g_Lib       char(10) ;
    g_File      char(10) ;
  end-pi ;

  dcl-s l_exist char(1) inz('N') ;

  exec sql
     select 'O' into :l_exist
     from qsys2.systables
     where system_table_schema = UPPER(TRIM( :g_Lib )) and
           system_table_name = UPPER(TRIM( :g_File )) and
           table_type in ('T', 'P') ;

  return (l_exist = 'O') ;

end-proc ;
