/*------------------------------------------------------------------*/
/*                                                                  */
/* Extraction source d'un objet SQL                                 */
/*                                                                  */
/*------------------------------------------------------------------*/
             CMD        PROMPT('extraire un source SQL')
             PARM       KWD(FILE) TYPE(LBL1) MIN(1) PROMPT('Nom +
                          de l''objet')
             PARM       KWD(SRCFILE) TYPE(LBL2) PROMPT('Nom du +
                          fichier source')
             PARM       KWD(SRCMBR) TYPE(*NAME) LEN(10) DFT(*OBJ) +
                          SPCVAL((*OBJ)) PROMPT('Nom du membre source')
             PARM       KWD(TYPSQL) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(TABLE) VALUES(TABLE FUNCTION INDEX +
                          PROCEDURE TRIGGER SCHEMA VIEW) +
                          PMTCTL(*PMTRQS) PROMPT('Type objet +
                                ')
 LBL1:       QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL((*LIBL) +
                          (*CURLIB)) PROMPT('Bibliothèque')
LBL2:       QUAL       TYPE(*NAME) LEN(10) DFT(QSQLSRC)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) SPCVAL((*LIBL) +
                          (*CURLIB)) PROMPT('Bibliothèque')
