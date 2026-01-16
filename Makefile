export VLLM_HOST_IP := $(shell ip -j addr show | jq -r '.[ ] | .addr_info[].local | select(startswith("192.168.20"))')

stop:
	uv run ray stop

head:
	uv run ray start \
		--head \
		--port 6379 \
		--node-ip-address 192.168.20.1 \
		--num-gpus 1 \
		--dashboard-host 0.0.0.0 \
		--block

worker:
	uv run ray start \
		--node-ip-address 192.168.20.2 \
		--address 192.168.20.1:6379 \
		--num-gpus 1 \
		--block

stat:
	uv run ray status

nodes:
	uv run ray list nodes

vllm:
	uv run vllm serve Qwen/Qwen3-0.6B \
		--distributed-executor-backend ray \
		--tensor-parallel-size 1 \
		--pipeline-parallel-size 2 \
		--dtype=half
