.data
        r:
                .int 0

        c:
                .int 0

        elem:
                .int 0

.global matrix_row_aver_asm

matrix_row_aver_asm:
        push %ebp      			/* Save old base pointer */
        mov %esp, %ebp 			/* Set ebp to current esp */
        subl $16, %esp                                  # malloc

        mov 12(%ebp), %ecx                              # Faire %ecx = outmatdata[0]
        mov 8(%ebp), %edx                               # Faire %edx = intmatdata[0]

        boucle1:
            movl $0, c                                  # Faire c = 0
            movl $0, elem                               # Faire elem = 0

        boucle2:
            add %edx, elem                              # Faire elem+=%edx
            lea 4(%edx), %edx                           # Deplacer la lecture de l'adresse de intmatdata vers la droite de l'espace d'un int
            
        comparaison:
            incl c                                      # c++
            movl c, %eax                                # Faire %eax = c
            cmp %eax, 16(%ebp)                          # Faire matorder - c
            ja boucle2                                  # Si matorder - c > 0

        moyenne:
            movl elem, %eax                             # Faire %eax = elem   
            divl 16(%ebp)                               # Faire elem/matorder
            mov %eax, %ecx                              # Faire %ecx = %eax
            lea 4(%ecx), %ecx                           # Deplacer la lecture de l'adresse de outmatdata vers la droite de l'espace d'un int
            incl r                                      # r++
            movl r, %eax                                # Faire %eax = r
            cmp %eax, 16(%ebp)                          # Faire matorder - r
            ja boucle1                                  # Si matorder - r > 0

		exit:
            leave          			/* Restore ebp and esp */
            ret           			/* Return to the caller */
		
