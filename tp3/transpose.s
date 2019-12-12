.globl matrix_transpose_asm

matrix_transpose_asm:
        push %ebp					# save old base pointer
        mov %esp, %ebp				        # set ebp to current esp
        subl $16, %esp                                  
	push %esi
	push %edi
	push %ebx	
	movl $0, %esi				        # mettre 0 dans r
	movl $0, %edi				        # mettre 0 dans c

	boucle1:
		cmp %esi, 16(%ebp)			# faire matorder - r
		je end					# sauter a end si matorder - r < 0
		
	boucle2:
		cmp %edi, 16(%ebp)			# faire matorder - c 
		jne transpose                           # sauter a transpose si matorder - c != 0
		incl %esi				# incrementer r
		movl $0, %edi                           # mettre c a 0
		jmp boucle1                             # sauter a boucle1
			
	transpose:
		movl 8(%ebp), %ebx			# recupere le pointeur inmatdata dans %ebx
		movl %edi, %eax				# mettre c dans %eax 
		mull 16(%ebp)				# multiplier c par matorder dans %eax
		addl %esi, %eax 			# additioner r a %eax
		movl (%ebx, %eax, 4), %ebx 	        # mettre inmatdata[%eax] dans %ebx
		
		movl 12(%ebp), %ecx			# mettre outmatdata dans %ecx
		movl %esi, %eax				# mettre r dans %eax 
		mull 16(%ebp)				# multiplier r par mattorder dans %eax
		addl %edi, %eax 			# ajouter c a %eax
		movl %ebx, (%ecx, %eax, 4)	        # donner la valeur a la position inverse
		incl %edi				# incrementer c
		jmp boucle2                             # sauter a la boucle2
		
	end:	
		pop %ebx
		pop %edi
		pop %esi
                leave					# restore ebp and esp 
                ret					# return to the caller 
