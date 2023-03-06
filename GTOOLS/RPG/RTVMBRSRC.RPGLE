**FREE
//
// Ce programme récupère dans une commande CRTPRTF
// CRTPF , CRTLF , CRTDSPF
//   La bibliothèque, le fichier source et le membre source
//
ctl-opt DFTACTGRP(*NO) ;

// Paramètre PGM
Dcl-Pi *N;
  P_data           Char(32000) ;   //I La commande
  P_lib            Char(10);       //O bibliothèque
  P_fil            Char(10);       //O Fichier
  P_mbr            Char(10);       //O Membre
End-Pi;

// Variables de travail
dcl-s pos1     PACKED(4 : 0) ;
dcl-s pos2     PACKED(4 : 0) ;
// CRTPRTF FILE(BIB/NOMPRTF) SRCFILE(LIB/FIL) SRCMBR(MBR)
// recherche SRCFILE dans la chaine
pos1 = %scan('SRCFILE(' : p_data : 1) ;
if pos1 > 1 ;
  // recherche bibliothèque source
  pos2   =  %scan('/' : p_data : pos1)  ;
  if pos2 >  0  ;
    p_lib  = %subst(p_data : (pos1 + 8) : (pos2 - (pos1 + 8 ) )) ;
  else ;
    p_lib = '*LIBL' ;
    pos2 = pos1 + 7 ;
  endif ;
  // recherche fichier source
  // recherche premier )
  pos1   =  %scan(')' : p_data : pos2) ;
  p_fil = %subst(p_data : (pos2 +1)  : (pos1 - (pos2 + 1) ));
endif ;
// recherche SRCMBR  dans la chaine
pos1 = %scan('SRCMBR(' : p_data : 1) ;
if pos1 > 1 ;
  // recherche du membre
  pos2   =  %scan(')' : p_data : pos1) ;
  p_mbr  = %subst(p_data : (pos1 + 7)  : (pos2 - (pos1 + 7) ));
  if p_mbr = '*FILE' ;
    pos1 = %scan('FILE(' : p_data : 1) ;
    if pos1 > 1 ;
      // recherche bibliothèque du fichier prtf
      pos2   =  %scan('/' : p_data : pos1)  ;
      if pos2 >  0  ;
        p_lib  = %subst(p_data : (pos1 + 5) : (pos2 - (pos1 + 5 ) )) ;
      else ;
        p_lib = '*LIBL' ;
        pos2 = pos1 + 7 ;
      endif ;
      // recherche fichier prtf
      // recherche premier )
      pos1   =  %scan(')' : p_data : pos2) ;
      p_mbr = %subst(p_data : (pos2 +1)  : (pos1 - (pos2 + 1) ));
    endif ;
  endif ;
endif ;
// si membre non indiqué on prend le fichier
pos1 = %scan('SRCMBR(' : p_data : 1) ;
if pos1 = 0 ;
  pos1 = %scan('FILE(' : p_data : 1) ;
  if pos1 > 1 ;
    // recherche bibliothèque du fichier prtf
    pos2   =  %scan('/' : p_data : pos1)  ;
    if pos2 >  0  ;
      p_lib  = %subst(p_data : (pos1 + 5) : (pos2 - (pos1 + 5 ) )) ;
    else ;
      p_lib = '*LIBL' ;
      pos2 = pos1 + 7 ;
    endif ;
    // recherche fichier prtf
    // recherche premier )
    pos1   =  %scan(')' : p_data : pos2) ;
    p_mbr = %subst(p_data : (pos2 +1)  : (pos1 - (pos2 + 1) ));
  endif ;
endif ;
*inlr = *on ;
