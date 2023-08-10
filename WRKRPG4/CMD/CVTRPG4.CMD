/*============================================================================*/
/* Conversion RPG3 vers RPG IV                                                */
/*    surcouche au cvtrpgsrc                                                  */
/*============================================================================*/
             CMD        PROMPT('Convert RPGIII to RPGIV')

             PARM       KWD(FROMMBR) TYPE(*NAME) SPCVAL((*ALL)) +
                          MIN(1) PROMPT('Depuis le membre')

             PARM       KWD(FROMFILE) TYPE(FRMFILE) PROMPT('Depuis le fichier')
 FRMFILE:    QUAL       TYPE(*NAME) DFT(QRPGSRC) SPCVAL((QRPGSRC)) EXPR(*YES)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*CURLIB) (*LIBL)) EXPR(*YES) +
                          PROMPT('Bibliothèque')

             PARM       KWD(TOFILE) TYPE(TOFILE) PROMPT('Vers le fichier')
 TOFILE:     QUAL       TYPE(*NAME) LEN(10) DFT(QRPGLESRC)
             QUAL       TYPE(*NAME) DFT(*FROMLIB) SPCVAL((*FROMLIB) (*CURLIB) (*LIBL)) +
                          PROMPT('Bibliothèque')

             PARM       KWD(TOMBR) TYPE(*NAME) DFT(*FROMMBR) +
                          SPCVAL((*FROMMBR)) PROMPT('Vers le membre')

             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*YES *NO) +
                          PROMPT('Remplacement membre existant')

