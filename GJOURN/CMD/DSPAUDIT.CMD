             CMD        PROMPT('Affichage poste d''audit')
             PARM       KWD(POSTE) TYPE(*CHAR) LEN(2) MIN(1) +
                          PROMPT('Poste � extraire')
             PARM       KWD(LIB) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Biblioth�que')
             PARM       KWD(DATE) TYPE(*CHAR) LEN(8) +
                          RANGE('01012020' '21122099') PROMPT('date +
                          du jour � extraire')
