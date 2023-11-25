; PIC18F4550 Configuration Bit Settings
; Assembly source line config statements
#include "p18f4550.inc"
    CONFIG FOSC = XT_XT ; Oscillator com Cristal de 4 MHz
    CONFIG WDT = OFF ; Watchdog Timer Enable bit (WDT enabled)
    CONFIG LVP = OFF ; Single-Supply ICSP Enable bit
    
VARIAVEIS UDATA_ACS 0
    VARIAVEL RES 1 ;Variavel de 8 bits
    AUXILIAR RES 1 ;Variavel que armazena a quantidade de bits 1 também de 8 bits
   
 
RES_VECT CODE 0x0000 ; processor reset vector
    GOTO START ; go to beginning of program
MAIN_PROG CODE ; let linker place main program

 START
    
REPETE
 
    CLRF AUXILIAR;Zera o valor de AUX
    MOVLW b'11111111'; Definindo o valor da variavel VAR
    MOVWF VARIAVEL
    
    ;As instruções abaixo avaliam os bits de VAR e incrementa AUX caso seja 1
    BTFSC VARIAVEL,0
    INCF AUXILIAR
    BTFSC VARIAVEL,1
    INCF AUXILIAR
    BTFSC VARIAVEL,2
    INCF AUXILIAR
    BTFSC VARIAVEL,3
    INCF AUXILIAR
    BTFSC VARIAVEL,4
    INCF AUXILIAR
    BTFSC VARIAVEL,5
    INCF AUXILIAR
    BTFSC VARIAVEL,6
    INCF AUXILIAR
    BTFSC VARIAVEL,7
    INCF AUXILIAR
    
GOTO REPETE    
 
END









