;============================================================
; index file which loads all source code and resources files
;============================================================

;============================================================
;    specify output file
;============================================================

!cpu 6502
;!to "build/st1.prg",cbm    ; output file

;============================================================
; BASIC loader with start address $c000
;============================================================

* = $0801                               ; BASIC start address (#2049)
!byte $0d,$08,$dc,$07,$9e,$20,$34,$39   ; BASIC loader to start at $c000...
!byte $31,$35,$32,$00,$00,$00           ; puts BASIC line 2012 SYS 49152
* = $c000     				            ; start address for 6502 code

;============================================================
;  Main init routine
;============================================================

!source "code/init.asm"

;============================================================
;  add additional source files as required
;============================================================

;!source "code/fill.asm"

!source "code/washing.asm"

;!source "code/rasters.asm"

