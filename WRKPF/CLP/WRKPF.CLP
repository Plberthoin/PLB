  /*===============================================================*/
  /*                                                               */
  /*                                                               */
  /*===============================================================*/
             PGM        PARM(&LIB)

             DCL        VAR(&LIB)        TYPE(*CHAR) LEN(10)
             DCL        VAR(&MSGID)      TYPE(*CHAR) LEN(7)
             DCL        VAR(&MSGDTA)     TYPE(*CHAR) LEN(80)

     /* Send all errors to error handling routine */
             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERROR))

     /* Check to be sure library exists */
             CHKOBJ     OBJ(&LIB) OBJTYPE(*LIB)

     /* Call program to display physical files */
             CALL       PGM(WRKPFR) PARM(&LIB)
     /* Branch around error handling routine */
             GOTO       CMDLBL(ENDPGM)

     /* Error handling routine */
 ERROR:      RCVMSG     MSGTYPE(*EXCP) MSGDTA(&MSGDTA) MSGID(&MSGID)
             SNDPGMMSG  MSGID(&MSGID) MSGF(QCPFMSG) MSGDTA(&MSGDTA) +
                          MSGTYPE(*ESCAPE)
 ENDPGM:     ENDPGM
