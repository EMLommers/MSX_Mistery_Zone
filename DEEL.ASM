        ORG   &HA000



DEEL:   LD    A,(DEELT)
        LD    L,A
        LD    H,0
        LD    A,(DELER)
        LD    C,A
        LD    B,8
DLUS:   ADD   HL,HL
        LD    A,H
        SUB   C
        JP    C,DEIND
        LD    H,A
        INC   L
DEIND:  DJNZ  DLUS
        LD    A,L
        LD    (QUOT),A
        LD    A,H
        LD    (REST),A
        RET


DEELT:  DB    12
DELER:  DB    10
QUOT:   DB    0
REST:   DB    0
     LD    A,H
        LD    (REST),A
        