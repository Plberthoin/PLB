*---------------------------------------------------------------------*
*                                                                     *
* Ce Logiciel permet de cr�er un environnement pour l'ex�cution       *
*    de vos instances NODEJS                                          *
* Vous ajouter un d�marrage dans votre qstrup                         *
* Vous ajouter un arr�t avant votre sauvegarde                        *
*                                                                     *
*---------------------------------------------------------------------*

 Principe :
 ---------

  Vous cr�ez un environnement  (biblioth�que , sbs, etc ...)
   crtnodenv
  Vous d�marrez un environnement
   srtnodenv
  Vous arr�trez un environnement
   endnodenv
  Vous supprimez un environnement
   dltnodenv
  Vous administrez vos instances
   wrknodses
   en les d�marrant <F6>
   strnodses
   en les arr�tant  Option 4
   endnodses
  Vous pouvez cr�er des d�finitions d'instances,
  celles que vous d�finissez en start(*YES)
  seront d�marr�es par la commande strnodenv
   lstnodses
   en ajoutant une d�finition
   Addnodses  <F6>
   en modifiant  une d�finition
   chgnodses  Option 2
   en supprimant une d�finition
   rmvnodses  Option 4

 Pr�-requis :
 -----------

  Vos scriptes .js recoivent le port d'ex�cution sur 4 en param�tre


 Installation :
 -------------

  Vous restaurez tous les sources sur votre IBMi
  Vous compiler dans l'ordre suivant
  - Fichiers BD
  - Fichier �cran
  - Commandes
  - Programmes CLLE
  - Programmes SQLRPGLE

 Param�trage :
 -------------

  crtnodenv vous devez indiquer une biblioth�que, mettez la m�me que
  la m�me que celle de vos objets.

  Si vous avez des sessions � lancer param�trez les
  lstnodses
  rappel vos scriptes doivent recevoir le port en param�tre
  un exemple de scripte de test est joint, installez le dans votre IFS

  Vous d�marrer votre environnement
  Vous pouvez voir les sessions qui tournent par WRKNODSES

  Pour tester vos sessions NODEJS
  http://votreIBMi:votreport

  Vous avez un menu que vous pouvez lancer par gnode
  Il a les principales options du logiciel

*** Listes  des sources
