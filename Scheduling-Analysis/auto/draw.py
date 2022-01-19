import matplotlib.pyplot as plt
import re
import numpy as np

def parse_file(filename):
    list_static = []
    list_dynamic = []
    list_guided = []
    
    f = open(filename)
    all_str = f.read()  
    pattern_schedule_list = re.compile('schedule(.*)')   
    pattern_time1_list = re.compile(r'(?<=Total time for 1000 reps of loop 1 = )\d+\.?\d*') 
    pattern_time2_list = re.compile(r'(?<=Total time for 1000 reps of loop 2 = )\d+\.?\d*') 
    result_schedule_list = pattern_schedule_list.findall(all_str)      
    result_time1_list = pattern_time1_list.findall(all_str)  
    result_time2_list = pattern_time2_list.findall(all_str)  
    
    
    best_schedule_index1 = -1
    best_time1 = float('inf')
    best_schedule_index2 = -1
    best_time2 = float('inf')
    for index in range(len(result_time2_list)):
        result_time2_list[index] = float(result_time2_list[index])
        if float(result_time2_list[index]) < best_time2:
            best_time2 = float(result_time2_list[index])
            best_schedule_index2 = index
    for index in range(len(result_time1_list)):
        result_time1_list[index] = float(result_time1_list[index])
        if float(result_time1_list[index]) < best_time1:
            best_time1 = float(result_time1_list[index])
            best_schedule_index1 = index
    
    return  best_schedule_index1, \
            best_schedule_index2,  \
            result_time1_list, result_time2_list ,\
            result_schedule_list

if __name__ == '__main__':
    best_schedule_index1, best_schedule_index2, \
        result_time_list_in_loop1, result_time_list_in_loop2, \
            schedule_list  =  parse_file('output')


    best_schedule_in_loop1 = str(pow(2,(int(best_schedule_index1) // 23)))+ " threads " + schedule_list[best_schedule_index1];
    best_schedule_in_loop2 = str(pow(2,(int(best_schedule_index2) // 23)))+ " threads " + schedule_list[best_schedule_index2];
    


    best_schedule_in_loop1_all_threads_list = [] # list by thread num 1,2....
    best_schedule_in_loop2_all_threads_list = [] # list by thread num 1,2....
    best_schedule_in_loop1_index_list = []
    best_schedule_in_loop2_index_list = []



    best_schedule_in_loop1_index_list_first = schedule_list.index(schedule_list[best_schedule_index1])

    for e in range(int(len(schedule_list)/23)):
        best_schedule_in_loop1_index_list.append(best_schedule_in_loop1_index_list_first + 23*e)
    for index in best_schedule_in_loop1_index_list:
        best_schedule_in_loop1_all_threads_list.append(result_time_list_in_loop1[index])
    
    best_schedule_in_loop2_index_list_first = schedule_list.index(schedule_list[best_schedule_index2])
    for e in range(int(len(schedule_list)/23)):
        best_schedule_in_loop2_index_list.append(best_schedule_in_loop2_index_list_first + 23*e)
    for index in best_schedule_in_loop2_index_list:
        best_schedule_in_loop2_all_threads_list.append(result_time_list_in_loop2[index])
    
    #initialize x : 1, 2, 4, 8, 16, 32, 64 can be used for both n threads and n chunksize

    x_list = [1, 2, 4, 8, 16, 32, 64] 
    x = np.array(x_list);

    #initialize speedup list for loop1 and loop2 loop1_speed_up_array and loop2_speed_up_array as Y axis
    Loop1_best_schedule_time = result_time_list_in_loop1[best_schedule_index1]
    Loop2_best_schedule_time = result_time_list_in_loop2[best_schedule_index2]

    loop1_speed_up_array = np.array(best_schedule_in_loop1_all_threads_list)
    loop2_speed_up_array = np.array(best_schedule_in_loop2_all_threads_list)

    loop1_speed_up_array = loop1_speed_up_array/Loop1_best_schedule_time
    loop2_speed_up_array = loop2_speed_up_array/Loop2_best_schedule_time
    
    #initialize describe of the speedup graph
    describe_of_speedup_graph_label_loop1=  schedule_list[best_schedule_index1] + " as the best schedule of Loop1 use " + str(pow(2,(int(best_schedule_index1) // 23)))+ " threads "
    describe_of_speedup_graph_label_loop2=  schedule_list[best_schedule_index2] + " as the best schedule of Loop2 use "+ str(pow(2,(int(best_schedule_index2) // 23)))+ " threads "
    describe_of_speedup_graph_title=  "speed up graph"
    describe_of_speedup_graph_x = "threads"
    describe_of_speedup_graph_y = "speedup"
    #plot speedup graph
    plt.figure()
    plt.plot(x, loop1_speed_up_array, color="blue", linewidth=1, linestyle="-", label=describe_of_speedup_graph_label_loop1)
    plt.plot(x, loop2_speed_up_array, color="red", linewidth=1, linestyle="-", label=describe_of_speedup_graph_label_loop2)
    plt.title(describe_of_speedup_graph_title)
    plt.xticks(x)
    plt.xlabel(describe_of_speedup_graph_x)
    plt.ylabel(describe_of_speedup_graph_y)
    plt.legend(loc = 'upper right')
    plt.savefig('./speedup_pic.jpg')
    print("\n\ndraw ok for speedup_pic.jpg")
    



    #plot execution time vs chunksize graph static n loop1
    loop1_static_n_thread1 = []
    loop1_static_n_thread2 = []
    loop1_static_n_thread4 = []
    loop1_static_n_thread8 = []
    loop1_static_n_thread16 = []
    loop1_static_n_thread32 = []
    loop1_static_n_thread64 = []
    for index in range(7):
        loop1_static_n_thread1.append(result_time_list_in_loop1[2 + index*3])
        loop1_static_n_thread2.append(result_time_list_in_loop1[25 + index*3])
        loop1_static_n_thread4.append(result_time_list_in_loop1[48 + index*3])
        loop1_static_n_thread8.append(result_time_list_in_loop1[71 + index*3])
        loop1_static_n_thread16.append(result_time_list_in_loop1[94 + index*3])
        loop1_static_n_thread32.append(result_time_list_in_loop1[117 + index*3])
        loop1_static_n_thread64.append(result_time_list_in_loop1[140 + index*3])
    loop1_static_n_thread1 = np.array(loop1_static_n_thread1)
    loop1_static_n_thread2 = np.array(loop1_static_n_thread2)
    loop1_static_n_thread4 = np.array(loop1_static_n_thread4)
    loop1_static_n_thread8 = np.array(loop1_static_n_thread8)
    loop1_static_n_thread16 = np.array(loop1_static_n_thread16)
    loop1_static_n_thread32 = np.array(loop1_static_n_thread32)
    loop1_static_n_thread64 = np.array(loop1_static_n_thread64)
    plt.figure()
    plt.plot(x, loop1_static_n_thread1, color="b", linewidth=1, linestyle="-", label="1 threads")
    plt.plot(x, loop1_static_n_thread2, color="g", linewidth=1, linestyle="-", label="2 threads")
    plt.plot(x, loop1_static_n_thread4, color="r", linewidth=1, linestyle="-", label="4 threads")
    plt.plot(x, loop1_static_n_thread8, color="c", linewidth=1, linestyle="-", label="8 threads")
    plt.plot(x, loop1_static_n_thread16, color="m", linewidth=1, linestyle="-", label="16 threads")
    plt.plot(x, loop1_static_n_thread32, color="y", linewidth=1, linestyle="-", label="32 threads")
    plt.plot(x, loop1_static_n_thread64, color="k", linewidth=1, linestyle="-", label="64 threads")
    plt.title("execution time shcedule STATIC N in loop1")
    plt.xlabel("chunksize")
    plt.ylabel("execution time")

    my_y_ticks = np.arange(0, 8, 0.5)
    plt.yticks(my_y_ticks)
    plt.xticks(x)
    plt.legend(loc = 'upper left')
    plt.savefig('./exec_time_static_n_loop1_pic.jpg')

    print("\ndraw ok for exec_time_static_n_loop1_pic.jpg")



    

    #plot execution time vs chunksize graph static n loop2
    loop2_static_n_thread1 = []
    loop2_static_n_thread2 = []
    loop2_static_n_thread4 = []
    loop2_static_n_thread8 = []
    loop2_static_n_thread16 = []
    loop2_static_n_thread32 = []
    loop2_static_n_thread64 = []
    for index in range(7):
        loop2_static_n_thread1.append(result_time_list_in_loop2[2 + index*3])
        loop2_static_n_thread2.append(result_time_list_in_loop2[25 + index*3])
        loop2_static_n_thread4.append(result_time_list_in_loop2[48 + index*3])
        loop2_static_n_thread8.append(result_time_list_in_loop2[71 + index*3])
        loop2_static_n_thread16.append(result_time_list_in_loop2[94 + index*3])
        loop2_static_n_thread32.append(result_time_list_in_loop2[117 + index*3])
        loop2_static_n_thread64.append(result_time_list_in_loop2[140 + index*3])
    loop2_static_n_thread1 = np.array(loop2_static_n_thread1)
    loop2_static_n_thread2 = np.array(loop2_static_n_thread2)
    loop2_static_n_thread4 = np.array(loop2_static_n_thread4)
    loop2_static_n_thread8 = np.array(loop2_static_n_thread8)
    loop2_static_n_thread16 = np.array(loop2_static_n_thread16)
    loop2_static_n_thread32 = np.array(loop2_static_n_thread32)
    loop2_static_n_thread64 = np.array(loop2_static_n_thread64)
    plt.figure()
    plt.plot(x, loop2_static_n_thread1, color="b", linewidth=1, linestyle="-", label="1 threads")
    plt.plot(x, loop2_static_n_thread2, color="g", linewidth=1, linestyle="-", label="2 threads")
    plt.plot(x, loop2_static_n_thread4, color="r", linewidth=1, linestyle="-", label="4 threads")
    plt.plot(x, loop2_static_n_thread8, color="c", linewidth=1, linestyle="-", label="8 threads")
    plt.plot(x, loop2_static_n_thread16, color="m", linewidth=1, linestyle="-", label="16 threads")
    plt.plot(x, loop2_static_n_thread32, color="y", linewidth=1, linestyle="-", label="32 threads")
    plt.plot(x, loop2_static_n_thread64, color="k", linewidth=1, linestyle="-", label="64 threads")
    plt.title("execution time shcedule STATIC N in loop2")
    plt.xlabel("chunksize")
    plt.ylabel("execution time")
    #my_y_ticks = np.arange(0, 8, 0.5)
    #plt.yticks(my_y_ticks)
    plt.xticks(x)
    plt.legend(loc = 'upper left')
    plt.savefig('./exec_time_static_n_loop2_pic.jpg')

    print("\ndraw ok for exec_time_static_n_loop2_pic.jpg")
    



    

    #plot execution time vs chunksize graph dynamic n loop2
    loop2_dynamic_n_thread1 = []
    loop2_dynamic_n_thread2 = []
    loop2_dynamic_n_thread4 = []
    loop2_dynamic_n_thread8 = []
    loop2_dynamic_n_thread16 = []
    loop2_dynamic_n_thread32 = []
    loop2_dynamic_n_thread64 = []
    for index in range(7):
        loop2_dynamic_n_thread1.append(result_time_list_in_loop2[3 + index*3])
        loop2_dynamic_n_thread2.append(result_time_list_in_loop2[26 + index*3])
        loop2_dynamic_n_thread4.append(result_time_list_in_loop2[49 + index*3])
        loop2_dynamic_n_thread8.append(result_time_list_in_loop2[72 + index*3])
        loop2_dynamic_n_thread16.append(result_time_list_in_loop2[95 + index*3])
        loop2_dynamic_n_thread32.append(result_time_list_in_loop2[118 + index*3])
        loop2_dynamic_n_thread64.append(result_time_list_in_loop2[141 + index*3])
    loop2_dynamic_n_thread1 = np.array(loop2_dynamic_n_thread1)
    loop2_dynamic_n_thread2 = np.array(loop2_dynamic_n_thread2)
    loop2_dynamic_n_thread4 = np.array(loop2_dynamic_n_thread4)
    loop2_dynamic_n_thread8 = np.array(loop2_dynamic_n_thread8)
    loop2_dynamic_n_thread16 = np.array(loop2_dynamic_n_thread16)
    loop2_dynamic_n_thread32 = np.array(loop2_dynamic_n_thread32)
    loop2_dynamic_n_thread64 = np.array(loop2_dynamic_n_thread64)
    plt.figure()
    plt.plot(x, loop2_dynamic_n_thread1, color="b", linewidth=1, linestyle="-", label="1 threads")
    plt.plot(x, loop2_dynamic_n_thread2, color="g", linewidth=1, linestyle="-", label="2 threads")
    plt.plot(x, loop2_dynamic_n_thread4, color="r", linewidth=1, linestyle="-", label="4 threads")
    plt.plot(x, loop2_dynamic_n_thread8, color="c", linewidth=1, linestyle="-", label="8 threads")
    plt.plot(x, loop2_dynamic_n_thread16, color="m", linewidth=1, linestyle="-", label="16 threads")
    plt.plot(x, loop2_dynamic_n_thread32, color="y", linewidth=1, linestyle="-", label="32 threads")
    plt.plot(x, loop2_dynamic_n_thread64, color="k", linewidth=1, linestyle="-", label="64 threads")
    plt.title("execution time shcedule DYNAMIC N in loop2")
    plt.xlabel("chunksize")
    plt.ylabel("execution time")
    #my_y_ticks = np.arange(0, 8, 0.5)
    #plt.yticks(my_y_ticks)
    plt.xticks(x)
    plt.legend(loc = 'upper left')
    plt.savefig('./exec_time_dynamic_n_loop2_pic.jpg')
    
    print("\ndraw ok for exec_time_dynamic_n_loop2_pic.jpg")






    #plot execution time vs chunksize graph dynamic n loop1
    loop1_dynamic_n_thread1 = []
    loop1_dynamic_n_thread2 = []
    loop1_dynamic_n_thread4 = []
    loop1_dynamic_n_thread8 = []
    loop1_dynamic_n_thread16 = []
    loop1_dynamic_n_thread32 = []
    loop1_dynamic_n_thread64 = []
    for index in range(7):
        loop1_dynamic_n_thread1.append(result_time_list_in_loop1[3 + index*3])
        loop1_dynamic_n_thread2.append(result_time_list_in_loop1[26 + index*3])
        loop1_dynamic_n_thread4.append(result_time_list_in_loop1[49 + index*3])
        loop1_dynamic_n_thread8.append(result_time_list_in_loop1[72 + index*3])
        loop1_dynamic_n_thread16.append(result_time_list_in_loop1[95 + index*3])
        loop1_dynamic_n_thread32.append(result_time_list_in_loop1[118 + index*3])
        loop1_dynamic_n_thread64.append(result_time_list_in_loop1[141 + index*3])
    loop1_dynamic_n_thread1 = np.array(loop1_dynamic_n_thread1)
    loop1_dynamic_n_thread2 = np.array(loop1_dynamic_n_thread2)
    loop1_dynamic_n_thread4 = np.array(loop1_dynamic_n_thread4)
    loop1_dynamic_n_thread8 = np.array(loop1_dynamic_n_thread8)
    loop1_dynamic_n_thread16 = np.array(loop1_dynamic_n_thread16)
    loop1_dynamic_n_thread32 = np.array(loop1_dynamic_n_thread32)
    loop1_dynamic_n_thread64 = np.array(loop1_dynamic_n_thread64)
    plt.figure()
    plt.plot(x, loop1_dynamic_n_thread1, color="b", linewidth=1, linestyle="-", label="1 threads")
    plt.plot(x, loop1_dynamic_n_thread2, color="g", linewidth=1, linestyle="-", label="2 threads")
    plt.plot(x, loop1_dynamic_n_thread4, color="r", linewidth=1, linestyle="-", label="4 threads")
    plt.plot(x, loop1_dynamic_n_thread8, color="c", linewidth=1, linestyle="-", label="8 threads")
    plt.plot(x, loop1_dynamic_n_thread16, color="m", linewidth=1, linestyle="-", label="16 threads")
    plt.plot(x, loop1_dynamic_n_thread32, color="y", linewidth=1, linestyle="-", label="32 threads")
    plt.plot(x, loop1_dynamic_n_thread64, color="k", linewidth=1, linestyle="-", label="64 threads")
    plt.title("execution time shcedule DYNAMIC N in loop1")
    plt.xlabel("chunksize")
    plt.ylabel("execution time")

    my_y_ticks = np.arange(0, 8, 0.5)
    plt.yticks(my_y_ticks)
    plt.xticks(x)
    plt.legend(loc = 'upper left')
    plt.savefig('./exec_time_dynamic_n_loop1_pic.jpg')
    
    print("\ndraw ok for exec_time_dynamic_n_loop1_pic.jpg")







    #plot execution time vs chunksize graph guided n loop1
    loop1_guided_n_thread1 = []
    loop1_guided_n_thread2 = []
    loop1_guided_n_thread4 = []
    loop1_guided_n_thread8 = []
    loop1_guided_n_thread16 = []
    loop1_guided_n_thread32 = []
    loop1_guided_n_thread64 = []
    for index in range(7):
        loop1_guided_n_thread1.append(result_time_list_in_loop1[4 + index*3])
        loop1_guided_n_thread2.append(result_time_list_in_loop1[27 + index*3])
        loop1_guided_n_thread4.append(result_time_list_in_loop1[50 + index*3])
        loop1_guided_n_thread8.append(result_time_list_in_loop1[73 + index*3])
        loop1_guided_n_thread16.append(result_time_list_in_loop1[96 + index*3])
        loop1_guided_n_thread32.append(result_time_list_in_loop1[119 + index*3])
        loop1_guided_n_thread64.append(result_time_list_in_loop1[142 + index*3])
    loop1_guided_n_thread1 = np.array(loop1_guided_n_thread1)
    loop1_guided_n_thread2 = np.array(loop1_guided_n_thread2)
    loop1_guided_n_thread4 = np.array(loop1_guided_n_thread4)
    loop1_guided_n_thread8 = np.array(loop1_guided_n_thread8)
    loop1_guided_n_thread16 = np.array(loop1_guided_n_thread16)
    loop1_guided_n_thread32 = np.array(loop1_guided_n_thread32)
    loop1_guided_n_thread64 = np.array(loop1_guided_n_thread64)
    plt.figure()
    plt.plot(x, loop1_guided_n_thread1, color="b", linewidth=1, linestyle="-", label="1 threads")
    plt.plot(x, loop1_guided_n_thread2, color="g", linewidth=1, linestyle="-", label="2 threads")
    plt.plot(x, loop1_guided_n_thread4, color="r", linewidth=1, linestyle="-", label="4 threads")
    plt.plot(x, loop1_guided_n_thread8, color="c", linewidth=1, linestyle="-", label="8 threads")
    plt.plot(x, loop1_guided_n_thread16, color="m", linewidth=1, linestyle="-", label="16 threads")
    plt.plot(x, loop1_guided_n_thread32, color="y", linewidth=1, linestyle="-", label="32 threads")
    plt.plot(x, loop1_guided_n_thread64, color="k", linewidth=1, linestyle="-", label="64 threads")
    plt.title("execution time shcedule GUIDED N in loop1")
    plt.xlabel("chunksize")
    plt.ylabel("execution time")

    my_y_ticks = np.arange(0, 8, 0.5)
    plt.yticks(my_y_ticks)
    plt.xticks(x)
    plt.legend(loc = 'upper left')
    plt.savefig('./exec_time_guided_n_loop1_pic.jpg')
    
    print("\ndraw ok for exec_time_guided_n_loop1_pic.jpg")








 #plot execution time vs chunksize graph guided n loop2
    loop2_guided_n_thread1 = []
    loop2_guided_n_thread2 = []
    loop2_guided_n_thread4 = []
    loop2_guided_n_thread8 = []
    loop2_guided_n_thread16 = []
    loop2_guided_n_thread32 = []
    loop2_guided_n_thread64 = []
    for index in range(7):
        loop2_guided_n_thread1.append(result_time_list_in_loop2[4 + index*3])
        loop2_guided_n_thread2.append(result_time_list_in_loop2[27 + index*3])
        loop2_guided_n_thread4.append(result_time_list_in_loop2[50 + index*3])
        loop2_guided_n_thread8.append(result_time_list_in_loop2[73 + index*3])
        loop2_guided_n_thread16.append(result_time_list_in_loop2[96 + index*3])
        loop2_guided_n_thread32.append(result_time_list_in_loop2[119 + index*3])
        loop2_guided_n_thread64.append(result_time_list_in_loop2[142 + index*3])
    loop2_guided_n_thread1 = np.array(loop2_guided_n_thread1)
    loop2_guided_n_thread2 = np.array(loop2_guided_n_thread2)
    loop2_guided_n_thread4 = np.array(loop2_guided_n_thread4)
    loop2_guided_n_thread8 = np.array(loop2_guided_n_thread8)
    loop2_guided_n_thread16 = np.array(loop2_guided_n_thread16)
    loop2_guided_n_thread32 = np.array(loop2_guided_n_thread32)
    loop2_guided_n_thread64 = np.array(loop2_guided_n_thread64)
    plt.figure()
    plt.plot(x, loop2_guided_n_thread1, color="b", linewidth=1, linestyle="-", label="1 threads")
    plt.plot(x, loop2_guided_n_thread2, color="g", linewidth=1, linestyle="-", label="2 threads")
    plt.plot(x, loop2_guided_n_thread4, color="r", linewidth=1, linestyle="-", label="4 threads")
    plt.plot(x, loop2_guided_n_thread8, color="c", linewidth=1, linestyle="-", label="8 threads")
    plt.plot(x, loop2_guided_n_thread16, color="m", linewidth=1, linestyle="-", label="16 threads")
    plt.plot(x, loop2_guided_n_thread32, color="y", linewidth=1, linestyle="-", label="32 threads")
    plt.plot(x, loop2_guided_n_thread64, color="k", linewidth=1, linestyle="-", label="64 threads")
    plt.title("execution time shcedule GUIDED N in loop2")
    plt.xlabel("chunksize")
    plt.ylabel("execution time")

    my_y_ticks = np.arange(0, 8, 0.5)
    plt.yticks(my_y_ticks)
    plt.xticks(x)
    plt.legend(loc = 'upper left')
    plt.savefig('./exec_time_guided_n_loop2_pic.jpg')
    
    print("\ndraw ok for exec_time_guided_n_loop2_pic.jpg\n")
    




    print('all task ok, please see pictures in directory!\n')
    print('----------------------------------------------------------------------------------')


    


    
    





