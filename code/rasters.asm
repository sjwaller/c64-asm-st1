;============================================================
; clear screen and turn black
; a loop instead of kernal routine to save cycles
;============================================================

loop			lda #$30
                ldx #$00 				; BLACK

raster1         cmp $d012 
                bne raster1 
                stx $d020 				; ASSIGN BLACK TO 
                stx $d021 				; BORDER AND FRAME 
                lda #$ab 
                ldx #$01 				; WHITE 

raster2         cmp $d012 
                bne raster2
                stx $d020 
                stx $d021 

                jmp loop         			; infinite loop