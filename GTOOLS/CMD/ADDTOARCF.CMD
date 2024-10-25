             CMD        PROMPT('Ajouter Fichier à archive')
             PARM       KWD(FROMFILE) TYPE(*CHAR) LEN(100) MIN(1) +
                          PROMPT('Fichier source')
             PARM       KWD(TOARCF) TYPE(*CHAR) LEN(100) MIN(1) +
                          PROMPT('Fichier archive')
             PARM       KWD(CRTARCF) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) +
                          PROMPT('Création archive')
             PARM       KWD(OPTIONS) TYPE(*CHAR) LEN(5) DFT(*NONE) +
                          MIN(0) PMTCTL(*PMTRQS) PROMPT('Options +
                          supplémentaires')
