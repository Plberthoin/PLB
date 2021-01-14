             CMD        PROMPT('Génération d''un fichier XLS')
             PARM       KWD(NOMFIC) TYPE(*CHAR) LEN(80) MIN(1) +
                          PROMPT('Nom du fichier XLS')
             PARM       KWD(REQUETE) TYPE(*CHAR) LEN(1000) MIN(1) +
                          PROMPT('Requete SQL à exécuter')
             PARM       KWD(EXEJAVA) TYPE(*CHAR) LEN(60) DFT(*DFT) +
                          MIN(0) PROMPT('Executable ACS à utiliser')
