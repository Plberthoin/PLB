*---------------------------------------------------------------------*
* Ce logiciel permet de g�rer vous aidez pour mettre en place         *
* de l'aide sur vos �crans DSPF en utilisant un panel de groupe       *
* de g�n�rer des menus multilangues                                   *
*---------------------------------------------------------------------*

Cet outil permet de  g�rer 
Les instrcutions � inclure dans votre fichier �cran
le sequellette du panel de groupe correspondant

il permet �galement de g�rer un fichier de message pour param�trer la langue de ce dernier

c'est la commande  CRTMNUMOD + le mod�le joint en uin source MODELE 

*** Listes  des sources

! CLP   ! GENUIMDSP   ! CLLE       ! G�n�ration aide Pour DSPF   !
! CMD   ! GENUIMDSP   ! CMD        ! G�n�ration aide Pour DSPF   !
! CBL   ! GENUIMCBL   ! SQLCBLE    ! G�n�ration aide Pour DSPF   !
! UIM   ! GENUIMCBL   ! PNLGRP     ! G�n�ration aide Pour DSPF   !
! CLP   ! CRTMNUMOD   ! CLLE       ! G�n�ration hier MSGF mod�le !
! CMD   ! CRTMNUMOD   ! CMD        ! G�n�ration hier MSGF mod�le !
! UIM   ! MODELE      ! PNLGRP     ! Modele menu UIM avec fichier!


Pas de d�pendance vous pouvez compiler dans l'ordre ou vous voulez
Attention  GENUIMCBL  c'est du cobol
pour avoir l'aide sur la commande 
vous devez indiquer sur la compilation de la commande : 
HLPPNLGRP(GENUIMDSP)
HLPID(*CMD)   

Pour les menus multilangue vous devez cr�er le fichiers message (par d�faut en Francais), c'est la commande CRTMNUMOD 
Vous devrez indiquer ensuite dans votre source le fichier message utilis�

 
       


                          !
*** Fin listes des sources
