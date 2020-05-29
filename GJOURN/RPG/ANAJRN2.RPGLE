f*------------------------------------------------------------------*

f*

f* Ce programme recopie un fichier sortie de dspjrn

f* options  ENTTYP(*RCD)

f*          ENTDTALEN(*VARLEN *CALC)

f*

f* dans un fichier de travail qui redecoupe les données spécifiques

f* dans notre exemple le

f* le fichier analyse  sera accessible par sql

f* dans notre cas de SORTIE vers ANALYSE

f*

f*------------------------------------------------------------------*

f* Fichier sortie du dspjrn

fsortie    if   e             disk

f* Fichier de traitement zone du fichier  + dspjrn

fanalyse   o    e             disk    rename(analyse:analysef)

f* Description du fichier de données

dds01           e ds                  EXTNAME(modele)

 /free

  //  *-------------------------------------------------------------*

  //  * Boucle de lecture du fichier                                *

  //  *-------------------------------------------------------------*

  dou %eof(sortie       )         ;

    read  sortie                  ;

    if %eof(sortie       )        ;

      Leave                       ;

    endif                         ;

  // externalisation des données

  Monitor ;

    ds01 = JOESD                  ;

    write analysef                ;

    on-error                      ;

  //  dsply  'Probléme sur poste :'     ;

  //  dsply          JOSEQN         ;

    endmon                        ;

  enddo                           ;

  //  *-------------------------------------------------------------*

  //  * Fin du programme                                            *

  //  *-------------------------------------------------------------*

  *inlr = *on                     ;

 /end-free
