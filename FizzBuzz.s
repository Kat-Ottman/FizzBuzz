            .text
            .align  2
            .global main


main:       //preserve registers for later
            stp     x29, x30, [sp, -16] !
            stp     x20, x21, [sp, -16] !
            stp     x22, x23, [sp, -16] !
            stp     x24, x25, [sp, -16] !


            mov     x20, 0

top:
            cmp     x20, 100            //compare i with 100
            bge     bottom              //if equal, go to bottom
            mov     x21, 0              //reset pflag
            mov     x23, 3              //what to divide by
            mov     x1, x20
            udiv    x22, x20, x23       //divide i by 3 and store in x22
            msub    x24, x22, x23, x20  //multiply % by 3 and subtract i, put into x24
            cmp     x24, 0              //check if num is divisible by 3
            beq     div_by_3            //jump if equal to go to placeholder
            mov     x23, 5              //(else) what to divide by
            udiv    x22, x20, x23       //divide i by 5 and store in x22
            msub    x24, x22, x23, x20  //multiply % by 5 and subtract i, put into x24
            cmp     x24, 0              //compare x24 and 0    
            beq     div_by_5            //jump if equal go to div_by_5
            ldr     x0, =fmt           //put i into x0
            bl      printf              //print i; not divisible by 3 or 5
            ldr     x0, =nl             //put /n into x0
            bl      printf              //print /n
            add     x20, x20, 1         //increment i
            b       top 


div_by_3:                               //is divisible by 3
            mov     x21, 1
            mov     x23, 5              //(else) what to divide by
            udiv    x22, x20, x23       //divide i by 5 and store in x22
            msub    x24, x22, x23, x20  //multiply % by 5 and subtract i, put into x24
            cmp     x24, 0
            beq     div_by_5            //jump if equal go to div_by_5  
            ldr     x0, =fizz           //put "fizz" into x0
            bl      printf              //print "fizz"; only divisble by 3
            ldr     x0, =nl             //put /n into x0
            bl      printf              //print /n
            add     x20, x20, 1         //increment i
            b       top

   div_by_5:                               //is divisible by 5
            cmp     x21, 1              //compare x21 with one to see if also divisible by 3
            beq     print_fizzbuzz      //if equal, go to print_fizzbuzz
            ldr     x0, =buzz            //put "buzz" into x0
            bl      printf              //print "buzz"; only divisible by 5
            ldr     x0, =nl             //put /n into x0
            bl      printf              //print /n  
            add     x20, x20, 1         //increment i
            b       top 

  print_fizzbuzz:
            ldr     x0, =fizz           //put "fizz" into x0
            bl      printf              //print "fizz"; divisible by 3
            ldr     x0, =buzz           //put "buzz" into x0
            bl      printf              //print "fizz"; divisible by 5
            ldr     x0, =nl             //put /n into x0
            bl      printf              //print /n 
            add     x20, x20, 1         //increment i
            b       top  


            #Dictionary:
            #   x20     as i
            #   x21     as pflag
            #   x23     as 3
            #   x24     as mod answer
            #   x25     as what to print

            #restore registers
bottom:     //gap

            ldp     x24, x25, [sp], 16   //must restore registers in reverse order because of stack
            ldp     x22, x23, [sp], 16
            ldp     x20, x21, [sp], 16
            ldp     x29, x30, [sp], 16
            mov     x0, xzr 
            ret

            .data


fizz:       .asciz  "Fizz"
buzz:       .asciz  "Buzz"
nl:         .asciz  "\n"
fmt:        .asciz  "%d"
pass:       .asciz  "pass"

            .end