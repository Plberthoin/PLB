             CMD        PROMPT('Changement status instance')
             PARM       KWD(INSTANCE) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Nom de l''instance')
             PARM       KWD(AUTOSTART) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES('*YES' '*NO') +
                          PROMPT('démarrage automatique')
