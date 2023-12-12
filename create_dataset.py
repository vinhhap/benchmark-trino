import subprocess
import os
from dotenv import load_dotenv
import pandas as pd
import time

load_dotenv()

if __name__ == "__main__":
    t_start = time.time()
    TRINO_SERVER = os.getenv('TRINO_SERVER')
    TRINO_USER = os.getenv('TRINO_USER')
    TRINO_PASSWORD = os.getenv('TRINO_PASSWORD')
    TRINO_BENCHMARK_CATALOG = os.getenv('TRINO_BENCHMARK_CATALOG')
    TRINO_BENCHMARK_SCHEMA = os.getenv('TRINO_BENCHMARK_SCHEMA')
    TPCH_CATALOG = os.getenv("TPCH_CATALOG", "tpch")
    TPCH_SCHEMA = os.getenv("TPCH_SCHEMA", "sf100")
    replace_list = [
        {"key": "{{ TRINO_BENCHMARK_CATALOG }}", "value": TRINO_BENCHMARK_CATALOG},
        {"key": "{{ TRINO_BENCHMARK_SCHEMA }}", "value": TRINO_BENCHMARK_SCHEMA},
        {"key": "{{ TPCH_CATALOG }}", "value": TPCH_CATALOG},
        {"key": "{{ TPCH_SCHEMA }}", "value": TPCH_SCHEMA}
    ]
    
    print("----- Creating temporary DDL file from template -----")
    template_ddl = open(os.path.join(os.getcwd(), "queries", "setup", "tpch-ddl.sql"), "r")
    ddl_content = template_ddl.read()
    for i in replace_list:
        ddl_content = ddl_content.replace(i['key'], i['value']) 
    tmp_ddl_path = os.path.join("queries", "setup", "tmp-tpch-ddl.sql")
    tmp_ddl_file = open(tmp_ddl_path, "w+")
    tmp_ddl_file.write(ddl_content)
    template_ddl.close()
    tmp_ddl_file.close()
    
    print("----- Running DDL file to create dataset -----")
    subprocess.run([
        "./trino", 
        "--server", TRINO_SERVER, 
        "--user", TRINO_USER, 
        "--catalog", TRINO_BENCHMARK_CATALOG, 
        "--schema", TRINO_BENCHMARK_SCHEMA,
        "-f", tmp_ddl_path,
        "--password"
    ], shell=False, stdout=subprocess.DEVNULL)
    
    print("----- Deleting temporary DDL file -----")
    os.remove(tmp_ddl_path)
    
    t_end = time.time()
    elapsed_time = round(t_end - t_start, 2)
    print(f"----- Finished DDL, took:  {elapsed_time}s-----")