    #include <cuda.h>
    #include <stdio.h>
    #include <time.h>

    #define SIZE 10

    __global__ void min(int *a , int *c,int *d)	// kernel function definition
    {
    int i = blockIdx.x * blockDim.x + threadIdx.x;					// initialize i to thread ID
	printf("Thread number= %d",i);
	if(i==0)
	{
	int small=9999;
		int j;
		for(j=0;j<5;j++)
			{

				if(a[j]<small){
					small = a[j];
					}
			}
								*c = small;
					printf("\n\tsmall1 = %d small2 = %d",small,small2);

	}
	
	if(i==1)
	{
		int small2=9999;
			int j;
		for(j=5;j<10;j++)
			{
				
				if(a[j]<small2){
					small2 = a[j];
					}
			}
					*d = small2;
					printf("\n\tsmall1 = %d small2 = %d",small,small2);

	
	}
		

    }

    int main()
    {
    int i;
    srand(time(NULL));		//makes use of the computer's internal clock to control the choice of the seed

    int a[SIZE] = {10,3,6,2,9,1,0,8,5,8};
    int c,d;

    int *dev_a, *dev_c,*dev_d;		//GPU / device parameters

    cudaMalloc((void **) &dev_a, SIZE*sizeof(int));		//assign memory to parameters on GPU from CUDA runtime API
    cudaMalloc((void **) &dev_c, SIZE*sizeof(int));
    cudaMalloc((void **) &dev_d, SIZE*sizeof(int));

    

    /*for( i = 0 ; i < SIZE ; i++)
    {
    	a[i] = j;
    	j--;		// input the numbers
    }*/
    for( i = 0 ; i < SIZE ; i++)
    {
    	printf("\n\t%d", a[i]);			// input the numbers
    }
    
    cudaMemcpy(dev_a , a, SIZE*sizeof(int),cudaMemcpyHostToDevice);		//copy the array from CPU to GPU
    min<<<1,2>>>(dev_a,dev_c,dev_d);										// call kernel function <<<number of blocks, number of threads
    cudaMemcpy(&c, dev_c, SIZE*sizeof(int),cudaMemcpyDeviceToHost);		// copy the result back from GPU to CPU
	cudaMemcpy(&d, dev_d, SIZE*sizeof(int),cudaMemcpyDeviceToHost);

	if(c>d)
	    printf("\nmin =  %d ",d);		
	else
		    printf("\nmin =  %d ",c);


    cudaFree(dev_a);		// Free the allocated memory
    cudaFree(dev_c);
    printf("");

    return 0;
    }
