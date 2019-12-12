.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl _ZNK7CCircle12PerimeterAsmEv

_ZNK7CCircle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */

        mov 8(%ebp), %eax       # mettre le pointeur de l'objet dans %eax
        fld 4(%eax)             # mettre le radius sur la pile
        fldpi                   # ajouter pi à la pile
	fld factor              # mettre 2.0 a st[0] et pi a st[1], radisu devient st[2]
	fmulp                   # multiplier par 2
        fmulp                   # multiplier par pi
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
