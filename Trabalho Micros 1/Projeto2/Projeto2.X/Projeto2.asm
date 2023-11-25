
    #include "p18f4550.inc"
    
VARIAVEIS UDATA_ACS 0
    
    VARIAVEl RES 1;Variavel contadora auxiliar
    VARIAVEl2 RES 1;Variavel contadora auxiliar
    VARIAVEl3 RES 1;Variavel contadora auxiliar
    VARIAVEl4 RES 1;Variavel contadora auxiliar
    VARIAVEl5 RES 1;Variavel contadora auxiliar
    VARIAVEl6 RES 1;Variavel contadora auxiliar
 
    MIN RES 1;Variavel de minutos
 
RES_VECT CODE 0x0000 ; processor reset vector
    GOTO START ; go to beginning of program
   
MAIN_PROG CODE ; let linker place main program
 
START
 
    ;Configurações iniciais
    MOVLW h'00'
    MOVWF TRISD ;Coloca todos os pinos de PORTD como saída
    MOVLW b'11110111'
    MOVWF TRISB;Pinos de PORTB como entrada exceto pelo RB3
	
    INICIO;Estagio inicial com cronômetro em 60 minutos
    BCF PORTB,3 ;Desliga o buzzer
    CALL Atraso1s
    MOVLW h'60'
    MOVWF MIN
    MOVWF PORTD;Coloca 60 no cronômetro

    POOLING;Estágio de pooling, para testar os dois botoes
    BTFSC PORTB,6;O botao ligado ao pino RB06 ao ser acionado incrementa o cronometro em 10 minutos
    CALL INC10
    BTFSC PORTB,7;O botao ligado a porta RB07 ao ser acionado inicia a contagem que não pode ser interrompida 
    GOTO EXEC
    GOTO POOLING
	
EXEC;Execução da contagem regressiva
CALL Atraso1m	
DECF MIN,W
CALL DAW_S;Ajuste decimal feito após a subtração
MOVWF MIN
MOVWF PORTD
BTFSS STATUS,Z;Checa se a contagem chegou a 0, caso sim pula a proxima instrução
GOTO EXEC

BUZZ;Estagio de alarme do buzzer, é ativado por 250ms, após esse periodo espera um segundo e caso algum botão seja acionado retorna ao inicio (INICIO)
BSF PORTB,3
CALL INTORROMPEBUZZ_250ms   
BCF PORTB,3
CALL INTORROMPEBUZZ_250ms
CALL INTORROMPEBUZZ_250ms
CALL INTORROMPEBUZZ_250ms
CALL INTORROMPEBUZZ_250ms
GOTO BUZZ

INTORROMPEBUZZ_250ms ;Sub-rotina de pooling de aproximadamente 250ms, para checar se algum dos botes foi pressionado
    MOVLW d'111'
    MOVWF VARIAVEl6
    LOOP7
    MOVLW d'250'
    MOVWF VARIAVEl5
    LOOP6
    BTFSC PORTB,6
    GOTO INICIO	
    BTFSC PORTB,7	
    GOTO INICIO
    DECFSZ VARIAVEl5
    GOTO LOOP6
    DECFSZ VARIAVEl6
    GOTO LOOP7
    RETURN
		
INC10;Sub-rotina para incrementar o contador em 10 minutos
    MOVF MIN,W
    ADDLW d'10'
    daw
    MOVWF MIN
    MOVWF PORTD
    CALL Atraso1s;Atraso para evitar erros pelo efeito bounce
    RETURN
	
Atraso1m; Subrotina para gerar 1 minuto de atraso
    MOVLW d'59'
    MOVWF VARIAVEl3
    MLOOP
    CALL Atraso1s
    decfsz VARIAVEl3;Decrementa VARIAVEl até 0, e entao pula a instrução 'goto'
    GOTO MLOOP
    RETURN   
    
Atraso1s;Subrotina para atrasar aproximadamente 1 segundo, mais 'nop's foram adicionados a fim de se obter uma maior precisão na sub-rotina de 1 minuto
    MOVLW d'250'
    MOVWF VARIAVEl2
    LOOP2
    CALL Atraso4ms
    decfsz VARIAVEl2;Decrementa VARIAVEl até 0, e entao pula a instrução 'goto'
    GOTO LOOP2
    RETURN
      
Atraso4ms;Subrotina para gerar aproximadamente 4 milissegungos de atraso
    MOVLW d'253'
    MOVWF VARIAVEl
    LOOP3
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	decfsz VARIAVEl;Decrementa VARIAVEl até 0, e entao pula a instrução 'goto'
    GOTO LOOP3
    RETURN 
    
    
Atraso250ms;Sub-rotina para gerar 250 milissegungos de atraso
    MOVLW d'62'
    MOVWF VARIAVEl4
    LOOP4
    CALL Atraso4ms
    decfsz VARIAVEl4;Decrementa VARIAVEl até 0, e entao pula a instrução 'goto'
    GOTO LOOP4
    RETURN 

    
DAW_S; Sub-rotina, fornecida pelo professor para ajuste decimal na subtração
    movwf 0x00
    andlw 0x0F
    movwf 0x01
    movlw 0x09
    cpfsgt 0x01
    btfss STATUS,DC
    bra l1
    bcf STATUS,DC
    l2    
    movlw 0x9F
    cpfsgt 0x00
    btfss STATUS,C
    bra l3
    movf 0x00,W
    bcf STATUS,C
    return
    l3    
    movlw 0x60
    subwf 0x00,w
    bsf STATUS,C
    return
    l1
    movlw 0x06
    subwf 0x00
    bsf STATUS,DC
    bra l2
     
END
    
    





