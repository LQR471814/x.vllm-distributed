#!/bin/sh
echo $VLLM_HOST_IP

uv run vllm serve Qwen/Qwen3-0.6B \
	--distributed-executor-backend ray \
	--tensor-parallel-size 1 \
	--pipeline-parallel-size 2
