# Run Trino benchmark
## Requirement
- Benchmark scripts are written to be run on Linux environment.
- Your machine should have:
  + Python: >= 3.9
  + Java: openjdk 11

## How to run
- **Step 1:** Change environment variable in `.env_example` and rename it to `.env`.
  + `TRINO_SERVER`: URL of the Trino cluster.
  + `TRINO_USER`: Trino user.
  + `TRINO_PASSWORD`: Trino password.
  + `TRINO_BENCHMARK_CATALOG`: catalog used to store TPCH dataset.
  + `TRINO_BENCHMARK_SCHEMA`: schema used to store TPCH dataset.
  + `TPCH_CATALOG`: TPCH catalog name.
  + `TPCH_SCHEMA`: TPCH scaling factor.
- **Step 2:** Setup environment and dataset.
  ```BASH
  # Install required Python libraries and Trino CLI
  make setup
  
  # Create dataset
  make create-dataset
  ```
- **Step 3:** Run benchmark and get the result in `results` directory.
  ```BASH
  make run
  ```