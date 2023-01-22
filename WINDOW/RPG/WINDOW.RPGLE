**free
     // Ce programme recoit un texte et un titre et l'affiche
     // appuyer sur F3 pour continuer
        Ctl-Opt dftactgrp(*no);
        Ctl-Opt actgrp(*caller);
     // paramètre texte à afficher
        Dcl-Pi *N;
        P_titre            char(50)  ;
        P_texte            Char(80);
        End-Pi;
        Dcl-DS *N;
          idx            Zoned(2:0) inz(99);
          idxAlpha       Char(2)    overlay(idx:1);
        End-DS;
        Dcl-C F3         x'33';
        Dcl-C sa_norm    x'20';
        Dcl-C sa_highlight x'22';
        Dcl-S ExitStr      Char(43)   inz('Press enter to Continue or press F3 to Exit');
        Dcl-S txt          Char(128);
        Dcl-S txtlen       Bindec(9)  inz(132);
        Dcl-S err          Char(8)    inz(x'0000000000000000');
        Dcl-S aid          Char(1);
        Dcl-S wf1          Char(1);
        Dcl-S wrtn         Bindec(9);
        //  effacement
        Dcl-PR ClrScr Bindec(9) extproc('QsnClrScr');
        mode           Char(1)    options(*nopass) const;
        cmdbuf         Bindec(9)  options(*nopass) const;
        env            Bindec(9)  options(*nopass) const;
        error          Char(8)    options(*nopass);
        End-PR;
        //  ecriture
        Dcl-PR WrtDta Bindec(9) extproc('QsnWrtDta');
        data           Char(128);
        datalen        Bindec(9);
        fldid          Bindec(9)  options(*nopass) const;
        row            Bindec(9)  options(*nopass) const;
        col            Bindec(9)  options(*nopass) const;
        strmatr        Char(1)    options(*nopass) const;
        endmatr        Char(1)    options(*nopass) const;
        strcatr        Char(1)    options(*nopass) const;
        endcatr        Char(1)    options(*nopass) const;
        cmdbuf         Bindec(9)  options(*nopass) const;
        env            Bindec(9)  options(*nopass) const;
        error          Char(8)    options(*nopass);
        End-PR;
        //  lecture des touches de fonction
        Dcl-PR GetAID Char(1) extproc('QsnGetAID');
        aid            Char(1)    options(*nopass);
        env            Bindec(9)  options(*nopass) const;
        error          Char(8)    options(*nopass);
        End-PR;
        //
      // *********************************************************************
      //
      // *********************************************************************
      dou     aid = f3;
      // mise à blanc de l'écran
       wrtn = ClrScr('4' : 0 : 0 : err);
      // ecruture touche de fonction
       txt = ExitStr;
       txtlen = %Len(txt);
       wrtn = WrtDta (txt : txtlen : 0 : 4 : 2 :
              sa_norm : sa_norm : sa_highlight : sa_highlight :
              0 : 0 : err);
      // ecriture titre
       txt =  P_titre ;
       txtlen = %Len(txt);
         wrtn = WrtDta (txt : txtlen : 0 : 1 : 25 :
                sa_norm : sa_norm : sa_norm : sa_norm :
                0 : 0 : err);
      // ecriture texte
       txt =  P_texte ;
       txtlen = %Len(txt);
         wrtn = WrtDta (txt : txtlen : 0 : 2 : 2 :
                sa_norm : sa_norm : sa_norm : sa_norm :
                0 : 0 : err);
      // ecriture texte
          wf1 = GetAID (aid : 0 : err);
       Enddo;
         *INLR = *ON;
