
; used variables
fill = $0350      ; 848 : the byte to fill the screen with
endL = $0351      ; 849 : low byte of last screen character
endH = $0352      ; 850 : high byte of last screen character
posL = $01        ; present position
posH = $02

  
  *=$0355         ; start: sys853  
  lda #$00        ; initialize position pointer
  sta posL
  lda endH
  sta posH
  ldy endL        ; x is index
  lda fill        ; load fill byte into acc
loop:
  sta (posL),Y    ; write screen memory
  dey
  bne loop        ; page done?
  sta (posL),Y    ; write last 
  dec posH        ; decrement position high byte
  lda #$7f        ; finished (lowest position is $8000)
  cmp posH
  beq endPrg      ; if yes, then end
  lda fill        ; load fill byte into acc
  ldy #$ff        ; index to end of page
  bne loop        ; always jump to loop
endPrg:
  rts  