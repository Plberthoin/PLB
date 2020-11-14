             CMD        PROMPT('Démarrage session NODEJS')
             PARM       KWD(SCRIPTE) TYPE(*CHAR) LEN(50) MIN(1) +
                          PROMPT('Scripte à exécuter')
             PARM       KWD(PORT) TYPE(*CHAR) LEN(4) RANGE(1800 +
                          9999) MIN(1) PROMPT('Numéro du port')
             PARM       KWD(EXE) TYPE(*CHAR) LEN(50) +
                          DFT('/QOpenSys/pkgs/bin/node') +
                          PMTCTL(*PMTRQS) PROMPT('Exécutable NODEJS')
             PARM       KWD(lib) TYPE(*NAME) LEN(10) +
                          DFT('NODEJS') +
                          PROMPT('Bibliothèque Environnement')
