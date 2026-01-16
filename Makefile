export VLLM_HOST_IP := $(shell ip -j addr show | jq -r '.[ ] | .addr_info[] | select(.local | startswith("192.168.20")) | .local')
export GLOO_SOCKET_IFNAME := $(shell ip -j addr show | jq -r '.[ ] | .addr_info[] | select(.local | startswith("192.168.20")) | .label')
export NCCL_DEBUG := INFO
export NCCL_SOCKET_IFNAME := $(shell ip -j addr show | jq -r '.[ ] | .addr_info[] | select(.local | startswith("192.168.20")) | .label')

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
	uv run vllm serve Qwen/Qwen3-8B \
		--distributed-executor-backend ray \
		--gpu-memory-utilization 0.8 \
		--max-model-len 4096 \
		--tensor-parallel-size 2 \
		--pipeline-parallel-size 2 \
		--dtype=half \
		--host 0.0.0.0 \
		--port 8000
