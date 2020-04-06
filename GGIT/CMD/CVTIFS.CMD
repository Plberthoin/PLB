             CMD        PROMPT('conversion vers ifs')
             PARM       KWD(LIB) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Bibliothèque')
             PARM       KWD(FILE) TYPE(*NAME) LEN(10) DFT(QCLSRC) +
                          MIN(0) PROMPT('Fichier source')
             PARM       KWD(REPERT) TYPE(*NAME) LEN(03) DFT(CLP) +
                          MIN(0) PROMPT('Sous répertoire')
             PARM       KWD(RAC) TYPE(*CHAR) LEN(20) DFT('/git/') +
                          MIN(0) PROMPT('Racine')
