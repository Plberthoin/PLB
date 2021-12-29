             CMD        PROMPT('Log SQL d''un job')
             PARM       KWD(CMD) TYPE(*CMDSTR) LEN(512) MIN(1) +
                          PROMPT('Commande')
             PARM       KWD(LIB) TYPE(*NAME) LEN(10) DFT(*CURLIB) +
                          SPCVAL((*CURLIB)) PROMPT('Bibliothèque')
