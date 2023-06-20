.data

msg0:.asciz "*****Print Name*****\n"
msg1:.asciz  "Team\n"
msg2:.asciz  "name1\n"
msg3:.asciz  "name2\n"
msg4:.asciz  "name3\n"
msg5:.asciz "*****End Print*****\n"

team_ads : .word 0
name1_ads : .word 0
name2_ads : .word 0
name3_ads : .word 0

.text
.globl NAME
.type  NAME, %function

NAME: stmfd sp!,{lr}    @push return address onto stack
      ldr r5, =team_ads @load team_ads address in r5
      str r0, [r5]      @store the value of r0 in the address r5

      ldr r5, =name1_ads@load name1_ads address in r5
      str r1, [r5]      @store the value of r1 in the address r5

      ldr r5, =name2_ads@load name2_ads address in r5
      str r2, [r5]      @store the value of r2 in the address r5

      ldr r5, =name3_ads@load name3_ads address in r5
      str r3, [r5]      @store the value of r3 in the address r5

      ldr r0, =team_ads @load team_ads address in r0
      ldr r0, [r0]      @load the value of r0 to the address r0
      ldr r1, =msg1     @load msg1 address in r1
      bl strcpy         @copy string(msg1) from r1 to r0

      ldr r0, =name1_ads@load name1_ads address in r0
      ldr r0, [r0]      @load the value of r0 to the address r0
      ldr r1, =msg2     @load msg2 address in r1
      bl strcpy         @copy string(msg2) from r1 to r0

      ldr r0, =name2_ads@load name2_ads address in r0
      ldr r0, [r0]      @load the value of r0 to the address r0
      ldr r1, =msg3     @load msg3 address in r1
      bl strcpy         @copy string(msg3) from r1 to r0

      ldr r0, =name3_ads@load name3_ads address in r0
      ldr r0, [r0]      @load the value of r0 to the address r0
      ldr r1, =msg4     @load msg4 address in r1
      bl strcpy         @copy string(msg4) from r1 to r0



      ldr   r0, =msg0   @load msg0 address in r0
      bl    printf      @print("*****Print Name*****")


      ldr   r0, =msg1   @load msg1 address in r0
      bl    printf      @print("Team 05\n")


      ldr   r0, =msg2   @load msg2 address in r0
      bl    printf      @print("Chen Tzu Ying")



      ldr   r0, =msg3   @load msg3 address in r0
      bl    printf      @print("Liang Han Ting")



      ldr   r0, =msg4   @load msg4 address in r0
      bl    printf      @print("Yang yu sam")


      ldr   r0, =msg5   @load msg5 address in r0
      bl    printf      @print("End Print")

      mov r0, #0        @r0 = 0
      mov r1, #0        @r1 = 0
      mov r2, #0        @r2 = 0
      adcs r0, r1, r2   @add r1, r2 and carry bit, store
                        @result in r0 and set CPSR flags


      ldr r0, =msg4     @load msg4 address in r0
      ldr r1, =msg5     @load msg5 address in r1

      ldmfd sp!,{lr}    @pop return address from stack
      mov   pc, lr      @mov lr to pc














