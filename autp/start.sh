echo config env and ouput
#conf  env

module load intel-compilers-19/19.0.0.117

# create output-file

touch output

export OMP_NUM_THREADS=1
# static and auto
echo OK
echo start to run file
echo -n [

sed -in  's/schedule(.*)/schedule(static)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output

echo -n -

sed -in  's/schedule(.*)/schedule(auto)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

# n = 1, 2, 4, 8, 16, 32, 64 


sed -in  's/schedule(.*)/schedule(static,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

sed -in  's/schedule(.*)/schedule(static,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -



sed -in  's/schedule(.*)/schedule(static,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -



sed -in  's/schedule(.*)/schedule(static,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output






export OMP_NUM_THREADS=2
# static and auto


sed -in  's/schedule(.*)/schedule(static)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output

echo -n -

sed -in  's/schedule(.*)/schedule(auto)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

# n = 1, 2, 4, 8, 16, 32, 64 


sed -in  's/schedule(.*)/schedule(static,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

sed -in  's/schedule(.*)/schedule(static,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -



sed -in  's/schedule(.*)/schedule(static,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output




sed -in  's/schedule(.*)/schedule(static,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -



export OMP_NUM_THREADS=4
# static and auto


sed -in  's/schedule(.*)/schedule(static)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output

echo -n -

sed -in  's/schedule(.*)/schedule(auto)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

# n = 1, 2, 4, 8, 16, 32, 64 


sed -in  's/schedule(.*)/schedule(static,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

sed -in  's/schedule(.*)/schedule(static,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -



sed -in  's/schedule(.*)/schedule(static,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output




sed -in  's/schedule(.*)/schedule(static,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output

echo -n -




export OMP_NUM_THREADS=8
# static and auto


sed -in  's/schedule(.*)/schedule(static)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output

echo -n -

sed -in  's/schedule(.*)/schedule(auto)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

# n = 1, 2, 4, 8, 16, 32, 64 


sed -in  's/schedule(.*)/schedule(static,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

sed -in  's/schedule(.*)/schedule(static,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -



sed -in  's/schedule(.*)/schedule(static,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output




sed -in  's/schedule(.*)/schedule(static,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -





export OMP_NUM_THREADS=16
# static and auto


sed -in  's/schedule(.*)/schedule(static)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output

echo -n -

sed -in  's/schedule(.*)/schedule(auto)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

# n = 1, 2, 4, 8, 16, 32, 64 


sed -in  's/schedule(.*)/schedule(static,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

sed -in  's/schedule(.*)/schedule(static,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -



sed -in  's/schedule(.*)/schedule(static,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output




sed -in  's/schedule(.*)/schedule(static,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -




export OMP_NUM_THREADS=32
# static and auto


sed -in  's/schedule(.*)/schedule(static)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output

echo -n -

sed -in  's/schedule(.*)/schedule(auto)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

# n = 1, 2, 4, 8, 16, 32, 64 


sed -in  's/schedule(.*)/schedule(static,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

sed -in  's/schedule(.*)/schedule(static,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -



sed -in  's/schedule(.*)/schedule(static,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output




sed -in  's/schedule(.*)/schedule(static,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -




export OMP_NUM_THREADS=64
# static and auto


sed -in  's/schedule(.*)/schedule(static)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output

echo -n -

sed -in  's/schedule(.*)/schedule(auto)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

# n = 1, 2, 4, 8, 16, 32, 64 


sed -in  's/schedule(.*)/schedule(static,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,1)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -

sed -in  's/schedule(.*)/schedule(static,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,2)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -



sed -in  's/schedule(.*)/schedule(static,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,4)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,8)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,16)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -


sed -in  's/schedule(.*)/schedule(static,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,32)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output




sed -in  's/schedule(.*)/schedule(static,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(dynamic,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -
sed -in  's/schedule(.*)/schedule(guided,64)/g' demo.c
icc -qopenmp demo.c -o demo -lm -O3
./demo >> output
echo -n -]

echo COMPUTE ALL task now start to draw
echo COMPUTE ALL task now start to draw
echo COMPUTE ALL task now start to draw
echo COMPUTE ALL task now start to draw

echo ！！！！！！！！！！！！！！！！！！！！！！
echo ！！！！！！！！！！！！！！！！！！！！！！
echo ！！！！！！！！！！！！！！！！！！！！！！

module load anaconda/python3

python3 ./draw.py





