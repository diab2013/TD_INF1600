.data
	
.global func_s

func_s:	
	
		mov $0, %esi
		movl a, %eax	    
		movl b, %ebx
		movl c, %ecx
		movl d, %edx
		movl e, %edi
		jmp boucle
	
	comparaison:
		movl %eax, a
		movl %ebx, b
		movl %ecx, c
		movl %edx, d
		cmp $10, %esi				# i - 10 = ?
		jna boucle 					# on continue si i - 10 <= 0
		jmp end						# si i - 10 > 0 on arrete

	boucle:
		movl d, %eax				# a = d
		subl %ebx, %eax				# a = a - b				
		addl %edi, %eax		 		# a = a + e	
		subl $1000, %ebx			# b - 1000
		addl $500, %ecx				# c + 500
		cmp %ebx, %ecx				# c - b = ?
		ja if1 						# va dans le if1 si c - b > 0

	else:
		movl b, %ebx
		movl c, %ecx
		subl %edi, %ebx 			# b = b - e
		addl $500, %edx				# d = d + 500		
		addl $1, %esi					# i++
		jmp comparaison

	if1:
		movl b, %ebx
		movl c, %ecx
		subl $500, %ecx				# c = c - 500
		cmp %ecx, %ebx				# b - c = ?
		ja if2 						# va dans le if2 si b - c > 0
		inc %esi					# i++
		jmp comparaison

	if2:
		movl b, %ebx
		subl $500, %ebx				# b = b - 500
		inc %esi					#i++
		jmp comparaison

	end:
		ret

