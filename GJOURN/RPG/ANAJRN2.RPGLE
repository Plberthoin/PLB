**free
//------------------------------------------------------------------*
//
// Ce programme recopie un fichier sortie de dspjrn
// options  ENTTYP(*RCD)
//          ENTDTALEN(*VARLEN *CALC)
//
// dans un fichier de travail qui redecoupe les donn�es sp�cifiques
// dans notre exemple le
// le fichier analyse  sera accessible par sql
// dans notre cas de SORTIE vers ANALYSE
//
//------------------------------------------------------------------*
//Fichier sortie du dspjrn
Dcl-F sortie Usage(*Input);
//Fichier de traitement zone du fichier  + dspjrn
Dcl-F analyse Usage(*Output) rename(analyse:analysef);
//Description du fichier de donn�es
Dcl-DS ds01  EXTNAME('MODELE');
END-DS;
//  *-------------------------------------------------------------*
//  * Boucle de lecture du fichier                                *
//  *-------------------------------------------------------------*
dou %eof(sortie       )         ;
  read  sortie                  ;
  if %eof(sortie       )        ;
    Leave                       ;
  endif                         ;
  // externalisation des donn�es
  Monitor ;
    ds01 = JOESD                  ;
    write analysef                ;
  on-error                      ;
  endmon                        ;
enddo                           ;
//  *-------------------------------------------------------------*
//  * Fin du programme                                            *
//  *-------------------------------------------------------------*
*inlr = *on                     ;
