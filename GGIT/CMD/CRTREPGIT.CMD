             CMD        PROMPT('Création repository GIT')
             PARM       KWD(REPERT) TYPE(*CHAR) LEN(30) MIN(1) +
                          PROMPT('Répertoire')
             PARM       KWD(USER) TYPE(*NAME) LEN(10) DFT(*DFT) +
                          SPCVAL((*DFT)) MIN(0) PROMPT('Utilisateur')
             PARM       KWD(MAIL) TYPE(*char) LEN(50) DFT(*DFT) +
                          SPCVAL((*DFT)) MIN(0) PROMPT('Email')
