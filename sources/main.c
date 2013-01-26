#include "printA.h"
#include "printB.h"

unsigned char gl_runCnt = 0;

int main(int argc,char* argv[])
{
    char ans = 0;
	
	//gl_runCnt = 0;
	printa();
	printb();
	
//	printf("人为添加一句,测试makefile\n");
	printf("人为添加第二句,测试makefile\n");
	while( (ans != 'n') && (ans != 'N'))
	{
	    printf("Continue?A/B/N:");
		scanf("%c",&ans);
		getchar();
		switch(ans)
		{
		    case 'a':
			case 'A':
			   printa();
			   break;
			   
			case 'b':
   			case 'B':
			   printb();
			   break;
			   
			case 'n':
   			case 'N':
               printf("ERROR\n");
			   break;
			   
			default:
			   break;
		}
		printf("The %d times running A!\n",gl_runCnt);
	}

	return 0;
}