       // Converted from WRKPFTRG/QRPGLESRC(WRKPFTRGRN) to WRKPFTRG/QRPGLESRC(WRKPFTRG2).
       // Converted with CVTRPGFREE version 1.5.09 on 2023-08-04-15.44.53.410273.
       // Go to https://sourceforge.net/projects/cvtrpgfree/ for support and updates.
       // >>>>> File not found - conversion could be impaired.
       Dcl-F WRKPFTRE       WORKSTN
                                    SFILE(SFL01:NUM01);
       Dcl-F QAFDTRG                ;

       // Prototypes
       Dcl-PR QCMDEXC                  ExtPgm('QCMDEXC');
          CMD                   Char(120);
          LEN                 Packed(15:5);
       End-PR;

       Dcl-C ADDTRG                    '?ADDPFTRG FILE(';
       Dcl-C CHGTRG                    'CHGPFTRG FILE(';
       Dcl-C RMVTRG                    'RMVPFTRG FILE(';
       //==========================================================================================
       // Start of moved field definitions.
       //==========================================================================================
       Dcl-S CMD                   Char(120);
       Dcl-S LEN                 Packed(15:5);
       Dcl-S NUM01               Packed(4:0);
       Dcl-S TEST                  Char(4);
       //==========================================================================================
       // End of moved field definitions.
       //==========================================================================================

       // >>>>> Not converted: Conversion not currently supported.
     C     *ENTRY        PLIST
       // >>>>> Not converted: Conversion not currently supported.
     C                   PARM                    LIB
       // >>>>> Not converted: Conversion not currently supported.
     C     *in05         PARM      *in05         in05
       Test = 'INI1';

       DoU *IN03 = *ON
       or *IN05 = *ON;
          If TEST = 'INI1';
             Exsr INI1;
          ElseIf TEST = 'CHA1';
             Exsr CHA1;
          ElseIf TEST = 'AFF1';
             Exsr AFF1;
          ElseIf TEST = 'CTL1';
             Exsr CTL1;
          ElseIf TEST = 'TRT1';
             Exsr TRT1;
          EndIf;
       EndDo;

       *INLR = *ON;

       BegSr INI1;
          *IN40 = *ON;
          Write CTL01;
          *IN40 = *OFF;
          NUM01 = 0;
          Test = 'CHA1';
       EndSr;

       BegSr CHA1;
       // >>>>> Not converted: Straight move between unknown fields is dangerous.
     C                   MOVE      ' '           OPT01
          DoU *IN90 = *ON;
             Read QAFDTRG;
             *IN90 = %eof();
             If *IN90 = *OFF;

       // >>>>> Not converted: Straight move between unknown fields is dangerous.
     C                   MOVEL     TRNAM         WTRNAM
                NUM01 = NUM01 + 1;
                Write SFL01;
             EndIf;
          EndDo;
          Test = 'AFF1';
       EndSr;

       BegSr AFF1;
          *IN42 = *ON;
          If NUM01 > 0;
             *IN41 = *ON;
          Else;
             *IN41 = *OFF;
          EndIf;
          Write FMT01;
          Exfmt CTL01;
          If *IN03 = *OFF
          and *IN05 = *OFF;
             If *IN06 = *ON;
       // >>>>> Not converted: Straight move between unknown fields is dangerous.
     C                   MOVE      '1'           OPT01
             EndIf;
             Test = 'CTL1';
          EndIf;
       EndSr;
       BegSr CTL1;
          If *in06 = *on;
             Test = 'TRT1';
          Else;
             If num01 > 0;
                ReadC sfl01;
                *IN91 = %eof();
                If *in91 = *off;
                   Test = 'TRT1';
                EndIf;
             EndIf;
          EndIf;

       EndSr;
       BegSr trt1;
          Select;
       // PING
             When OPT01 = '1';
       // ADDPFTRG FILE(    ) TRGTIME(*BEFORE) TRGEVENT(*INSERT) PGM(    )
                CMD = *BLANK;
       // >>>>> Not converted: No padding specified, result unpredictable.
     C     addtrg        CAT       LIB:0         CMD
                CMD = %trimr(cmd) + %trim('/nomfic)');
       // >>>>> Automatically removed by conversion
       //C                   CALL      'QCMDEXC'                            98
                LEN = 120;

                CallP(E) QCMDEXC(
                                CMD
                                :LEN
                                );

                *IN98 = %error();
       //C                   PARM                    CMD             120
       //C                   PARM      120           LEN              15 5
             When OPT01 = '2';
                CMD = *BLANK;
       // >>>>> Not converted: No padding specified, result unpredictable.
     C     chgTRG        CAT       lib:0         CMD
                CMD = %trimr(cmd) + %trim('/');
                CMD = %trimr(cmd) + %trim(trfile);
                CMD = %trimr(cmd) + %trim(') TRG(');
                CMD = %trimr(cmd) + %trim(TRNAM);
                CMD = %trimr(cmd) + %trim(') STATE(');
                CMD = %trimr(cmd) + %trim('*DISABLED');
                CMD = %trimr(cmd) + %trim(') TRGLIB(');
                cmd = %trimr(cmd) + %trim(trlib);
                CMD = %trimr(cmd) + %trim(')');
       // CHGPFTRG FILE(    ) TRG(       ) TRGLIB(    ) STATE(*ENABLED)
       // >>>>> Automatically removed by conversion
       //C                   CALL      'QCMDEXC'
                LEN = 120;

                CallP QCMDEXC(
                             CMD
                             :LEN
                             );

       //C                   PARM                    CMD             120
       //C                   PARM      120           LEN              15 5
                trst = 'D';
             When OPT01 = '3';
                CMD = *BLANK;
       // >>>>> Not converted: No padding specified, result unpredictable.
     C     chgTRG        CAT       lib:0         CMD
                CMD = %trimr(cmd) + %trim('/');
                CMD = %trimr(cmd) + %trim(trfile);
                CMD = %trimr(cmd) + %trim(') TRG(');
                CMD = %trimr(cmd) + %trim(TRNAM);
                CMD = %trimr(cmd) + %trim(') STATE(');
                CMD = %trimr(cmd) + %trim('*ENABLED');
                CMD = %trimr(cmd) + %trim(') TRGLIB(');
                cmd = %trimr(cmd) + %trim(trlib);
                CMD = %trimr(cmd) + %trim(')');
                TRST = 'E';
       // >>>>> Automatically removed by conversion
       //C                   CALL      'QCMDEXC'
                LEN = 120;

                CallP QCMDEXC(
                             CMD
                             :LEN
                             );

       //C                   PARM                    CMD             120
       //C                   PARM      120           LEN              15 5
                trst = 'E';
       // RMVPFTRG FILE(    ) TRG(       ) TRGLIB(    )
             When OPT01 = '4';
                CMD = *BLANK;
       // >>>>> Not converted: No padding specified, result unpredictable.
     C     rmvTRG        CAT       lib:0         CMD
                CMD = %trimr(cmd) + %trim('/');
                CMD = %trimr(cmd) + %trim(trfile);
                CMD = %trimr(cmd) + %trim(') TRG(');
                CMD = %trimr(cmd) + %trim(TRNAM);
                CMD = %trimr(cmd) + %trim(') TRGLIB(');
                cmd = %trimr(cmd) + %trim(trlib);
                CMD = %trimr(cmd) + %trim(')');
                TRFILE = '*SUPPRIME*';
       // >>>>> Automatically removed by conversion
       //C                   CALL      'QCMDEXC'
                LEN = 120;

                CallP QCMDEXC(
                             CMD
                             :LEN
                             );

       //C                   PARM                    CMD             120
       //C                   PARM      120           LEN              15 5
          EndSl;
          If opt01 <> '1';
       // >>>>> Not converted: Straight move between unknown fields is dangerous.
     C                   MOVE      ' '           OPT01
             Update SFL01;
          EndIf;

          Test = 'AFF1';
       EndSr;

