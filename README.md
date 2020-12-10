# ESEMPI RAPPRESENTAZIONI NUMERI IN C - PROBLEMI DI OVERFLOW

Da: http://phrack.org/issues/60/10.html

## Overflow di lunghezza

    /* ex1.c - loss of precision */
    #include <stdio.h>

    int main(void){
            int l;
            short s;
            char c;

            l = 0xdeadbeef;
            s = l;
            c = l;

            printf("l = 0x%x (%d bits)\n", l, sizeof(l) * 8);
            printf("s = 0x%x (%d bits)\n", s, sizeof(s) * 8);
            printf("c = 0x%x (%d bits)\n", c, sizeof(c) * 8);

            return 0;
    }
    /* EOF */

massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$ ./ex1
l = 0xdeadbeef (32 bits)
s = 0xffffbeef (16 bits)
c = 0xffffffef (8 bits)
massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$

## Esempio conseguenze

    
    
    /* width1.c - exploiting a trivial widthness bug */
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int main(int argc, char *argv[]){
            unsigned short s;
            int i;
            char buf[80];

            if(argc < 3){
                    return -1;
            }

            i = atoi(argv[1]);
            s = i;

            if(s >= 80){            /* [w1] */
                    printf("Oh no you don't!\n");
                    return -1;
            }

            printf("s = %d\n", s);

            memcpy(buf, argv[2], i);
            buf[i] = '\0';
            printf("%s\n", buf);

            return 0;
    }


massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$ ./width1 6 ciao
s = 6
ciao
massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$ 
massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$ ./width1 80 ciao
Oh no you don't!
massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$ ./width1 65536 ciao
s = 0
Segmentation fault (core dumped)
massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$

## Arithmetic overflows

    /* ex2.c - an integer overflow */
    #include <stdio.h>

    int main(void){
            unsigned int num = 0xffffffff;

            printf("num is %d bits long\n", sizeof(num) * 8);
            printf("num = 0x%x\n", num);
            printf("num + 1 = 0x%x\n", num + 1);

            return 0;
    }
    /* EOF */

massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$ ./ex2
num is 32 bits long
num = 0xffffffff
num + 1 = 0x0
massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$ 

    /* ex3.c - change of signedness */
    #include <stdio.h>

    int main(void){
            int l;

            l = 0x7fffffff;

            printf("l = %d (0x%x)\n", l, l);
            printf("l + 1 = %d (0x%x)\n", l + 1 , l + 1);

            return 0;
    }
    /* EOF */

massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$ ./ex3
l = 2147483647 (0x7fffffff)
l + 1 = -2147483648 (0x80000000)
massimo@massimo-VirtualBox:~/workspace/BasicIntegerOverflow$

/* ex4.c - various arithmetic overflows */
    #include <stdio.h>

    int main(void){
            int l, x;

            l = 0x40000000;

            printf("l = %d (0x%x)\n", l, l);

            x = l + 0xc0000000;
            printf("l + 0xc0000000 = %d (0x%x)\n", x, x);

            x = l * 0x4;
            printf("l * 0x4 = %d (0x%x)\n", x, x);

            x = l - 0xffffffff;
            printf("l - 0xffffffff = %d (0x%x)\n", x, x);

            return 0;
    }
    /* EOF */

