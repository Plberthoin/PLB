         CMD        PROMPT('Affichage d''aide')
             PARM       KWD(AIDE) TYPE(E1) MIN(1) MAX(25) +
                          PROMPT('Identifiants des aides')
     E1:      ELEM       TYPE(Q1) MIN(1) PROMPT('Pannel groupe')
              ELEM       TYPE(*CHAR) LEN(32) MIN(1) PROMPT('Module +
                          d''aide')
     Q1:       QUAL       TYPE(*NAME) MIN(1)
               QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) +
                          PROMPT('Bibliotheque')

             PARM       KWD(RANGE) TYPE(E2) PROMPT('Aide à afficher')
     E2:      ELEM       TYPE(*INT4) DFT(*FIRST) REL(*GT 0) +
                          SPCVAL((*FIRST 1)) PROMPT('1 er aide')
              ELEM       TYPE(*INT4) DFT(*LAST) REL(*GT 0) +
                          SPCVAL((*LAST 0)) PROMPT('Dernier aide')

             PARM       KWD(TITRE) TYPE(*CHAR) LEN(55) DFT(*BLANK) +
                          SPCVAL((*BLANK ' ')) PROMPT('Titre à +
                          afficher')

             PARM       KWD(SCHIDX) TYPE(Q2) PROMPT('Index de +
                          recherche')
 Q2:         QUAL       TYPE(*NAME) DFT(*NONE)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) +
                          PROMPT('Bibliotheque')
            PARM       KWD(PLEINECRAN) TYPE(*CHAR) LEN(1) +
                          RSTD(*YES) DFT(*NO) SPCVAL((*YES Y) (*NO +
                          N)) PROMPT('Affichage plein écran')

             PARM       KWD(CURSEUR) TYPE(E3) PROMPT('Position +
                          curseur avant aide')
     E3:      ELEM       TYPE(*INT4) DFT(1) RANGE(1 24) PROMPT('N° +
                          ligne')
              ELEM       TYPE(*INT4) DFT(1) RANGE(1 80) PROMPT('N° +
                          colonne')

             PARM       KWD(FENETRE) TYPE(E4) PMTCTL(CTL1) +
                          PROMPT('fenetre logique concernée/aide')
     E4:      ELEM       TYPE(*INT4) DFT(01) RANGE(1 24) PROMPT('N° +
                          ligne angle sup gauche')
              ELEM       TYPE(*INT4) DFT(01) RANGE(1 80) PROMPT('N° +
                          colonne angle sup gauche')
              ELEM       TYPE(*INT4) DFT(02) RANGE(1 24) PROMPT('N° +
                         ligne angle inf droit')
              ELEM       TYPE(*INT4) DFT(80) RANGE(1 80) PROMPT('N° +
                          colonne angle inf droit')
CTL1:       PMTCTL     CTL(PLEINECRAN) COND((*EQ 'N'))
