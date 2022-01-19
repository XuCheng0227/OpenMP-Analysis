#ifndef _AFFINITY_H_
#define _AFFINITY_H_

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <math.h>

typedef struct local_set {
  int id;
  int low;
  int high;
  int length;
  int complete;
  omp_lock_t lock;
}local_set;

typedef struct chunk {
  int low;
  int high;
  int chunksize;
}chunk;

void set_local_set_id(local_set* local_set_instance, int id, int num_threads);

int get_local_set_id(local_set* local_set_instance);

void set_local_set_range(local_set* local_set_instance, int low, int high);

int get_local_set_low(local_set* local_set_instance);

int get_local_set_high(local_set* local_set_instance);

void set_local_set_length(local_set* local_set_instance, int length);

int get_local_set_length(local_set* local_set_instance);

void set_complete(local_set* local_set_instance, int complete);

int get_complete(local_set* local_set_instance);

local_set* local_set_init(int myid, int iterations, int num_threads);

local_set** local_set_storage_init(int num_threads, int iterations);

void set_chunk_range(chunk* chunk_instance, int low, int high);

int get_chunk_low(chunk* chunk_instance);

int get_chunk_high(chunk* chunk_instance);

void set_chunksize(chunk* chunk_instance, int chunksize);

int get_chunksize(chunk* chunk_instance);

chunk** chunk_storage_init(int num_threads);

int find_chunk(local_set* local_set_instance, chunk* chunk_instance, int num_threads, int myid, int steal);

int assign_work(local_set** local_sets, chunk** chunks, int thread_num, int num_threads);

int steal_work(local_set** local_sets, chunk* chunk_instance, int num_threads, int myid);

int find_most_loaded(local_set** local_sets, int num_threads, int num_thread);

void free_heap(local_set** local_sets, chunk** chunks, int num_threads);

#endif
