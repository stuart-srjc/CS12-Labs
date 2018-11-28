#include<stdio.h>
extern int getStats(char[], long, long*, long*, long*, long*);
extern int getStatsExtended(char[], long, long*, long*, long*, long*, long*, long*);
extern int parameters(char[], long, long*, long*, long*, long*, long*, long*);


int main()
{
    int returnValue;
    int loop;
    char array1[] = {1,2,13,4,5,9,2,3,4,5};
    char array2[] = {7,2,13,4,5,9,2,3,4,5};
    long arraySize=10;
    long max = 3;
    long min = 3;
    long sum = 3;
    long ave = 3;
    long minXmax = 3;
    long maxDmin = 3;

    printf("\n\nHello World of Assembly, c speaking\n\n");

    parameters(array1, arraySize, &max, &min, &sum, &ave, &minXmax, &maxDmin);
    printf("%ld, %ld, %ld, %ld, %ld, %ld\n", max, min, sum, ave, minXmax, maxDmin);

    getStats(array1, arraySize, &max, &min, &sum, &ave);
    printf("Max: %ld, Min: %ld, Sum: %ld, Ave: %ld\n", max, min, sum, ave);
    
    getStatsExtended(array1, arraySize, &max, &min, &sum, &ave, &minXmax, &maxDmin);
    printf("Max: %ld, Min: %ld, Sum: %ld, Ave: %ld, Min x Max: %ld, Max/Min: %ld\n", max, min, sum, ave, minXmax, maxDmin);

    getStatsExtended(array2, arraySize, &max, &min, &sum, &ave, &minXmax, &maxDmin);
    printf("Max: %ld, Min: %ld, Sum: %ld, Ave: %ld, Min x Max: %ld, Max/Min: %ld\n", max, min, sum, ave, minXmax, maxDmin);

 


}

