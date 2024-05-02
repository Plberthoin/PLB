             CMD        PROMPT('Copie depuis un SAVF')
             PARM       KWD(FROMSAVF) TYPE(Q1)                MIN(1) +
                          PROMPT('SAVF d''origine')
             PARM       KWD(TOFILE) TYPE(Q2)                MIN(1) +
                          PROMPT('Fichier destination')
             PARM       KWD(CRTFILE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) SPCVAL(('*YES' +
                          '1') ('*NO' '0')) PROMPT('Création du +
                          fichier')
 Q1:         QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) PROMPT('Bibliothèque')
 Q2:         QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL) +
                          (*CURLIB)) PROMPT('Bibliothèque')
