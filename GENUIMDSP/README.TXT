*---------------------------------------------------------------------*
* Ce logiciel permet de gérer vous aidez pour mettre en place         *
* de l'aide sur vos écrans DSPF en utilisant un panel de groupe       *
*---------------------------------------------------------------------*

Cet outil permet de  gérer 
Les instrcutions à inclure dans votre fichier évcran
le sequellette du panel de groupe correspondant 

*** Listes  des sources

! CLP   ! GENUIMDSP   ! CLLE       ! Génération aide Pour DSPF   !
! CMD   ! GENUIMDSP   ! CMD        ! Génération aide Pour DSPF   !
! CBL   ! GENUIMCBL   ! SQLCBLE    ! Génération aide Pour DSPF   !
! UIM   ! GENUIMCBL   ! PNLGRP     ! Génération aide Pour DSPF   !

Pas de dépendance vous pouvez compiler dans l'ordre ou vous voulez
Attention  GENUIMCBL  c'est du cobol
pour avoir l'aide sur la commande 
vous devez indiquer sur la compilation de la commande : 
HLPPNLGRP(GENUIMDSP)
HLPID(*CMD)         


                          !
*** Fin listes des sources
