             CMD        PROMPT('Affichage d''une Dataq')
             PARM       KWD(DTAQ) TYPE(QUAL1) MIN(1) PROMPT('Data Queue')

             PARM       KWD(OUTFMT) TYPE(*CHAR) LEN(5)  DFT(*CHAR) +
                          RSTD(*YES) VALUES(*CHAR *HEX) PROMPT('Format de +
                          sortie')

 QUAL1:      QUAL       TYPE(*NAME) LEN(10) MIN(1) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL((*LIBL)) +
                          EXPR(*YES) PROMPT('Bibliothèque')
