.globl _ZNK9CTriangle12PerimeterAsmEv

_ZNK9CTriangle12PerimeterAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        mov 8(%ebp), %eax       # accès au pointeur de l'objet
        fld 4(%eax)             # mettre le premier coté du triangle sur la pile, st[2] au final
        fld 8(%eax)             # mettre le deuxième coté du triangle sur la pile, st[1] au final
        fld 12(%eax)            # mettre le troisième coté du triangle sur la pile, st[0] au final
        faddp                   # additionner troisième coté avec deuxième coté (3e + 2e)
        faddp                   # additionner le premier coté avec le résulat précédent ((3e + 2e) + 1er)
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
