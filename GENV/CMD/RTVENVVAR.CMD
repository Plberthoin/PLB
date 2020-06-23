             CMD        PROMPT('lecture variable enviornnement') +
                          ALLOW(*IPGM *BPGM)
             PARM       KWD(ENVVAR) TYPE(*CHAR) LEN(50) MIN(1) +
                          PROMPT('Environment variable')
             PARM       KWD(LEVEL) TYPE(*CHAR) LEN(06) RSTD(*YES) +
                          DFT(SYSTEM) VALUES('JOB' 'SYSTEM') MIN(0) +
                          PROMPT('Niveau')
             PARM       KWD(VALUE) TYPE(*CHAR) LEN(256) RTNVAL(*YES) +
                          MIN(0) PROMPT('Valeur')
