             CMD        PROMPT('Conversion Menu vers ATTNMNUT')
             PARM       KWD(MENU) TYPE(P1) PROMPT('Nom du menu � +
                          exporter')
     P1:     QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) MIN(0) +
                          PROMPT('Biblioth�que du menu')
             PARM       KWD(USER) TYPE(*NAME) LEN(10) DFT(*CURRENT) +
                          SPCVAL((*CURRENT)) MIN(0) PROMPT('Utilisateur')
