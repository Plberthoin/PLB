*---------------------------------------------------------------------*
* Ce logiciel permet d'utiliser des �l�ments Graphiques 5250          *
* Il s'utilise sous forme de R�pertoire de liage                      *
*---------------------------------------------------------------------*

Vous pourrez int�grer dans vos d�veloppements 5250
  Une box
  Un �cran de validation
  Une liste � s�lectionner
  Un calendrier
  Une ligne de commande avec gestion des droits
  Un controle de la taille de l'�cran
  Un controle du type du travail 

*** Listes  des sources


! CLP   ! COMPILE     ! CLLE       ! G�n�ration du produit NEW5250       !
! DDS   ! NEW5250     ! DSPF       ! G�n�ration Menu barre Pour DSPF     !
! RPG   ! NEW5250     ! SQLRPGLE   ! Source module New525O               !
! RPG   ! NEW5250INC  ! SQLRPGLE   ! D�claration prototypages            !
! RPG   ! DDS_INC     ! SQLRPGLE   ! D�claration des indicateurs         !
! SRV   ! NEW5250     ! BND        ! Source d'exportation des fonctions  !
! RPG   ! TNEW5250    ! SQLRPGLE   ! Programme Exemple � customiser      !
! CLP   ! TNEW5250C   ! CLLE       ! Programme Exemple � customiser      !
! CLP   ! GETJOBTYPE  ! CLLE       ! Module R�cup�ration Type de travail !


*** Fin listes des sources

Pr� requis :

Compilateur RPGLE
Version V7R3 (� cause du full free)

Installation :

Vous devez restaurer, les sources sur votre syst�me
Compiler le DSPF
vous devez avoir en ligne le fichier qsrvsrc qui contient le source BND
Compiler le programme de g�n�ration COMPILE
Lancer le prgramme COMPILE en indicant Votre biblioth�que de g�n�ration      

Vous devez obtenir
Un programme de service plus un r�pertoire de liage qui sont les 2 �lements utilis�s
 
Utilisation :

Pour les int�grer vous avez un exemple TNEW5250 et TNEW5250C qui montrent le liage en RPGLE et EN CLLE 
le liage
la d�claration des prototypages
et l'utilisation des proc�dures 
                       

