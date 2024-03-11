*---------------------------------------------------------------------*
* Ce logiciel permet d'utiliser des éléments Graphiques 5250          *
* Il s'utilise sous forme de Répertoire de liage                      *
*---------------------------------------------------------------------*

Vous pourrez intégrer dans vos développements 5250
  Une box
  Un écran de validation
  Une liste à sélectionner
  Un calendrier
  Une ligne de commande avec gestion des droits
  Un controle de la taille de l'écran

*** Listes  des sources


! CLP   ! COMPILE     ! CLLE       ! Génération du produit NEW5250       !
! DDS   ! NEW5250     ! DSPF       ! Génération Menu barre Pour DSPF     !
! RPG   ! NEW5250     ! SQLRPGLE   ! Source module New525O               !
! RPG   ! NEW5250INC  ! SQLRPGLE   ! Déclaration prototypages            !
! RPG   ! DDS_INC     ! SQLRPGLE   ! Déclaration des indicateurs         !
! SRV   ! NEW5250     ! BND        ! Source d'exportation des fonctions  !
! RPG   ! TNEW5250    ! SQLRPGLE   ! Programme Exemple à customiser      !
! CLP   ! TNEW5250C   ! CLLE       ! Programme Exemple à customiser      !


*** Fin listes des sources

Pré requis :

Compilateur RPGLE
Version V7R3 (à cause du full free)

Installation :

Vous devez restaurer, les sources sur votre système
Compiler le DSPF
vous devez avoir en ligne le fichier qsrvsrc qui contient le source BND
Compiler le programme de génération COMPILE
Lancer le prgramme COMPILE en indicant Votre bibliothèque de génération      

Vous devez obtenir
Un programme de service plus un répertoire de liage qui sont les 2 élements utilisés
 
Utilisation :

Pour les intégrer vous avez un exemple TNEW5250 et TNEW5250C qui montrent le liage en RPGLE et EN CLLE 
le liage
la déclaration des prototypages
et l'utilisation des procédures 
                       

