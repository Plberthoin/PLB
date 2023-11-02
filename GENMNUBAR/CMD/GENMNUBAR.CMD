/* Commande pour générer un squelette de mnubarre     */
/* SOURCE DDS */
/* SOURCE RPG */
             CMD        PROMPT('Génération menu Barre')
/* Fichier source DDS */
             PARM       KWD(MBRDDS) TYPE(*NAME) LEN(10) MIN(1) +
                          PROMPT('Membre  DDS')
             PARM       KWD(FICDDS) TYPE(P3)                               +
                                 PROMPT('Fichier DDS')
     P3:     QUAL       TYPE(*NAME) LEN(10) MIN(0) DFT(QDDSSRC)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) MIN(0) +
                          PROMPT('Bibliothèque du fic DDS')
/* Fichier source RPG */
             PARM       KWD(MBRRPG) TYPE(*NAME) LEN(10) DFT(*MBRDDS) +
                          SPCVAL((*MBRDDS)) MIN(0) PROMPT('Membre  RPGLE')
             PARM       KWD(SRCRPG) TYPE(P2)         +
                           PROMPT('Fichier RPG')
     P2:     QUAL       TYPE(*NAME) LEN(10) MIN(0) DFT(QRPGLESRC)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) MIN(0) +
                          PROMPT('Bibliothèque du fic UIM')
 /* Menu1                 */
             PARM       KWD(MENU1) TYPE(*NAME) LEN(10) DFT(MENU_1) +
                          MIN(0)              PROMPT('Menu 1')
             PARM       KWD(OPTION11) TYPE(*CHAR) LEN(10) DFT(Option_1) +
                          MIN(0) CASE(*MIXED) PROMPT('Menu_1 Option_1')
             PARM       KWD(OPTION12) TYPE(*CHAR) LEN(10) DFT(Option_2) +
                          MIN(0) CASE(*MIXED) PROMPT('Menu_1 Option_2')
             PARM       KWD(OPTION13) TYPE(*CHAR) LEN(10) DFT(Option_3) +
                          MIN(0) CASE(*MIXED) PROMPT('Menu_1 Option_3')
             PARM       KWD(MENU2) TYPE(*NAME) LEN(10) DFT(MENU_2) +
                          MIN(0)              PROMPT('Menu 2')
             PARM       KWD(OPTION21) TYPE(*CHAR) LEN(10) DFT(Option_1) +
                          MIN(0) CASE(*MIXED) PROMPT('Menu_2 Option_1')
             PARM       KWD(OPTION22) TYPE(*CHAR) LEN(10) DFT(Option_2) +
                          MIN(0) CASE(*MIXED) PROMPT('Menu_2 Option_2')
             PARM       KWD(OPTION23) TYPE(*CHAR) LEN(10) DFT(Option_3) +
                          MIN(0) CASE(*MIXED) PROMPT('Menu_2 Option_3')
/* menu1 doit être différent de menu 2 */
             DEP        CTL(*ALWAYS) PARM((&MENU2 *NE &MENU1))
