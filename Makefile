stop:
	uv run ray stop

head:
	uv run ray start --head --port 9889 --node-ip-address 0.0.0.0 --num-gpus 1

worker:
	uv run ray start --address 192.168.20.1:9889 --num-gpus 1

stat:
	uv run ray status

nodes:
	uv run ray list nodes

vllm:
	uv run vllm serve Qwen/Qwen3-0.6B \
		--distributed-executor-backend ray \
		--tensor-parallel-size 1 \
		--pipeline-parallel-size 2
