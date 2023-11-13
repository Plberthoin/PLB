*---------------------------------------------------------------------*
* Ce logiciel permet de gérer un menu associé à la touche ATTN        *
* Ou chaque utilisateur peut gérer ses propres options                *
* sous forme de Favoris                                               *
*---------------------------------------------------------------------*

Cet outil permet de  gérer les actions utiliées par un utilisateur 
Chaque utilisateur peut mettre à jour ses commandes qu'il utilise le plus
derrière une option de menu.
Vous pouvez exporter un menu SDA existant par la commande EXPATTMNU
pour le mettre en oeuvre
Vous devez soit changer le profil utilisateur par la commande
CHGUSRPRF ... ATNPGM(ATTNMNU)
ou
CHGPRF ATNPGM(*LIBL/ATTNMNU)

ou l'ajouter temporairement par la commande 

SETATNPGM PGM(ATTNMNU)

*** Listes  des sources

! SQL   ! ATTNMNUT    ! SQL       ! Fichier qui contient les otions !
! RPG   ! ATTNMNU     ! SQLRPGLE  ! Programme ATTN                  !
! DDS   ! ATTNMNU     ! DSPF      ! Ecran ATTN                      !
! UIM   ! ATTNMNU     ! PNLGRP    ! Aide ATTN                       !
! CMD   ! EXPATTMNU   ! CMD       ! Exportation d'un menu           !
! CLP   ! EXPATTMNU   ! CLLE      ! Exportation d'un menu           !


PREREQUIS

Vous devez avoir la version V7R3 Level 15 pour disposer de la vue QSYS2.MESSAGE_FILE_DATA


La bibliothèque qui contient vos objets doit être en ligne 

Vous devez d'abord créer le fichier BD ATTNMNUT 
Vous devez ensuite compiler l'écran ATTNMNU
Et ensuite compiler les autres objets  

                          !
*** Fin listes des sources
