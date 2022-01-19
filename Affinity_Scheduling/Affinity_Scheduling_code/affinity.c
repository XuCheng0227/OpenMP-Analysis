#include <stdio.h>
#include <stdlib.h>

#include "affinity.h"


void set_local_set_id(local_set* local_set_instance, int id, int num_threads) {
  if (id >= num_threads || id < 0) {
    printf("Invalid id: %d, check it again.\n", id);
  }
  local_set_instance -> id = id;
}

int get_local_set_id(local_set* local_set_instance) {
  return local_set_instance -> id;
}

void set_local_set_range(local_set* local_set_instance, int low, int high) {
  if (low > high + 1) {
    printf("Wrong! The range of the local set must be greater than 0.\n");
    exit(0);
  }
  local_set_instance -> low = low;
  local_set_instance -> high = high;
}

int get_local_set_low(local_set* local_set_instance) {
  return local_set_instance -> low;
}

int get_local_set_high(local_set* local_set_instance) {
  return local_set_instance -> high;
}

void set_local_set_length(local_set* local_set_instance, int length) {
  if (length < -1) {
    printf("The length of the local set must be greater than 0\n");
    exit(0);
  }
  local_set_instance-> length = length;
}

int get_local_set_length(local_set* local_set_instance) {
  return local_set_instance -> length;
}

void set_complete(local_set* local_set_instance, int complete) {
  local_set_instance -> complete = complete;
}

int get_complete(local_set* local_set_instance) {
  return local_set_instance -> complete;
}

local_set* local_set_init(int myid, int iterations, int num_threads) {
  if (iterations < 1) {
    printf("Illegal iterations: The number of iterations must be a non-negative value, but it is %d.\n", iterations);
    exit(0);
  }

  local_set* local_set_instance = (local_set*) malloc(sizeof(local_set));

  omp_init_lock(&(local_set_instance -> lock));
  set_local_set_id(local_set_instance, myid, num_threads);

  int iter_per_size = (int) ceil((double)iterations/(double)num_threads);
  int low = myid*iter_per_size;
  int high = ((myid+1)*iter_per_size > iterations) ? iterations:(myid+1)*iter_per_size -1;

  set_local_set_range(local_set_instance, low, high);
  int length = get_local_set_high(local_set_instance) - get_local_set_low(local_set_instance) + 1;
  set_local_set_length(local_set_instance, length);

  if (get_local_set_length(local_set_instance) == 0) {
    set_complete(local_set_instance, 1);
  }
  else {
    set_complete(local_set_instance, 0);
  }

  return local_set_instance;
}

local_set** local_set_storage_init(int num_threads, int iterations) {
  local_set** local_set_storage = (local_set**) malloc(num_threads*sizeof(local_set*));
  for (int i=0; i < num_threads; i++) {
    local_set* local_set_instance = local_set_init(i, iterations, num_threads);
    local_set_storage[i] = local_set_instance;
  }
  return local_set_storage;
}

void set_chunk_range(chunk* chunk_instance, int low, int high) {
  if (low > high) {
    printf("Wrong! The range of the chunk bust be greater than 0.\n");
    exit(0);
  }
  chunk_instance -> low = low;
  chunk_instance -> high = high;
}

int get_chunk_low(chunk* chunk_instance) {
  return chunk_instance -> low;
}

int get_chunk_high(chunk* chunk_instance) {
  return chunk_instance -> high;
}

void set_chunksize(chunk* chunk_instance, int chunksize) {
  if (chunksize < 0) {
    printf("The length of the chunk must be greater than 0\n");
    exit(0);
  }
  chunk_instance -> chunksize = chunksize;
}

int get_chunksize(chunk* chunk_instance) {
  return chunk_instance -> chunksize;
}

chunk** chunk_storage_init(int num_threads) {
  chunk** chunk_storage = (chunk**) malloc(num_threads*sizeof(chunk*));
  for (int i=0; i < num_threads; i++) {
    chunk* chunk_instance = (chunk*) malloc(sizeof(chunk));
    set_chunksize(chunk_instance, 0);
    set_chunk_range(chunk_instance, 0, 0);
    chunk_storage[i] = chunk_instance;
  }
  return chunk_storage;
}

int find_chunk(local_set* local_set_instance, chunk* chunk_instance, int num_threads, int myid, int steal) {
  if (steal != 1) {
    omp_set_lock(&(local_set_instance -> lock));
  }

  if (get_complete(local_set_instance)) {
    omp_unset_lock(&(local_set_instance -> lock));
    return 0;
  }

  int local_set_length = get_local_set_length(local_set_instance);
  int chunksize;

  if (local_set_length >= num_threads) {
    chunksize = (int) ceil((double)local_set_length/(double) num_threads);
  }
  else {
    chunksize = local_set_length;
  }
  set_chunksize(chunk_instance, chunksize);
  int chunk_low = get_local_set_low(local_set_instance);
  int chunk_high = chunk_low + chunksize - 1;
  set_chunk_range(chunk_instance, chunk_low, chunk_high);

  int local_set_low = get_local_set_low(local_set_instance) + chunksize;
  int local_set_high = get_local_set_high(local_set_instance);
  int length = local_set_high - local_set_low + 1;
  if (length == 0) {
    set_complete(local_set_instance, 1);
  }

  set_local_set_range(local_set_instance, local_set_low, local_set_high);
  set_local_set_length(local_set_instance, length);
  omp_unset_lock(&(local_set_instance -> lock));

  return 1;
}

int assign_work(local_set** local_sets, chunk** chunks, int thread_num, int num_threads) {
  local_set* local_set_instance = local_sets[thread_num];
  chunk* chunk_instance = chunks[thread_num];

  int flag = find_chunk(local_set_instance, chunk_instance, num_threads, thread_num, 0);

  if (!flag) {
    int flag1 = steal_work(local_sets, chunk_instance, num_threads, thread_num);
    return flag1;
  }
  return flag;
}

int steal_work(local_set** local_sets, chunk* chunk_instance, int num_threads, int myid) {

  int most_loaded_set = find_most_loaded(local_sets, num_threads, myid);
  if (most_loaded_set != -1) {
    int a = find_chunk(local_sets[most_loaded_set], chunk_instance, num_threads, myid, 1);
    return a;
  }
  else {
    return 0;
  }
}

int find_most_loaded(local_set** local_sets, int num_threads, int thread_num) {
  local_set* most_loaded_set = NULL;
  local_set* temp_loaded_set = NULL;
  int max_length = 0;
  int temp_length= 0;

  for (int i=0; i < num_threads; i++) {
    if (i == thread_num) {
      continue;
    }
    temp_loaded_set = local_sets[i];
    omp_set_lock(&temp_loaded_set -> lock);
  }
  temp_loaded_set = NULL;

  for (int i=0; i < num_threads; i++) {
    temp_loaded_set = local_sets[i];

    if (get_complete(temp_loaded_set)) {
      continue;
    }

    temp_length = get_local_set_length(temp_loaded_set);
    if (temp_length > max_length) {
      max_length = temp_length;
      most_loaded_set = temp_loaded_set;

    }
  }

  for (int i=0; i < num_threads; i++) {
    if (i == thread_num) {
      continue;
    }
    if (most_loaded_set != NULL) {
      if (i == get_local_set_id(most_loaded_set)) {
        continue;
      }
    }
    temp_loaded_set = local_sets[i];
    omp_unset_lock(&temp_loaded_set -> lock);
  }

  if (max_length == -1) {
    printf("The functionality is wrong, check it again.\n");
    exit(0);
  }

  if (most_loaded_set == NULL) {
    return -1;
  }
  else {
    return get_local_set_id(most_loaded_set);
  }
}

void free_heap(local_set** local_sets, chunk** chunks, int num_threads) {
  for (int i = 0; i < num_threads; i++) {
    local_set* ls = local_sets[i];
    chunk* c = chunks[i];
    omp_destroy_lock(&(ls->lock));
    free(ls);
    free(c);
  }
  free(local_sets);
  free(chunks);
}
