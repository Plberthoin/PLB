             CMD        PROMPT('Création MNU/MSGF modéle')
             PARM       KWD(MSGF) TYPE(Q1) MIN(1) PROMPT('Fichier Messages')
 Q1:         QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) MIN(0)  +
                         PROMPT('Bibliothèque')
