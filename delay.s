				GLOBAL	DELAY1
				
				AREA	brnch,CODE,READONLY
				
DELAY1				
				STMEA	SP!,{R0-R10,LR}
				MRS		R0,CPSR
				STMEA	SP!,{R0}
				
				;Delay with initialization, delay is around 2 ms
				LDR		R7,=3000000
DELAY			SUBS	R7,R7,#1
				BNE		DELAY
				
				LDMEA	SP!,{R0}
				MSR		CPSR_f,R0
				LDMEA	SP!,{R0-R10,LR}
				
				BX		LR
				
				END
					