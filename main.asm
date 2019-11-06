; screens in the main binary

SECTION rodata_user;;rodata == Read Only Data

PUBLIC _screen1
	_screen1:
		BINARY "screen1.bin"

PUBLIC _screen2
	_screen2:
		BINARY "screen2.bin"


; void blackout(void)
; preserves a
SECTION code_user
	PUBLIC _blackout
	_blackout:
	   ld hl, 22528
	   ld (hl), 0
	   push hl
	   pop de
	   inc de
	   ld bc, 767
	   ldir   
	ret

;;SECTION code_user
;;	PUBLIC _switchScreen
;;	_switchScreen:
;;	   ld a,($5b5c)   ;//System variable with the previous value
;;	   xor   8			;//Change screen
;;	   ld bc,$7ffd		;//Port to write
;;	   di				;//disable interupts
;;	   ld ($5b5c),a		;//Update system variable
;;	   out   (c),a		;//Address
;;	   ei				;//enable interupts
;;   ret


; void bank(unsigned char ramBank)
; fastcall linkage
; preserves de,hl
SECTION code_crt_common   ; keep it early in the binary
	PUBLIC _bank
	_bank:
	   ld a,($5b5c)   ;//System variable with the previous value
	   and $f8
	   or L
	   ld bc,$7ffd		;//Port to write
	   di
	   ld ($5b5c),a		;//Update system variable
	   out   (c),a		;//Address
	   ei				;//enable interupts
   ret
