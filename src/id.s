

.data
scanf_id1: .asciz "%d"     @format string, to input ID1
scanf_id2: .asciz "%d"     @format string, to input ID2
scanf_id3: .asciz "%d"     @format string, to input ID3
total_out: .asciz "%d\n"   @format string, to print ID total
scanf_command: .asciz "%s" @format string, to input command
scanf_word: .word 0        @int variable, scanf will store the
                           @number here
p: .asciz "p"              @string "p", scanf will also stroe
                           @the command here
destion: .word 0           @all ID will store in destion
array_ads: .word 0

msg1:.asciz "*****Input ID*****\n"
msg2:.asciz "**Please Enter Member 1 ID**\n"
msg3:.asciz "**Please Enter Member 2 ID**\n"
msg4:.asciz "**Please Enter Member 3 ID**\n"
msg5:.asciz "**Please Enter Command**\n"
msg6:.asciz "*****Print Team Member ID and ID Summation*****\n"
msg7:.asciz "\nID Summation :"
msg8:.asciz "*****End Print*****"
msg9:.asciz "no useful command\n"



.text
.globl ID
.type  ID, %function

error: stmfd sp!,{lr}
       str r5, [r4, #12]
       ldr r0, =msg9
       bl printf              @print("no useful command")
       ldmfd sp!,{lr}
       mov pc, lr             @return address

continue: stmfd sp!,{lr}
          ldr r0, =total_out  @load format string(total_out) address in r0
          ldr r1, [r4]        @load r1 at the address r4
          bl printf           @print("%d", r1), print ID1

          ldr r0, =total_out
          ldr r1, [r4, #4]!   @load r1 at the address r4+4, update r4
          bl printf           @print("%d", r1),print ID2

          ldr r0, =total_out
          ldr r1, [r4, #4]   @load r1 at the address r4+4
          bl printf          @print("%d", r1),print ID3

          ldr r0, =msg7     @print("ID Summation :")
          bl printf

          ldr r0, =total_out
          mov r1, r5
          bl printf         @print("%d", r1),print ID total

          @ldr r4, =destion
          ldr r4, =array_ads
          ldr r4, [r4]
          str r5, [r4, #12] @store r5(total) in the address r4+16


          ldr r0, =msg8     @print("*End Print*")
          bl printf

          ldmfd sp!,{lr}
          mov pc, lr        @return address

ID:   stmfd sp!,{lr}
      ldr r1, =array_ads
      str r0, [r1]

      cmp r5, #0             @if r5 != 0
      movne r5, #0           @then set r5 = 0

      @ldr r4, =destion       @load destion address in r4
      ldr r0, =msg1          @print("*Input ID*\n")
      bl  printf

      ldr r0, =msg2          @print("*Enter ID 1*\n")
      bl  printf

      ldr r0, =scanf_id1     @load scanf_id1 address in r0
      ldr r1, =scanf_word    @load scanf_word address in r1
      bl scanf               @scanf("%d", &scanf_word ),input ID1
      ldr r1, =scanf_word
      ldr r1,[r1]            @load r1 with word at the address in r1
      add r5, r5, r1         @add r1 t0 r5
      @str r1, [r4]           @store word(ID1) in r1 at the address r4

      ldr r4, =array_ads     @load array_ads address in r4
      ldr r4, [r4]           @load r4 with word at the address in r4
      str r1, [r4]           @store word(ID1) in r1 at the address r4


      ldr r0, =msg3
      bl  printf             @print("*Enter ID 2*\n")

      ldr r0, =scanf_id2     @load scanf_id2 address in r0
      ldr r1, =scanf_word    @load scanf_word address in r1
      bl scanf               @scanf("%d", &scanf_word ),input ID2
      ldr r1, =scanf_word
      ldr r1,[r1]            @load r1 with word at the address in r1
      add r5, r5, r1         @add r1 t0 r5
      str r1, [r4, #4]       @store word(ID2) in r1 at the address (r4+4)


      ldr r0, =msg4          @print("*Enter ID 3*\n")
      bl  printf

      ldr r0, =scanf_id3     @load scanf_id3 address in r0
      ldr r1, =scanf_word    @load scanf_word address in r1
      bl scanf               @scanf("%d", &scanf_word ),input ID3
      ldr r1, =scanf_word
      ldr r1,[r1]            @load r1 with word at the address in r1
      adds r5, r5, r1        @add r1 t0 r5 and set CPSR
      strpl r1, [r4, #8]     @if N clear,store ID3 in the address r4+8


      ldr r0, =msg5
      bl  printf             @print("*Enter Command*\n")

      ldr r1, =p             @load p address in r1
      ldr r1, [r1]
      str r1, [r4, #16]      @store r1(value "p") in r4+12

      ldr r0, =scanf_command @load scanf_command address in r0
      ldr r1, =p             @load p address in r1
      bl scanf               @scanf("%s", p),input command
      ldr r1, =p
      ldr r1, [r1]           @load input cmd in r1


      ldr r7, [r4, #16]      @load r7 at the address (r4+12)("p")
      cmp r1, r7             @compare if the input cmd is "p"

      ldreq r0, =msg6        @if (cmd == "p"),print msg6
      bleq  printf
      bleq  continue         @if (cmd == "p"), branch to continue
      blne  error            @else print error msg

      @ldr r4, =destion       @load destion address in r4
      ldmfd sp!,{lr}
      mov pc, lr


