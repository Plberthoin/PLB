             CMD        PROMPT('Génération UIM pour CMD')
             PARM       KWD(COMMANDE) TYPE(Q1) MIN(1) +
                          PROMPT('Commande')
             PARM       KWD(Fichier ) TYPE(Q2) MIN(1) +
                          PROMPT('Fichier source')
 Q1:         QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) MIN(0)  +
                         PROMPT('Bibliothèque')
 Q2:         QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) MIN(0)  +
                         PROMPT('Bibliothèque')
