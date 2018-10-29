#include<stdio.h>


__global__
	void mean(int *a,int *b)
	{
		int id = blockDim.x * blockIdx.x + threadIdx.x;
		
		b[id] += a[id];
	
	}

int main()
{
	int a[100],b[100];
	int i,sum=0;
	int *dev_a,*dev_b;
	
	for(i=0;i<100;i++)
	{
		a[i] = 1;
		b[i] = 1;
		}
	
	
	printf("\n\t Printing Arrays : ");
	
	printf("Array A");
	for(i=0;i<100;i++)
	{
		printf("\n\t %d" ,a[i]);
	}

	printf("Array B");
	for(i=0;i<100;i++)
	{
		printf("\n\t %d" ,b[i]);
	}
	
	cudaMalloc(&dev_a,100*sizeof(int));
	cudaMalloc(&dev_b,100*sizeof(int));

	cudaMemcpy(dev_a,a,100*sizeof(int),cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b,b,100*sizeof(int),cudaMemcpyHostToDevice);
	
	mean<<<1,100>>>(dev_a,dev_b);
	
	cudaMemcpy(&b,dev_b,100*sizeof(int),cudaMemcpyDeviceToHost);
	
	
	for(i=0;i<100;i++)
	{
		
		sum+=b[i];
	}
	
	printf("\n\tSum = %d",sum);
	
	printf("\n\tMean = %d",sum/100);
	
}