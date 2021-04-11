             CMD        PROMPT('Récupération d''un fichier')
             PARM       KWD(URL) TYPE(*CHAR) LEN(132) MIN(1) +
                          PROMPT('URL de votre fichier')
             PARM       KWD(CTLCERT) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) +
                          PROMPT('Controle du certificat')
