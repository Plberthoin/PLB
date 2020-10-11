             CMD        PROMPT('Check date certificat')
             PARM       KWD(EMAIL) TYPE(*CHAR) LEN(50) MIN(1) +
                          PROMPT('Email')
             PARM       KWD(PASSWORD) TYPE(*CHAR) LEN(50) MIN(1) +
                          CASE(*MIXED) DSPINPUT(*NO) PROMPT('Mot de +
                          passe magasin')
