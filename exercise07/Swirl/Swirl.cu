
#include <stdio.h>
#include <math.h>
#include "common.h"
#include "bmp.h"
#include <stdlib.h>
#include <GLUT/glut.h>

#define DIM 512
#define blockSize 8

#define PI 3.1415926535897932f
#define centerX (DIM/2)
#define centerY (DIM/2)

float sourceColors[DIM*DIM];	// host memory for source image
float readBackPixels[DIM*DIM];	// host memory for swirled image

float *sourceDevPtr;			// device memory for source image
float *swirlDevPtr;				// device memory for swirled image

__global__ void swirlKernel( float *sourcePtr, float *targetPtr ) 
{
	int index = threadIdx.x;    
	// TODO: Index berechnen	

	// TODO: Den swirl invertieren.

	targetPtr[index] = sourcePtr[index];    // simple copy
}

void display(void)	
{
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	dim3    blocks(DIM/blockSize,DIM/blockSize);
	dim3    threads(blockSize,blockSize);	

	//: Swirl Kernel aufrufen.
	swirlKernel<<<blocks, threads, 0>>>(sourceDevPtr,swirlDevPtr);
	// Ergebnis zu host memory zuruecklesen.
	CUDA_SAFE_CALL( cudaMemcpy(readBackPixels, swirlDevPtr, DIM * DIM, cudaMemcpyDeviceToHost) );	

	// Ergebnis zeichnen (ja, jetzt gehts direkt wieder zur GPU zurueck...) 
	glDrawPixels( DIM, DIM, GL_LUMINANCE, GL_FLOAT, readBackPixels );

	glutSwapBuffers();
}

// clean up memory allocated on the GPU
void cleanup() {
    CUDA_SAFE_CALL( cudaFree( sourceDevPtr ) ); 
    CUDA_SAFE_CALL( cudaFree( swirlDevPtr ) ); 
}

int main(int argc, char **argv)
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
	glutInitWindowSize(DIM, DIM);
	glutCreateWindow("Simple OpenGL CUDA");
	glutIdleFunc(display);
	glutDisplayFunc(display);

	// load bitmap	
	Bitmap bmp = Bitmap("who-is-that.bmp");
	if (bmp.isValid())
	{		
		for (int i = 0 ; i < DIM*DIM ; i++) {
			sourceColors[i] = bmp.getR(i/DIM, i%DIM) / 255.0f;
		}
	}

	
	CUDA_SAFE_CALL( cudaMalloc((void**)&sourceDevPtr, DIM * DIM )) ;
	CUDA_SAFE_CALL( cudaMalloc((void**)&swirlDevPtr, DIM * DIM )) ;
	CUDA_SAFE_CALL( cudaMemcpy(sourceDevPtr, sourceColors, DIM * DIM , cudaMemcpyHostToDevice) );	
	glutMainLoop();

	cleanup();
}
