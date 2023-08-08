       CTL-OPT
       ALWNULL(*INPUTONLY) ;
       Dcl-F QADBXREF               Keyed;
       // Procedure Interface
       Dcl-PI WRKPFR;
          LIB                   Char(10);
       End-PI;
       // DS d'utilisation des APIs
       Dcl-DS *N                       INZ;
          PNLGRP        Char(20)    Pos(1)  INZ('WRKPFH    *LIBL     ');
          APPSCP                 BinDec(8:0) Pos(21);
          EXTPRM                 BinDec(8:0) Pos(25);
          ERRCOD                 BinDec(8:0) Pos(29);
          FKEY                   BinDec(8:0) Pos(33);
          VARLEN                 BinDec(8:0) Pos(37);
       End-DS;
       // Prototypes
       Dcl-PR QUIOPNDA                 ExtPgm('QUIOPNDA');
          HANDLE                Char(8);
          PNLGRP                    Like(PNLGRP);
          APPSCP                    Like(APPSCP);
          EXTPRM                    Like(EXTPRM);
          FULHLP                Char(1);
          ERRCOD                    Like(ERRCOD);
       End-PR;
       Dcl-PR QUIPUTV                  ExtPgm('QUIPUTV');
          HANDLE                    Like(HANDLE);
          LIB                       Like(LIB);
          VARLEN                    Like(VARLEN);
          RCDNAM                Char(10);
          ERRCOD                    Like(ERRCOD);
       End-PR;
       Dcl-PR QUIADDLE                 ExtPgm('QUIADDLE');
          HANDLE                    Like(HANDLE);
          VARBUF                    Like(VARBUF);
          VARLEN                    Like(VARLEN);
          RCDNAM                    Like(RCDNAM);
          LSTNAM                Char(10);
          OPTION                    Like(OPTION);
          LEHNDL                Char(4);
          ERRCOD                    Like(ERRCOD);
       End-PR;
       Dcl-PR QUIDSPP                  ExtPgm('QUIDSPP');
          HANDLE                    Like(HANDLE);
          FKEY                      Like(FKEY);
          PNLNAM                Char(10);
          REDSPO                Char(1);
          ERRCOD                    Like(ERRCOD);
       End-PR;
       Dcl-PR QUIDLTL                  ExtPgm('QUIDLTL');
          HANDLE                    Like(HANDLE);
          LSTNAM                    Like(LSTNAM);
          ERRCOD                    Like(ERRCOD);
       End-PR;
       Dcl-PR QUICLOA                  ExtPgm('QUICLOA');
          HANDLE                Char(8);
          CLSOPT                Char(1);
          ERRCOD                    Like(ERRCOD);
       End-PR;
       Dcl-DS VARBUF;
          OPT                    BinDec(4:0) Pos(1);
          FIL                      Char(10) Pos(3);
          TXT                      Char(50) Pos(13);
       End-DS;
       //==========================================================================================
       // Start of moved field definitions.
       //==========================================================================================
       Dcl-S CLSOPT                Char(1);
       Dcl-S FULHLP                Char(1);
       Dcl-S HANDLE                Char(8);
       Dcl-S LEHNDL                Char(4);
       Dcl-S LSTNAM                Char(10);
       Dcl-S OPTION                Char(4);
       Dcl-S PNLNAM                Char(10);
       Dcl-S RCDNAM                Char(10);
       Dcl-S REDSPO                Char(1);
       //==========================================================================================
       // End of moved field definitions.
       //==========================================================================================
       // OPEN THE DISPLAY APPLICATION
       APPSCP = -1;
       FULHLP = 'N';
       ERRCOD = 0;
       QUIOPNDA( HANDLE :PNLGRP :APPSCP :EXTPRM :FULHLP :ERRCOD );
       // PUT THE LIBRARY NAME ON THE SCREEN
       VARLEN = 10;
       RCDNAM = 'HEADER';
       ERRCOD = 0;
       QUIPUTV( HANDLE :LIB :VARLEN :RCDNAM :ERRCOD );
       // PERFORM A LOOP FOR F5 (REFRESH) KEY
       DoU FKEY <> 5;
          // POSITION THE FILE TO THE SELECTED LIBRARY
          SetLL LIB QDBXREF;
          ReadE LIB QDBXREF;
          *IN99 = %eof();
          OPTION = 'FRST';
          // ADD LIST ENTRIES FOR THE SELECTED LIBRARY
          DoW *IN99 = *OFF;
             If DBXATR = 'PF';
                OPT = 0;
                FIL = DBXFIL;
                TXT = DBXTXT;

       // >>>>> Automatically removed by conversion
                VARLEN = 62;
                RCDNAM = 'DETAIL';
                LSTNAM = 'DETLST';
                ERRCOD = 0;
                QUIADDLE( HANDLE :VARBUF :VARLEN :RCDNAM
                          :LSTNAM :OPTION :LEHNDL :ERRCOD );
                OPTION = 'NEXT';
             EndIf;

             ReadE LIB QDBXREF;
             *IN99 = %eof();
          EndDo;
          // DISPLAY THE PANEL
          PNLNAM = 'WRKPF';
          REDSPO = 'N';
          ERRCOD = 0;
          QUIDSPP( HANDLE :FKEY :PNLNAM :REDSPO :ERRCOD );
          // DELETE THE LIST IF F5 PRESSED AND LIST NOT EMPTY
          If FKEY = 5
          and OPTION <> 'FRST';
             LSTNAM = 'DETLST';
             ERRCOD = 0;
             QUIDLTL( HANDLE :LSTNAM :ERRCOD  );
          EndIf;
       EndDo;
       // CLOSE THE APPLICATION
       CLSOPT = 'M';
       ERRCOD = 0;
       QUICLOA( HANDLE :CLSOPT :ERRCOD  );
       *INLR = *ON;
