             CMD        PROMPT('Création d''un Menu UIM')
             PARM       KWD(MENU) TYPE(Q1) MIN(1) PROMPT('Menu')
             PARM       KWD(Fichier ) TYPE(Q2) MIN(1) +
                          PROMPT('Fichier source')
             PARM       KWD(SOCIETE) TYPE(*CHAR) LEN(30) MIN(1) +
                          PROMPT('Société')
             PARM       KWD(TITRE) TYPE(*CHAR) LEN(30) MIN(1) +
                          PROMPT('Titre du menu')
 /* option 1 */
             PARM       KWD(OPTION1) TYPE(*CHAR) LEN(50) MIN(1) +
                          PROMPT('Texte option 1')
             PARM       KWD(COMMANDE1) TYPE(*CHAR) LEN(132) MIN(1) +
                          PROMPT('Commande')
 /* option 2 */
             PARM       KWD(OPTION2) TYPE(*CHAR) LEN(50) +
                          DFT(*NONE)        PROMPT('Texte option 2')
             PARM       KWD(COMMANDE2) TYPE(*CHAR) LEN(132)        +
                          PROMPT('Commande')  DFT(*NONE)
 /* option 3 */
             PARM       KWD(OPTION3) TYPE(*CHAR) LEN(50) MIN(0) +
                          PROMPT('Texte option 3')  DFT(*NONE)
             PARM       KWD(COMMANDE3) TYPE(*CHAR) LEN(132) MIN(0) +
                          PROMPT('Commande')  DFT(*NONE)
 /* option 4 */
             PARM       KWD(OPTION4) TYPE(*CHAR) LEN(50) MIN(0) +
                          PROMPT('Texte option 4')  DFT(*NONE)
             PARM       KWD(COMMANDE4) TYPE(*CHAR) LEN(132) MIN(0) +
                          PROMPT('Commande')    DFT(*NONE)
 /* option 5 */
             PARM       KWD(OPTION5) TYPE(*CHAR) LEN(50) MIN(0) +
                          PROMPT('Texte option 5') DFT(*NONE)
             PARM       KWD(COMMANDE5) TYPE(*CHAR) LEN(132) MIN(0) +
                          PROMPT('Commande')   DFT(*NONE)
 /* option 6 */
             PARM       KWD(OPTION6) TYPE(*CHAR) LEN(50) MIN(0) +
                          PROMPT('Texte option 6') DFT(*NONE)
             PARM       KWD(COMMANDE6) TYPE(*CHAR) LEN(132) MIN(0) +
                          PROMPT('Commande')     DFT(*NONE)
 /* option 7 */
             PARM       KWD(OPTION7) TYPE(*CHAR) LEN(50) MIN(0) +
                          PROMPT('Texte option 7') DFT(*NONE)
             PARM       KWD(COMMANDE7) TYPE(*CHAR) LEN(132) MIN(0) +
                          PROMPT('Commande')     DFT(*NONE)
 /* option 8 */
             PARM       KWD(OPTION8) TYPE(*CHAR) LEN(50) MIN(0) +
                          PROMPT('Texte option 8')  DFT(*NONE)
             PARM       KWD(COMMANDE8) TYPE(*CHAR) LEN(132) MIN(0) +
                          PROMPT('Commande')     DFT(*NONE)
 /* option 9 */
             PARM       KWD(OPTION9) TYPE(*CHAR) LEN(50) MIN(0) +
                          PROMPT('Texte option 9') DFT(*NONE)
             PARM       KWD(COMMANDE9) TYPE(*CHAR) LEN(132) MIN(0) +
                          PROMPT('Commande')  DFT(*NONE)
 /* option 10 */
             PARM       KWD(OPTION10) TYPE(*CHAR) LEN(50) MIN(0) +
                          PROMPT('Texte option 10')  DFT(*NONE)
             PARM       KWD(COMMANDE10) TYPE(*CHAR) LEN(132) MIN(0) +
                          PROMPT('Commande')      DFT(*NONE)
 Q1:         QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) MIN(0)  +
                         PROMPT('Bibliothèque')
 Q2:         QUAL       TYPE(*NAME) MIN(1)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) MIN(0)  +
                         PROMPT('Bibliothèque')
