*---------------------------------------------------------------------*
* Ce logiciel permet d'envoyer les statistiques                       *
* De volume pour une unité de bande                                   *
*---------------------------------------------------------------------*

Vous devrez indiquer l'unité de bande et le mail de destination
  

*** Listes  des sources


! CLP   ! SNDVOLSTAT  ! CLLE       ! Envoi Statistique de volume         !
! CMD   ! SNDVOLSTAT  ! CMD        ! Envoi Statistique de volume         !
! CLP   ! RTVDEVTYP   ! CLLE       ! Réupération type d'unité            !
*** Fin listes des sources

Pré requis :



Installation :

Vous devez restaurer, les sources sur votre système
Compiler les programmes       
Compiler la commande 

SNDVOLSTAT DEVD(TAP01) MAIL('plb@gaia.fr') 
                       

