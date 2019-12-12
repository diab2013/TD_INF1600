.data
        factor: .float 2.0 /* use this to multiply by two */

.text
.globl _ZNK9CTriangle7AreaAsmEv

_ZNK9CTriangle7AreaAsmEv:
        push %ebp      /* save old base pointer */
        mov %esp, %ebp /* set ebp to current esp */
        
        sub $4, %esp            # faire de l'espace pour une variable locale s
        mov 8(%ebp), %eax       # mettre le pointeur de l'objet dans %eax
        mov 0(%eax), %ecx       # mettre le pointeur de la table virtuel de triangle

        push %eax               # sauver le pointeur de l'objet sur la pile
        call *12(%ecx)          # appeler la méthode CTriangle::PerimeterAsm de triangle.vtable, 
                                # le retour est strocké dans %eax, mais la valeur est encore sur la pile

        fld factor              # mettre le float 2.0 sur la pile à st[0]
        fdivrp                  # diviser le paramètre par 2 (st[1] / st[0])
        fstp -4(%ebp)           # sauver le résultat dans la variable local s , elle sera reutilisée

        fld -4(%ebp)            # mettre s sur la pile 
        fld 4(%eax)             # mettre le premier coté en paramètre sur la pile
        fsubrp                  # soustraire s par le première coté (st[1] - st[0])

        fld -4(%ebp)            # mettre s sur la pile 
        fld 8(%eax)             # mettre le deuxième coté en paramètre sur la pile
        fsubrp                  # soustraire s par le deuxième coté (st[1] - st[0])

        fld -4(%ebp)            # mettre s sur la pile 
        fld 12(%eax)            # mettre le troisîeme coté en paramètre sur la pile
        fsubrp                  # soustraire s par le troisîeme coté (st[1] - st[0])

        fmulp                   # multiplier les deux derniers résultats ensemble (st[0] * st[1])
        fmulp                   # multiplier le dernier résultat avec s moins le premier coté
        fld -4(%ebp)            # metter s sur la pile
        fmulp                   # multiplier s par le résultat du dernier calcul fait
        fsqrt                   # st[0] est remplacé par sa racine carrée
        
        leave          /* restore ebp and esp */
        ret            /* return to the caller */
