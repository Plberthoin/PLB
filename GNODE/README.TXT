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
CLPADDNODSES CLLE    Ajout     d une session NODEJS
CLPCHGNODSES CLLE    Modifier  d une session NODEJS
CLPCRTNODENV CLLE    Cr�ation environnement nodejs
CLPDLTNODENV CLLE    Suppression environnement nodejs
CLPENDNODENV CLLE    Arr�t de l environnement NODEJS
CLPENDNODSES CLLE    Arr�t d une session NODEJS
CLPGNODE     CLLE    Lancement menu GNODE
CLPRMVNODSES CLLE    Suppression  d une session NODEJS
CLPRTVLIBPGM CLLE    Recup�ration biblioth�que du programme
CLPSTRNODENV CLLE    D�marrage de l environnement NODEJS
CLPSTRNODSES CLLE    D�marrage d une session NODEJS
CMDADDNODSES CMD     Ajouter une session nodejs
CMDCHGNODSES CMD     Changer une session nodejs
CMDCRTNODENV CMD     Cr�ation environnement NODEJS
CMDDLTNODENV CMD     Supression environnement NODEJS
CMDENDNODENV CMD     Arr�t environnement NODEJS
CMDENDNODSES CMD     Arr�t session nodejs
CMDGNODE     CMD     Lancement console gnode
CMDLSTNODSES CMD     Gestion des d�dinitions de sessions NODEJS
CMDRMVNODSES CMD     Retrait une session nodejs
CMDSTRNODENV CMD     D�marrage environnement NODEJS
CMDSTRNODSES CMD     d�marrage d une session NODEJS
CMDWRKNODSES CMD     Gestion des sessions NODEJS
DDSGNODE     MNUD    Console nodeJS
DDSGNODEE    DSPF    Console nodeJS pour menu en clle
DDSGNODEQQ   MNUC    Console nodeJS
DDSLSTNODSESEDSPF    Gestion des d�finitions de session
DDSWRKNODSES DSPF    Gestion des sessions NODESJS
RPGLSTNODSES SQLRPGLEGestion des d�finitons de session
RPGWRKNODSES SQLRPGLEGestion des sessions NODESJS
SQLLSTNODSES SQL     Listes des sessions node JS
TXTREADME    TXT     readme do logiciel GNODE
TXTVERSION   TXT     historiques des versions
*** Fin listes des sources
