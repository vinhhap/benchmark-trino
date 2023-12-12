TRINO_CLI_VERSION=434

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done
	
.PHONY: setup
setup: # Setup environment to run the benchmark
	mkdir results && \
	pip install -r requirements.txt && \
	curl https://repo1.maven.org/maven2/io/trino/trino-cli/434/trino-cli-$(TRINO_CLI_VERSION)-executable.jar --output trino && \
	chmod +x trino

.PHONY: create-dataset
create-dataset: # Create benchmark dataset 
	python create_dataset.py

.PHONY: run
run: # Run benchmark
	python benchmark.py