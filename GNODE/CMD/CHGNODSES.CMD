             CMD        PROMPT('Modifier une session NODEJS')
             PARM       KWD(PORT) TYPE(*CHAR) LEN(4) RANGE(1800 +
                          9999) MIN(1) PROMPT('Num�ro du port')
             PARM       KWD(SCRIPTE) TYPE(*CHAR) LEN(50) DFT(*SAME) +
                          MIN(0) PROMPT('Scripte � ex�cuter')
             PARM       KWD(SESSION) TYPE(*char) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) MIN(0) +
                          PROMPT('D�marrage des sessions')
             PARM       KWD(ENV) TYPE(*CHAR) LEN(10) DFT(NODEJS) +
                          PROMPT('Biblioth�que environnement')
