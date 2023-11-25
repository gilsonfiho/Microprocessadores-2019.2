; PIC18F4550 Configuration Bit Settings
; Assembly source line config statements
#include "p18f4550.inc"
    CONFIG FOSC = XT_XT ; Oscillator com Cristal de 4 MHz
    CONFIG WDT = OFF ; Watchdog Timer Enable bit (WDT enabled)
    CONFIG LVP = OFF ; Single-Supply ICSP Enable bit
    
VARIAVEIS UDATA_ACS 0
    
    VARIAVEL1 RES 2; 1° variavel de 16 bits
    VARIAVEL2 RES 2 ;2° variavel de 16 bits
    SOMA RES 2; Varivel que recebera o valor da soma também de 16 bits
 
RES_VECT CODE 0x0000 ; processor reset vector
    GOTO START ; go to beginning of program
    
MAIN_PROG CODE ; let linker place main program

 START
  
    
REPETE  
    
    ;VALORES DE SOMA
    MOVLW h'da'
    MOVWF VARIAVEL1+1;VARIAVEL1+1 representa o byte mais significativo VAR1
    MOVLW h'da'
    MOVWF VARIAVEL1;VARIAVEL1 representa o byte menos significativo VAR1
    
    MOVLW h'de'
    MOVWF VARIAVEL2+1;VARIAVEL2+1 representa o byte mais significativo VAR2
    MOVLW h'de'
    MOVWF VARIAVEL2;VARIAVEL2 representa o byte menos significativo VAR2
    
    
    
    ;EXECUÇÃO DA SOMA
    MOVF VARIAVEL1,W
    ADDWF VARIAVEL2,W
    MOVWF SOMA; Soma as partes menos significativas
    
    MOVLW h'00'
    BTFSC STATUS,C  ; Checa se ouve overflow no ultimo bit da soma da parte menos significativa e soma um no W caso sim
    MOVLW h'01'
    
    ADDWF VARIAVEL1+1,W
    ADDWF VARIAVEL2+1,W   
    MOVWF SOMA+1; Soma das partes mais significativas
    
GOTO REPETE    
 
END


