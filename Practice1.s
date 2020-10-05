PROCESSOR 16F887
    #include <xc.inc>
    ;word 1 :configuración de los fuses
    
    CONFIG FOSC=INTRC_NOCLKOUT
    CONFIG WDTE=OFF
    CONFIG PWRTE=ON
    CONFIG MCLRE=OFF
    CONFIG CP=OFF
    CONFIG CPD=OFF
    CONFIG BOREN=OFF
    CONFIG IESO=OFF
    CONFIG FCMEN=OFF
    CONFIG LVP=OFF
    CONFIG DEBUG=ON
    CONFIG BOR4V=BOR40V
    CONFIG WRT=OFF
    
    PSECT udata
 mul:
    DS 1
    
PSECT resetVec,class=CODE,delta=2
    resetVect:
	PAGESEL main
	goto main
	
PSECT code 
pausa:
    movlw  1			; se realiza el movimiento de l hacia w
    movwf  0x20
    
incremento:
    incfsz  0x20,f		; Disminuye el valor de CONT2 en 1
    GOTO    incremento
incremento2:
    incfsz  0x20,f		; Disminuye el valor de CONT2 en 1
    GOTO    incremento2
  
incremento3:
    incfsz  0x20,f		; Disminuye el valor de CONT2 en 1
    GOTO    incremento3
     RETURN
    PSECT code
 main:
    BANKSEL PORTB
    BANKSEL TRISB
    clrf TRISB
    loop:
    movlw 0x1
    movwf PORTB
    DEPT1:
    RLF PORTB,0
    CALL pausa
    BTFSS PORTB,7
    GOTO DEPT2
    DEPT2:
    RRF PORTB,1
    CALL pausa
    BTFSS PORTB,0
    GOTO DEPT2
    GOTO DEPT1
    END





