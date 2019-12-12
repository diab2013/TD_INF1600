.globl matrix_multiply_asm

matrix_multiply_asm:
         push %ebp      				# save old base pointer
         mov %esp, %ebp 				# set ebp to current esp
         subl $16, %esp				   # malloc
         movl $0, -4(%ebp)			   # mettre r a 0
      	movl $0, -8(%ebp)			   # mettre c a 0
         movl $0, -12(%ebp)			# mettre i a 0
         movl 20(%ebp), %ebx			# %ebx = matorder

         for1:
    	         cmp -4(%ebp), %ebx 			# faire matorder - r %ebx = matorder
    	         je end						   # sauter a end si matorder - r = 0

         for2:
    	         cmp -8(%ebp), %ebx 			# faire matorder - c
     	         movl $0, -16(%ebp)			
    	         jne for3				         # sauter a for3 si matorder - c != 0
    	         movl $0, -8(%ebp)			   # on reset c
    	         incl -4(%ebp)				   # imcremente r
    	         jmp for1				         # sauter a for1
    	
         for3:
     	         cmp -12(%ebp), %ebx 		   # faire matorder - i 
     	         jne multiplication		   # sauter a multiplication si matorder - i != 0
     	         movl $0, -12(%ebp)			# reset i
     	         incl -8(%ebp)				   # incremente c
    	         jmp for2				         # sauter a for2
    
         multiplication:
    	         movl -4(%ebp), %eax 		   # placer r dans %eax
    	         mull 20(%ebp)				   # multiplier r par matorder dans %eax
    	         addl -12(%ebp), %eax		   # additioner i a %eax
    	         movl 8(%ebp), %ecx 			# placer inmapdata1 dans %ecx
    	         movl (%ecx, %eax, 4), %ecx	# placer inmapdata1[%eax] dans %ecx

    	         movl -12(%ebp), %eax		   # placer i dans %eax
    	         mull 20(%ebp)				   # multiplier i par matorder dans %eax
    	         addl -8(%ebp), %eax			# additioner c a %eax
    	         movl 12(%ebp), %edx			# placer inmapdata2 dans %edx
    	         movl (%edx, %eax, 4), %edx	# placer inmapdata2[%eax] dans %edx

    	         movl %edx, %eax				# placer %edx dans %eax
    	         mull %ecx					   # multiplier %ecx et %edx dans %eax
    	         addl %eax, -16(%ebp)		   # aditionner %eax et %ebp

    	         movl -4(%ebp), %eax			# placer r dans %eax
    	         mull 20(%ebp)				   # multipler r par matorder dans %eax
    	         addl -8(%ebp), %eax			# additioner c a %eax
    	         movl 16(%ebp), %ecx			# mettre outmapdata dans %exc
    	         movl -16(%ebp), %edx		   # mettre %epb dans %edx
    	         movl %edx, (%ecx, %eax, 4) 

            	incl -12(%ebp)				   # incremente i
    	         jmp for3				         # sauter a for3

         end:   
               addl $16, %esp				   # on libere la memoire
               leave          				# restore ebp and esp 
               ret            				# return to the caller 
