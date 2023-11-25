; PIC18F4550 Configuration Bit Settings
; Assembly source line config statements

    #include "p18f4550.inc"
    CONFIG FOSC = INTOSC_HS ; Oscillator com Cristal de 4 MHz
    CONFIG WDT = OFF ; Watchdog Timer Enable bit (WDT enabled)
    CONFIG LVP = OFF ; Single-Supply ICSP Enable bit
    
VARIAVEIS UDATA_ACS 0
    
    VAR RES 1;Variavel contadora auxiliar
 
RES_VECT CODE 0x0000 ; processor reset vector
    GOTO START ; go to beginning of program
    
MAIN_PROG CODE ; let linker place main program

START
 
    MOVLW b'11111000';Configura os 3 ultimos bits como sa�da
    MOVWF TRISD
    BSF PORTD,0;A primeira forma de onda come�a em nivel alto 
    BCF PORTD,1;A segunda forma de onda come�a em nivel baixo 
    BCF PORTD,2;A terceira forma de onda come�a em nivel baixo
    CALL Atraso600
    MAIN
	BCF PORTD,0;Ap�s um periodo a primeira forma de onda vai para nivel baixo
	BSF PORTD,1;Ap�s um periodo a segunda forma de onda vai para nivel alto
	CALL Atraso600
	BCF PORTD,1;Ap�s dois periodos a segunda forma de onda vai para nivel baixo
	BSF PORTD,2;Ap�s dois periodos a terceira forma de onda vai para nivel alto
	CALL Atraso600
	BCF PORTD,2
	BSF PORTD,0
	CALL Atraso600
	
    ;;A partir de ent�o o padr�o se repete
    
GOTO MAIN
    
    
Atraso600;Subrotina para gerar 600 microssegundos de atraso
    MOVLW d'50'
    MOVWF VAR
    LOOP
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	decfsz VAR;Decrementa VAR at� 0, e entao pula a instru��o 'goto'
    GOTO LOOP
    RETURN
 
END