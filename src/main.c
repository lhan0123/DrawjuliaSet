#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>

#define FRAME_WIDTH		640
#define FRAME_HEIGHT	480

#define FRAME_BUFFER_DEVICE	"/dev/fb0"

extern void NAME() ;
extern void ID() ;
extern void drawJuliaSet( int cX, int cY, int width, int height, int16_t (*frame)[FRAME_WIDTH]) ;

int main()
{
    //RGB16
	int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];
	char team[30] ;
    char name1[30] ;
    char name2[30] ;
    char name3[30] ;





	int max_cX = -700;
	int min_cY = 270;

	int cY_step = -5;
	int cX = -700;	// x = -700~-700
	int cY;			// y = 400~270

	int fd;
	int id[5]; //id[0] = id1, id[1] = id2, id[2], =id3, id[3] = totalID, id[4]= (no use)
    char cmd = '0' ;
    printf("Function1: NAME\n") ;
    NAME(team, name1, name2, name3) ;

    printf("Function2: ID\n") ;
    ID(id) ; //call ID function and store the data t0 array

    printf("\nMain Function: \n") ;
    printf("*****Print All***** \n") ;
    printf("%s", team) ;
    printf("%d   %s", id[0], name1) ;
    printf("%d   %s", id[1], name2) ;
    printf("%d   %s", id[2], name3) ;
    printf("ID Summation = %d", id[3]) ;
    printf("\n") ;
    printf("*****End Print***** \n") ;


    printf( "\n***** Please enter p to draw Julia Set animation *****\n" );
    while(getchar()!='p') {}

        system( "clear" );

        fd = open( FRAME_BUFFER_DEVICE, (O_RDWR | O_SYNC) );

        if( fd<0 )
        {	printf( "Frame Buffer Device Open Error!!\n" );	}
        else
        {
            for( cY=400 ; cY>=min_cY; cY = cY + cY_step ) {
                drawJuliaSet( cX, cY, FRAME_WIDTH, FRAME_HEIGHT, frame );

                write( fd, frame, sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH );

                lseek( fd, 0, SEEK_SET );

            }

                printf(".*.*.*.<:: Happy New Year ::>.*.*.*.\n") ;
                printf("by  %s", team) ;
                printf("%d   %s", id[0], name1) ;
                printf("%d   %s", id[1], name2) ;
                printf("%d   %s", id[2], name3) ;

                close( fd );
        }


    while(getchar()!='p') {}


    return 0;
}
