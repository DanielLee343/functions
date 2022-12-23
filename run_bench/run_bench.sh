#!/bin/bash

# $1: function to run

spin_single_func() 
{
    # $1: function to test <matmul, >
    # $2: parameter pass to function, e.g., matrix size

    # clear $1_$2.csv
    rm -r ./$1_$2.csv
    # get python pid to be ignored
    pidIgnore=$(pidof python3)
    # let the program run, wait for 0.05 sec for python to spin up
    cpus=""
    time curl http://127.0.0.1:8080/function/$1 -d '{"n":"'$2'"}' \
        & sleep 0.05

    pid=$(pidof python3 -o $pidIgnore)

    # get cpu ids involved, if needed
    # while :;
    # do
    #     check_pid=$(pidof python3 -o $pidIgnore)
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
        check_pid=$(pidof python3 -o $pidIgnore)
        # if the function is finished
        if [ -z "$check_pid" ]; then
            break
        else 
            cur_rss=$(echo $(sudo pmap $pid -x | tail -n 1) | awk -F ' ' '{print $4}')
            now=$(date +"%T")
            echo $now","$(($cur_rss/1024)) >> $1_$2.csv
            sleep 1
        fi
    done
}

run_norm() 
{
    rm -r ./normal_run/$1_$2.csv
    pidIgnore=$(pidof python3)
    cpus=""
    time python3 ./normal_run/$1.py $2 \
        & sleep 0.05

    pid=$(pidof python3 -o $pidIgnore)

    # use pmap to get memory usage VS. time
    echo $pid
    while :;
    do
        check_pid=$(pidof python3 -o $pidIgnore)
        # if the function is finished
        if [ -z "$check_pid" ]; then
            break
        else 
            cur_rss=$(echo $(sudo pmap $pid -x | tail -n 1) | awk -F ' ' '{print $4}')
            now=$(date +"%T")
            echo $now","$(($cur_rss/1024)) >> ./normal_run/$1_$2.csv
            sleep 1
        fi
    done
}

get_func_cpu_usage() 
{
    pidIgnore=$(pidof python3)
    cpus=""
    time curl http://127.0.0.1:8080/function/$1 -d '{"n":"'$2'"}' \
        & sleep 0.05

    pid=$(pidof python3 -o $pidIgnore)
    while :;
    do
        check_pid=$(pidof python3 -o $pidIgnore)
        if [ -z "$check_pid" ]; then
            break
        else 
            cpus=$(echo $(taskset -cp $pid) | awk -F 'list: ' '{print $2}')
            echo $cpus
            sleep 1
        fi
    done
}

run_one_func_bench()
{
    local func_name=$1
    # 
    for n in 15000 
    do
        echo "testing" $func_name with size $n
        get_func_cpu_usage "$func_name" "$n"
    done
}

run_one_func_bench $1

