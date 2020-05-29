             CMD        PROMPT('Affichage poste d''audit')
             PARM       KWD(POSTE) TYPE(*CHAR) LEN(2) MIN(1) +
                          PROMPT('Poste à extraire')
             PARM       KWD(LIB) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Bibliothèque')
             PARM       KWD(DATE) TYPE(*CHAR) LEN(8) +
                          RANGE('01012020' '21122099') PROMPT('date +
                          du jour à extraire')
