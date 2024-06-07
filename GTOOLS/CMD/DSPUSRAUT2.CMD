/*------------------------------------------------------------------*/
/*                                                                  */
/*    Récupération des droits absolus d'un utilisateur sur un objet */
/*                                                                  */
/*------------------------------------------------------------------*/
             CMD        PROMPT('Droit PROFIL --> OBJET')
/*                                                                  */
             PARM       KWD(OBJET) TYPE(QUAL1) MIN(1) PROMPT('Nom de +
                          l''objet')
/*                                                                  */
             PARM       KWD(TYPE  ) TYPE(*CHAR) LEN(10) DFT(*FILE) +
                          PROMPT('Type de l''objet')
/*                                                                  */
             PARM       KWD(USRPRF) TYPE(*NAME) LEN(10) +
                          DFT(*CURRENT) SPCVAL((*CURRENT)) +
                          PMTCTL(*PMTRQS) PROMPT('Nom du profil')
/*                                                                  */
/*    Déclaration d'un nom Qualifié                                 */
/*                                                                  */
 QUAL1:      QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) PROMPT('Bilbliothèque')
/*                                                                  */
/*    Dépendance de zone                                            */
/*                                                                  */
             DEP        CTL(&USRPRF *EQ &OBJET) PARM((&TYPE *NE +
                          *USRPRF))
