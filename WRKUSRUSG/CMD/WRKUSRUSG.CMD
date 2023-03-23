cmd  ('Gestion d''une ID fonction')
             PARM       KWD(FCNID) TYPE(*CHAR) LEN(30) MIN(1) +
                          CHOICE(*PGM) CHOICEPGM(*LIBL/LSTFUNCF4) +
                          PROMPT('ID fonction')
