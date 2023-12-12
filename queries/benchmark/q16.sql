select
    p.brand,
    p.type,
    p.size,
    count(distinct ps.suppkey) as supplier_cnt
from
    partsupp ps,
    part p
where
    p.partkey = ps.partkey
    and p.brand <> 'Brand#44'
    and p.type not like 'SMALL BURNISHED%'
    and p.size in (36, 27, 34, 45, 11, 6, 25, 16)
    and ps.suppkey not in (
        select
            s.suppkey
        from
            supplier s
        where
            s.comment like '%Customer%Complaints%'
    )
group by
    p.brand,
    p.type,
    p.size
order by
    supplier_cnt desc,
    p.brand,
    p.type,
    p.size;

