/*----------------------------------------*/
/*        DECLARATION GESTION DES ERREURS */
/*----------------------------------------*/

             DCL        &ERRORSW *LGL                     /* SWITCH  */
             DCL        &MSGID *CHAR LEN(7)               /* ID MSG  */
             DCL        &MSGDTA *CHAR LEN(100)            /* DATA    */
             DCL        &MSGF *CHAR LEN(10)               /* FICHIER */
             DCL        &MSGFLIB *CHAR LEN(10)            /* BIBLI   */
 /* INTERCEPTION DES ERREURS IMPREVISIBLES                 */
             MONMSG     MSGID(CPF0000) EXEC(GOTO ERREUR)
