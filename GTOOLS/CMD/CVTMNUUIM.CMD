             CMD        PROMPT('Conversion Menu en UIM')
             PARM       KWD(MSGF) TYPE(Q1) MIN(1) PROMPT('Fichier +
                          message')
             PARM       KWD(Fichier ) TYPE(Q2) MIN(1) +
                          PROMPT('Fichier source')
             PARM       KWD(SOCIETE) TYPE(*CHAR) LEN(30) MIN(1) +
                          PROMPT('Société')
 Q1:         QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) MIN(0)  +
                         PROMPT('Bibliothèque')
 Q2:         QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) MIN(0)  +
                         PROMPT('Bibliothèque')
