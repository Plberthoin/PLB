RETURN
ERREUR:
/*----------------------------------------*/
/*        GESTION DES ERREURS             */
/*----------------------------------------*/

             IF         &ERRORSW SNDPGMMSG MSGID(CPF9999) +
                          MSGF(QCPFMSG) MSGTYPE(*ESCAPE) /* 2EME FOIS*/
                                                         /* ARRET PGM*/
             CHGVAR     &ERRORSW '1' /* MISE EN PLACE DU SWTICH     */


 /* RENVOI DES MESSAGES DE TYPE *DIAG SI FIN ANORMALE */
 DIAGMSG:    RCVMSG     MSGTYPE(*DIAG) MSGDTA(&MSGDTA) MSGID(&MSGID) +
                          MSGF(&MSGF) MSGFLIB(&MSGFLIB)
             IF         (&MSGID *EQ '       ') GOTO EXCPMSG
             SNDPGMMSG  MSGID(&MSGID) MSGF(&MSGFLIB/&MSGF) +
                          MSGDTA(&MSGDTA) MSGTYPE(*DIAG)
  /* RENVOI DU MESSAGE D'ERREUR                        */
  EXCPMSG:    RCVMSG     MSGTYPE(*EXCP) MSGDTA(&MSGDTA) MSGID(&MSGID) +
                           MSGF(&MSGF) MSGFLIB(&MSGFLIB)
              SNDPGMMSG  MSGID(&MSGID) MSGF(&MSGFLIB/&MSGF) +
                           MSGDTA(&MSGDTA) MSGTYPE(*ESCAPE)
 /*----------------------------------------*/
 /*        FIN DU PROGRAMME                */
 /*----------------------------------------*/
 /* ENDPGM */
