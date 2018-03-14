# CI243 - UFPR - EXERCICIO 3

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


#     OBS: executando esse programa a saida serah:
#     0 1 2 3 4 5 6 7 8 9 2 3 4 5 6 7 8 9 10 11 
#     2 1 2 3 4 5 6 7 8 9 7 3 8 5 9 7 10 9 11 11 
#     2 1 2 3 4 5 5 5 5 5 5 3 8 5 9 7 10 9 11 11 


 .data 
C: .space 80
A: .space 40
B: .space 40
i: .space 4

#                         static int C[20];
#
#
#                         int main ( )                      // linha 

 .text
main:

#                         {                                 // linha 
#
#                                static int A[10], B[10];
#                                static int i;         
#
#                                for( i=0; i<10; i++ ) 
	sw $0, i
	
for00:
	lw $t1, i
	lw $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor00
#                                      A[i] = i;
	lw $t0, i
	mul $t0, $t0, 4
	lw $t1, i
	sw $t1, A($t0)
	
	lw $t0, i
	addi $t0, $t0, 1
	sw $t0, i
#
	j for00
fimfor00:
#                                for( i=0; i<10; i++ ) 
	sw $0, i
for01:
	lw $t1, i
	lw $t2, 10
	slt $t0, $t1, $t2
	beq $t0, $0, fimfor01
			
#                                      B[i] = A[i]+2;
	lw $t0, i
	mul $t0, $t0, 4
	lw $t1, A($t0)
	addi $t1, $t1, 2
	sw $t1, B($t0)
	
	lw $t0, i
	addi $t0, $t0, 1
	sw $t0, i
#
	j for01
fimfor01:
#
#                                for( i=0; i<20; i++ )
	sw $0, i
for02:
#                                      if( i < 10 )
#                                          C[i] = A[i];
#                                      else
#                                          C[i] = B[i-10];  // MUDADO AQUI!!
#
#                                imprimeVetC();
#
#                                for( i=0; i<10; i++ ) {
#                                      C[i] = A[i];
#                                      C[i*2] = B[i];
#                                }
#
#                                imprimeVetC();
#
#                                for( i=0; i<12; i++ )   // MUDADO AQUI!!
#                                      C[i] = max5( C[i] );
	lw $t0, i
	mul $t0, $t0, 4
	lw $a0, C($t0)
	jal max5
	
	sw $v0, C($t0)
#                                
#                                imprimeVetC();
#
#                                exit (0);                  // linha 
#                        }                                  // linha 
#

#                        void imprimeVetC()
#                        {
#                            static int ii;
#                        
#                                for( ii=0; ii<20; ii++ ) {
#                                      imprimeInt( C[ii] );         // linha 
#                                      imprimeChar( ' ' );   
#                                }
#                                imprimeChar( 10 );
#                        }

#                        int max5( int x )
#                        {
max5:
	
#                            if( x < 5 )
#                               return x;
#                            else
#                               return 5;
#                        }
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
