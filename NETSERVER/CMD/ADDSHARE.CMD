/*--------------------------------------*/
/* Ajout d'un partage de netserver      */
/*--------------------------------------*/
CMD        PROMPT('Ajouter partage NetServer')
             PARM       KWD(SHARE) TYPE(*CHAR) LEN(12) +
                          PROMPT('Nom du partage')
             PARM       KWD(PATH) TYPE(*CHAR) LEN(256) +
                          PROMPT('Chemin IFS')
             PARM       KWD(TEXT) TYPE(*CHAR) LEN(50) +
                          PROMPT('Description')
