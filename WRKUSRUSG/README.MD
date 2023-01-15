CVTRPGFREE Utility

Converts an RPGLE source member from fixed-format RPG to free-form RPG.

===============================================================================
Files included:

CVTRPGFREE.cmd      - Command
CVTRPGFREH.pnlgrp   - Command help panel group
CVTRPGFREC.clle     - Command processing program
CVTRPGFRP1.prtf     - Printer file
CVTRPGFRER.sqlrpgle - SQLRPGLE program

Please submit any issues or requests via:
   https://sourceforge.net/p/cvtrpgfree/tickets/


================================================================================
Change Log
================================================================================
1.5.06    29/10/2022   
* FIX: DS declarations with LikeRec on secondary lines were generating an
       extraneous End-DS.
* FIX: Remove old-fashioned 'SR' code in subroutines, as it was stopping the 
       proper conversion of code.
================================================================================
1.5.05    28/08/2022   
* FIX: Lines wrapped onto a new line as a result of indentation, were causing
       the following line to be converted incorrectly.
* FIX: '@' and '#' characters removed from variable names to aid compilation on
       machines using code pages which do not support them (ticket #32).
* FIX: Definition of CVTRGPLOG was not allowing the program to compile properly.
================================================================================
1.5.04    01/04/2022   
* FIX: Constant definitions with a name using an elipsis when not required 
       caused a program crash.
* FIX: Conversion of mixed source where mainline starts with /free was placing
       moved definitions prior to the first line of mainline code.
* FIX: (Ticket #37) Closure of structure was being placed in the wrong position.
* FIX: (Ticket #38) Ensure that strcutre closing opcodes are in the requested
       case.
* FIX: (Ticket #39) Correct the conversion of EXTNAME keyword containing extract
       type.
================================================================================
1.5.03    05/01/2022   
* FIX: (Ticket #34) CHECKR not converting properly.
* FIX: (Ticket #35) Testing of presence of reserved word *ROUTINE in status 
       data structure was not taking lower-case into account.
================================================================================
1.5.02    18/12/2021   
* FIX: MOVEA with an index variable name of more than 3 characters was being
       converted incorrectly, causing a compilation error.
================================================================================
1.5.01    02/12/2021   
* NEW: Extended indentation logic to include declarations, to match that of RDi.
* NEW: Reinstated wrapping of code lines which extend into comment area in order
       to preserve correct indentation as much as possible.
* FIX: Push copybook definition outside of data strucutres by default (ticket 
       #31).
* FIX: Convert conversion of pointer parameters in prototype definitions which
       have no name (ticket #30).
* FIX: Avoid truncation of long H-specs (ticket #29).
* FIX: Structure long name (with elipsis) following another structure were being
       converted incorrectly.
================================================================================
1.5.00    03/11/2021   
* NEW: Source members of type 'RPG' are converted to RPGLE prior to being run
       through CVTRPGFREE.
* NEW: Logging option added.  Conversions are now logged to file QGPL/CVTRPGLOG.
* NEW: Warning added for files which cannot be found during conversion.
* NEW: CAT now converts if no padding specified and sum lengths of fields 
       matches or exceeds the result field.
* NEW: Constants are catalogued to make MOVEs which use them convert reliably.
* NEW: Conversion of MOVE statements has been improved, resulting in a more
       accurate functional conversion, leaving fewer lines required to be 
       manually amended to produce a clean compile.
* NEW: Move of inline definitions now excludes variables already defined,
       resulting in fewer 'already defined' compilation errors.
* NEW: Fields defined on I-specs are added to the dictionary to improve convers-
       ion of MOVEs.
* FIX: CAT(P) conversion now pads the result correctly.
* FIX: Stand-alone fields were not having their domains catalogued correctly in
       a number of instances, leading to non-conversion of some moves.
* FIX: Multi-line ELSEIF was not being converted.
* FIX: Coversion of multiple members was producing a spool file for each member.
       It now puts all conversions onto a single spool file.
* FIX: /copy following a structure definition was sometimes being included in
       the definition instead of outside of it.
* FIX: MOVE(P) and MOVEL(P) conversion where a char result field is the same
       length or shorter than the factor2 field no longer performs the redundant
       padding.

================================================================================
1.4.0     24/10/2021   
* NOTE THE SOURCE TYPE FOR CVTRPGFRER HAS CHANGED TO SQLRPGLE !!
* NEW: Field definitions for files are retrieved and used to determine whether a
       MOVE is safe to convert (requires files to be in the library list).
       This has pushed the average conversion rate to over 98% in most cases.
       This required the inclusion of embedded SQL and so now requires V7R2M0 or
       higher.  Included:
       > Alpha to Alpha same length.
       > Alpha to Alpha, target longer than source.
       > Alpha to Numeric, same length.
       > Numeric to Alpha, same length.
       More to follow...
* FIX: Conversion of ElseIf was truncating extended factor2.
* FIX: MOVE involving *ALL now converts.
* FIX: CALL with an extender or error indicator now convert to CALLP(E) and
       sets any associated error indicator.
* FIX: Lines with an unprintable character in the Spec Type column were causing
       code lines which span more than one line to fail conversion.

================================================================================
1.3.12    19/10/2021   
* FIX: Correct the conversion of duration value for EXTRCT (ticket #25).
* FIX: Improve the conversion of long names on declarations (ticket #26).
* NEW: MOVE for like fields defined in-line should now convert.

================================================================================
1.3.11    05/10/2021   
* FIX: CALLP using PLIST was not converting correctly since the last update.

================================================================================
1.3.10    26/08/2021   
* FIX: Conditioning indicators on IF or DO are explicitly excluded from 
       conversion.
* FIX: LDA datastructure defined as UDS now converts to DTAARA(*AUTO) without
       enclosing apostophes (ticket #22).
* FIX: Error indicator on most opcodes was not being converted to using the (E)
       operation extender.
* FIX: MOVE(P) and MOVEL(P) were not converted so that the target field is
       cleared first.

================================================================================
1.3.91    23/07/2021     
* FIX: CALL using PLIST was being converted to using the PLIST name.

================================================================================
1.3.9     22/07/2021     
* FIX: CALL using a variable was not suppressing the associated PARM lines.
* FIX: Declarations with long names should now convert correctly using the one
       definition instead of two (ticket #20).
* FIX: Pointer parameters for PROCPTR are now converted correctly (ticket #21).

================================================================================
1.3.8     10/06/2021     
* FIX: Conversion of a variable CALL is now suffixed with an underscore in order
       to provide a clean compile (ticket #17).
* FIX: *ENTRY list is no longer converted if one or more parameters contain
       mapped input or output parameters.

================================================================================
1.3.7     30/05/2021     
* FIX: Corrected the conversion of CALLB.

================================================================================
1.3.6     27/05/2021     
* NEW: MOVE of literal values into *INxx indicators is now converted.
* NEW: MOVEA involving the *IN array and literals is now converted.
* NEW: CALLB is now catered for.  Converted as long as the 'D' extender is not
       specified.
* FIX: FEOD statements with an error indicator were not having the error 
       indicator removed on conversion.
* FIX: Moved definitions are now placed BEFORE I-specs.
* FIX: Crash on Program Status Datastructure figurative constant *ROUTINE.
* FIX: CALL with operation extender was not being converted.
* FIX: CALLP with operation extender was not converting correctly.

================================================================================
1.3.5     13/03/2021     
* NEW: Constants now have the superfluous CONST keyword removed.
* NEW: Moved in-line definitions now exclude previously-defined variables to 
       avoid compilation error RNF3316.
* FIX: For constant values which exceed one line, second or subsequent lines
       were being treated as C-specs if they contained an '=' character.
* FIX: For constant values which exceed one line, second and subsequent lines
       were having leading blanks removed.
* FIX: For initialisation values which exceed one line, the second and sub-
       sequent lines were not being left-justified.
* FIX: Count of moved in-line definitions is now reset for each source member.

================================================================================
1.3.4     10/03/2021     

* FIX: Conversion of DS was excluding the last subfield if it was the last line
       in the source member.
* FIX: DO statements which don't use a result index variable are now assigned
       one during conversion to avoid generating a conversion error.
* FIX: Amended to allow compilation of the main program under V7R1M0.

================================================================================
1.3.3     10/02/2021     

* FIX: Embedded SQL on C-specs were being treated as having conditioning
       indicators, resulting in non-conversion.  This has been fixed.
* FIX: Conversion of DS omitted the last subfield if the sibfield was hte last
       line of source.
* FIX: DO statements without from and to values were missing the default 'to' on
       the converted FOR statement (ticket 13).

================================================================================
1.3.2     21/01/2021     

* FIX: Float values on D-specs are now converted.
* FIX: Inhibit the conversion of *ENTRY parameters to Procedure Interface if any
       of the parameters have mapped values either in or out (temporary fix).
* FIX: Statements with a following blank C-spec line are now terminated 
       correctly.

================================================================================
1.3.1     19/11/2020     

* NEW: Added option to convert to fully-free, and optionally, to retain existing
       line markers (they are moved to the right-hand side). 																																																																			
* NEW: Comments on H-specs are converted to full comments.
* NEW: Comments on P-specs are converted to full comments.
* CHG: Prototypes are now 																																																																																																																																																						 to after H or F specs (if any).
* FIX: Constants spanning three or more lines are now converted properly.
* FIX: Converting all members from one source file to another was giving copy
       errors.
* FIX: D-specs with DTAARA(*VAR are now expanded properly.
* FIX: Removal of non-printable characters now extends to the line marker part
       of the line.  This removes some formatting issues encountered.

================================================================================
1.3.0     12/10/2020     

* NEW: Parameter lists can now be converted and used to define procedure
       interfaces (i.e. replace *ENTRY), prototypes (i.e. programs called via
       CALL statements and CALLP parameters.
* NEW: CALL opcodes are now converted to CALLP if conversion of parameter lists
       is requested.
* NEW: Converted key lists and parameter lists can be retained as comments or
       completely removed.  The default is to retain them as comments.
* FIX: Data area names on D-specs are now expanded properly.
* FIX: D-specs containing a semi-colon in quotes no longer trigger end of line.
* FIX: D-specs containing ellispis in quotes no longer trigger a continuation
       line.

================================================================================
1.2.8     23/09/2020     

* NEW: Option to remove end of comment markers.
* NEW: Comments on D-specs are converted to full comments.
* NEW: Option to define the case of op codes (*UPPER, *LOWER, *MIXED).
--------------------------------------------------------------------------------
1.2.7     20/08/2020     

* FIX: Potential infinite loop when processing D-specs.
* FIX: Datastructure subfields defined using LIKEDS were stopping the main DS
       from being closed with an END-DS.
* FIX: '=' in comment section in declarations would falsely signal being in code
       resulting in unpredictable results.
* FIX: Datastructures using LIKEREC keyword no longer have a END-DS added.
* FIX: Corrected the extraction and conversion of TAG statements.
* FIX: D-specs with data type Z are now converted to Timestamp correctly.
* FIX: DOU statements are now converted (don't know how I missed that one!).
--------------------------------------------------------------------------------
1.2.6     13/08/2020     

* NEW: MOVE statements using *ZERO/S are now converted.
* NEW: Comments on F-specs are converted to full comments.
* FIX: Unsigned integers in D-specs are now converted correctly.
* FIX: Long field names containing ellipses are now converted correctly.
--------------------------------------------------------------------------------
1.2.5     30/07/2020     

* NEW: Added the removal of unused TAGs, and the conversion of GOTO and CABxx
       statements if the associated TAG is on an ENDSR.
--------------------------------------------------------------------------------
1.2.41    30/07/2020     

* Fix: free-form opcodes without parameters in the original source were not being
       formatted or indented properly.
* Fix: Conversion stats in the audit report now show zero values.
* Fix: TIME has been amended to convert as %dec(%time()); instead of just
       %time();
--------------------------------------------------------------------------------
1.2.3     27/07/2020     

* NEW: Added option to remove non-printable characters from comments.
       Much old source contains non-printable characters in order to apply colours
       and highlighting to lines of code - usually comments, and these are no longer
       required when using the LPEX editor.  So an option has been added to remove
       these characters from the source.
* Fix: when moving in-line declarations, trailing characters from CALLP operators
       would sometimes be interpeested as being a declaration.  This has been fixed.
* Fix: NEXT was not being converted.  This has been fixed.
--------------------------------------------------------------------------------
1.2.2     21/07/2020     

* Added option to convert key lists.
--------------------------------------------------------------------------------
1.2.1     21/07/2020     

* NEW: Added option to convert MOVE statements.
       Defaults to 'Y', but the conversion has been amended to exclude straight 
       moves between unknown fields.
* FIX: FEOD and FORCE now have a trailing blank.
* FIX: Corrected source file names on audit report.
* FIX: corrected line conditioning indicator when the conditioned line itself
       cannot be converted.
* FIX: moved DTAARA definitions no longer have empty brackets if no name is
       specified.
* Moved in-line definitions are now listed alphabetically.
--------------------------------------------------------------------------------
1.2.0     20/07/2020     

* NEW: Updated source handling to cater for different source file lengths (ticket #5).
       Compiling the program no longer requires special pre-compile setup.
* NEW: Option to specify indentation level (defaults to 3).
* NEW: Option to suppress the non-conversion comments.
* NEW: Rejection of conversion of control indicators.
* NEW: Conversion of line conditioning indicators.
* FIX: missing declaration names in structures (ticket #3).
* FIX: conversion of declarations inside compiler directives (ticket #4).
* FIX: error occurring following "member already exists" message (ticket #2).
* FIX: DoW converts correctly now.
--------------------------------------------------------------------------------
-- Period of inactivity...
--------------------------------------------------------------------------------
1.1.7     04/08/2017     

* FIX: Program Status Datastructure keywords were being bracketed with 'Pos()'.
--------------------------------------------------------------------------------
1.1.6     24/03/2017     

* CHG: Replaced '$' in all variable names as this was causing compilation issues on
       some codepages.
* FIX: Copybooks containing structure definitions without an additional line after
       the last definition were missing the 'End-' declaration on conversion.
--------------------------------------------------------------------------------
1.1.5     07/03/2017     

* FIX: DTAARA names in the DTAARA keyword on stand-alone variables are now expanded
       to be in quotation marks.
* FIX: Stop spurious '*N' being generated in prototype definitions.
--------------------------------------------------------------------------------
1.1.4     13/01/2017     

* FIX: Conversion of Prototypes or Procedure Interfaces which happen to have a 'U'
       or 'S' in position 23 caused the generation of an erroneous DTAARA keyword.
* FIX: EXTPROC with a name that spans more than one line now moves the remaining 
       name to the left of the line as expected.
* FIX: Timestamps (Data Type 'Z') now correctly omit the '()' definition on 
       conversion.
* FIX: Stand-alone fields with data types that have no brackets (e.g. Ind) now 
       have a space inserted before the keywords for the field.
--------------------------------------------------------------------------------
1.1.3     24/11/2016     

* FIX: Conversion of D-specs with keywords and comments on the same line could
       corrupt the keywords if the conversion would cause them to encroach upon the
       comment section.  This has been fixed, and the offending keyword(s) are now
       moved to a secondary line.
* FIX: the dropping of DATFMT and TIMFMT values from variable definitions.
* FIX: Stopped the extraneous space being inserted prior to the terminating 
       semi-colon when no keywords are specified on a definition.
* FIX: Procedure interfaces with long names (ending with an elipsis) are now
       converted correctly.
--------------------------------------------------------------------------------
1.1.2     22/11/2016     

* FIX: Stop generation of End-DS for datastructures defined using LIKEREC.
* FIX: End of line comments would sometimes cause causing a crash.
* FIX: Corrected conversion of DSPLY that expects a response but does not specify
       a message queue.
* FIX: Handle conversion of DOW and DOU with extended factor2.
* FIX: Cater for blank lines with just a comment section.
--------------------------------------------------------------------------------
1.1.1     16/11/2016     

* NEW: Cater for conversion of DIV with half adjust operation extender.
* FIX: Consider a compiler directive to be the end of the current declaration.
* FIX: Constants spanning three or more lines now have the middle lines correctly 
       moved to the left of the line.
--------------------------------------------------------------------------------
1.1.0     15/11/2016     

* NEW: Changed command to allow it to be used on 80-column RPG source files as 
       well as 100-column source files.
* NEW: Command now uses temporary source files in QTEMP.
* FIX: Moved in-line definitions are now placed prior to I-specs.
--------------------------------------------------------------------------------
1.0.2     14/11/2016     Minor update

* FIX: Cater for prototype definitions with unnamed parameters.
* FIX: Correctly convert SELECT constructs that are terminated with END instead of
       ENDSL.
--------------------------------------------------------------------------------
1.0.1     04/11/2016     Minor update

* NEW: Amended the order of the command parameters to enable defaulting of the
       FROMFILE.
--------------------------------------------------------------------------------
1.0       03/11/2016     Initial public release
--------------------------------------------------------------------------------