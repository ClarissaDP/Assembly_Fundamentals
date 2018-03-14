# obs1: o numero 32 equivale ao espaco ' ' na tabela ASCII
# obs2: o numero 10 equivale ao \n na tabela ASCII


                       # int main ( )                      // linha 1
                       # {                                 // linha 2
                       #        static int a, bb, c, i;            // linha 3 (declaracoes .data ACIMA)
 .data
a: .space 4
bb: .space 4
c: .space 4
i: .space 4 
                       #        static int Vet[11];                // linha 4 (declaracoes .data ACIMA)
Vet: .space 44


 .text
main:
		       #        c = 2;                   // linha 5 (q1)
	li $t0, 2
	sw $t0, c
                       #        Vet[ 0 ] = 7;            // linha 6 (q1)
	li $s0, 0
	li $t1, 7
	sw $t1, Vet($s0)
                       #        a = readInt();           // linha 7 (q1)
	jal readInt
	sw $v0, a
                       #        if( a < 0 )              // linha 8 (q1)
if00:
	lw $t1, a
	slt $t0, $t1, $0
	beq $t0, $0, else00
                       #             exit( 0 );            // linha 9 (q1)
	li $a0, 0
	jal exit

else00:
                       #        c = min( 11, a );        // linha 10 (q1)
	li $a0, 11
	lw $a1, a
	jal min
	sw $v0, c	
                       #        imprimeInt( c );         // linha 11 (q2)
	lw $a0, c
	jal imprimeInt
                       #        imprimeChar( ' ' );     // linha 12 (q2)
	li $a0, 32
        jal imprimeChar
        
       	 	       #        for (i=1; i<11; i++) {      // linha 13 (q3)
	li $t0, 1
	sw $t0, i
	
for00:
	lw $s0, i
	li $s1, 11
	slt $t0, $s0, $s1
	beq $t0, $0, fimfor00
	
                       #                bb = i*2;            // linha 14 (q3)
	lw $t1, i
	mul $t0, $t1, 2
	sw $t0, bb
                       #                Vet[i]= bb;          // linha 15 (q3)
	lw $t0, bb
	lw $t1, i
	mul $t1, $t1, 4
	sw $t0, Vet($t1)
                       #        }                           // linha 16 (q3)
	lw $s0, i
	addi $s0, $s0, 1    ## instrução do for  (i++)
	sw $s0, i
	
	j for00
	
fimfor00:
		       #        for (i=c; i<=10; i=i+2) {   // linha 17 (q4)
	lw $t0, c
	sw $t0, i
	
for01:
	lw $s0, i
	li $s1, 10
	sle $t0, $s0, $s1
	beq $t0, $0, fimfor01
	
                       #                bb = bb + Vet[i];     // linha 18 (q4)
	lw $t0, bb
	lw $s0, i
	mul $s0, $s0, 4
	lw $s1, Vet($s0)
	add $t0, $t0, $s1
	sw $t0, bb
                       #        }                           // linha 19 (q4)
	lw $s0, i
	addi $s0, $s0, 2	## instrução do for  (i=i+2)
	sw $s0, i
	
	j for01
	
fimfor01:
         	       #
                       #        imprimeInt( bb );            // linha 20 (q2)
	lw $a0, bb
	jal imprimeInt
                       #        imprimeChar( ' ' );        // linha 21 (q2)
	li $a0, 32
	jal imprimeChar 
                       #        exit (0);                  // linha 22 (q2)
	li $a0, 0
	jal exit
                       #} 

      
      
#########  Rotina que retorna o minimo entre dois valores recebidos                  
                       # funcao max A SER CODIFICADA por voce
                       # int min( int a, int bb )           // linha 24 (q5)
min:
                       # {                                 // linha 25 (q5)
                       #     if( a < bb )                   // linha 26 (q5)
if01:
	slt $t0, $a0, $a1
	beq $t0, $0, else01
                       #       return a;                   // linha 27 (q5)  
	move $v0, $a0  
	jr $ra 
                       #     else                          // linha 28 (q5)
else01:
                       #       return bb;                   // linha 29 (q5)
	move $v0, $a1  
	jr $ra                        
                       # }                                 // linha 30 (q5)
                      
  
#########  rotina para ler numero inteiro e colocar o valor em $v0
      .text 
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
