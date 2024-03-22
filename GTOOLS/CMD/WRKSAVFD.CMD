             CMD        PROMPT('Gestion des fichiers SAVF')
             PARM       KWD(LIB) TYPE(*NAME) LEN(10) DFT(*ALL) +
                          SPCVAL((*ALL) (*ALLUSR)) +
                          PROMPT('Bibliothèque')
             PARM       KWD(CONFIRM) TYPE(*CHAR) LEN(04) RTNVAL(*NO) +
                          RSTD(*YES) DFT(*YES) VALUES(*YES *NO) +
                          PROMPT('Confirmer la supression')
