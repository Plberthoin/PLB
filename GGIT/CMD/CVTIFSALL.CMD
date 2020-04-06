             CMD        PROMPT('Conversion vers ifs Biblio')
             PARM       KWD(LIB) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Bibliothèque')
             PARM       KWD(RAC) TYPE(*CHAR) LEN(20) DFT('/git/') +
                          MIN(0) PROMPT('Racine')
             PARM       KWD(README) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) MIN(0) +
                          PROMPT('Génération Readme')
