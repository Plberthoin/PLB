**Free
// Projet NEW5250
// Ajout �l�ments d'affichage pour d�veloppement 5250
// BOX
// VALIDATION
// LISTE
// DATE
// D�finition des prototypages de fonction
// Affichage d'une box
// extraction taille de l'�cran
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
// Execution ligne de commande
Dcl-PR Ligne_Commande  ;
          *N    Char(03) CONST;
End-PR;
// Extraction taille de l'�cran
 Dcl-PR   GetDevType  Char(10)    ;
          *N    Char(10) Const;
End-PR;
// Extraction type de travail
 Dcl-PR   GetjobType              ;
          *N    Char(04) Const;
End-PR;
