/* Commande pour générer l'aide des écrans            */
/* Génère les mots clés à intégter dans un écran      */
/* et le squelette du panel de group pour l'affichage */
/* des informations nécessaires                       */
             CMD        PROMPT('Génération aide pour Ecran')
             PARM       KWD(ECRAN) TYPE(*NAME) LEN(10) MIN(1) PROMPT('Nom +
                          de l''écran')
             PARM       KWD(BIBECRAN) TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) MIN(0) +
                          PROMPT('Bibliothèque de l''écran')
             PARM       KWD(FICUIM) TYPE(*NAME) LEN(10) DFT(QPNLSRC) +
                          MIN(0) PROMPT('Fichier UIM')
             PARM       KWD(BIBUIM) TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) MIN(0) +
                          PROMPT('Bibliothèque du fic UIM')
             PARM       KWD(MBRUIM) TYPE(*NAME) LEN(10) DFT(*FILE) +
                          SPCVAL((*FILE)) MIN(0) PROMPT('Membre  UIM')
             PARM       KWD(FICDDS) TYPE(*NAME) LEN(10) DFT(QDDSSRC) +
                          MIN(0) PROMPT('Fichier DDS')
             PARM       KWD(BIBDDS) TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) MIN(0) +
                          PROMPT('Bibliothèque du fic DDS')
             PARM       KWD(MBRDDS) TYPE(*NAME) LEN(10) DFT(*FILE) +
                          SPCVAL((*FILE)) MIN(0) PROMPT('Membre  DDS')
 /* paramètres optionnels */
             PARM       KWD(PEINECR) TYPE(*CHAR) LEN(1) RSTD(*YES) DFT(N) +
                          VALUES(N O) MIN(0) PMTCTL(*PMTRQS) PROMPT('Plein +
                          Ecran O/N')
