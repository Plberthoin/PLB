             CMD        PROMPT('Commit repository GIT')
             PARM       KWD(REPERT) TYPE(*CHAR) LEN(30) MIN(1) +
                          PROMPT('Répertoire')
             PARM       KWD(TEXT) TYPE(*CHAR) LEN(50) DFT(*DFT) +
                          SPCVAL((*DFT)) MIN(0) PROMPT('Descriptif')
