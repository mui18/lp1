#include<stdio.h>
#include<math.h>

__global__
void sub(float *a,float *b,int count,float mean)
{
	int id = blockIdx.x  *  blockDim.x + threadIdx.x;
	
	if(id<count)
	{
		
		b[id] = (a[id]-mean)*(a[id]-mean);
	}
	
}


int main(void)
{
float h_a[10],h_b[10],mean,std_dev=0,var=0;
int i,count=10,sum=0;
float *d_a,*d_b;

for(i=0;i<count;i++)
{
h_a[i] = i;
h_b[i] = 0.0;

}
printf("\n\tPrinting Array: ");

for(i=0;i<count;i++)
{
	printf("\n\t %f  ",h_a[i]);
}



printf("\n\n\tAddition of Array = ");
for(i=0;i<count;i++)
{
	sum+=h_a[i];
}

printf(" %d",sum);

mean = (float)sum/count;

printf("\n\tMean = %f",mean);


cudaMalloc(&d_a,sizeof(int)*count);
cudaMemcpy(d_a,h_a,sizeof(int)*count,cudaMemcpyHostToDevice);

cudaMalloc(&d_b,sizeof(int)*count);
cudaMemcpy(d_b,h_b,sizeof(int)*count,cudaMemcpyHostToDevice);


sub<<<1,10>>>(d_a,d_b,count,mean);

cudaMemcpy(h_b,d_b,sizeof(int)*count,cudaMemcpyDeviceToHost);



for(i=0;i<count;i++)
{
	var+=h_b[i];
}


var = var/(count);

printf("\n\tVariance = %f",var);

std_dev = sqrt(var);

printf("\n\tStandard Deviation = %f",std_dev);

cudaFree(d_a);
cudaFree(d_b);
return 0;

}

