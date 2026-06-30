/*--------------------------------------*/
/* retrait d'un partage de netserver      */
/*--------------------------------------*/
CMD        PROMPT('Retrait partage NetServer')
             PARM       KWD(SHARE) TYPE(*CHAR) LEN(12) +
                          PROMPT('Nom du partage')
