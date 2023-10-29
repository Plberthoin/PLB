/* Commande pour générer l'aide des écrans            */
/* Génère les mots clés à intégRer dans un écran      */
/* et le squelette du panel de group pour l'affichage */
/* des informations nécessaires                       */
             CMD        PROMPT('Génération aide pour Ecran')
             PARM       KWD(ECRAN) TYPE(P1)                   PROMPT('Nom +
                          de l''écran')
     P1:     QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) MIN(0) +
                          PROMPT('Bibliothèque de l''écran')
             PARM       KWD(FICUIM) TYPE(P2)         +
                           PROMPT('Fichier UIM')
     P2:     QUAL       TYPE(*NAME) LEN(10) MIN(0) DFT(QPNLSRC)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) MIN(0) +
                          PROMPT('Bibliothèque du fic UIM')
             PARM       KWD(MBRUIM) TYPE(*NAME) LEN(10) DFT(*FILE) +
                          SPCVAL((*FILE)) MIN(0) PROMPT('Membre  UIM')
             PARM       KWD(FICDDS) TYPE(P3)                               +
                                 PROMPT('Fichier DDS')
     P3:     QUAL       TYPE(*NAME) LEN(10) MIN(0) DFT(QDDSSRC)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) MIN(0) +
                          PROMPT('Bibliothèque du fic DDS')
             PARM       KWD(MBRDDS) TYPE(*NAME) LEN(10) DFT(*FILE) +
                          SPCVAL((*FILE)) MIN(0) PROMPT('Membre  DDS')
 /* paramètres optionnels */
             PARM       KWD(PEINECR) TYPE(*CHAR) LEN(1) RSTD(*YES) DFT(N) +
                          VALUES(N O) MIN(0) PMTCTL(*PMTRQS) PROMPT('Plein +
                          Ecran O/N')
             PARM       KWD(TEXTZON) TYPE(*CHAR) LEN(50) DFT('Cette +
                          zone sert à ...') MIN(0) PMTCTL(*PMTRQS) +
                          PROMPT('Texte pour zone ')
