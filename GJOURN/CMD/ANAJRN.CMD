/*---------------------------------------------------------------*/

/* ANALYSE D'UN JOURNAL                                          */

/*---------------------------------------------------------------*/

             CMD        PROMPT('Analyse des donnɩes journal')

             PARM       KWD(FICHIER) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Fichier')

             PARM       KWD(BIBLIO) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Bibliothèque du fichier')

             PARM       KWD(JRN    ) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Journal')

             PARM       KWD(BIBLIO1) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Bibliothèque du journal')
             PARM       KWD(FICOUT) TYPE(*CHAR) LEN(10) DFT(*NONE) +
                          MIN(0) PROMPT('Fichier de sortie')

             PARM       KWD(BIBOUT) TYPE(*CHAR) LEN(10) MIN(0) +
                          PROMPT('Bibliothèque de sortie')

/*---------------------------------------------------------------*/

             PARM       KWD(FDAT) TYPE(*CHAR) LEN(06) DFT( *ALL ) +
                          MIN(0) PMTCTL(*PMTRQS) PROMPT('Date de +
                          Départ ddmmyy')

             PARM       KWD(FHRE) TYPE(*CHAR) LEN(06) DFT( *ALL ) +
                          MIN(0) PMTCTL(*PMTRQS) PROMPT('Heure de +
                          Départ hhmmss')

             PARM       KWD(TDAT) TYPE(*CHAR) LEN(06) DFT( *ALL ) +
                          MIN(0) PMTCTL(*PMTRQS) PROMPT('Date de +
                          fin ddmmyy')

             PARM       KWD(THRE) TYPE(*CHAR) LEN(06) DFT( *ALL ) +
                          MIN(0) PMTCTL(*PMTRQS) PROMPT('Heure de +
                          Fin hhmmss')
