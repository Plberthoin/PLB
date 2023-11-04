**free
// Nommage     des indicateurs de l'écran
Dcl-DS DS_Ind len(99);
// Touches de fonctions
  Sortie                        ind pos(3);
  Liste                         ind pos(4);
  Reaffichage                   ind pos(5);
  Creer                         ind pos(6);
  Precedent                     ind pos(7);
  Suivant                       ind pos(8);
  Valider                       ind pos(10);
  Annuler                       ind pos(12);
  Positionner                   ind pos(17);
  Exporter                      ind pos(18);
  Explorateur                   ind pos(20);
// Sous fichier
  SFLCLR                        ind pos(40);  // Effacement du sous fichier
  SFLDSPCTL                     ind pos(41);  // Affichage format de contrôle
  SFLDSP                        ind pos(42);  // Affichage sous fichier
  SFLEND                        ind pos(43);  // Fin de sous fichier
  ROLLUP                        ind pos(49);  // Touche Rollup
  ROLLDOWN                      ind pos(50);  // Touche Rolldown
// Indicateurs dates
  Ind_Lundi                     ind pos(51);
  Ind_Mardi                     ind pos(52);
  Ind_Mercredi                  ind pos(53);
  Ind_Jeudi                     ind pos(54);
  Ind_Vendredi                  ind pos(55);
  Ind_Samedi                    ind pos(56);
  Ind_Dimanche                  ind pos(57);
  Ind_Lundi_Now                 ind pos(61);
  Ind_Mardi_Now                 ind pos(62);
  Ind_Mercredi_Now              ind pos(63);
  Ind_Jeudi_Now                 ind pos(64);
  Ind_Vendredi_Now              ind pos(65);
  Ind_Samedi_Now                ind pos(66);
  Ind_Dimanche_Now              ind pos(67);
// Indicateurs d'erreur
//  Erreur_1                      ind pos(61);
//  Erreur_2                      ind pos(62);
//  Erreur_3                      ind pos(63);
//  Erreur_4                      ind pos(64);
//  Erreur_5                      ind pos(65);
//  Erreur_6                      ind pos(66);
//  Erreur_7                      ind pos(67);
  Erreur_8                      ind pos(68);
  Erreur_9                      ind pos(69);
// Attribut d'affichage
  Proteger1                     ind pos(71);
  Cacher1                       ind pos(72);
  Positionner1                  ind pos(73);
  Proteger2                     ind pos(74);
  Cacher2                       ind pos(75);
  Positionner2                  ind pos(76);
End-DS;
