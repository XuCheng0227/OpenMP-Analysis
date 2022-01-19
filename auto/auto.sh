touch output.txt
path=./output.txt

# excute for each schedule scheme
# use >> to append instead of redirect(override)

printf "" > $path # override all

printf "\nstatic\n" >> $path
export OMP_SCHEDULE="static"
srun --cpu-bind=cores ./loops >> $path

printf "\nauto\n" >> $path
export OMP_SCHEDULE="auto"
srun --cpu-bind=cores ./loops >> $path

printf "\nstatic,n\n" >> $path
for i in {1,2,4,8,16,32,64}
do
  printf "\nstatic,$i\n" >> $path
  export OMP_SCHEDULE="static,$i"
  srun --cpu-bind=cores ./loops >> $path
done

printf "\ndanamic\n" >> $path
for i in {1,2,4,8,16,32,64}
do
  printf "\ndynamic,$i\n" >> $path
  export OMP_SCHEDULE="dynamic,$i"
  srun --cpu-bind=cores ./loops >> $path
done

printf "\nguided,n\n" >> $path
for i in {1,2,4,8,16,32,64}
do
  printf "\nguided,$i\n" >> $path
  export OMP_SCHEDULE="guided,$i"
  srun --cpu-bind=cores ./loops >> $path
done
