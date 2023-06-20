.data
result: .asciz "%d"
cx: .word 0
cy: .word 0
width: .word 0
height: .word 0
frame_ads: .word 0

localvb_ads: .word 0
quotient: .word 0

num1 : .word 750
num2 : .word 1500
num3 : .word 1000
num4 : .word 4000000
num5 : .word 0xffff
num6 : .word 0xff
num7 : .word 1280


.equ color, 0
.equ maxIter, 2
.equ zx, 6
.equ zy, 10
.equ tmp, 14
.equ i, 18
.equ x, 22
.equ y, 26
.equ size, 30



.text
.globl drawJuliaSet
.type drawJuliaSet, %function

init :    stmfd sp!, {lr}

          ldr r4, =cx
          str r0, [r4]     @store cx in memory

          mov r5, r0        @r5 = cx
          mov r9, r1        @r9 = cy
          mov r0, r11       @r0 = fp
          mov r1, #8        @r1 = 8
          sbcs r11, r0, r1  @r11=r0-r1+carry bit - 1, and set CPSR
          ldr r1, [r11]     @load r1 at address r11

          ldr r4, =cy
          str r1, [r4]     @store cy in memory

          mov r0, r5        @r0 = cX
          mov r1, r9        @r1 = cY
          add r11, r11, #8  @restore r11 to original value

          ldr r4, =width
          str r2, [r4]     @store width in memory

          ldr r4, =height
          str r3, [r4]     @store height in memory

          ldr r4, =frame_ads
          ldr r5, [sp, #8]
          str r5, [r4]     @store frame address in memory

          ldmfd sp!,{lr}
          mov pc, lr

div_width_n :  stmfd sp!, {lr}
               mov r5, #0       @r5 is quotient

loop_wn :      add r9, r9, r2   @r9 = r9 + (width>>1)
               cmp r9, #0       @compare whether r9 <= 0
               suble r5, r5, #1 @if true, r5--
               ble loop_wn      @if true, branch to loop_wn

               mov r9, #-1
               cmp r9, #0       @let program not to branch to div_width_p
               ldmfd sp!, {lr}
               mov pc, lr

div_width_p :  stmfd sp!, {lr}
               mov r5, #0       @r5 is quotient

loop_wp :      sub r9, r9, r2   @r9 = r9 - (width>>1)
               cmp r9, #0       @compare whether r9 >= 0
               addge r5, r5, #1 @if true, r5++
               bge loop_wp      @if true, branch to loop_wp

               ldmfd sp!, {lr}
               mov pc, lr

div_height_n : stmfd sp!, {lr}
               mov r5, #0        @r5 is quotient
loop_n :       add r9, r9, r3    @r9 = r9 + (height>>1)
               cmp r9, #0        @compare whether r9 <= 0
               suble r5, r5, #1  @if true, r5--
               ble loop_n        @if true, branch to loop_n

               mov r9, #-1
               cmp r9, #0        @let program not to branch to div_height_p
               ldmfd sp!, {lr}
               mov pc, lr

div_height_p : stmfd sp!, {lr}
               mov r5, #0         @r5 is quotient
loop_p :       sub r9, r9, r3     @r9 = r9 - (height>>1)
               cmp r9, #0         @compare whether r9 >= 0
               addge r5, r5, #1   @if true, r5++

               bge loop_p         @if true, branch to loop_p

               ldmfd sp!, {lr}
               mov pc, lr

div_thousand_n : stmfd sp!, {lr}
                 mov r0, #0        @r0 is quotient
                 ldr r1, =num3
                 ldr r1, [r1]      @r1 = 1000
loop_tn :        add r9, r9, r1    @r9 = r9 + 1000
                 cmp r9, #0        @compare whether r9 <= 0
                 suble r0, r0, #1  @if true, r5--
                 ble loop_tn       @if true, branch to loop_tn

                 ldr r1, = quotient
                 str r0, [r1]       @store result in quotient

                 cmp r9, #0
                 movge r9, #-1      @let program not to branch to div_height_p

                 cmp r9, #0
                 ldmfd sp!, {lr}
                 mov pc, lr

div_thousand_p : stmfd sp!, {lr}
                 mov r0, #0       @r0 is quotient
                 ldr r1, =num3
                 ldr r1, [r1]     @r1 = 1000
loop_tp   :      sub r9, r9, r1   @r9 = r9 - 1000
                 cmp r9, #0       @compare whether r9 >= 0
                 addge r0, r0, #1 @if true, r0++
                 bge loop_tp      @if true, branch to loop_tp


                 ldr r1, = quotient
                 str r0, [r1]        @store result in quotient

                 ldmfd sp!, {lr}
                 mov pc, lr

while :          stmfd sp!, {lr}
loop_while :     sub r9, r4, r5       @r9 = zx*zx-zy*zy
                 cmp r9, #0           @compare r9 is negative or positive
                 bllt div_thousand_n  @if (r9<0), branch t0 div_thousand_n
                 blge div_thousand_p  @if (r9>=0), branch t0 div_thousand_n

                 ldr r0, =quotient
                 ldr r0, [r0]         @r0 =(zx * zx - zy * zy)/1000

                 ldr r1, =cx
                 ldr r1, [r1]         @r1 = cX

                 add r0, r0, r1       @r0 = tmp = (zx * zx - zy * zy)/1000 +cX

                 ldr r9, =localvb_ads
                 ldr r9, [r9]
                 add r9, r9, #tmp
                 str r0, [r9]         @store tmp in memroy


                 ldr r9, =localvb_ads
                 ldr r9, [r9]
                 add r9, r9, #zx
                 ldr r4, [r9]         @r4 = zx


                 ldr r9, =localvb_ads
                 ldr r9, [r9]
                 add r9, r9, #zy
                 ldr r5, [r9]         @r5 = zy



                 mul r0, r4, r5     @r0 = zx * zy
                 add r9, r0, r0     @r9 = 2 * zx * zy

                 cmp r9, #0           @compare r9 is negative or positive
                 bllt div_thousand_n  @if (r9<0), branch t0 div_thousand_n
                 blge div_thousand_p  @if (r9>=0), branch t0 div_thousand_n

                 ldr r0, =quotient
                 ldr r0, [r0]       @ r0 = (2 * zx * zy)/1000

                 ldr r1, =cy
                 ldr r1, [r1]       @r1 = cY

                 add r0, r0, r1     @r0 = zy = (2 * zx * zy)/1000 + cY
                 mov r5, r0         @r5 = zy

                 ldr r9, =localvb_ads
                 ldr r9, [r9]
                 add r9, r9, #zy
                 str r5, [r9]       @store zy in memroy


                 ldr r9, =localvb_ads
                 ldr r9, [r9]
                 add r9, r9, #tmp
                 ldr r1, [r9]       @r1 = tmp

                 ldr r9, =localvb_ads
                 ldr r9, [r9]
                 add r9, r9, #zx
                 str r1, [r9]       @store zx in memory, zx = tmp

                 mov r4, r1         @r4 = zx = tmp
                 sub r12, r12, #1   @i--

                 ldr r0, =num4
                 ldr r0, [r0]       @r0 = 4000000

                 mul r4, r4, r4     @r4 = zx*zx
                 mul r5, r5, r5     @r5 = zy*zy
                 add r9, r4, r5     @r9 = zx*zx+zy*zy

                 cmp r9, r0         @compare whether r9 < 4000000
                 bge while_exit     @if r9 >= 4000000, branch to while_exit
                 cmp r12, #0        @compare whether i > 0
                 bgt loop_while     @if i > 0, branch to loop_while

 while_exit :    ldmfd sp!, {lr}
                 mov pc, lr



drawJuliaSet :   stmfd sp!, {lr}

                 bl init             @store cx, cy, width, height, frame in memory

                 sub sp, sp, #size

                 ldr r5, =localvb_ads @store sp in localvb_ads
                 str sp, [r5]

                 mov r7, #0          @r7 = x = 0


loop1 :          cmp r8, #0
                 movne r8, #0        @y = 0

                 cmp r8, r3          @compare whether y < height
                 blt loop2           @true, go to 1oop2
                 bge first_for_end   @no loop2,go to end loop1

loop2 :          mov r2, r2, lsr #1  @width >> 1
                 sub r9, r7, r2      @x-width>>1

                 ldr r4, = num2     @r4 = 1500
                 ldr r4, [r4]
                 mul r9, r9, r4     @1500(x-width>>1)

                 cmp r9, #0
                 bllt div_width_n  @r9 < 0
                 blge div_width_p  @r9 >= 0

                 ldr r4, =localvb_ads
                 ldr r4, [r4]
                 add r4, r4, #zx
                 str r5, [r4]       @store zx in memory


                 mov r3, r3, lsr #1 @height >> 1
                 sub r9, r8, r3     @y-height>>1

                 ldr r4, =num3
                 ldr r4, [r4]       @r4 = 1000
                 mul r9, r9, r4     @1000*(y-height>>1)

                 cmp r9, #0         @compare whether r9 < 0

                 bllt div_height_n  @r9 < 0
                 blge div_height_p  @r9 >= 0



                 ldr r4, =localvb_ads
                 ldr r4, [r4]
                 add r4, r4, #zy
                 str r5, [r4]       @store zy in memory
                                    @r5 = zy


                 ldr r4, =localvb_ads
                 ldr r4, [r4]
                 add r4, r4, #zx
                 ldr r4, [r4]       @r4 = zx

                 mov r12, #255      @r12 = i = 255

                 ldr r0, =num4
                 ldr r0, [r0]       @r0 = 4000000


                 mul r4, r4, r4     @r4 = zx*zx
                 mul r5, r5, r5     @r5 = zy*zy
                 add r9, r4, r5     @r9 = zx*zx+zy*zy

                 cmp r9, r0           @compare whether r9 < 4000000
                 bge second_for_end   @if r9 >= 4000000, branch to second_for_end
                 cmplt r12, #0        @compare whether i > 0
                 blgt while           @if i > 0, branch to while

second_for_end : ldr r1, =num6
                 ldr r1, [r1]         @r1 = 0xff
                 and r0, r12, r1      @r0 = i&0xff
                 mov r1, r0, lsl #8   @r1 = (i&0xff) << 8
                 orr r4, r1, r0       @r4 = r1|r0
                 mvn r4, r4           @~r4

                 ldr r9, =num5
                 ldr r9, [r9]         @r9 = 0xffff
                 and r0, r4, r9       @r0 = (~r4)&0xffff
                                      @r0 = color

                 ldr r4, =num7
                 ldr r4, [r4]
                 mul r9, r8, r4       @ r9 = y * 1280

                 mov r4, #2
                 mul r5, r7, r4       @ r5 = x * 2


                 add r1, r5, r9     @ r1 = r5 + r9


                 ldr r4, =frame_ads
                 ldr r4, [r4]
                 add r4, r4, r1
                 strh r0, [r4]         @store r0 in frame[y][x]

                 add r8, r8, #1        @y++

                 ldr r3, =height
                 ldr r3, [r3]          @r3 = height value

                 ldr r2, =width
                 ldr r2, [r2]          @r2 = width value

                 cmp r8, r3            @compare whether y < height
                 blt loop2             @if true, branch to loop2

first_for_end :  add r7, r7, #1        @x++
                 ldr r2, =width
                 ldr r2, [r2]         @r2 = width value
                 cmp r7, r2           @compare whether x < width
                 blt loop1            @if true, branch to loop1


exit :
                 add sp, sp, #size    @restore sp to original value
                 ldmfd sp!,{lr}
                 mov pc, lr


