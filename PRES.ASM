        ORG   &HC000

        LD    A,(&HF3E0)
        AND   144
        OUT   (&H99),A
        LD    A,1+128
        OUT   (&H99),A

ROUT:   LD    A,1
        OUT   (&H99),A
        LD    A,15+128
        OUT   (&H99),A

        XOR   A
        OUT   (&H99),A
        LD    A,23+128
        OUT   (&H99),A

        LD    A,106-29
        OUT   (&H99),A
        LD    A,19+128
        OUT   (&H99),A

CHMID:  IN    A,(&H99)
        AND   1
        JR    Z,CHMID

        LD    A,&H3F
        OUT   (&H99),A
        LD    A,2+128
        OUT   (&H99),A


        LD    A,74
        OUT   (&H99),A
        LD    A,23+128
        OUT   (&H99),A

        LD    A,2
        OUT   (&H99),A
        LD    A,15+128
        OUT   (&H99),A

        LD    B,59
CH58:   IN    A,(&H99)
        AND   32
        JP    NZ,CH58
        LD    A,(&HF3E0)
        AND   &HD0
        OUT   (&H99),A
        LD    A,1+128
        OUT   (&H99),A

        XOR   A
        OUT   (&H99),A
        OUT   (&H99),A
        OUT   (&H99),A
        OUT   (&H99),A
        OUT   (&H99),A
        OUT   (&H99),A
        OUT   (&H99),A
        OUT   (&H99),A

        DJNZ  CH58
        OUT   (&H99),A
        OUT   (&H99),A


        LD    A,(&HF3E0)
        AND   144
        OUT   (&H99),A
        LD    A,1+128
        OUT   (&H99),A

        IN    A,(&HAA)
        AND   &HF0
        ADD   A,8
        OUT   (&HAA),A
        IN    A,(&HA9)
        AND   1
        JP    NZ,ROUT



        XOR   A
        OUT   (&H99),A
        LD    A,15+128
        OUT   (&H99),A
        XOR   A
        CALL  &H5F


        LD    A,(&HF3E0)
        OUT   (&H99),A
        LD    A,1+128
        OUT   (&H99),A




        RET
H5F

