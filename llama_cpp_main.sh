#!/bin/bash

source ./llama_cpp_common.sh
NAME_SHELL=`basename $0 .sh`
LOG_DIR="${NAME_SHELL}_${LOG_DIR}"
PATH_BIN=$DIR_BIN/main
PATH_RESULT=$LOG_DIR/results.csv
DEFAULT_THREAD=8

log_info "shell file:${NAME_SHELL}"
log_info "bin file:${PATH_BIN}"
log_info "model file:${PATH_MODEL}"

mkdir $LOG_DIR
echo "Thread,Prompt Speed,Token Speed" >> $PATH_RESULT
for((i=1;i<=$DEFAULT_THREAD;i*=2));  
do   
    log_info "main thread begin:${i}"
    PATH_LOG=./${LOG_DIR}/${NAME_SHELL}_thread_${i}.txt
    CMD="${PATH_BIN} -m ${PATH_MODEL} -p \"${DEFAULT_PROMPT}\" -n 128 -b 512 -s 1 -t ${i} > ${PATH_LOG} 2>&1"
    eval $CMD
    SPEED_PROMPT=`cat $PATH_LOG | grep "llama_print_timings: prompt eval time" | grep -P "\d+.\d+" -o | tail -n 1`
    SPEED_TOKEN=`cat $PATH_LOG | grep "llama_print_timings:        eval time" | grep -P "\d+.\d+" -o | tail -n 1`
    echo "${i},${SPEED_PROMPT},${SPEED_TOKEN}" >> $PATH_RESULT
    log_info "main thread end:${i}"
done  

log_info "shell file:${NAME_SHELL} done"

