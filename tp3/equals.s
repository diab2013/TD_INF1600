.data
        r:
                .int 0

        c:
                .int 0

.globl matrix_equals_asm

matrix_equals_asm:
        push %ebp      /* Save old base pointer */
        mov %esp, %ebp /* Set ebp to current esp */
        subl $16, %esp                                  # malloc

        mov 16(%ebp), %eax                              # Faire %eax = matorder
        mov 12(%ebp), %ecx                              # Faire %ecx = intmatdata2[0]
        mov 8(%ebp), %edx                               # Faire %edx = intmatdata1[0]
        
        boucle1:
                movl $0, c                              # Faire c = 0
                
        boucle2:
                cmp %ecx, %edx                          # Faire %edx - %ecx
                jne notEqual                            # Si %edx - %ecx != 0
                lea 4(%ecx), %ecx                       # Deplacer la lecture de l'adresse de intmatdata2 vers la droite de l'espace d'un int
                lea 4(%edx), %edx                       # Deplacer la lecture de l'adresse de intmatdata1 vers la droite de l'espace d'un int

        equal:
                incl c                                  # c++
                cmp c, %eax                             # Faire %eax - c
                ja boucle2                              # Si %eax - c > 0
                incl r                                  # r++
                cmp r, %eax                             # Faire %eax - r
                ja boucle1                              # Si %eax - r > 0
                mov $1, %eax                            # Faire %eax = 1
                jmp exit             

        notEqual:
                mov $0, %eax                            # Faire %eax = 0

        exit:       
                leave          /* Restore ebp and esp */
                ret            /* Return to the caller */
