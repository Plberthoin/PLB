pgm parm(&usr) /*---------------------------------------------------*/
/* Ce programme dumpe les instructions SQL d'un profil              */
/*------------------------------------------------------------------*/
dcl &usr *char 10
chkobj &usr *usrprf
monmsg cpf0000  exec(do)
             SNDUSRMSG  MSG('User, ' *BCAT &USR *BCAT 'inutilisable +
                          ou inexistant') MSGTYPE(*INFO)
                          return
                          enddo
/* dumpage des informations dans le profil */
             DMPSYSOBJ  OBJ('ISQLST' *TCAT &USR *TCAT '*') +
                          CONTEXT(QRECOVERY) TYPE(19) SUBTYPE(EE)
/* dumpage des informations dans le profil */
             DLTF       FILE(QTEMP/W132)
MONMSG CPF2105
             CRTPF      FILE(QTEMP/W132) RCDLEN(132)
             CHGPF      FILE(QTEMP/W132) SIZE(*NOMAX)
             CPYSPLF    FILE(QPSRVDMP) TOFILE(QTEMP/W132) +
                          SPLNBR(*LAST)
                          dltf QTEMP/SQLLISTE
                           MONMSG CPF2105
             RUNSQL     SQL('CREATE            TABLE QTEMP/SQLLISTE +
                          (IDSQL CHAR ( 7) NOT NULL WITH DEFAULT, +
                          CMDSQL CHAR (2048) NOT NULL WITH +
                          DEFAULT)') COMMIT(*NONE)
 /* appel du programme qui génère le fichier sqlliste dans QTEMP */
             CALL       PGM(DMPSQLUSRR)
             SNDUSRMSG  MSG('le fichier SQLLISTE a été généré dans  +
                          QTEMP') MSGTYPE(*INFO)
endpgm
