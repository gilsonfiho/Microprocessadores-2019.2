; PIC18F4550 Configuration Bit Settings
; Assembly source line config statements
#include "p18f4550.inc"
    CONFIG FOSC = XT_XT ; Oscillator com Cristal de 4 MHz
    CONFIG WDT = OFF ; Watchdog Timer Enable bit (WDT enabled)
    CONFIG LVP = OFF ; Single-Supply ICSP Enable bit
    
VARIAVEIS UDATA_ACS 0
    VAR RES 1 ; Variavel
    VARMENOS RES 1 ; Parte menos significativa da variavel
    VARMAIS RES 1 ; Parte mais significativa da variavel
    RESULTADO RES 1; Soma das duas partes
   
 
RES_VECT CODE 0x0000 ; processor reset vector
    GOTO START ; go to beginning of program
MAIN_PROG CODE ; let linker place main program

 START  
    
REPETE
    
    ;Inicializando VARMENOS e VARMAIS com 0
    CLRF VARMAIS ;
    CLRF VARMENOS;
    
    MOVLW b'11111111'; Aqui é definido o valor da variavel VAR
    MOVWF VAR
    
    
    ;Checa os bits menos significativos da variavel VAR, e seta os bits de VARMENOS de acordo
    BTFSC VAR,0
    BSF VARMENOS,0
    BTFSC VAR,1
    BSF VARMENOS,1
    BTFSC VAR,2
    BSF VARMENOS,2
    BTFSC VAR,3
    BSF VARMENOS,3
    
    ;Checa os bits mais significativos da variavel VAR, e seta os bits de VARMAIS de acordo
    BTFSC VAR,4
    BSF VARMAIS,0
    BTFSC VAR,5
    BSF VARMAIS,1
    BTFSC VAR,6
    BSF VARMAIS,2
    BTFSC VAR,7
    BSF VARMAIS,3
    
    ;Realiza a soma de VARMENOS e VARMAIS e coloca o resultado em RESULTADO
    MOVF VARMENOS,W
    ADDWF VARMAIS,W
    MOVWF RESULTADO
   
GOTO REPETE    
 
END





