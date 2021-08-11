 CMD        PROMPT('Convertir Query/400 -> QM/400')
             PARM       KWD(QUERY) TYPE(QUAL1) MIN(1) PROMPT('Nom du +
                          query')
 QUAL1:      QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*CURLIB) (*LIBL)) MIN(0) +
                          PROMPT('Bibliothèque')
 PARM       KWD(QM) TYPE(QUAL2) MIN(0) PROMPT('Nom requête QM/400')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(*QRYDFN) +
                          SPCVAL((*QRYDFN)) MIN(0)
             QUAL       TYPE(*NAME) LEN(10) DFT(*CURLIB) +
                          SPCVAL((*CURLIB)) MIN(0) +
                          PROMPT('Bibliothèque')
             PARM       KWD(FORMAT) TYPE(*NAME) LEN(10) DFT(*NONE) +
                          SPCVAL((*NONE) (*QRY)) MIN(0) PROMPT('Nom +
                          format QM/400')
             PARM       KWD(EXEC) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*YES *NO) MIN(0) +
                          PROMPT('Exécution requête')
