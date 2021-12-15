" Vim syntax file
" Language: P4_16
" Maintainer: Antonin Bas, Barefoot Networks Inc
" Latest Revision: 5 August 2014
" Updated By: Gyanesh Patra, Unicamp University
" Latest Revision: 12 April 2016
" Updated Again By: Robert MacDavid, Princeton University
" Latest Revision: 12 June 2017

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Use case sensitive matching of keywords
syn case match

syn keyword p4ObjectKeyword   action apply control default
syn keyword p4ObjectKeyword   enum extern exit
syn keyword p4ObjectKeyword   header header_union
syn keyword p4ObjectKeyword   match_kind
syn keyword p4ObjectKeyword   package parser
syn keyword p4ObjectKeyword   state struct switch size
syn keyword p4ObjectKeyword   table transition tuple typedef
syn keyword p4ObjectKeyword   verify

" Tables
syn keyword p4ObjectAttributeKeyword  key actions default_action entries
syn keyword p4ObjectAttributeKeyword  implementation
" Counters and meters
syn keyword p4ObjectAttributeKeyword  counters meters
" Var Attributes
syn keyword p4ObjectKeyword           const in out inout


syn keyword p4Annotation              @name @tableonly @defaultonly
syn keyword p4Annotation              @globalname @atomic @hidden


syn keyword p4MatchTypeKeyword        exact ternary lpm range

syn keyword p4TODO           contained FIXME TODO
syn match   p4Comment        '\/\/.*'  contains=p4TODO
syn region  p4BlockComment   start='\/\*'  end='\*\/' contains=p4TODO keepend

" use c preprocessor syntax
" syn match   p4Preprocessor   '#(include|define|undef|if|ifdef) .*$'
" syn match   p4Preprocessor   '#(if|ifdef|ifndef|elif|else) .*$'
" syn match   p4Preprocessor   '#(endif|defined|line|file) .*$'
" syn match   p4Preprocessor   '#(error|warning) .*$'
syn region	cPreCondit	start="^\s*\zs\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" keepend contains=cComment,cCommentL,cCppString,cCharacter,cCppParen,cParenError,cNumbers,cCommentError,cSpaceError
syn match	cPreConditMatch	display "^\s*\zs\(%:\|#\)\s*\(else\|endif\)\>"
if !exists("c_no_if0")
  syn cluster	cCppOutInGroup	contains=cCppInIf,cCppInElse,cCppInElse2,cCppOutIf,cCppOutIf2,cCppOutElse,cCppInSkip,cCppOutSkip
  syn region	cCppOutWrapper	start="^\s*\zs\(%:\|#\)\s*if\s\+0\+\s*\($\|//\|/\*\|&\)" end=".\@=\|$" contains=cCppOutIf,cCppOutElse,@NoSpell fold
  syn region	cCppOutIf	contained start="0\+" matchgroup=cCppOutWrapper end="^\s*\(%:\|#\)\s*endif\>" contains=cCppOutIf2,cCppOutElse
  if !exists("c_no_if0_fold")
    syn region	cCppOutIf2	contained matchgroup=cCppOutWrapper start="0\+" end="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0\+\s*\($\|//\|/\*\|&\)\)\@!\|endif\>\)"me=s-1 contains=cSpaceError,cCppOutSkip,@Spell fold
  else
    syn region	cCppOutIf2	contained matchgroup=cCppOutWrapper start="0\+" end="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0\+\s*\($\|//\|/\*\|&\)\)\@!\|endif\>\)"me=s-1 contains=cSpaceError,cCppOutSkip,@Spell
  endif
  syn region	cCppOutElse	contained matchgroup=cCppOutWrapper start="^\s*\(%:\|#\)\s*\(else\|elif\)" end="^\s*\(%:\|#\)\s*endif\>"me=s-1 contains=TOP,cPreCondit
  syn region	cCppInWrapper	start="^\s*\zs\(%:\|#\)\s*if\s\+0*[1-9]\d*\s*\($\|//\|/\*\||\)" end=".\@=\|$" contains=cCppInIf,cCppInElse fold
  syn region	cCppInIf	contained matchgroup=cCppInWrapper start="\d\+" end="^\s*\(%:\|#\)\s*endif\>" contains=TOP,cPreCondit
  if !exists("c_no_if0_fold")
    syn region	cCppInElse	contained start="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0*[1-9]\d*\s*\($\|//\|/\*\||\)\)\@!\)" end=".\@=\|$" containedin=cCppInIf contains=cCppInElse2 fold
  else
    syn region	cCppInElse	contained start="^\s*\(%:\|#\)\s*\(else\>\|elif\s\+\(0*[1-9]\d*\s*\($\|//\|/\*\||\)\)\@!\)" end=".\@=\|$" containedin=cCppInIf contains=cCppInElse2
  endif
  syn region	cCppInElse2	contained matchgroup=cCppInWrapper start="^\s*\(%:\|#\)\s*\(else\|elif\)\([^/]\|/[^/*]\)*" end="^\s*\(%:\|#\)\s*endif\>"me=s-1 contains=cSpaceError,cCppOutSkip,@Spell
  syn region	cCppOutSkip	contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cSpaceError,cCppOutSkip
  syn region	cCppInSkip	contained matchgroup=cCppInWrapper start="^\s*\(%:\|#\)\s*\(if\s\+\(\d\+\s*\($\|//\|/\*\||\|&\)\)\@!\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" containedin=cCppOutElse,cCppInIf,cCppInSkip contains=TOP,cPreProc
endif
syn region	cIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	cIncluded	display contained "<[^>]*>"
syn match	cInclude	display "^\s*\zs\(%:\|#\)\s*include\>\s*["<]" contains=cIncluded
"syn match cLineSkip	"\\$"
syn cluster	cPreProcGroup	contains=cPreCondit,cIncluded,cInclude,cDefine,cErrInParen,cErrInBracket,cUserLabel,cSpecial,cOctalZero,cCppOutWrapper,cCppInWrapper,@cCppOutInGroup,cFormat,cNumber,cFloat,cOctal,cOctalError,cNumbersCom,cString,cCommentSkip,cCommentString,cComment2String,@cCommentGroup,cCommentStartError,cParen,cBracket,cMulti,cBadBlock
" syn region	cDefine		start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell
syn region	cDefine		start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,p4Indentifier
syn region	cPreProc	start="^\s*\zs\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend contains=ALLBUT,@cPreProcGroup,@Spell
" End of c

syn keyword p4Type           bit bool int varbit void error

" Integer Literals

syn match   p4Int            '\<[0-9][0-9_]*\>'
syn match   p4Indentifier    '\<[A-Za-z_][A-Za-z0-9_]*\>'
syn match   p4HexadecimalInt '0[Xx][0-9a-fA-F]\+'
syn match   p4DecimalInt     '0[dD][0-9_]\+'
syn match   p4OctalInt       '0[oO][0-7_]\+'
syn match   p4BinaryInt      '0[bB][01_]\+'


syn region  p4SizedType     start='(bit|int|varbit)\<' end='\>'
syn match   p4UserType      '\<[A-Za-z_][A-Za-z0-9_]*[_][t]\>'
syn keyword p4Operators     and or not &&& mask


" Header Methods
syn keyword p4Primitive     isValid setValid setInvalid
" Table Methods
syn keyword p4Primitive     hit action_run
" Packet_in methods
syn keyword p4Primitive     extract lookahead advance length
" Packet_out methods
syn keyword p4Primitive     emit
" Known parser states
syn keyword p4Primitive     accept reject
" Misc
syn keyword p4Primitive     NoAction


syn keyword p4Conditional   if else select
syn keyword p4Statement     return

" Don't Care
syn keyword p4Constant      _
" Error
syn keyword p4Constant      NoError PacketTooShort NoMatch StackOutOfBounds
syn keyword p4Constant      OverwritingHeader HeaderTooShort ParserTiimeout
" Boolean
syn keyword p4Boolean       false true

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Apply highlight groups to syntax groups defined above
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_p4_syntax_inits")
  if version <= 508
    let did_p4_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink p4ObjectKeyword          Repeat
  HiLink p4UserType		  Type
  HiLink p4ObjectAttributeKeyword Keyword
  HiLink p4TypeAttribute          StorageClass
  HiLink p4Annotation             Special
  HiLink p4MatchTypeKeyword       Keyword
  HiLink p4TODO                   Todo
  HiLink p4Comment                Comment
  HiLink p4BlockComment           Comment
  " HiLink p4Preprocessor           PreProc
  HiLink p4SizedType              Type
  HiLink p4Type                   Type
  HiLink p4DecimalInt             Number
  HiLink p4HexadecimalInt         Number
  HiLink p4OctalInt		  Number
  HiLink p4BinaryInt		  Number
  HiLink p4Int			  Number
  HiLink p4Operators              Operator
  HiLink p4Primitive              Function
  HiLink p4Conditional            Conditional
  HiLink p4Statement              Statement
  HiLink p4Constant               Constant
  HiLink p4Boolean                Boolean
  HiLink cInclude		Include
  HiLink cPreProc		PreProc
  HiLink cDefine		Macro
  HiLink cIncluded		cString
  HiLink cString		String
  HiLink cCppInWrapper		cCppOutWrapper
  HiLink cCppOutWrapper		cPreCondit
  HiLink cPreConditMatch	cPreCondit
  HiLink cPreCondit		PreCondit
  HiLink cCppOutSkip		cCppOutIf2
  HiLink cCppInElse2		cCppOutIf2
  HiLink cCppOutIf2		cCppOut
  HiLink cCppOut		Comment

  delcommand HiLink
endif

let b:current_syntax = "p4"

" vim: set expandtab sw=2 sts=2 ts=8:
