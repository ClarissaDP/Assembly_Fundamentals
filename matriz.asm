# CI243 - UFPR - EXERCICIO 4 - sobre Mtrizes

# Dado o programa C abaixo (em comentarios #) gerar o programa 
#   assemby equivalente do MIPS conforme padroes 
#   de geracao de codigo estudados.
# Gerar apenas a parte relativa ao codigo (parte de dados e
# funcoes de biblioteca ja' foram inseridas abaixo

# IMPORTANTE:
# cada linha do programa foi precedida de comentarios
# assim, DEVEMOS GERAR o programa p.asm (assembly) escrevendo:
#    a) para linha programa em C inserir o 
#        codigo MIPS gerado adequadamente PARA CADA linha
#    b) MANTER o original em comentarios
#    c) escreva em assembly SEMPRE alinhando na MARGEM ESQUERDA
#    d) NAO MUDE nada nas linhas de comentarios #, 
#       NAO MUDE o ALINHAMENTO  (-5 pts se fizer isso)

# Entrega: somente ESSE arquivo
# - NAO DELETE nada, nem os comentarios
# - alterar esse arquivo INSERINDO CODIGO assembly entre linhas
# - o numero de cada QUESTAO estah `a direita em comentarios
# - o valor de cada questao esta' ao final desse arquivo
# - seu codigo devera' funcionar mostrando resultados 
#     se voce nao fizer todas as questoes 

# obs1: o numero 32 equivale ao espaco ' ' na tabela ASCII
# obs2: o numero 10 equivale ao \n na tabela ASCII


#/*
#     OBS1: fazendo ateh a linha XXX primeiro imprime a primeira matriz
#           fazendo todo imprime duas Matrizes como abaixo:
#
#            1 1 1 1 1 1 1 1 1 1 
#            0 1 1 1 1 1 1 1 1 1 
#            0 0 1 1 1 1 1 1 1 1 
#            0 0 0 1 1 1 1 1 1 1 
#            0 0 0 0 1 1 1 1 1 1 
#            0 0 0 0 0 1 1 1 1 1 
#            0 0 0 0 0 0 1 1 1 1 
#            0 0 0 0 0 0 0 1 1 1 
#            0 0 0 0 0 0 0 0 1 1 
#            0 0 0 0 0 0 0 0 0 1 
#
#            1 0 0 0 0 0 0 0 0 0 4 1 1 1 1 1 1 1 1 1 
#            1 1 0 0 0 0 0 0 0 0 4 4 1 1 1 1 1 1 1 1 
#            1 1 1 0 0 0 0 0 0 0 4 4 4 1 1 1 1 1 1 1 
#            1 1 1 1 0 0 0 0 0 0 4 4 4 4 1 1 1 1 1 1 
#            1 1 1 1 1 0 0 0 0 0 4 4 4 4 4 1 1 1 1 1 
#            1 1 1 1 1 1 0 0 0 0 4 4 4 4 4 4 1 1 1 1 
#            1 1 1 1 1 1 1 0 0 0 4 4 4 4 4 4 4 1 1 1 
#            1 1 1 1 1 1 1 1 0 0 4 4 4 4 4 4 4 4 1 1 
#            1 1 1 1 1 1 1 1 1 0 4 4 4 4 4 4 4 4 4 1 
#            1 1 1 1 1 1 1 1 1 1 4 4 4 4 4 4 4 4 4 4 
#
#*/

 .data
Mat: .space 800
l: .space 4
c: .space 4

#                         int main ( )                      // linha 
#                         {                                 // linha 
 .text
main:

#
#                                static int Mat[10][20];  	-> Declarado acima
#                                static int l, c;         	-> Declarado acima
#
	sw $0, l	# l=0  -> abaixo

#                                for( l=0; l<10; l++ )
for00:
	lw $t1, l
	li $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor00
	
	sw $t1, c
#                                   for( c=0; c<10; c++ )
for01:
	lw $t1, c
	li $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor01
#                                      if( l >= c )
	lw $t1, l
	lw $t2, c
	sge $t0, $t1, $t2
	beq $t0, $0, else00
#                                          Mat[l][c] = 1;
	lw $t0, l
	mul $t0, $t0, 80
	lw $t1, c
	mul $t1, $t1, 4
	add $t0, $t0, $t1
	li $t1, 1
	sw $t1, Mat($t0)
	
	j fimif00
#                                      else
else00:
#                                          Mat[l][c] = 0;
	lw $t0, l
	mul $t0, $t0, 80
	lw $t1, c
	mul $t1, $t1, 4
	add $t0, $t0, $t1
	sw $0, Mat($t0)
	
fimif00:
	lw $t0, c
	addi $t0, $t0, 1
	sw $t0, c
	
	j for01
#
fimfor01:
#                                imprimeChar( 10 );     
	li $a0, 10
	jal imprimeChar     
	
	lw $t0, l
	addi $t0, $t0, 1
	sw $t0, l
	
	j for00   
#
fimfor00:
	sw $0, l
#                                for( l=0; l<10; l++ ) {
for02:
	lw $t1, l
	li $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor02
#                                   for( c=0; c<10; c++ ) {
	sw $0, c
for03:
	lw $t1, c
	li $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor03
#                                      imprimeInt( Mat[c][l] );   // atencao aqui 
	lw $t0, l
	mul $t0, $t0, 80
	lw $t1, c
	mul $t1, $t1, 4
	add $a0, $t0, $t1
	jal imprimeInt
#                                      imprimeChar( ' ' );  
	li $a0, 32
	jal imprimeChar
	
	lw $t0, c
	addi $t0, $t0, 1
	sw $t0, c
#                                   } 
	j for03
fimfor03:
#                                   imprimeChar( 10 );
	li $a0, 10
	jal imprimeChar
	
	lw $t0, l
	addi $t0, $t0, 1
	sw $t0, l
#                                }
	j for02
fimfor02:
#
#                                imprimeChar( 10 );               // linha XXX
	li $a0, 10
	jal imprimeChar
#
	sw $0, l
#                                for( l=0; l<10; l++ )
for04:
	lw $t1, l
	li $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor04
	
	sw $0, c
#                                   for( c=0; c<10; c++ )
for05:
	lw $t1, c
	li $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor05
#                                      Mat[l][c+10] = 1 + Mat[l][c] * 3;
	lw $t0, l
	mul $t0, $t0, 80
	lw $t1, c
	
	mul $t2, $t1, 4
	add $t2, $t0, $t1
	lw $t3, Mat($t2)
	addi $t3, $t3, 1
	
	addi $t1, $t1, 10
	mul $t1, $t1, 4
	add $t0, $t0, $t1
	sw $t3, Mat($t0)
#
	lw $t0, c
	addi $t0, $t0, 1
	sw $t0, c
	
	j for05
fimfor05:
	lw $t0, l
	addi $t0, $t0, 1
	sw $t0, l
	
	j for04
fimfor04:
	sw $0, l
#                                for( l=0; l<10; l++ ) {
for06:
	lw $t1, l
	li $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor06
	
	sw $0, c
#                                   for( c=0; c<20; c++ ) {
for07:
	lw $t1, c
	li $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor07
#                                      imprimeInt( Mat[l][c] );         // linha 
	lw $t0, l
	mul $t0, $t0, 80
	lw $t1, c
	mul $t1, $t1, 4
	add $a0, $t0, $t1
	jal imprimeInt
#                                      imprimeChar( ' ' );  
	li $a0, 32
	jal imprimeChar
	
	lw $t0, c
	addi $t0, $t0, 1
	sw $t0, c
	
	j for07
fimfor07:
#                                   } 
#                                   imprimeChar( 10 );
	li $a0, 10
	jal imprimeChar
	
	lw $t0, l
	addi $t0, $t0, 1
	sw $t0, l
	
	j for06
fimfor06:
#                                }
#
#
#                                exit (0);                  // linha 
	li $a0, 0
	jal exit
#                        }                                  // linha 


      .text   
#########  rotina para ler numero inteiro e colocar o valor em $v0
readInt:
         li $v0, 5             # numero da funcao readInt
         syscall               # chamar funcao do SO
         jr   $ra              # return

#########  rotina para imprimir numero inteiro que estah em $a0
imprimeInt: li   $v0, 1           # especifica em $V0 a funcao a ser executada
                                  # nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return
	
#########  rotina para imprimir um caracter que estah em $a0
      .text    
imprimeChar: li   $v0, 11         # especifica em $V0 a funcao a ser executada
                                  #0 nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return

#########  rotina exit que termina programa com valor passado em  $a0
      .text 
exit:   li   $v0, 10          # system call for exit (especifica termino de programa)
        syscall               # we are out of here.  (chama SO para terminar)   
        #veja que nao tem return visto que o programa termina


