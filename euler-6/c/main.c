#include <stdio.h>

int main() {
    //Value n to compute - ex. 10 for problem 6.
    int n = 10;
    int soq = 0;
    int sos = 0;

    for (size_t i = 0; i <= n; i++) {
        //compute sum of squares
        soq += (i * i);

        //step 1 of square sum
        sos = sos + i;
    }
    //step 2 of square sum
    sos = sos * sos;

    int sum = sos - soq;

    printf("value: %i - difference: %i \n", n, sum);
    return(0);
}