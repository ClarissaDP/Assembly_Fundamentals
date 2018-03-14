#       int main() 
#       {
#          static int menor, n, i;
#
#          i = 0;

.data
menor: .space 4
n: .space 4
i: .word 0

.text
main:
#          n = readInt();
	jal readInt
	sw $v0,i
#          while( n >= 0 ) {
# 
while00:
	lw $t0, n
	sge $t1,$t0,$0
	bge $t1,$0,fimwhile             
#             menor = min( n, i );
	lw $t2,n
	move $a0,$t2
	lw $t3,i
	move $a1,$t3
	jal min
	sw $v0,menor
#             imprimechar( 10 );  // salta uma linha
	lw $t4,10
	move $a0,$t4
	jal imprimeChar
#             imprimeInt( menor );
	lw $t5,menor
	move $a0,$t5
	jal imprimeInt
#             n = readInt();
	jal readInt
	sw $v0,n
#             i = i + 1;
	lw $t6,i
	addi $t7,$t6,1
	sw $t7,i
#          }
	j while00
fimwhile:
#          exit( 0 );
#       }
	move $a0,$0
	jal exit

# int min( int a, int b )
# {
min:
#   if( a < b ) 
	sgt $t0,$a0,$a1
	beq $t1,$0,else00
#      m = a;
	lw $t2,a
	sw $t2, m
	jal fimif00
#   else
else00:
#      m = b;
	lw $t2,b
	sw $t2,m
#   return( m );
fimif00:
	add $v0,$0,$t2	
# }
	jr $ra

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
