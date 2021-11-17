**free
//
// Ce programme vous permet d'afficher un panneau d'aide
//
     ctl-opt option(*srcstmt);
//   Paramètres
     DCL-PI *n;
       P1 LIKEDS(P1mdl); //liste de panneaux
       P2 LIKEDS(P2mdl); // Range
       P3 CHAR(55);      // titre
       P4 CHAR(20);      // INDEX
       P5 CHAR(1);       // plein écran ?
       P6 LIKEDS(P6mdl); // position curseur
       P7 LIKEDS(P7mdl); // Fenêtre;
     End-Pi;
     dcl-ds P1mdl template;
       NBP INt(5);
       Dep INT(5) DIM(25);
       filler char(5000);
     End-Ds;
     DCL-DS P2mdl template;
       NBE2 INT(5);
       RANGE CHAR(8);
        RG1 INT(10) OVERLAY(RANGE);
        RG2 INT(10) OVERLAy(RANGE : *NEXT);
     End-Ds;
     DCL-DS P6mdl template;
       NBE6 INT(5);
       PC   CHAR(8);
        PCC  INT(10) OVERLAY(PC);
        PCL  INT(10) OVERLAY(PC : *NEXT);
     End-Ds;
     DCL-DS P7mdl template;
       NBE7 INT(5);
       ASG CHAR(8);
        ASGL INt(10) OVERLAY(ASG);
        ASGC INt(10) OVERLAY(ASG : *NEXT);
       AID CHAR(8);
        AIDL INt(10) OVERLAY(AID);
        AIDC INt(10) OVERLAY(AID : *NEXT);
     End-Ds;
     DCl-s TBi CHAr(52) DIM(25);
     DCL-DS ELEMH;
       NBE1 int(5);
       PNL CHAR(10);
       BIB CHAR(10);
       HLP CHAR(32);
     End-Ds;
     DCL-DS DSH;
       PNLDS CHAR(10);
       BIBDS CHAR(10);
       HLPDS CHAR(32);
     End-Ds;
     DCL-S X  INt(10);
     DCL-S NH INt(10);
     DCL-DS ZERROR;
       LGERR INt(10);
       LGRCV INT(10);
       IDRCV CHAR(7);
       reserved char(1);
     End-Ds;
     dcl-pr QDCXLATE EXTPGM('QDCXLATE');
       *n PACKED(5:0) const;
       *n CHAR(52);
       *n CHAR(10)    const;
       *n CHAR(10)    const;
     End-Pr;
 // prototypage  de l'api QUHDSPH
     dcl-pr QUHDSPH EXTPGM('QUHDSPH');
       *n CHAr(52) DIM(25); // tableau de panneaux
                            //  25 FOIS 52C
                            //<-PNLGRP-><-BIBLI-><-MODULE->
                            //    10       10       32
      *n INT(10);          // nbr de panneaux
      *n CHAR(8);          // range (1er / dernier)
                           // (les autres sont affichés avec F2 "AIDE ETENDUE")
      *n CHAR(55);         // titre
      *n CHAR(20);         // index  <-INDEX(10C)-><-BIBLIO(10C)>
      *n CHAR(1);          // plein écran  Y=Oui, N=Non (fenêtre)
      *n CHAR(8);          // angle sup. gauche de la partie concernée
      *n CHAR(8);          // angle inf. droit de la partie concernée
      *n CHAR(8);          // position curseur
      *n CHAR(10);          // retour d'erreur
     End-Pr;
     // traitement de la liste des panneaux
     for x = 1 to P1.NBP;
       ELEMH = %SUBST(P1 : P1.Dep(x)+1 : %size(ELEMH));
       IF PNL <> *BLANK  AND BIB <> *BLANK  AND HLP <> *BLANK;
         PNLDS = PNL;
         BIBDS = BIB;
         HLPDS = HLP;
         // CVt Minuscules/Majuscules
         QDCXLATE(32 : DSH : 'QSYSTRNTBL' : '*LIBL');
         NH += 1;
        TBI(NH) = DSH;
       ENDIF;
     ENDFOR;
     IF P2.RG1 > NH;
       P2.RG1 = NH;
     ENDIF;
     IF P2.RG2 < P2.RG1 OR P2.RG2 > NH;
      P2.RG2 = NH;
     ENDIF;
     LGERR = 15;
  // Affichage
     QUHDSPH(TBi : NH : P2.RANGE : P3 : P4 : P5 : P7.ASG : P7.AID: P6.PC: ZERROR);
     *INLR = *ON;
