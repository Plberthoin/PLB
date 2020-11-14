             CMD        PROMPT('Arrêt session NODEJS')
             PARM       KWD(PORT) TYPE(*CHAR) LEN(4) RANGE(1800 +
                          9999) MIN(1) PROMPT('Numéro du port')
             PARM       KWD(env) TYPE(*NAME) LEN(10) +
                          DFT('NODEJS') +
                          PROMPT('Bibliothèque Environnement')
