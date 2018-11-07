#include<stdio.h>
extern int mulby4(int);
extern void printXtimes(int, int);
extern int getRandNum(int);
extern int getMax(int, int, int, int, int, int);

int main()
{
    int returnValue;
    int loop;

    printf("\n\nHello World of Assembly, c speaking\n\n");
    printf("Testing: mulby4 with 3\n");
    printf("mulby4(3);\n");
    returnValue = mulby4(3);
    printf("mulby4(3); returns a %d\n", returnValue);
    
    printf("\nTAesting: printXtimes with 3,3\n");
    printXtimes(3,3);
    printf("\n");

    
    printf("\nTAesting: getRandNum with 16 10 times\n");
    
    for (loop = 0; loop < 10; loop++)
        printf("Loop %d: %d\n", loop, getRandNum(16));


    printf("\nTAesting: getMax\n");

    printf("%d\n", getMax(1,2,3,4,5,6));
    printf("%d\n", getMax(1,12,3,4,5,6));
    printf("%d\n", getMax(1,2,3,18,5,6));
    printf("%d\n", getMax(24,2,3,4,5,6));
    printf("%d\n", getMax(1,2,3,4, 30,6));
    printf("%d\n", getMax(1,2,3,4,5,36));
    printf("%d\n", getMax(1,2,42,4,5,6));
    printf("%d\n", getMax(1,2,3,48,5,6));
    


}

