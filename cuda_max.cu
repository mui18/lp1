#include<stdio.h>
#define SIZE 100

__global__
	void max(int *a,int *b,int *c)
	{
		int i = blockIdx.x*blockDim.x + threadIdx.x;
		int id;
		
		switch(i)
		{
			case 0:
				
				for(id = 0 ; id<SIZE/10 ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			break;			
			case 1:
			
			
				for(id = SIZE/10 ; id<(SIZE/10)+10 ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			
			break;
			case 2:
			
			
				for(id = (SIZE/10)+10 ; id< (SIZE/10)+20 ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			
			break;
			case 3:
			
			
				for(id = (SIZE/10)+20 ; id< (SIZE/10)+30 ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			
			break;
			case 4:
			
				
				for(id = (SIZE/10)+30 ; id<(SIZE/10)+40  ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			
			break;
			case 5:
			
			
				for(id = (SIZE/10)+40 ; id<(SIZE/10)+50  ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			break;
			case 6:
			
			
				for(id = (SIZE/10)+50 ; id< (SIZE/10)+60 ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			break;
			case 7:
			
				
				for(id =(SIZE/10)+60 ; id< (SIZE/10)+70 ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			break;
			case 8:
			
				for(id =(SIZE/10)+70 ; id< (SIZE/10)+80 ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			
			break;
			case 9:
					
				for(id =(SIZE/10)+80 ; id<(SIZE/10)+90  ; id++)
					{
						if(a[id] >	c[i])
							c[i] = a[id];
							
					}
				b[i] = c[i];
			
			break;
			
			}
		
	}
	
	__global__
	void max2(int *a , int *b , int *c)
	{
		
	int i = blockIdx.x*blockDim.x + threadIdx.x;
	int big=-9999,big2 = -9999;
	int id;
	

	if ( i==0 )
	{
	
		
		for(id =0 ; id<5 ; id++)
					{
		
						if(a[id] >	big)
							big = a[id];
							
					}
				*b = big;
	
		
		
	}
		
	if(i==1)
	{
		for(id =5 ; id<10 ; id++)
					{
						if(a[id] >	big2)
							big2 = a[id];
							
					}
				*c = big2;
		
		
		
	}
		
		
	}



int main()
{
	int a[100],b=0,c=0,i,big[10],big2[10];
	int *d_a,*d_b,*d_c,*d_d,*d_one,*d_two;
	
	
	for(i=0;i<SIZE;i++)
		{
			a[i] = rand();
			
			}	
		
		
			for(i=0;i<SIZE/10;i++)
			{
				big[i] = 0;
				big2[i] = -9999;
			
			}	
			
	printf("\n\tPrinting Array : ");		
	for(i=0;i<SIZE;i++)
		printf("\n%d",a[i]);
		
	cudaMalloc(&d_a,SIZE*sizeof(int));
	cudaMemcpy(d_a,a,SIZE*sizeof(int),cudaMemcpyHostToDevice);
	
	cudaMalloc(&d_b,SIZE*sizeof(int));
	cudaMemcpy(d_b,big,SIZE*sizeof(int),cudaMemcpyHostToDevice);
	
	cudaMalloc(&d_c,SIZE*sizeof(int));
	cudaMemcpy(d_c,big2,SIZE*sizeof(int),cudaMemcpyHostToDevice);
	
	max<<<1,10>>>(d_a,d_b,d_c);
	cudaDeviceSynchronize();
	
	cudaMemcpy(big,d_b,SIZE*sizeof(int),cudaMemcpyDeviceToHost);
	
	printf("\n\n\tPrinting Max elements among array of 100 : ");
	
	for(i=0;i<SIZE/10;i++)
		printf("\n\t%d",big[i]);
	
	cudaMalloc(&d_d,10*sizeof(int));
	cudaMemcpy(d_d,big,10*sizeof(int),cudaMemcpyHostToDevice);
	
	cudaMalloc((void**)&d_one,sizeof(int));
	cudaMalloc((void**)&d_two,sizeof(int));
	
	
	max2<<<1,2>>>(d_d,d_one,d_two);
	cudaDeviceSynchronize();
	
	cudaMemcpy(&b,d_one,sizeof(int),cudaMemcpyDeviceToHost);
	
	
	cudaMemcpy(&c,d_two,sizeof(int),cudaMemcpyDeviceToHost);
	
	
	if(b>c)
		printf("\n\tMax = %d",b);
	else
		printf("\n\tMax = %d",c);
				
}