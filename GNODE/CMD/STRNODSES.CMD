             CMD        PROMPT('D�marrage session NODEJS')
             PARM       KWD(SCRIPTE) TYPE(*CHAR) LEN(50) MIN(1) +
                          PROMPT('Scripte � ex�cuter')
             PARM       KWD(PORT) TYPE(*CHAR) LEN(4) RANGE(1800 +
                          9999) MIN(1) PROMPT('Num�ro du port')
             PARM       KWD(EXE) TYPE(*CHAR) LEN(50) +
                          DFT('/QOpenSys/pkgs/bin/node') +
                          PMTCTL(*PMTRQS) PROMPT('Ex�cutable NODEJS')
             PARM       KWD(lib) TYPE(*NAME) LEN(10) +
                          DFT('NODEJS') +
                          PROMPT('Biblioth�que Environnement')
