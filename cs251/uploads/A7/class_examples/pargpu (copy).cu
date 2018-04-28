#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>

#define NUM 10000000

#define CUDA_ERROR_EXIT(str) do{\
                                    cudaError err = cudaGetLastError();\
                                    if( err != cudaSuccess){\
                                             printf("Cuda Error: '%s' for %s\n", cudaGetErrorString(err), str);\
                                             exit(-1);\
                                    }\
                             }while(0);
#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))


__device__ void function(int *a,int b)
{
    a[0] = a[0]^b;
    return;
}
__global__ void calculate(int *mem, int num,int skip)
{
      int i = blockDim.x * blockIdx.x + threadIdx.x;
	if(i%(2*skip)!=0) return;
      if(i+skip >= num)
           return;
       int *a = mem+i;
      function(a,a[skip]);
}

int main(int argc, char **argv)
{
    struct timeval start, end, t_start, t_end;
    int i;
    int *ptr;
    int *gpu_mem;   
    unsigned long num = NUM;   /*Default value of num from MACRO*/
    int blocks,seed;

         num = atoi(argv[1]);   /*Update after checking*/
	seed = atoi(argv[2]);
         if(num <= 0)
               num = NUM;
	if(num>=(1<<20)) {
		printf("maxlimit is set to 2^20\n");
		return 0;
	}
	srand(seed);
    /* Allocate host (CPU) memory and initialize*/

    ptr = (int *)malloc(num  * sizeof(int));
    for(i=0; i<num; ++i){
       ptr[i] = rand();
    }
    
    
    gettimeofday(&t_start, NULL);
    
    /* Allocate GPU memory and copy from CPU --> GPU*/

    cudaMalloc(&gpu_mem, num* sizeof(int));
    CUDA_ERROR_EXIT("cudaMalloc");
    cudaMemcpy(gpu_mem, ptr, num  * sizeof(int) , cudaMemcpyHostToDevice);
    CUDA_ERROR_EXIT("cudaMemcpy");
    
    gettimeofday(&start, NULL);
   blocks = num /1024;
    
    if(num % 1024)
           ++blocks;
	for(int i = 0 ; i <21;i++){
	 calculate<<<blocks,1024>>>(gpu_mem, num,1<<i);
	}
    CUDA_ERROR_EXIT("kernel invocation");
    gettimeofday(&end, NULL);
    
    /* Copy back result*/

    cudaMemcpy(ptr, gpu_mem, num  * sizeof(int) , cudaMemcpyDeviceToHost);
    CUDA_ERROR_EXIT("memcpy");
    gettimeofday(&t_end, NULL);
    
    printf("Total time = %ld microsecs Processsing =%ld microsecs\n", TDIFF(t_start, t_end), TDIFF(start, end));
    cudaFree(gpu_mem);

	printf("%d\n",ptr[0]);
     
    free(ptr);
}
