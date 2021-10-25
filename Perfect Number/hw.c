#include <stdio.h>

int floorSqrt(int x)
{
    for(long int i=0;i<=x;i++)                     
        if(((i+1)*(i+1)) > x)                            #find the first i+1 value, which (i+1)^2 is greater than the target number and return i
            return i;
    return 0;
}

int checkPerfectNumber(int num) {
    if ((num & 1 == 1) || (num < 2)) {
        return 0;
    }

    int sum_factor = 1;                                  #1 is factor for every number, so we preadd it to the sum, and start i in the below for loop from 2

    for (int i = 2; i < floorSqrt(num) + 1; i++) {       #find factor of the number (the maximum i number doesnt need to exceed floorSqrt(num))
        
        if (num % i == 0) {                              #remainder is 0 =>factor of num
            sum_factor += i;                             #add the factor and its pair factor to sum
            sum_factor += num / i;                    
        }
    }

    if (sum_factor == num){                              #if sum equals to original number, it is a perfect number and return True(1)
        return 1;
    }
    else
    {
        return 0;
    }
}
 
int main(void)                                           #main
{
    int n=28;                                            #set variable
    printf("1 is True, 0 is False:%d",checkPerfectNumber(n));
}