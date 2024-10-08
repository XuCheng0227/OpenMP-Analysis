#include <stdio.h>
#include <math.h>
#include <omp.h>

#include "affinity.h"

#define N 1729
#define reps 1000
double a[N][N], b[N][N], c[N];
int jmax[N];


void init1(void);
void init2(void);
void runloop(int);
void loop1chunk(int, int);
void loop2chunk(int, int);
void valid1(void);
void valid2(void);


int main(int argc, char *argv[]) {

  double start1,start2,end1,end2;
  int r;

  init1();

  start1 = omp_get_wtime();

  for (r=0; r<reps; r++){
    runloop(1);
  }

  end1  = omp_get_wtime();

  valid1();

  printf("Total time for %d reps of loop 1 = %f\n",reps, (float)(end1-start1));


  init2();

  start2 = omp_get_wtime();

  for (r=0; r<reps; r++){
    runloop(2);
  }

  end2  = omp_get_wtime();

  valid2();

  printf("Total time for %d reps of loop 2 = %f\n",reps, (float)(end2-start2));

}

void init1(void){
  int i,j;

  for (i=0; i<N; i++){
    for (j=0; j<N; j++){
      a[i][j] = 0.0;
      b[i][j] = 1.618*(i+j);
    }
  }

}

void init2(void){
  int i,j, expr;

  for (i=0; i<N; i++){
    expr =  i%( 4*(i/60) + 1);
    if ( expr == 0) {
      jmax[i] = N/2;
    }
    else {
      jmax[i] = 1;
    }
    c[i] = 0.0;
  }

  for (i=0; i<N; i++){
    for (j=0; j<N; j++){
      b[i][j] = (double) (i*j+1) / (double) (N*N);
    }
  }

}

void runloop(int loopid)  {
  local_set** local_sets = NULL;
  chunk** chunks = NULL;
  int flag;
  int n;

#pragma omp parallel default(none) shared(n, loopid, local_sets, chunks) private(flag)
  {
    int myid  = omp_get_thread_num();
    int nthreads = omp_get_num_threads();

    #pragma omp single
    {
      local_sets = local_set_storage_init(nthreads, N);
      n = nthreads;
    }
    #pragma omp barrier

    #pragma omp single
    {
      chunks = chunk_storage_init(nthreads);
    }
    #pragma omp barrier

    do {
      flag = assign_work(local_sets, chunks, myid, nthreads);
      switch (loopid) {
         case 1:
         if (flag) {
           loop1chunk(get_chunk_low(chunks[myid]),get_chunk_high(chunks[myid]));
         }
         break;
         case 2:
         if (flag) {
           loop2chunk(get_chunk_low(chunks[myid]),get_chunk_high(chunks[myid]));
         }
         break;
         #pragma omp barrier
        }
    } while(flag);

    #pragma omp barrier
   }
    free_heap(local_sets, chunks, n);
}


void loop1chunk(int lo, int hi) {
  int i,j;
  for (i=lo; i<=hi; i++){
    for (j=N-1; j>i; j--){
      a[i][j] += cos(b[i][j]);
    }
  }

}



void loop2chunk(int lo, int hi) {
  int i,j,k;
  double rN2;
  rN2 = 1.0 / (double) (N*N);

  for (i=lo; i<=hi; i++){
    for (j=0; j < jmax[i]; j++){
      for (k=0; k<j; k++){
	c[i] += (k+1) * log (b[i][j]) * rN2;
      }
    }
  }

}


void valid1(void) {
  int i,j;
  double suma;

  suma= 0.0;
  for (i=0; i<N; i++){
    for (j=0; j<N; j++){
      suma += a[i][j];
    }
  }
  printf("Loop 1 check: Sum of a is %lf\n", suma);

}


void valid2(void) {
  int i;
  double sumc;

  sumc= 0.0;
  for (i=0; i<N; i++){
    sumc += c[i];
  }
  printf("Loop 2 check: Sum of c is %f\n", sumc);
}
