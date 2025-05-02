             CMD        PROMPT('Convert Fichier en JSON')
             PARM       KWD(FILE) TYPE(FRMFILE) PROMPT('Fichier')
 FRMFILE:    QUAL       TYPE(*NAME) MIN(1) EXPR(*YES)
             QUAL       TYPE(*NAME) MIN(1) EXPR(*YES) +
                          PROMPT('Bibliothèque')
             PARM       KWD(AGREG) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) +
                          PROMPT('Agrégation des flux')
             PARM       KWD(SAVE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) +
                          PROMPT('Sauvegarder le script')
