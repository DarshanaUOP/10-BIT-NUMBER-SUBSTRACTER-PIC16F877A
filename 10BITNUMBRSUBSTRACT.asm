;Author: DarshanaAriyarathna || darshana.uop@gmail.com || +94774901245
processor	16f877a			;Initialize the processor
#include	<p16f877a.inc>		;Include library


org	0x00;
    TIMER1  EQU	0x20
    TIMER2  EQU	0x21
    DISP    EQU	0x22
    
    K3	    EQU	0x23
    K2	    EQU	0x24
    K1	    EQU	0x25
    K0	    EQU	0x26

    HIGH_BIT_COPPY	EQU 0x27
    LOW_BIT_COPPY	EQU 0x28
    NEWS    EQU	0x29
    
   NORTH_H EQU	0x2A
   NORTH_L EQU	0x2B
   
   NORTH_H_ZERO EQU	0x32
   NORTH_L_ZERO EQU	0x33
   
   ;NORTH_H_RES	EQU	0x32
   ;NORTH_L_RES	EQU	0x33
   
    
GOTO	Main
 Main:
    CALL    INITIALIZE_IC
    CALL    INITIALIZE_LCD
    ;CALL    writeOnDisp
    CALL    K_VALUES_TO_ZERO
    CALL    SUBSTRACT
    GOTO    PROCESS_HIGH_VALUE
    UP
    CALL    PRINT_K_VALUES
    CALL    WAIT
    GOTO    Main
    
    SUBSTRACT
    
	MOVLW	b'00000011'
	MOVWF	NORTH_H
	MOVLW	b'00000000'
	MOVWF	NORTH_L
	
	MOVLW	b'00000000'
	MOVWF	NORTH_H_ZERO
	MOVLW	b'11110001'
	MOVWF	NORTH_L_ZERO
	
	MOVF	NORTH_L_ZERO,0
	SUBWF	NORTH_L,1
	
	BTFSC	STATUS,2
	    MOVLW   d'0'
	    MOVLW   d'1'
	SUBWF	NORTH_H,1
	
	MOVF	NORTH_H_ZERO,0
	SUBWF	NORTH_H,1
	
	
    RETURN
    
    ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    K_VALUES_TO_ZERO
	MOVLW	b'00000000'
	MOVWF	K3
	
	MOVLW	b'00000000'
	MOVWF	K2
	
	MOVLW	b'00000000'
	MOVWF	K1
	
	MOVLW	b'00000000'
	MOVWF	K0
    RETURN
    PROCESS_HIGH_VALUE
	;THIS VALUES ONLY FOR THIS PROG: TESTING

	MOVF	NORTH_H,0
	MOVWF	HIGH_BIT_COPPY
	;MOVLW	d'3'
	;MOVLW	d'30'
	
	
	MOVLW	b'00000001'
	SUBWF	HIGH_BIT_COPPY,0
	BTFSC	STATUS,2
		GOTO	LIBRARY_ONE
		MOVLW	b'00000010'
		SUBWF	HIGH_BIT_COPPY,0
		
		BTFSC	STATUS,2
			GOTO	LIBRARY_TWO
			MOVLW	b'00000011'
			SUBWF	HIGH_BIT_COPPY,0
		
			BTFSC	STATUS,2
				GOTO	LIBRARY_THREE
				GOTO	BEFORE_END
	BEFORE_END
	
	CALL	writeOnDisp
	    GOTO    PROCESS_LOWER_VALUE
	    GOTO	UP
	
    GOTO    Main
    ;______________________________
    
    LIBRARY_ONE
	;256
	MOVLW	d'6'
	MOVWF	K0
	
	MOVLW	d'5'
	MOVWF	K1
	
	MOVLW	d'2'
	MOVWF	K2
	
    GOTO    BEFORE_END
    ;______________________________
    
    LIBRARY_TWO
	;512
	MOVLW	d'2'
	MOVWF	K0
	
	MOVLW	d'1'
	MOVWF	K1
	
	MOVLW	d'5'
	MOVWF	K2
	
    GOTO    BEFORE_END
    ;______________________________
    
    LIBRARY_THREE
	;768
	MOVLW	d'8'
	MOVWF	K0
	
	MOVLW	d'6'
	MOVWF	K1
	
	MOVLW	d'7'
	MOVWF	K2
	
    GOTO    BEFORE_END
    ;______________________________
    ;PROCESS_LOWER_VALUE
    
    PROCESS_LOWER_VALUE
    ;IN HERE SET ADRESL VALUE TO LOW_BIT_COPPY
    MOVF	NORTH_L,0
    MOVWF	LOW_BIT_COPPY
    GOTO    FIND_K2
    FIND_K2
	MOVLW   d'100'
	SUBWF   LOW_BIT_COPPY,0
	BTFSC   STATUS,0
	    GOTO	CHECK_POIT_2	
    	    GOTO	FIND_K1		
	    
    FIND_K1
	MOVLW   d'10'
	SUBWF   LOW_BIT_COPPY,0
	BTFSC   STATUS,0
	    GOTO	CHECK_POIT_1    
	    GOTO	FIND_K0

    FIND_K0
	MOVLW   d'1'
	SUBWF   LOW_BIT_COPPY,0
	BTFSC   STATUS,0
	    GOTO	CHECK_POIT_0
	    GOTO	END_3
	    
    END_3
	;WHEN EXITING FROM "GOTO END_3" IT IS NOT CALCULATE THAT ONE SO NEEDS TO ADD IT
	;CALL	K0_PLUS_ONE
    GOTO    UP
    ;______________________________    
    CHECK_POIT_2
	MOVWF	LOW_BIT_COPPY
	CALL	K2_PLUS_ONE
    GOTO    FIND_K2
    ;______________________________ 
    CHECK_POIT_1
	MOVWF	LOW_BIT_COPPY
	CALL	K1_PLUS_ONE
    GOTO    FIND_K1
    ;______________________________ 
    CHECK_POIT_0
	MOVWF	LOW_BIT_COPPY
	CALL	K0_PLUS_ONE
    GOTO    FIND_K0
    
    ;______________________________
    K0_PLUS_ONE
	MOVLW	d'1'
	ADDWF	K0,1
	MOVLW	d'10'
	SUBWF	K0,0
	BTFSC	STATUS,1
	    GOTO    K0_MIN_TEN
	   GOTO    END_2
	    
	    K0_MIN_TEN
		MOVLW   b'00001010'
		SUBWF   K0,1
		GOTO	K1_PLUS_ONE
		GOTO    END_2
    
    K1_PLUS_ONE
        MOVLW	d'1'
	ADDWF	K1,1
	MOVLW	d'10'
	SUBWF	K1,0
	BTFSC	STATUS,1
	   GOTO    K1_MIN_TEN
	   GOTO    END_2
	    
	    K1_MIN_TEN
		MOVLW   b'00001010'
		SUBWF   K1,1
		GOTO	K2_PLUS_ONE
		GOTO    END_2
	   
    
    K2_PLUS_ONE
	MOVLW	d'1'
	ADDWF	K2,1
	MOVLW	d'10'
	SUBWF	K2,0
	BTFSC	STATUS,1
	   GOTO    K2_MIN_TEN
	   GOTO    END_2
	    
	    K2_MIN_TEN
		MOVLW   b'00001010'
		SUBWF   K2,1
		GOTO	K3_PLUS_ONE
		GOTO    END_2
	    
    K3_PLUS_ONE
	MOVLW	d'1'
	ADDWF	K3,1
	MOVLW	D'10'
	SUBWF	K3,0
	
	MOVF	STATUS,0
	MOVWF	PORTB
	
	BTFSC	STATUS,1
	    GOTO    K3_MIN_TEN
	    GOTO    END_2
	    
	    K3_MIN_TEN
		MOVLW   b'00001010'
		SUBWF   K3,1
		GOTO    END_2

    END_2
    RETURN
    
    
    ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ;subroutings_for_INITIALIZE_LCD
    INITIALIZE_LCD
	CALL    instructionMode
	CALL    setFunctions
	CALL    setDisplayOnOff
	CALL    displayClear
	CALL    setEntryModule
	CALL	set_CGRAM_address
	CALL	set_DDRAM_address_to_line1
    RETURN
    ;______________________________________
    
    instructionMode
	    MOVLW   b'000'
            MOVWF   PORTC
	    CALL    ENABLE_PULSE
    RETURN
    ;______________________________________
    dataSendMode
	    ;MOVLW   b'11111111'
	    ;MOVWF   PORTD

            ;MOVLW   b'00001'
            ;MOVWF   PORTC
	    BSF	    PORTC,0
	    ;CALL    ENABLE_PULSE
    RETURN
    ;______________________________________
    
    setFunctions
    	CALL    instructionMode
	MOVWF   PORTC
	MOVLW   b'00111000'
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;| bit7	    | bit6	| bit5	    | bit4	| bit3	    | bit2	| bit1	    | bit0	|
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;|	0   |	0   	|	1   |   1	|0=1 Line   |0=5x8 Dots |	x   |	x   	|
	;|	    |	    	|	    |	    	|1=2 Line   |1=5x11 Dots|	x   |	x   	|
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+  
	MOVWF   PORTD
	CALL    ENABLE_PULSE
    RETURN
    ;______________________________________
    setDisplayOnOff
	CALL    instructionMode
	MOVLW   b'00001111'
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;| bit7	    | bit6      | bit5	    | bit4	| bit3	    | bit2	| bit1	    | bit0      |
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;|	0   |	0   	|	0   |	0   	|	1   |0=DispOff  |0=CurserOff|0=BlinkOff |
	;|	    |	    	|	    |	    	|	    |1=DispOn   |1=CurserOn |1=BlinkOn  |
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	MOVWF   PORTD
	CALL    ENABLE_PULSE
    RETURN
    ;______________________________________
    displayClear
    	CALL    instructionMode
	MOVLW   b'00000001'
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;| bit7	    | bit6	| bit5	    | bit4      | bit3	    | bit2      | bit1	    | bit0	|
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;|	0   |	0	|	0   |	0	|	0   |   0	|	0   |   1	|
	;|	    |		|	    |		|	    |		|	    |		|
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	MOVWF   PORTD
	CALL    ENABLE_PULSE
	CALL	set_DDRAM_address_to_line1
    RETURN
    ;______________________________________
    setEntryModule
       	CALL	instructionMode
	MOVLW   b'00000110'
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+---------------+
	;| bit7	    | bit6	| bit5	    | bit4      | bit3	    | bit2      | bit1	    | bit0	    |
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+---------------+
	;|	0   |   0	|	0   |   0	|	0   |   1	|0=Decrement|0=EntireShift  |
	;|	    |		|	    |		|	    |		|   Mode    |   off	    |
	;|	    |		|	    |		|	    |	        |1=Increment|1=EntireShif   |
	;|	    |		|	    |		|	    |		|   Mode    |   on	    |
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+---------------+
	MOVWF   PORTD
	CALL    ENABLE_PULSE
    RETURN
    
    ;______________________________________
    set_CGRAM_address
    	CALL	instructionMode
	MOVLW   b'01000000'	
	;SET CGRAM ADDRESS
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;| bit7	    | bit6	| bit5	    |bit4	| bit3	    | bit2	| bit1	    | bit0	|
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;|	0   |	1	|	AC5 |	AC4	|	AC3 |	AC2	|	AC1 |	AC0	|
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	
	MOVWF   PORTD
	CALL    ENABLE_PULSE
    RETURN
    
    ;______________________________________
    set_DDRAM_address_to_line1
    	CALL	instructionMode
	MOVLW   b'10000000'	;SET DDRAM ADDRESS
    
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;| bit7	    | bit6	| bit5	    | bit4	| bit3	    | bit2	| bit1	    | bit0	|
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	;|	1   |	AC6	|	AC5 |	AC4	|	AC3 |	AC2	|	AC1 |	AC0	|
	;+----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
	    ;DDRAM ADDRESS 1ST Line:00H to 27H
	    ;DDRAM ADDRESS 2ND Line:40H to 67H

	MOVWF   PORTD
	CALL    ENABLE_PULSE
	CALL	dataSendMode
    RETURN
    ;______________________________________
    set_DDRAM_address_to_line2
    	CALL	instructionMode
	MOVLW   b'11000000'
	MOVWF   PORTD
	CALL    ENABLE_PULSE
	CALL	dataSendMode

    RETURN
    ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ;subroutings_for_INITIALIZE_IC
    INITIALIZE_IC
	CALL	GO_BANK_1
	    MOVLW   b'000'
	    MOVWF   TRISC
	    MOVLW   b'00000000'
	    MOVWF   TRISD
	    BSF	    PORTB,0
	CALL	GO_BANK_0
	    MOVLW   b'000'
	    MOVWF   PORTC

	    MOVLW   b'00000000'
	    MOVWF   PORTD
    RETURN
    
    GO_BANK_0
	BCF	    STATUS,5
        BCF	    STATUS,6
    RETURN
    
    GO_BANK_1
	BSF	    STATUS,5
        BCF	    STATUS,6
    RETURN
    
    GO_BANK_2
	BCF	    STATUS,5
        BSF	    STATUS,6
    RETURN
    
    GO_BANK_3
	BSF	    STATUS,5
        BSF	    STATUS,6
    RETURN
    
    ENABLE_PULSE
	BSF	    PORTC,2
	CALL    DELAY_50_MS
	BCF	    PORTC,2
	;CALL    DELAY_50_MS
    RETURN
    ;_______________________________________
    DELAY_50_MS
	DECFSZ	TIMER1,1
	GOTO	DELAY_50_MS
	;DECFSZ	TIMER2,1
	;GOTO	DELAY_50_MS
	;MOVLW   b'11111111'
	;movwf   TIMER1
    RETURN
    
    ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    ;subroutings_for_PRINT_IN_LCD
    writeOnDisp
	MOVLW	'R'
	CALL    PRINT_CHAR
	MOVLW	'U'
	CALL    PRINT_CHAR
	MOVLW	'N'
	CALL    PRINT_CHAR
	MOVLW	'*'
	CALL    PRINT_CHAR

	MOVLW	'*'
	CALL    PRINT_CHAR
	
    RETURN
    writeOnDisp1
	;CALL	displayClear
	MOVF	K3,0
	CALL	MAKE_LCD_NUMBER
	CALL    PRINT_CHAR
	
	MOVF	K2,0
	CALL	MAKE_LCD_NUMBER
	CALL    PRINT_CHAR
	
	MOVF	K1,0
	CALL	MAKE_LCD_NUMBER
	CALL    PRINT_CHAR
	
	MOVF	K0,0
	CALL	MAKE_LCD_NUMBER
	CALL    PRINT_CHAR
	
	
	
    RETURN
    MAKE_LCD_NUMBER
	ADDLW	b'00110000'
    RETURN
    
    PRINT_CHAR
	MOVWF  PORTD
	CALL    ENABLE_PULSE
    RETURN
    
    WAIT
	DECFSZ	TIMER1,1
	GOTO	WAIT
	DECFSZ	TIMER2,1
	GOTO	WAIT
    RETURN 
END


