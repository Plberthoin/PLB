*---------------------------------------------------------------------*
*                                                                     *
* Ce Logiciel permet de créer un environnement pour l'exécution       *
*    de vos instances NODEJS                                          *
* Vous ajouter un démarrage dans votre qstrup                         *
* Vous ajouter un arrêt avant votre sauvegarde                        *
*                                                                     *
*---------------------------------------------------------------------*

 Principe :
 ---------

  Vous créez un environnement  (bibliothèque , sbs, etc ...)
   crtnodenv
  Vous démarrez un environnement
   srtnodenv
  Vous arrêtrez un environnement
   endnodenv
  Vous supprimez un environnement
   dltnodenv
  Vous administrez vos instances
   wrknodses
   en les démarrant <F6>
   strnodses
   en les arrêtant  Option 4
   endnodses
  Vous pouvez créer des définitions d'instances,
  celles que vous définissez en start(*YES)
  seront démarrées par la commande strnodenv
   lstnodses
   en ajoutant une définition
   Addnodses  <F6>
   en modifiant  une définition
   chgnodses  Option 2
   en supprimant une définition
   rmvnodses  Option 4

 Pré-requis :
 -----------

  Vos scriptes .js recoivent le port d'exécution sur 4 en paramètre


 Installation :
 -------------

  Vous restaurez tous les sources sur votre IBMi
  Vous compiler dans l'ordre suivant
  - Fichiers BD
  - Fichier écran
  - Commandes
  - Programmes CLLE
  - Programmes SQLRPGLE

 Paramétrage :
 -------------

  crtnodenv vous devez indiquer une bibliothèque, mettez la même que
  la même que celle de vos objets.

  Si vous avez des sessions à lancer paramétrez les
  lstnodses
  rappel vos scriptes doivent recevoir le port en paramètre
  un exemple de scripte de test est joint, installez le dans votre IFS

  Vous démarrer votre environnement
  Vous pouvez voir les sessions qui tournent par WRKNODSES

  Pour tester vos sessions NODEJS
  http://votreIBMi:votreport

  Vous avez un menu que vous pouvez lancer par gnode
  Il a les principales options du logiciel

*** Listes  des sources
