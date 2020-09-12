CMD        PROMPT('Changement Nom netbios')
             PARM       KWD(NAME) TYPE(*NAME) LEN(15) MIN(1) +
                          PROMPT('Nom Netbios')
             PARM       KWD(WINDOW) TYPE(*NAME) LEN(15) MIN(1) +
                          PROMPT('Nom du Domaine windows')
             PARM       KWD(TEXT) TYPE(*CHAR) LEN(50) MIN(1) +
                          PROMPT('Texte descriptif')
