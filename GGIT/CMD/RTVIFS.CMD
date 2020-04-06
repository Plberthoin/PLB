             CMD        PROMPT('Resturation depuis l''IFS')
             PARM       KWD(APPLIC) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Application')
             PARM       KWD(BIBRST) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Bibliothèque de restauration')
             PARM       KWD(REPERT) TYPE(*CHAR) LEN(3) DFT(CLP) +
                          MIN(0) PROMPT('Répertoire')
             PARM       KWD(RAC) TYPE(*CHAR) LEN(20) DFT('/git/') +
                          MIN(0) PROMPT('Racine')
