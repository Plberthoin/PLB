             CMD        PROMPT('Affichage d''une fenêtre')
             PARM       KWD(TITRE) TYPE(*CHAR) LEN(50) MIN(1) +
                          PROMPT('Titre')
             PARM       KWD(TEXTE) TYPE(*CHAR) LEN(80) MIN(1) +
                          PROMPT('Texte à afficher')
