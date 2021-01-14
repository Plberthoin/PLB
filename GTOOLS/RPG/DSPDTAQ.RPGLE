       // Affichage du contenu d'une dtaq
       // Recoit en paramètre la dtaq et la bibliothèque
       //
       ctl-opt DFTACTGRP(*NO) ;
       dcl-f DSPDTAQE   WORKSTN  SFILE(sfl01:cle01) SFILE(sfl02:cle02);
       // les paramètres recus
       //************************************************************
       // Paramètres reçus
       //************************************************************
       dcl-pi *N ;
         P_DTAQ char(20);
         P_fmt  char(5);
       end-pi ;
       //************************************************************
       // zones isolées
       //************************************************************
       DCL-S ptIndicateurs pointer Inz(%addr(*in));
       dcl-s ForCounter int(10);
       dcl-s p1data varchar(65535);
       dcl-s qTrimLen int(10);
       dcl-s  V0200LEN int(10);
       dcl-s UserSpaceName char(20) inz('DTAQDUMP  QTEMP     ');
       dcl-s cle01 PACKED(4) ;
       dcl-s cle02 PACKED(4);
       dcl-s AliSfl ind inz(*on);
       dcl-s AliSfl2 ind;
       dcl-s ofsender int(10);
       //************************************************************
       // constantes
       //************************************************************
       dcl-c nonprnt X'000102030405060708090A0B0C0D0E0F101112131415161718191A1+
         B1C1D1E1F202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3+
         D3E3F41';

       dcl-c space X'40404040404040404040404040404040404040404040404040404040+
         40404040404040404040404040404040404040404040404040404040404040404040+
         404040';
       //************************************************************
       // Data-structures
       //************************************************************
       dcl-ds Infds; //INFDS data structure
         Choice char(1) pos(369);
         Currec int(5) pos(378);
       end-ds;

       // Move pointer through message entries
       dcl-ds ListEntryDS qualified based(ListEntryPtr);
         NextEntry int(10);
         Datetime char(8); // TODformat
         MessageData char(65535); //variable text
       end-ds;

       DCL-DS  dsIndicateurs Based(ptIndicateurs);
         Mode_hexa ind pos(10);
         Entry_nd ind;
         Chg_ind ind pos(30);
         sflclr_sfl01 ind pos(40);
         sfldspctl_sfl01 ind;
         sfldsp_sfl01 ind;
         sflclr_sfl02 ind pos(50);
         sfldspctl_sfl02 ind;
         sfldsp_sfl02 ind;
         Dtaq_with_key ind pos(80);
         Dtaq_with_senderid ind ;
       END-DS;
       // Program Info
       //
       dcl-ds *n PSDS;
         wPGM *proc;
         wPARMS  packed(3) pos(37);
         wMSGDTA char(80) pos(91);
         wMSGID char(4) pos(171);
         wJOB char(10) pos(244);
         wUSER char(10);
         wJOBx  zoned(6);
       end-ds;
       // parms for QMHRDQM retrieve dataq entries
       dcl-ds qmhrdqmDS qualified based(uheadPtr);
         BytesReturned int(10);
         BytesAvail int(10);
         MsgRtnCount int(10);
         MsgAvlCount int(10);
         KeyLenRtn int(10);
         KeyLenAvl int(10);
         MsgTxtRtn int(10);
         MsgTxtAvl int(10);
         EntryLenRtn int(10);
         EntryLenAvl int(10);
         OffsetToEntry int(10);
         DtaqLib char(10);
       end-ds;

      // Message selection info - RDQS0100 nonkeyed queues  RDQS0200 Keyed data queues
       dcl-ds rdqs0100DS qualified;
         Selection char(1) inz('A'); //all
         MsgByteRtv int(10)  inz pos(5);  //message bytes to rtv
       end-ds;

       // Error return code parm for APIs.
       dcl-ds ApiErrDS qualified;
         BytesProvided int(10);
         BytesReturned int(10);
         ErrMsgId char(7);
         *n char(1);
         MsgReplaceVal char(112);
       end-ds;

       dcl-ds  qmhqrdqdDS  qualified inz;
         MsgLength int(10) pos(9);
         KeyLength int(10);
         Sequence char(1);
         SenderID char(1);
         Text  char(50);
         LocalOrDDM char(1);
         EntryCount int(10) pos(73);
         MaxOverFlow int(10);
         DtaqName char(10);
         DtaqLib char(10);
       end-ds;

       dcl-ds rdqs0200DS qualified inz;
         Selection char(1) inz('K'); //Keyed
         KeyOrder char(2) inz('GE');
         MsgByteRtv int(10) pos(5); //  message bytes to rtv
         KeyByteRtv int(10); //keys bytes to rtv
         KeyLen int(10); //key length
         Key char(256); // key value
       end-ds;

       dcl-ds clechar;
         Valcle1 char(120);
         Valcle2 char(120);
         Valcle3 char(16);
       END-DS;

       dcl-ds cleHEXG;
         Valcle1HG char(120);
         Valcle2HG char(120);
         Valcle3HG char(16);
       END-DS;

       dcl-ds cleHEXd;
         Valcle1Hd char(120);
         Valcle2Hd char(120);
         Valcle3Hd char(16);
       END-DS;

       //************************************************************
       // prototypes
       //************************************************************
       dcl-pr QMHRDQM extpgm; //Get q Entry
         *n like(qmhrdqmDS) Options(*varsize); // Receiver
         *n  int(10) const; // Length
         *n char(8) const;  // Api Format
         *n char(20);       // Dtaq and Lib
         *n like(RDQS0200DS) Options(*varsize) const; // Key Information
         *n int(10) const; // Key Info Length
         *n char(8) const; // Information
         *n like(ApiErrDS) Options(*varsize); //Error Parm
       end-pr;

       dcl-pr QUSCRTUS extpgm;
         *n char(20) const;
         *n char(10) const;
         *n int(10) const;
         *n char(1) const;
         *n char(10) const;
         *n char(50) const;
         *n char(10) const;
         *n like(ApiErrDS) Options(*varsize);
       end-pr;

       dcl-pr QUSPTRUS extpgm;
         *n char(20) const;
         *n pointer;
         *n like(ApiErrDS) Options(*varsize);
       end-pr;

       dcl-pr QMHQRDQD extpgm; // Data q Description
         *n  like(qmhqrdqdDS); // Receiver
         *n int(10) const; // Length
         *n char(8) const; // Api Format
         *n Char(20) const; // Dtaq and Lib
       end-pr;

       Dcl-pr QWCCVTDT extpgm;
         *n char(10) const;
         *n char(8) const;
         *n char(10) const;
         *n char(8);
         *n like(ApiErrDS) Options(*varsize);
       end-pr;

       dcl-pr cvthc extproc('cvthc');
         *n char(1);
         *n char(1);
         *n int(10) value;
       end-pr;
       //***********************************************************************
      /free
       Mode_hexa=P_fmt='*HEX';

       dtq=%trim(%subst(p_dtaq:11))+'/'+%subst(p_dtaq:1:10);
       //
       // init user        //
       Trait_parm();
       Display_SFL();
       //
       *inlr = *on;
       //
       // Initialisation
       //
       dcl-proc Init_SFL;
         num01 = 1;
         clear cle01;
         sflclr_sfl01 = *on;
         clear sfldsp_sfl01;
         clear sfldspctl_sfl01;

         write ctl01;
         clear sflclr_sfl01;
         clear AliSfl;
       end-proc ;
       //
       // Chargement
       //
       //
       // Display
       //
       dcl-proc Display_SFL;
         if AliSfl;
           Init_SFL();
           Load_SFL();
         ENDIF;

         sfldsp_sfl01=cle01>0;
         dow 1=1;
           sfldspctl_sfl01=*on;
           write fmt01;
           exfmt(e) ctl01;
           if *inkc;
             leave;
           //       affichage du detail
           endif;
           select;
           // raffraichissage des infos
           when *inKE;
             AliSfl=*on;
           other;
             //       affichage du detail
             if sfldsp_sfl01;
               readc sfl01 ;
               if not %eof() ;
                 //suppression entete
                 Detail_poste();
                 clear opt01;
                 update(e) sfl01;
               else;
                 AliSfl=*on;
               endif ;
             endif ;
           endsl;
         enddo;
       end-proc ;
       //******************************************************************
       // traitement paramètre
       dcl-proc Trait_parm      ;
         // create user space
         QUSCRTUS( UserSpaceName: 'TEST': 13000000: x'00': '*ALL':
           'List Objects  ': '*NO ': ApiErrDS);
         // Get pointer to object list user spaces
         QUSPTRUS( UserSpaceName: uHeadPtr: ApiErrDS);

         // Call API to retrieve data queue description.
         monitor;
           QMHQRDQD( qmhqrdqdDS: %size(qmhqrdqdDS): 'RDQD0100': P_dtaq);
         on-error;
         endmon;
         Dtaq_with_key=qmhqrdqdDS.Sequence='K';
         if qmhqrdqdDS.Sequence='K';
           seq='*KEYED';
           KEYLEN=qmhqrdqdDS.KeyLength;
         elseif qmhqrdqdDS.Sequence='F';
           seq='*FIFO';
         else;
           seq='*LIFO';
         EndIf;

         if qmhqrdqdDS.SenderID='Y';
           IDEM='*YES';
           ofsender=36;
         else;
           IDEM='*NO';
           ofsender=0;
         EndIf;

       end-proc ;
       //---------------------------------------------------------
       // Call API to retrieve data queue entries
       // Different type dataqs require a different parm list to the API.
       //---------------------------------------------------------
       dcl-proc Load_SFL       ;

         if Dtaq_with_key;
           rdqs0200DS.MsgByteRtv = qmhqrdqdDS.MsgLength;
           rdqs0200DS.KeyByteRtv = qmhqrdqdDS.KeyLength;
           rdqs0200DS.KeyLen = qmhqrdqdDS.KeyLength;

           v0200Len=16+qmhqrdqdDS.KeyLength;  //len of info

           QMHRDQM( qmhrdqmDS: 12000000: 'RDQM0200': P_dtaq:
           rdqs0200DS: v0200Len: 'RDQS0200': ApiErrDS);
         else;
           // non keyed
           rdqs0100DS.MsgByteRtv = qmhqrdqdDS.MsgLength;
           QMHRDQM( qmhrdqmDS: 12000000: 'RDQM0100': P_dtaq:
            rdqs0100DS: %size(rdqs0100DS): 'RDQS0100': ApiErrDS);
         endif;

         //---------------------------------------------------------
         // Spin through the dataq entries.
         // Convert API date/time stamp to human-readable.
         // Load to subfile.
         //---------------------------------------------------------
         // chargement des écrans
         nbposte= qmhrdqmDS.MsgRtnCount ;
         lenposte =  qmhrdqmDS.MSGTXTRTN ;
         if qmhrdqmDS.MsgRtnCount >  0;

           //---------------------------------------------------------
           // Move pointer through message entries
           //---------------------------------------------------------
           ListEntryPtr = uHeadPtr + qmhrdqmDS.OffsetToEntry;
           pos=qmhrdqmDS.OffsetToEntry;
           for ForCounter = 1 to qmhrdqmDS.MsgRtnCount;
             srTempqDS();
             //viewqDS = %subst(TempqDS: 1);
             pos=ListEntryDS.NextEntry;
             ListEntryPtr = uHeadPtr + ListEntryDS.NextEntry;
           endfor;
         endif;
       end-proc ;
       //---------------------------------------------------------
       // Fill TempqDS from User Space Data.
       // Note: If Keyed data queue, then there is an unexplained
       // 5 bytes at the beginning of each key.
       // not sure if this a bug or an undocumented feature.
       // Also the size of the msg entry could be larger than  msg variable
       // allowed. qTrimLen is used to make sure this doesn't blow up!
       //---------------------------------------------------------
       dcl-proc srTempqDS;

         dcl-s TempqDS char(65535);

         dcl-ds timestamp qualified len(17);
           date char(8);
           heure char(6);
         END-DS;

         qTrimLen = qmhqrdqdDS.MsgLength;

         if Dtaq_with_key;
           // RMH -Entry/Key display mode.
           TempqDS= %subst(ListEntryDS.MessageData:5+ofsender+KeyLen:qTrimLen);
           keyval=%subst(ListEntryDS.MessageData:5:KeyLen);
         else;
           TempqDS=%subst(ListEntryDS.MessageData:1+ofsender:qTrimLen);
         endif;
         // suppression des caractères non affichables
         // formatage zone de l'écran
         dta100 = %subst(%xlate(nonprnt:space:%trimr(tempqDS)):1);

         QWCCVTDT('*DTS':ListEntryDS.Datetime:'*DMYY':timestamp:ApiErrDS);
         edate=%xlate('.':'/':%char(%date(timestamp.date:*EUR0):*eur));
         etime=%char(%time(timestamp.heure:*HMS0):*HMS);

         // ecriture enregistrement du sfl
         cle01+=1 ;
         write sfl01 ;
       end-proc  ;
       //**********************************************************************
       Dcl-proc detail_poste;

         poste=cle01;
         AliSfl2=*on;
         posit=1;

         dow 1=1;
           if AliSfl2;
             charge_sfl2();
           ENDIF;
           write fmt02;
           exfmt(e) ctl02;

           if *inkl=*on;
             leave;
           elseif *inkj;
             Mode_hexa=not Mode_hexa;
             alisfl2=*on;
           elseif *inkk;
             aff_hexa_cle();
           elseif chg_ind; // position
             alisfl2=*on;
             if posit>lenposte;
               posit=lenposte-%size(dta125);
               if posit<0;
                 posit=1;
               ENDIF;
             ENDIF;
           ENDIF;

         ENDDO;
       END-PROC;
       //**********************************************************************
       dcl-proc charge_sfl2;

         dcl-s TempqDS char(65535);
         dcl-s dta250 char(250);
         dcl-s dta125HG varchar(125);
         dcl-s dta125HD varchar(125);
         dcl-s i uns(3);
         dcl-s lg int(10);
         dcl-s pos1 int(10) inz(1);

         ListEntryPtr = uHeadPtr+pos;
         num02 = 1;

         clear cle02;
         sflclr_sfl02 = *on;
         clear sfldsp_sfl02;
         clear sfldspctl_sfl02;

         write ctl02;
         clear sflclr_sfl02;
         clear alisfl2;
         clear Entry_nd;

         entry=posit;

         qTrimLen = qmhqrdqdDS.MsgLength;

         if Dtaq_with_key;
           // RMH -Entry/Key display mode.
           TempqDS= %subst(ListEntryDS.MessageData:5+ofsender+KeyLen:qTrimLen);
           keyval=%xlate(nonprnt:space:%subst(ListEntryDS.MessageData:5:
             KeyLen));
           if ofsender>0;
             idem$=%subst(ListEntryDS.MessageData:5+KeyLen);
           ENDIF;
         else;
           TempqDS=%subst(ListEntryDS.MessageData:1+ofsender:qTrimLen);

           if ofsender>0;
             idem$=TempqDS=%subst(ListEntryDS.MessageData:1);
           ENDIF;
         endif;

         tempqDS=%subst(tempqDS:posit);

         // suppression des caractères non affichables
         p1data = %trimr(tempqDS);
         p1data = %xlate(nonprnt:space:p1data) ;
         Lg=qTrimLen-entry+1;
         // formatage zone de l'écran
         dow pos1< %len(p1data);
           if not Mode_hexa;
             dta125 = %subst(p1data:pos1) ;
             // ecriture enregistrement du sfl
             cle02+=1 ;
             write sfl02 ;
           else;  //mode hexa
             clear Entry_nd;
             dta125 = %subst(p1data:pos1);
             cle02+=1 ;
             write sfl02 ;

             dta125 = %subst(tempqDS:pos1);
             cvthc(dta250:dta125:250);
             clear dta125HG;
             clear dta125HD;
             for i=1 to %size(dta125)*2 by 2;
               dta125HG+=%subst(dta250:I:1);
               dta125HD+=%subst(dta250:i+1:1);
             ENDFOR;

             if lg<%size(dta125);
               %subst(dta125HG:lg+1)='';
               %subst(dta125HD:lg+1)='';
             ENDIF;

             lg-=%size(dta125);

             Entry_nd=*on;
             dta125=dta125HG;
             cle02+=1 ;
             write sfl02 ;

             dta125=dta125HD;
             cle02+=1 ;
             write sfl02 ;
           endif;
           entry+=%size(dta125);
           pos1+=%size(dta125);
         ENDDO;

         sfldsp_sfl02=cle02>0;
         sfldspctl_sfl02=*on;

       END-PROC;
       //**********************************************************************
       dcl-proc aff_hexa_cle;

         dcl-s key512 char(512);
         dcl-s key256 char(256);
         dcl-s i uns(3);
         dcl-s charhg char(1) based(ptr_charHG);
         dcl-s charhd char(1) based(ptr_charHD);


         CLECHAR=keyval;
         key256=%subst(ListEntryDS.MessageData:5:KeyLen);
         cvthc(key512:key256:512);

         clear cleHEXG;
         clear cleHEXD;

         ptr_charHG=%addr(cleHEXG);
         ptr_charHD=%addr(cleHEXD);
         for i=1 to KEYLEN *2 by 2;
           charhg=%subst(key512:I:1);
           charhd=%subst(key512:i+1:1);
           ptr_charHG+=1;
           ptr_charHD+=1;
         ENDFOR;

         dow 1=1;
           exfmt fmt03;
           if *inkl;
             leave;
           ENDIF;
         ENDDO;


       END-PROC;


      /end-free 