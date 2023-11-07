#!/bin/bash

LOG_PREFIX="### Marketing Eco Team ###"
LOG_DIR="log_$(date +%Y-%m-%d_%H-%M-%S)"

DIR_BIN=~/gen-ai/llama.cpp/
DIR_MODEL=~/gen-ai/models/Llama-2-7B-GGUF

PATH_BIN=$DIR_BIN/main
PATH_MODEL=$DIR_MODEL/llama-2-7b.Q4_0.gguf

DEFAULT_PROMPT="Write a story about llamas."
DEFAULT_STAT=true

log_info() {
    echo "${LOG_PREFIX}   ${1}"
}
