;============================================================
; clear screen and turn black
; a loop instead of kernal routine to save cycles
;============================================================

loop			jsr fill
                jsr write
                jsr flash
                jmp *         		; infinite loop

fill            lda #$51     		; #$20 is the spacebar Screen Code
                sta $0400,x  		; fill four areas with 256 spacebar characters
                sta $0500,x 
                sta $0600,x 
                sta $06e8,x

                lda #$02     		; set foreground to black in Color Ram 
                sta $d800,x  
                lda #$05
                sta $d900,x
                lda #$06
                sta $da00,x
                lda #$07
                sta $dae8,x

                inx           		; increment X

                bne fill    		; did X turn to zero yet?
                             		; if not, continue with the loop
                rts          		; return from this subroutine
               
write           
                lda #$1     		; set foreground to black in Color Ram 
                sta $d9a0,x 		; somewhere near middle of screen

                lda text,x
                cmp #$40        	; is text char over #$40?
                bcc charokay    	; else don't change
                sec             	; otherwise
                sbc #$40        	; to correct chars
                
charokay
                sta $05a0,x     	; somewhere near middle of screen
                inx
                cpx #$0B
                bne write 
                rts

flash           inc $d020       	; increment border color
                lda $dc01       
                bne flash
                rts

text            !scr "Hello World!"