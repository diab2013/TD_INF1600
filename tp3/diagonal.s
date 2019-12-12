.global matrix_diagonal_asm

matrix_diagonal_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
        subl $16, %esp          # malloc
        push %esi
        push %edi
        push %ebx
        movl $0, %esi               # mettre 0 dans r
        movl $0, %edi               # mettre 0 dans c

    for1:
        cmp %esi, 16(%ebp)          # faire matorder - r
        jnae end                    # sauter a end si mattorder - r < 0
    
    for2:
        cmp %edi, 16(%ebp)          # faire matorder - c
        jne if                      # sauter a if si mattorder - c != 0
        incl %esi                   # incrementer r
        movl $0, %edi               # mettre c a 0
        jmp for1                    # sauter a for1

    if:
        cmp %edi, %esi              # faire r - c
        jne pasEgal                 # si c - r != 0, on va a pasEgal
	
    Egal:
        movl 8(%ebp), %ebx          # je récupère dans %ebx
        movl %esi, %eax             # mettre r dans %eax
        mull 16(%ebp)               # multiplier r et matorder dans %eax
        addl %edi, %eax             # additioner c a %eax
        movl (%ebx, %eax, 4), %ebx  # mettre inmatdata[%eax] dans %ebx
        movl 12(%ebp), %ecx         # mettre outmatdata dans %ecx
        movl %ebx, (%ecx, %eax, 4)  # garder la valeur
        incl %edi                   # incrementer c
        jmp for2                    # sauter a for2
    
    pasEgal:
        movl 12(%ebp), %ebx         # mettre outmatdata dans %ecx
        movl %esi, %eax             # additioner r a %eax
        mull 16(%ebp)               # multiplier c par matorder dans %eax
        addl %edi, %eax             # additioner c a %eax
        movl $0, (%ebx, %eax, 4)    # mettre a 0 car non diagonal
        incl %edi                   # incrementer c
        jmp for2                    # sauter a for2

    end:
        pop %ebx
        pop %edi
        pop %esi
        leave          			/* Restore ebp and esp */
        ret            			/* Return to the caller */
