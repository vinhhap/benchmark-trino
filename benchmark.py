import subprocess
import os
from dotenv import load_dotenv
import pandas as pd
import time

load_dotenv()

def run_benchmark(trino_server: str, 
                trino_user: str,
                trino_catalog: str,
                trino_schema: str,
                n_iter: int=1) -> pd.DataFrame:
    result = []
    for n in range(n_iter):
        for i in range(1, 23):
            print(f"----- Runing iteration {n + 1} query {i} ------")
            t_start = time.time()
            subprocess.run([
                "./trino", 
                "--server", trino_server, 
                "--user", trino_user, 
                "--catalog", trino_catalog, 
                "--schema", trino_schema,
                "-f", os.path.join(os.getcwd(), "queries", "benchmark", f"q{i}.sql"),
                "--password"
            ], shell=False, stdout=subprocess.DEVNULL)
            t_end = time.time()
            t_elapsed = t_end - t_start
            result.append({
                "iter": n + 1,
                "query": f"q{i}",
                "elapsed_time_ms": t_elapsed * 1000
            })
            print(f"----- Finished iteration {n + 1} query {i}: {round(t_elapsed, 2)}s -----")
    return pd.DataFrame(result)
    
if __name__ == "__main__":
    TRINO_SERVER = os.getenv('TRINO_SERVER')
    TRINO_USER = os.getenv('TRINO_USER')
    TRINO_PASSWORD = os.getenv('TRINO_PASSWORD')
    TRINO_BENCHMARK_CATALOG = os.getenv('TRINO_BENCHMARK_CATALOG')
    TRINO_BENCHMARK_SCHEMA = os.getenv('TRINO_BENCHMARK_SCHEMA')
    
    df_result = run_benchmark(TRINO_SERVER, TRINO_USER, TRINO_BENCHMARK_CATALOG, TRINO_BENCHMARK_SCHEMA, 5)
    df_result.to_csv("./results/benchmark_result.csv", index=False)