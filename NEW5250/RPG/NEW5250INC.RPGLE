**Free
// Projet NEW5250
// Ajout �l�ments d'affichage pour d�veloppement 5250
// BOX
// VALIDATION
// LISTE
// DATE
// D�finition des prototypages de fonction
// Affichage d'une box
Dcl-PR Affichage_Box;
          *N    Char(35) CONST;
          *N    Char(55) CONST;
End-PR;
// Affichage fen�tre de validation
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