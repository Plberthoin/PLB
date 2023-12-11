**Free
// Projet NEW5250
// Ajout éléments d'affichage pour développement 5250
// BOX
// VALIDATION
// LISTE
// DATE
// Définition des prototypages de fonction
// Affichage d'une box
Dcl-PR Affichage_Box;
          *N    Char(35) CONST;
          *N    Char(55) CONST;
End-PR;
// Affichage fenêtre de validation
Dcl-PR Affichage_Valid ;
          *N    Char(35) CONST;
          *N    Char(55) CONST;
          *N    Char(55) CONST;
          *N    Char(55) CONST;
          *N    Char(02)      ;
End-PR;
// Affichage d'un sous fichier liste
Dcl-PR Affichage_Liste;
          *N    Char(1024) CONST;
          *N    Char(35) CONST;
          *N    Char(45);
End-PR;
// Affichage calendrier
Dcl-PR Affichage_Date;
          *N    date(*ISO);
          *N    date(*ISO) options(*NOPASS);
End-PR;
// Execution ligne de commande
Dcl-PR Ligne_Commande  ;
          *N    Char(03) CONST;
End-PR;
