			GLOBAL	task2
			IMPORT	DELAY2
			AREA	mycode,CODE,ReadonLy
					
task1
IO0_Base	EQU		0xE0028000				
PINSEL0		EQU		0xE002C000				;PINSEL0 is a control register and is 32-bit long. Pin function slection for port 0 (#0-GPIO)
IO0DIR		EQU		0x8						;sets direction for port 0 (0=input, 1=output)
IO0PIN		EQU		0						;GPIO Port pin to designate value for port(0=0,1=1)
IO0SET		EQU		0x4						;Similar to IO0PIN except it on;y turns off the LED
IO0CLR		EQU		0xC						;Similar to IO0PIN except it on;y turns on the LED
			
			LDR		R0,=IO0_Base
			
			;PINSEL0
			LDR 	R3,=PINSEL0				
			LDR		R1,[R3]					;Reading from PINSEL0
			LDR		R2,=0XFFFF			;Massk for LED pins only
			AND		R1,R1,R2				;Set LED pins as GPIO
			STR		R1,[R3]					;Write to PINSEL0
			
			;IODIR
			LDR		R1,[R0,#IO0DIR]	
			MOV		R2,#0xFF00
			ORR		R1,R2,R1
			STR		R1,[R0,#IO0DIR]			;Set IO0DIR to output
			
			MOV		R4,#0x100
			
			;Turn off LEDS
			STR		R2,[R0,#IO0SET]
			BL		DELAY2
			
			;TURN ON LEDS
LEDPLUS1	STR		R4,[R0,#IO0CLR]
			MOV		R4,R4,LSL#1
			BL		DELAY2
			
			CMP		R4,#0x10000
			BNE		LEDPLUS1
			
			B		task2
			
stop		B			stop	
			
			END