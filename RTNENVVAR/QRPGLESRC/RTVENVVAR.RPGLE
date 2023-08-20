**FREE
 //
 // Ce programme récupère la valeur d'une variable d'environnement
 //
  dcl-pi *N ;
    P_Var    char(50);    // Non de la variable
    P_Type   char(06);    // Système ou Job
    P_Value  char(256) ;  // Valeur
  end-pi ;
 //
  exec sql
  SELECT CAST(ENVIRONMENT_VARIABLE_VALUE AS  char(256)) into :P_Value
  FROM QSYS2.ENVIRONMENT_VARIABLE_INFO
        WHERE ENVIRONMENT_VARIABLE_TYPE = :P_Type and
        ENVIRONMENT_VARIABLE_NAME = :P_Var  ;
  if sqlcode <> 0 ;
    P_Value = '*ERREUR' ;
  endif ;
 //
 *inlr = *on ;
