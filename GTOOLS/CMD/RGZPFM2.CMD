/* Permet de réorganiser un gros fichier */
             CMD        PROMPT('Réorganisation d''un PF')
             PARM       KWD(FIL) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Fichier')
             PARM       KWD(LIB) TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) MIN(0) PROMPT('Nom de la +
                          bibliothèque')
             PARM       KWD(INDEX) TYPE(*CHAR) LEN(04) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) MIN(0) +
                          PROMPT('Recréation des indexs ')
