create table if not exists {{ TRINO_BENCHMARK_CATALOG }}.{{ TRINO_BENCHMARK_SCHEMA }}.nation 
with (
  format = 'PARQUET'
)
as
select * from {{ TPCH_CATALOG }}.{{ TPCH_SCHEMA }}.nation;

create table if not exists {{ TRINO_BENCHMARK_CATALOG }}.{{ TRINO_BENCHMARK_SCHEMA }}.region 
with (
  format = 'PARQUET'
)
as
select * from {{ TPCH_CATALOG }}.{{ TPCH_SCHEMA }}.region;

create table if not exists {{ TRINO_BENCHMARK_CATALOG }}.{{ TRINO_BENCHMARK_SCHEMA }}.part 
with (
  format = 'PARQUET'
)
as
select * from {{ TPCH_CATALOG }}.{{ TPCH_SCHEMA }}.part;

create table if not exists {{ TRINO_BENCHMARK_CATALOG }}.{{ TRINO_BENCHMARK_SCHEMA }}.supplier
with (
  format = 'PARQUET'
)
as
select * from {{ TPCH_CATALOG }}.{{ TPCH_SCHEMA }}.supplier;

create table if not exists {{ TRINO_BENCHMARK_CATALOG }}.{{ TRINO_BENCHMARK_SCHEMA }}.partsupp 
with (
  format = 'PARQUET'
)
as
select * from {{ TPCH_CATALOG }}.{{ TPCH_SCHEMA }}.partsupp;

create table if not exists {{ TRINO_BENCHMARK_CATALOG }}.{{ TRINO_BENCHMARK_SCHEMA }}.customer 
with (
  format = 'PARQUET'
)
as
select * from {{ TPCH_CATALOG }}.{{ TPCH_SCHEMA }}.customer;

create table if not exists {{ TRINO_BENCHMARK_CATALOG }}.{{ TRINO_BENCHMARK_SCHEMA }}.orders 
with (
  format = 'PARQUET',
  partitioned_by = ARRAY['orderdate']
)
as
select 
    orderkey,
    custkey,
    orderstatus,
    totalprice,
    orderpriority,
    clerk,
    shippriority,
    comment,
    orderdate
from tpch.sf1.orders;

create table if not exists {{ TRINO_BENCHMARK_CATALOG }}.{{ TRINO_BENCHMARK_SCHEMA }}.lineitem 
with (
  format = 'PARQUET',
  partitioned_by = ARRAY['shipdate']
)
as
select 
    orderkey,
    partkey,
    suppkey,
    linenumber,
    quantity,
    extendedprice,
    discount,
    tax,
    returnflag,
    linestatus,
    commitdate,
    receiptdate,
    shipinstruct,
    shipmode,
    comment,
    shipdate
from {{ TPCH_CATALOG }}.{{ TPCH_SCHEMA }}.lineitem;