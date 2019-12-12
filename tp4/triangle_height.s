.data
        factor:
                .float 2.0              # diviseur

.globl	_ZNK9CTriangle9HeightAsmEv

_ZNK9CTriangle9HeightAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        mov 8(%ebp), %eax               # Avoir acces au pointeur
	mov 0(%eax), %ecx               # Mettre dans %ecx le pointeur vers la table virtuelle

	push %eax                       # Mettre %eax sur la pile
	call *20(%ecx)                  # Appeler la fonction CTriangle::AreaAsm de la table virtuelle dans %ecx, l'aire du triangle est le premier element de la pile    

	fld 12(%eax)                    # Mettre le cote c en haut de la pile
	fdivrp	                        # st[0] = Aire du triangle / c

	fld factor                      # Mettre la valeur 2.0f en haut de la pile
        fmulp                           # st[0] = 2.0f * Aire du triangle / c
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
