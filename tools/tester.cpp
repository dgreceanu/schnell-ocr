#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <unistd.h>

#include <highgui.h>
#include <cv.h>
#include <cxcore.h>


#include "ocr.h"


#define ERGEBNIS_LAENGE 100
char ergebnis[ERGEBNIS_LAENGE];

int main(int argc, char *argv[], char *env[])
{
	IplImage *src;
	struct intern_bitmap *bm;

	/* Argumente testen */
	if (argc == 1) {
		printf("usage: \n\t%s <ein Bild>\n",argv[0]);
		return 1;
	}

	/* init OpenCV */
	cvInitSystem(argc, argv);
	
	/* Bild Lesen */
	src = cvLoadImage(argv[1], CV_LOAD_IMAGE_GRAYSCALE);
	if (!src) {
		printf("Error: cvLoadImage()\n");
		return 1;
	}
	
	bm = preprocess(src);
	ocr_bestpassend(bm, ergebnis, ERGEBNIS_LAENGE);
	bm_release(bm);
	
	printf("Ergebnis: %s\n", ergebnis);
	
	/* das original Bild anzeigen */
	cvNamedWindow("Demo Window", CV_WINDOW_AUTOSIZE);
	cvShowImage("Demo Window", src);
	cvWaitKey(-1);
	cvDestroyWindow("Demo Window");

	return 0;
}