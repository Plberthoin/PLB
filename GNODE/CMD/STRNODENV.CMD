             CMD        PROMPT('Démarrage environnement NODEJS')
             PARM       KWD(ENV) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Biblio de l''environnement')
             PARM       KWD(SESSION) TYPE(*char) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) MIN(0) +
                          PROMPT('Démarrage des sessions')

