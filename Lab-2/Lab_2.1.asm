list P=18F45K22, r=dec, n=0
     #include <P18F45K22.INC>

     ;   /* setup to use the 4xPLL with a 16MHz internal oscillator for a 64MHz system clock */

         config FOSC = INTIO67       ;/* Internal oscillator block, port function on RA6 and RA7          */
         config PLLCFG = ON          ;/* Oscillator multiplied by 4                                       */
         config PRICLKEN = ON        ;/* Primary clock is always enabled                                  */
         config HFOFST = OFF         ;/* HFINTOSC delayed by the oscillator stable status                 */
         config FCMEN = OFF          ;/* Fail-Safe Clock Monitor disabled                                 */
         config IESO = ON            ;/* Oscillator Switchover mode enabled                               */
         config PWRTEN = ON          ;/* Power up timer enabled                                           */
         config BOREN = OFF          ;/* Brown-out Reset disabled in hardware and software                */
         config BORV = 190           ;/* VBOR set to 1.90 V nominal                                       */
                                     ;
         config WDTEN = OFF          ;/* Watch dog timer is always disabled. SWDTEN has no effect.        */
         config WDTPS = 32768        ;/* 1:32768                                                          */
         config CCP2MX = PORTC1      ;/* CCP2 input/output is multiplexed with RC1                        */
         config CCP3MX = PORTB5      ;/* P3A/CCP3 input/output is multiplexed with RB5                    */
         config PBADEN = OFF         ;/* PORTB<5:0> pins are configured as digital I/O on Reset           */
         config T3CMX = PORTC0       ;/* T3CKI is on RC0                                                  */
         config P2BMX = PORTC0       ;/* P2B is on RC0                                                    */
         config LVP = OFF            ;/* Single-Supply ICSP disabled                                      */
         config STVREN = ON          ;/* Stack full/underflow will cause Reset                            */
         config MCLRE = INTMCLR      ;/* RE3 input pin enabled; MCLR disabled                             */
         config XINST = OFF          ;/* Instruction set extension and Indexed Addressing mode disabled   */

     ;   /* Turn off all code protection */
         config CP0   = OFF, CP1   = OFF, CP2   = OFF, CP3   = OFF, CPB   = OFF, CPD   = OFF
         config WRT0  = OFF, WRT1  = OFF, WRT2  = OFF, WRT3  = OFF, WRTB  = OFF, WRTC  = OFF
         config EBTR0 = OFF, EBTR1 = OFF, EBTR2 = OFF, EBTR3 = OFF, EBTRB = OFF
	 
	 org 0h
	;initialization steps
	 BANKSEL ANSELC	; going anselc bank
	 CLRF ANSELC ; reset anselc
	 CLRF TRISC ; portc is output
	 MOVLW 0X00 ; clear wreg
	 MOVWF PORTC ; moving portc
	 ; loop
COUNT	 EQU 0X25 ; COUNT = 25H
	 MOVLW .40 ; loading d'40' to wreg for 40 times loop
	 MOVWF COUNT ; moving value to 25h loc
AGAIN	 INCF PORTC,F ; every step portc will increase 1H
	 CALL DELAY ; calling delay
	 DECF COUNT,F ; checking if 25h loc is zero
	 BNZ AGAIN ; if it is not zero, go to AGAIN
	 ;-----------delay subroutine
DELAY	MOVLW .255 ; outer loop is starting
	MOVWF 0X0C ; 0x0C is 255
LOOP_1  MOVLW .255 ; intermediate loop starts
	MOVWF 0X0D ; 0x0D is 255
LOOP_0  NOP ; inner loop starts
	NOP ; wasting 1 us 9 times
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	DECFSZ 0X0D,F
	GOTO LOOP_0 ; repeat until 0x0D is zero
	DECFSZ 0X0C,F
	GOTO LOOP_1 ; repeat until 0x0C is zero
	RETURN ; return to caller
	END ; end of asm file


