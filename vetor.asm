# CI243 - UFPR - EXERCICIO

# Dado o programa C abaixo (em comentarios #) gerar o programa 
#   assemby equivalente do MIPS conforme padroes 
#   de geracao de codigo estudados.
# Gerar apenas a parte relativa ao codigo (parte de dados e
# funcoes de biblioteca ja' foram inseridas abaixo

# IMPORTANTE:
# cada linha do programa foi precedida de comentarios
# assim, DEVEMOS GERAR o programa p1.s (assembly) escrevendo:
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

#                         static int C[20];
 .data
C: .space 80		# Variável global 

A: .space 40		# Variáveis declaradas abaixo
B: .space 40
i: .space 4
#
#                         int main ( )                      // linha 1
#                         {                                 // linha 2
 .text
main:

#
#                                static int A[10], B[10];    -> Declarada acima
#                                static int i;		     -> Declarada acima
#
#                                for( i=0; i<10; i++ ) 
	sw $0, i

for00:
	lw $s0, i
	li $t1, 10
	slt $t0, $s0, $t1
	beq $t0,$0, fimfor00
		
#                                      A[i] = i;
	lw $s0, i
	mul $t0, $s0, 4
	sw $s0, A($t0)
	
	lw $s0, i	#  -> i++
	addi $s0, $s0, 1
	sw $s0, i
	
	j for00
#
fimfor00:
	sw $0, i	
#                                for( i=0; i<10; i++ ) 
for01:
	lw $s0, i
	li $t1, 10
	slt $t0, $s0, $t1
	beq $t0,$0, fimfor01
#                                      B[i] = A[i]+2;
	lw $s0, i
	mul $t0, $s0, 4
	lw $t1, A($t0)
	addi $t1, $t1, 2
	sw $t1, B($t0)
	
	lw $s0, i	#  -> i++
	addi $s0, $s0, 1
	sw $s0, i
	
	j for01
#
fimfor01:
	sw $0, i	
#                                for( i=0; i<20; i++ )  {
for02:
	lw $s0, i
	li $t1, 20
	slt $t0, $s0, $t1
	beq $t0,$0, fimfor02
#                                      if( i < 10 )
if00:
	lw $s0, i
	li $t1, 10
	slt $t0, $s0, $t1
	beq $t0, $0, else00
#                                          C[i] = A[i];
	lw $s0, i
	mul $t0, $s0, 4
	lw $t1, A($t0)
	sw $t1, C($t0)
	
	j fimif00
#                                      else
else00:
#                                          C[i] = B[i];
	lw $s0, i
	mul $t0, $s0, 4
	lw $t1, B($t0)
	sw $t1, C($t0)

fimif00:	
			
	lw $s0, i	#  -> i++
	addi $s0, $s0, 1
	sw $s0, i
	
	j for02
#   }
fimfor02:
	sw $0, i	
#                                for( i=0; i<20; i++ ) {
for03:
	lw $s0, i
	li $t1, 20
	slt $t0, $s0, $t1
	beq $t0,$0, fimfor03
#                                      imprimeInt( C[i] );         // linha 
	lw $s0, i
	mul $t0, $s0, 4
	lw $a0, C($t0)
	jal imprimeInt
#                                      imprimeChar( ' ' );   
	li $a0, 32
	jal imprimeChar
#                                }
	lw $s0, i	#  -> i++
	addi $s0, $s0, 1
	sw $s0, i
	
	j for03
#
fimfor03:
#                                exit (0);                  // linha 18 (q1)
	li $a0, 0
	jal exit
#                        }                                  // linha 19 (q1)
#

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
                                  # nesse caso a funcao Print Integer 
            syscall               # chama funcao do Sistema Operacional
            jr   $ra              # return

#########  rotina exit que termina programa com valor passado em  $a0
      .text 
exit:   li   $v0, 10          # system call for exit (especifica termino de programa)
        syscall               # we are out of here.  (chama SO para terminar)   
        #veja que nao tem return visto que o programa termina


