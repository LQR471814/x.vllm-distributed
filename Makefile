stop:
	uv run ray stop

head:
	uv run ray start --head --port 6379 --node-ip-address 192.168.20.1

worker:
	uv run ray start --address 192.168.20.1:6379 --node-ip-address 192.168.20.2

vllm:
	vllm serve Qwen/Qwen3-0.6B \
		--distributed-executor-backend ray \
		--tensor-parallel-size 1 \
		--pipeline-parallel-size 2
