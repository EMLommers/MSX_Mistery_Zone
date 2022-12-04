        ORG   &HC000

MM:     DI
        LD    A,7
        CALL  &H5F
        CALL  CHECK           ;Checkmuis
        CALL  START           ;init muis/cursor

        CALL  RUN             ;jump routinemuis


START:  DI

        LD    HL,SPRITE
        LD    BC,32*5
        LD    DE,&HF000
        CALL  &H5C
        LD    HL,COLOR
        LD    BC,16*5
        LD    DE,&HF800
        CALL  &H5C
        RET



RUN:    DI
        LD    A,(&HFCAF)
        CP    5
        RET   NZ
        LD    A,(PEEK)
        CP    2
        JP    Z,CURS

        LD    A,12
        CALL  &HDB

        LD    A,13
        CALL  &HDB
        LD    D,A
        LD    A,(XCOOR)
        ADD   D
        CP    255-12
        JR    NC,NX
        LD    (XCOOR),A

NX:     LD    A,14
        CALL  &HDB
        LD    D,A
        LD    A,(YCOOR)
        ADD   D
        CP    211-15
        JR    NC,NX2
        LD    (YCOOR),A

NX2:
; Read PPI for cursor routine

CURS:   IN    A,(&HAA)
        AND   &HF0
        ADD   A,8
        OUT   (&HAA),A
        IN    A,(&HA9)
        LD    D,A

        BIT   5,A
        CALL  Z,UP

        LD    A,D
        BIT   6,A
        CALL  Z,DOWN

        LD    A,D
        BIT   4,A
        CALL  Z,LEFT

        LD    A,D
        BIT   7,A
        CALL  Z,RIGHT


        XOR   A
        LD    (SPRPN),A
        LD    A,(XCOOR)
        CP    7
        JP    NC,NX3
        LD    A,7
        LD    (XCOOR),A

NX3:    LD    B,5
        LD    HL,&HFA00
        LD    C,&H99

LOOP:   LD    A,H
        RES   7,A
        SET   6,A
        PUSH  AF
        LD    A,0
        AND   1
        LD    C,A
        LD    A,H
        AND   &HC0
        OR    0
        RLCA
        RLCA
        DI
        OUT   (&H99),A
        LD    A,14+128
        OUT   (&H99),A
        LD    A,L
        OUT   (&H99),A
        POP   AF
        OUT   (&H99),A




        LD    A,(YCOOR)
        OUT   (&H98),A
        LD    A,(XCOOR)
        OUT   (&H98),A
        LD    A,(SPRPN)
        SLA   A
        SLA   A
        OUT   (&H98),A
        SRA   A
        SRA   A
        INC   A
        LD    (SPRPN),A

        INC   HL
        INC   HL
        INC   HL
        INC   HL
        DJNZ  LOOP
        RET

UP:     LD    A,(YCOOR)
        DEC   A
        CP    255
        RET   Z

        LD    (YCOOR),A
        RET
DOWN:   LD    A,(YCOOR)
        INC   A
        CP    211-15
        RET   Z
        LD    (YCOOR),A
        RET
LEFT:   LD    A,(XCOOR)
        DEC   A
        CP    255
        RET   Z
        LD    (XCOOR),A
        RET
RIGHT:  LD    A,(XCOOR)
        INC   A
        CP    255-12
        RET   Z
        LD    (XCOOR),A
        RET
; Check mouse very good...
CHECK:  LD    A,12
        CALL  &HDB
        LD    A,13
        CALL  &HDB

        CP    1
        JP    NZ,NO
        LD    D,A
NO:     PUSH  DE
        LD    A,14
        CALL  &HDB
        POP   DE
        CP    1
        JP    NZ,NO2
        ADD   D
        LD    (PEEK),A
        RET
NO2:    XOR   A
        LD    (PEEK),A
        RET
PEEK:   DB    0
YCOOR:  DB    0
XCOOR:  DB    8
SPRPN:  DB    0




SPRITE: DEFB  48,72,69,34,16,8,16,32
        DEFB  32,32,32,16,24,14,3,0
        DEFB  0,0,128,64,32,16,8,8
        DEFB  8,4,4,8,8,24,240,224
        DEFB  0,48,8,5,2,3,0,6
        DEFB  3,0,7,0,0,0,0,0
        DEFB  0,0,0,0,192,32,128,64
        DEFB  64,136,80,160,0,0,0,0
        DEFB  0,0,48,8,5,0,9,9
        DEFB  12,11,0,7,0,0,0,0
        DEFB  0,0,0,128,0,192,112,176
        DEFB  176,112,168,16,224,64,0,0
        DEFB  0,0,0,16,8,4,6,16
        DEFB  0,20,8,8,7,0,0,0
        DEFB  0,0,0,0,0,0,0,0
        DEFB  0,0,0,64,16,160,0,0
        DEFB  0,0,0,0,0,0,0,0
        DEFB  16,0,16,0,0,1,0,0
        DEFB  0,0,0,0,0,0,0,0
        DEFB  0,0,0,0,0,0,0,0
; sprite color
COLOR:  DEFB  13,13,13,13,13,13,13,13
        DEFB  13,13,13,13,13,13,13,13
        DEFB  0,12,12,12,12,12,12,12
        DEFB  12,12,12,12,0,0,0,0
        DEFB  0,0,10,10,10,10,10,10
        DEFB  10,10,10,10,10,10,0,0
        DEFB  0,0,0,5,5,5,5,5
        DEFB  0,5,5,5,5,5,0,0
        DEFB  0,0,0,0,0,0,0,0
        DEFB  2,0,2,0,0,2,0,0
; Normal colors
SCCOL:  DEFB  &H20,1          ; 11 -> 2
        DEFB  &H42,3          ; 12 -> 5
        DEFB  &H53,4          ; 13 -> 10
        DEFB  &H64,5          ; 14 -> 12
        DEFB  &H00,0          ; 15 -> 13

       DEFB  &H53,4          ; 13 -> 10
        DE