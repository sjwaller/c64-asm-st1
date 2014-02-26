;; http://www.tnd64.unikat.sk/assemble_it4.html
			lda #$16 	 ; set charset
			sta $D018

showmsg    	lda message,X 
           	sta $0400,x 
           	inx 
           	cpx #$28 
           	bne showmsg

;====================== 
; INTERRUPT HANDLER 
;====================== 
            sei 
            
            lda #<irq 	; point IRQ Vector to custom irq routine
            ldx #>irq 
            sta $0314   ; call INIT to produce the main IRQ interrupt flag, using the BASIC Kernal flag
            stx $0315   ;

            cli

loop        jmp * 		; infinite loop

;====================== 
; custom interrupt routine
;====================== 
            
irq     	jsr colwash 
           	jmp $ea31		; return to kernel interrupt routine

;====================== 
;COLOUR WASHING ROUTINE 
;====================== 
colwash     lda colour+$00 
            sta colour+$28 
            ldx #$00

cycle       lda colour+$01,X 
            sta colour+$00,X 
            lda colour,X 
            sta $D800,X 
            inx 
            cpx #$28 
            bne cycle 
            rts

;====================== 
;COLOUR WASHING ROUTINE (REVERSED)
;====================== 
rcolwash    lda colour+$28 
            sta colour+$00 
            ldx #$28 
rcycle      lda colour-$01,X 
            sta colour+$00,X 
            lda colour,X 
            sta $D7FF,X 
            dex 
            bne rcycle
            rts

;DATA TABLES FOR COLOURS

colour       !BYTE $09,$09,$02,$02,$08 
             !BYTE $08,$0A,$0A,$0F,$0F 
             !BYTE $07,$07,$01,$01,$01 
             !BYTE $01,$01,$01,$01,$01 
             !BYTE $01,$01,$01,$01,$01 
             !BYTE $01,$01,$01,$07,$07 
             !BYTE $0F,$0F,$0A,$0A,$08 
             !BYTE $08,$02,$02,$09,$09 
             !BYTE $00,$00,$00,$00,$00

;DATA FOR TEXT MESSAGE

message      !scr "    ..... ST1: NOT-MEGA-DEMO  .....     " 


