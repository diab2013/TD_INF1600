.globl _ZNK7CCircle7AreaAsmEv

_ZNK7CCircle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        mov 8(%ebp), %eax       # mettre le pointeur de l'objet dans %eax
        fld 4(%eax)             # mettre le radius sur la pile, s[0]
	fld 4(%eax)             # mettre le radius une deuxième fois, donc raidus est sur st[0] et st[1]
        fldpi                   # ajouter pi sur la pile, pi sur s[0], radisu sur st[1] et st[2]
	fmulp                   # multiplier pi et le radius    (pi * r)
        fmulp                   # multiplier le resultat précédent par le radius ((pi * r) * r)
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
