;;; A simple Emacs major mode for STOL as used in ITOS 9.4.0

;;;; Notices:

;; Copyright © 2020 United States Government as represented by the Administrator of the National Aeronautics
;; and Space Administration.  No copyright is claimed in the United States under Title 17, U.S. Code. All
;; Other Rights Reserved.

;;;; Disclaimers

;; No Warranty: THE SUBJECT SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY OF ANY KIND, EITHER EXPRESSED,
;; IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL CONFORM
;; TO SPECIFICATIONS, ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR FREEDOM
;; FROM INFRINGEMENT, ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL BE ERROR FREE, OR ANY WARRANTY THAT
;; DOCUMENTATION, IF PROVIDED, WILL CONFORM TO THE SUBJECT SOFTWARE. THIS AGREEMENT DOES NOT, IN ANY MANNER,
;; CONSTITUTE AN ENDORSEMENT BY GOVERNMENT AGENCY OR ANY PRIOR RECIPIENT OF ANY RESULTS, RESULTING DESIGNS,
;; HARDWARE, SOFTWARE PRODUCTS OR ANY OTHER APPLICATIONS RESULTING FROM USE OF THE SUBJECT SOFTWARE.  FURTHER,
;; GOVERNMENT AGENCY DISCLAIMS ALL WARRANTIES AND LIABILITIES REGARDING THIRD-PARTY SOFTWARE, IF PRESENT IN
;; THE ORIGINAL SOFTWARE, AND DISTRIBUTES IT "AS IS."

;; Waiver and Indemnity: RECIPIENT AGREES TO WAIVE ANY AND ALL CLAIMS AGAINST THE UNITED STATES GOVERNMENT,
;; ITS CONTRACTORS AND SUBCONTRACTORS, AS WELL AS ANY PRIOR RECIPIENT.  IF RECIPIENT'S USE OF THE SUBJECT
;; SOFTWARE RESULTS IN ANY LIABILITIES, DEMANDS, DAMAGES, EXPENSES OR LOSSES ARISING FROM SUCH USE, INCLUDING
;; ANY DAMAGES FROM PRODUCTS BASED ON, OR RESULTING FROM, RECIPIENT'S USE OF THE SUBJECT SOFTWARE, RECIPIENT
;; SHALL INDEMNIFY AND HOLD HARMLESS THE UNITED STATES GOVERNMENT, ITS CONTRACTORS AND SUBCONTRACTORS, AS WELL
;; AS ANY PRIOR RECIPIENT, TO THE EXTENT PERMITTED BY LAW.  RECIPIENT'S SOLE REMEDY FOR ANY SUCH MATTER SHALL
;; BE THE IMMEDIATE, UNILATERAL TERMINATION OF THIS AGREEMENT.

(defvar stol-mode-syntax-table nil "Syntax table for `stol-mode'.")

(setq stol-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        (modify-syntax-entry ?\; "<" synTable) (modify-syntax-entry ?\n ">" synTable) synTable))

(setq directives (regexp-opt '("assign" "as"
                               "chart" "ch"
                               "cmd"
                               "convert" "con"
                               "do"
                               "edit" "ed"
                               "else"
                               "enddo"
                               "endif"
                               "endproc"
                               "event"
                               "format" "fo"
                               "free"
                               "global"
                               "goto" "go" "g"
                               "history" "hi"
                               "if"
                               "interval" "in"
                               "kill"
                               "killproc" "killp"
                               "let"
                               "limits" "lim"
                               "list" "li"
                               "namespace"
                               "page" "p"
                               "position" "po"
                               "proc"
                               "return"
                               "run"
                               "snap" "sn"
                               "start" "s"
                               "step"
                               "term" "te"
                               "then"
                               "until"
                               "wait" "w") 'symbols))

(setq functions (regexp-opt '("abs"
                              "acos"
                              "asin"
                              "atan"
                              "atan2"
                              "bwand"
                              "bwinvert"
                              "bwlshift"
                              "bwor"
                              "bwreverse"
                              "bwrshift"
                              "bwxor"
                              "ceil"
                              "coalesce"
                              "concat"
                              "contains"
                              "convertescape"
                              "cos"
                              "cosh"
                              "escapexmlchars"
                              "exists"
                              "floor"
                              "format"
                              "getenv"
                              "iif"
                              "iscommand"
                              "isdate"
                              "isfloat"
                              "isglobal"
                              "isinlimits"
                              "isint"
                              "islocal"
                              "ismnemonic"
                              "isnull"
                              "isnumber"
                              "isquality"
                              "isred"
                              "isredhi"
                              "isredlo"
                              "isstatic"
                              "isstring"
                              "issymbol"
                              "istime"
                              "isunsigned"
                              "isvariable"
                              "isyellow"
                              "isyellowhi"
                              "isyellowlo"
                              "ln"
                              "log"
                              "lowercase"
                              "max"
                              "min"
                              "mkdate"
                              "mkepochdate"
                              "mktime"
                              "mod"
                              "name"
                              "replace"
                              "round"
                              "roundeven"
                              "sin"
                              "sinh"
                              "split"
                              "sqrt"
                              "strcasestr"
                              "strfdate"
                              "strlen"
                              "strpackhex"
                              "strstr"
                              "strtok"
                              "strtol"
                              "strtoul"
                              "substr"
                              "tan"
                              "tanh"
                              "ternary"
                              "todate"
                              "tofloat"
                              "tohexstring"
                              "toint"
                              "tonull"
                              "tostring"
                              "tostringnotnull"
                              "totime"
                              "tounsigned"
                              "trunc"
                              "unconvertescape"
                              "uppercase") 'symbols))

; Everything that's important that isn't a directive, constant, or built-in function
(setq keywords (regexp-opt '("at" "local" "sho" "speed") 'symbols))

;; Multiple list members highlighting in the same face are here when I couldn't figure out how to combine
;; them. This works just as well anyway.

(setq stol-font-lock-keywords
      (list `("\\.true\\."  . font-lock-constant-face)
            `("\\.false\\." . font-lock-constant-face)
            `("[\\\s]*p@"   . font-lock-builtin-face)
            `("\\.eq\\."    . font-lock-builtin-face)
            `("\\.ne\\."    . font-lock-builtin-face)
            `("\\.lt\\."    . font-lock-builtin-face)
            `("\\.gt\\."    . font-lock-builtin-face)
            `("\\.le\\."    . font-lock-builtin-face)
            `("\\.ge\\."    . font-lock-builtin-face)
            `("\\.not\\."   . font-lock-builtin-face)
            `("\\.and\\."   . font-lock-builtin-face)
            `("\\.or\\."    . font-lock-builtin-face)
            `("\\.xor\\."   . font-lock-builtin-face)
            `("/[^\\\s]*\s" . font-lock-builtin-face)
            `(,directives   . font-lock-builtin-face)
            `(,functions    . font-lock-builtin-face)
            `("^[^\\\s]+:"  . font-lock-keyword-face)
            `(,keywords     . font-lock-keyword-face)))

; STOL is case-insensitive so font-lock-keywords are identified without regard for case
(setq font-lock-keywords-case-fold-search 1)

;; Could base this on fortran-mode or f90-mode, since STOL is related syntactically, but these modes introduce
;; a bunch of other stuff that isn't in STOL
(define-derived-mode stol-mode prog-mode "STOL" "Major mode for editing STOL procedure scripts."
  (setq font-lock-defaults '(stol-font-lock-keywords nil font-lock-keywords-case-fold-search)))

;; File name ends in .proc (case insensitive).
(setq auto-mode-alist (append '(("\\.proc" . stol-mode)) auto-mode-alist))
