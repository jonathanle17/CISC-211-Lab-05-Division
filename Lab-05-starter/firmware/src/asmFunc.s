/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    LDR r2,=dividend /*stores r0 into dividend */
    STR r0,[r2]
    
    LDR r3,=divisor /*stores r1 into divisor */
    STR r1,[r3]
    
    mov r8,0 /* register for 0 at r8 */
    
    LDR r5,=quotient /* stores 0 into quotient */
    STR r8,[r5]
    
    LDR r6,=mod /* stores 0 into mod */
    STR r8,[r6]
    
    LDR r7,=we_have_a_problem /* stores 0 into we_have_a_problem */
    STR r8,[r7]
    
    CMP r0,r8 /* checks if dividend is 0 */
    beq error /* if yes */
    CMP r1,r8 /* checks if divisor is 0 */
    beq error /* if yes */
    CMP r0,r1 /* is dividend less than divisor */
    bmi divisor_greater_dividend /* if yes */
    b division_by_subtraction /* if not */
    
error:
    add r8,r8,1
    STR r8,[r7] /* stores 1 into we_have_a_problem */
    LDR r0,=quotient /* address of quotient into r0 */
    b done
    
division_by_subtraction:
    add r8,r8,1 /* add 1 to quotient */
    sub r0,r0,r1 /* subtract dividend by divisor */
    CMP r0,r1 /*is dividend less than divisor */
    bmi divisor_greater_dividend /* if yes */
    b division_by_subtraction /* if not repeat */
    
divsior_greater_dividend:
    STR r8,[r5] /* stores quotient value into address of quotient */
    STR r0,[r6] /* stores dividend after division into mod (remainder) */
    b done 
    
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




