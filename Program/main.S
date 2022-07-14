;
; Saxion University of Applied Sciences
; Applied Computer Science
; Smart Embedded Systems Minor - Spring 2020/2021
;
; Luciano Regis Orlandini - 460952
;

    .text

begin:
    SET   1             ; 00 ( R0 = 1 )
    MOVE  r0, r1        ; 01 ( R1 = R0 )
    SET   2             ; 02 ( R0 = 2 )
    MOVE  r0, r4        ; 03 ( R4 = R0 )

phase_1:
    SUB   r4, r1        ; 04 ( R0 = R4 - R1 )
    MOVE  r0, r4        ; 05 ( R4 = R0 )
    JUMP  phase_2, eq   ; 06 ( PC = 08 if (R0 = 0) )
    JUMP  phase_1       ; 07 ( PC = 04 )

phase_2:
    SET   3             ; 08 ( R0 = 2 )
    MOVE  r0, r2        ; 09 ( R2 = R0 )
    NOT   r2            ; 10 ( R0 = ~R2 )
    ADD   r0, r1        ; 11 ( R0 = R0 + R1 )
    ST    128, r2       ; 12 ( MEM[128] = R2 )
    LD    128, r3       ; 13 ( R3 = MEM[128] )
    ADD   r0, r3        ; 14 ( R0 = R0 + R3 )
    JUMP  phase_3, cf   ; 15 ( PC - 17 if (R0[16] = 1) )
    JUMP  begin         ; 16 ( PC = 0 ) *expected to be ignored

phase_3:
    SET   511           ; 17 ( R0 = 511 )
    MOVE  r0, r1        ; 18 ( R1 = R0 )
    SET   65408         ; 19 ( R0 = 65408 )
    MOVE  r0, r2        ; 20 ( R2 = R0 )
    AND   r1, r2        ; 21 ( R0 = R1 & R2 )
    OR    r1, r2        ; 22 ( R0 = R1 | R2 )

phase_4:
    SET   100           ; 23 ( R0 = 100 )
    MOVE  r0, r1        ; 24 ( R1 = R0 )
    SET   10            ; 25 ( R0 = 10 )
    MOVE  r0, r2        ; 26 ( R2 = R0 )

loop:
    SUB   r1, r2        ; 27 ( R0 = R1 - R2 )
    MOVE  r0, r1        ; 28 ( R1 = R0 )
    STAGE_INC 25        ; 29 ( ST_CNT += 25 )
    JUMPS GE, 70, end   ; 30 ( PC = 32 if (ST_CNT >= 70) )
    JUMP  loop          ; 31 ( PC = 27 )

end:
    STAGE_DEC 60        ; 32 ( ST_CNT -= 60 )
    JUMPS LE, 1, begin  ; 33 ( PC = 0 if (ST_CNT <= 1) ) *expected to be ignored
    STAGE_RST           ; 34 ( ST_CNT = 0 )