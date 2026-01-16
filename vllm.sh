#!/bin/sh
export VLLM_HOST_IP="$(ip -j addr show | jq -r '.[ ] | .addr_info[].local | select(startswith("192.168.20"))')"
uv run vllm serve Qwen/Qwen3-0.6B \
	--distributed-executor-backend ray \
	--tensor-parallel-size 1 \
	--pipeline-parallel-size 2
