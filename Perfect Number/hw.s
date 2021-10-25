.data
str1:   .string "\n 1 is Perfect Number, 0 is not ==> "     #String to print
num: .word 28                                       #Set int equals to 28

.text
main:
    lw a0,num                                       #set value into a0
    jal ra,checkPerfectNumber                       #jump to the checkPerfectNumber tag and link return address to next line
    la a0,str1                                      #set string value into output string for print                              
    li a7,4
    ecall
    mv a0,a1                                        #set result value into output string for print
    li a7,1
    j Exit                                          #jump to Exit tag to end the program

floorSqrt:
    add a7,zero,zero                                #j=0 (use register a7)
    Loopfs:
    bgt a7,a0,Donefs                                #j>n, condition of exiting for loop(didnt trigger the if statement inside)
    addi t1,a7,1                                    #j+1
    mul t1,t1,t1                                    #(j+1)*(j+1)
    bgt t1,a0,DoneIf                                #(j+1)*(j+1)>num, if statement is True, jump to tag Doneif and return the value j
    addi a7,a7,1                                    #j++ in for loop
    j Loopfs                                        #keep for loop running
    Donefs:
    add a7,zero,zero                                #a7=0 (a7 is floorSqrt(num) value)
    j Exitfs                                        #jump to exit tag of the floorsqrt function(a7=0)
    DoneIf:                                         #when (j+1)*(j+1)>num
    add a7,a7,zero                                  #assign a7 as j
    Exitfs:
    jr ra                                           #back to line 47(Loop tag)

checkPerfectNumber:
   addi a3,zero,1                                   #assign sumfactor=1
   mv t2, a0                                        #assign parameter num value into t2 register
   andi t0,t2,1                                     #see if num is odd (num&1), because odd number can't be perfect number
   bne t0,zero,check                                #num & 1!=0(t0=1 is odd number, so jump back to)
   slti t0,a0,2                                     #num<2 (t0=1)
   beq t0,zero,calc                                 #num>=2
   check:
   add a1,zero,zero                                 #set a1=0(register a1 is 1 or 0, representing the result True or False)
   jr ra                                            #jump back to line 9(return address preserve by line 8 jal)
   calc:                                            #if statement is false
   addi a2,zero,2                                   #set i=2 in register a2
   addi sp,sp,-4                                    #preserve return address of line 9, because we are going to use another function which will overwrite the previous ra, so have to save the old address into stack
   sw ra,0(sp)                                      #save ra value into stack
   jal floorSqrt                                    #prepare the floorSqrt value for the for loop
   Loop:
   bge a2,a7,Donecpn                                #a7 is sqrt value, compare with i(a2)
   rem t1,a0,a2                                     #get num%i value into t1
   bne t1,zero,notDv                                #if statement num%i!=0(t1 equal to 1 means we have to skip the calculation in if)
   add a3,a3,a2                                     #sumfactor+=i
   div t1,a0,a2                                     #num/i
   add a3,a3,t1                                     #sumfactor+=num/i
                                                    #get the current sum in variable sumfactor(a3)
   notDv:                                           #tag to skip the calculation in if statement
   addi a2,a2,1                                     #i++
   j Loop                                           #keep the for loop going
 
   Donecpn:                                         #tag for exit for loop
   lw ra,0(sp)                                      #load line 9 address back
   addi sp,sp,4                                     #resume the stack pointer
   ResultTrue:
   bne a3,a0,ResultFalse                            #check if sumfactor(a3) equals to num(a0)
   addi a1,zero,1                                   #a1=1(result is True)
   ret
   ResultFalse:
   add a1,zero,zero                                 #a1=0(result is False)
   ret
Exit:
    ecall