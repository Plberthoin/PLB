     FWRKPFTRE  CF   E             WORKSTN usropn
     F                                     SFILE(SFL01:NUM01)
     FQAFDTRG   IF   E             DISK
     D ADDTRG          C                   CONST('?ADDPFTRG FILE(')
     D CHGTRG          C                   CONST('CHGPFTRG FILE(')
     D RMVTRG          C                   CONST('RMVPFTRG FILE(')
     C*
     C     *ENTRY        PLIST
     C                   PARM                    LIB
     C     *in05         PARM      *in05         in05              1
     C                   MOVE      'INI1'        TEST              4
     c                   open      qafdtrg                              34
     c     *in34         ifeq      *on
     c     'Ecr132'      dsply
     c                   return
     c                   endif
     C*
     C     *IN03         DOUEQ     *ON
     C     *IN05         oreq      *ON
     C     TEST          CASEQ     'INI1'        INI1
     C     TEST          CASEQ     'CHA1'        CHA1
     C     TEST          CASEQ     'AFF1'        AFF1
     C     TEST          CASEQ     'CTL1'        CTL1
     C     TEST          CASEQ     'TRT1'        TRT1
     C                   ENDCS
     C                   ENDDO
     C*
     C                   MOVE      *ON           *INLR
     C*
     C     INI1          BEGSR
     C                   MOVE      *ON           *IN40
     C                   WRITE     CTL01
     C                   MOVE      *OFF          *IN40
     C                   Z-ADD     0             NUM01             4 0
     C                   MOVE      'CHA1'        TEST
     C                   ENDSR
     C*
     C     CHA1          BEGSR
     C                   MOVE      ' '           OPT01
     C     *IN90         DOUEQ     *ON
     C                   READ      QAFDTRG                                90
     C     *IN90         IFEQ      *OFF

     C                   MOVEL     TRNAM         WTRNAM
     C                   ADD       1             NUM01
     C                   WRITE     SFL01
     C                   ENDIF
     C                   ENDDO
     C                   MOVE      'AFF1'        TEST
     C                   ENDSR
     C*
     C     AFF1          BEGSR
     C                   MOVE      *ON           *IN42
     C     NUM01         IFGT      0
     C                   MOVE      *ON           *IN41
     C                   ELSE
     C                   MOVE      *OFF          *IN41
     C                   ENDIF
     C                   WRITE     FMT01
     C                   EXFMT     CTL01
     C     *IN03         IFEQ      *OFF
     C     *IN05         andeq     *OFF
     C     *IN06         IFEQ      *ON
     C                   MOVE      '1'           OPT01
     C                   ENDIF
     C                   MOVE      'CTL1'        TEST
     C                   ENDIF
     C                   ENDSR
     C     CTL1          BEGSR
     c     *in06         ifeq      *on
     C                   MOVE      'TRT1'        TEST
     c                   else
     c     num01         ifgt      0
     c                   readc     sfl01                                  91
     c     *in91         ifeq      *off
     C                   MOVE      'TRT1'        TEST
     c                   endif
     c                   endif
     c                   endif
     C*
     C                   ENDSR
     C     trt1          BEGSR
     C                   SELECT
     C* PING
     C     OPT01         WHENEQ    '1'
     c* ADDPFTRG FILE(    ) TRGTIME(*BEFORE) TRGEVENT(*INSERT) PGM(    )
     c                   MOVE      *BLANK        CMD
     C     addtrg        CAT       LIB:0         CMD
     C     cmd           CAT       '/nomfic)':0  CMD
     C                   CALL      'QCMDEXC'                            98
     C                   PARM                    CMD             120
     C                   PARM      120           LEN              15 5
     C     OPT01         WHENEQ    '2'
     c                   MOVE      *BLANK        CMD
     C     chgTRG        CAT       lib:0         CMD
     C     cmd           CAT       '/':0         CMD
     C     cmd           CAT       trfile:0      CMD
     C     cmd           CAT       ') TRG(':0    CMD
     C     cmd           CAT       TRNAM:0       CMD
     C     cmd           CAT       ') STATE(':0  CMD
     C     cmd           CAT       '*DISABLED':0 CMD
     C     cmd           CAT       ') TRGLIB(':0 CMD
     C     cmd           CAT       trlib:0       cmd
     C     cmd           CAT       ')':0         CMD
     c* CHGPFTRG FILE(    ) TRG(       ) TRGLIB(    ) STATE(*ENABLED)
     C                   CALL      'QCMDEXC'
     C                   PARM                    CMD             120
     C                   PARM      120           LEN              15 5
     C                   move      'D'           trst
     C     OPT01         WHENEQ    '3'
     c                   MOVE      *BLANK        CMD
     C     chgTRG        CAT       lib:0         CMD
     C     cmd           CAT       '/':0         CMD
     C     cmd           CAT       trfile:0      CMD
     C     cmd           CAT       ') TRG(':0    CMD
     C     cmd           CAT       TRNAM:0       CMD
     C     cmd           CAT       ') STATE(':0  CMD
     C     cmd           CAT       '*ENABLED':0  CMD
     C     cmd           CAT       ') TRGLIB(':0 CMD
     C     cmd           CAT       trlib:0       cmd
     C     cmd           CAT       ')':0         CMD
     C                   MOVE      'E'           TRST
     C                   CALL      'QCMDEXC'
     C                   PARM                    CMD             120
     C                   PARM      120           LEN              15 5
     C                   move      'E'           trst
     c* RMVPFTRG FILE(    ) TRG(       ) TRGLIB(    )
     C     OPT01         WHENEQ    '4'
     c                   MOVE      *BLANK        CMD
     C     rmvTRG        CAT       lib:0         CMD
     C     cmd           CAT       '/':0         CMD
     C     cmd           CAT       trfile:0      CMD
     C     cmd           CAT       ') TRG(':0    CMD
     C     cmd           CAT       TRNAM:0       CMD
     C     cmd           CAT       ') TRGLIB(':0 CMD
     C     cmd           CAT       trlib:0       cmd
     C     cmd           CAT       ')':0         CMD
     C                   MOVE      '*SUPPRIME*'  TRFILE
     C                   CALL      'QCMDEXC'
     C                   PARM                    CMD             120
     C                   PARM      120           LEN              15 5
     C                   ENDSL
     c     opt01         ifne      '1'
     C                   MOVE      ' '           OPT01
     C                   UPDATe    SFL01
     c                   endif
     C*
     C                   MOVE      'AFF1'        TEST
     C                   ENDSR
