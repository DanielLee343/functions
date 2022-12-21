#!/bin/bash

#clear test.csv
echo > ./test.csv
# first let the program run, wait for 0.05 sec for python to spin up, 
# then get the pid of python
cpus=""
time curl -i http://127.0.0.1:8080/function/matmul -d '{"n":"10000"}' \
    & sleep 0.05
pid=$(pidof python3 -o 1131)

# get cpu ids involved, if needed
# while :;
# do
#     check_pid=$(pidof python3 -o 1131)
#     if [ -z "$check_pid" ]; then
#         break
#     else 
#         cpus=$(echo $(taskset -cp $pid) | awk -F 'list: ' '{print $2}')
#         echo $cpus
#         sleep 1
#     fi
# done

# use mpstat to get the CPU usage VS. time, if needed
# mpstat -P ${cpus} 1

# use pmap to get memory usage VS. time
echo $pid
while :;
do
    check_pid=$(pidof python3 -o 1131)
    if [ -z "$check_pid" ]; then
        break
    else 
        cur_rss=$(echo $(sudo pmap $pid -x | tail -n 1) | awk -F ' ' '{print $4}')
        now=$(date +"%T")
        echo $now","$(($cur_rss/1024)) >> test.csv
        sleep 1
    fi
done