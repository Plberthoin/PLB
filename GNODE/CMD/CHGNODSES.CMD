             CMD        PROMPT('Modifier une session NODEJS')
             PARM       KWD(PORT) TYPE(*CHAR) LEN(4) RANGE(1800 +
                          9999) MIN(1) PROMPT('Numéro du port')
             PARM       KWD(SCRIPTE) TYPE(*CHAR) LEN(50) DFT(*SAME) +
                          MIN(0) PROMPT('Scripte à exécuter')
             PARM       KWD(SESSION) TYPE(*char) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) MIN(0) +
                          PROMPT('Démarrage des sessions')
             PARM       KWD(ENV) TYPE(*CHAR) LEN(10) DFT(NODEJS) +
                          PROMPT('Bibliothèque environnement')
