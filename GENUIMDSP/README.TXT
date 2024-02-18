*---------------------------------------------------------------------*
* Ce logiciel permet de gérer vous aidez pour mettre en place         *
* de l'aide sur vos écrans DSPF en utilisant un panel de groupe       *
* de générer des menus multilangues                                   *
*---------------------------------------------------------------------*

Cet outil permet de  gérer 
Les instrcutions à inclure dans votre fichier écran
le sequellette du panel de groupe correspondant

il permet également de gérer un fichier de message pour paramétrer la langue de ce dernier

c'est la commande  CRTMNUMOD + le modéle joint en uin source MODELE 

*** Listes  des sources

! CLP   ! GENUIMDSP   ! CLLE       ! Génération aide Pour DSPF   !
! CMD   ! GENUIMDSP   ! CMD        ! Génération aide Pour DSPF   !
! CBL   ! GENUIMCBL   ! SQLCBLE    ! Génération aide Pour DSPF   !
! UIM   ! GENUIMCBL   ! PNLGRP     ! Génération aide Pour DSPF   !
! CLP   ! CRTMNUMOD   ! CLLE       ! Génération hier MSGF modéle !
! CMD   ! CRTMNUMOD   ! CMD        ! Génération hier MSGF modéle !
! UIM   ! MODELE      ! PNLGRP     ! Modele menu UIM avec fichier!


Pas de dépendance vous pouvez compiler dans l'ordre ou vous voulez
Attention  GENUIMCBL  c'est du cobol
pour avoir l'aide sur la commande 
vous devez indiquer sur la compilation de la commande : 
HLPPNLGRP(GENUIMDSP)
HLPID(*CMD)   

Pour les menus multilangue vous devez créer le fichiers message (par défaut en Francais), c'est la commande CRTMNUMOD 
Vous devrez indiquer ensuite dans votre source le fichier message utilisé

 
       


                          !
*** Fin listes des sources
