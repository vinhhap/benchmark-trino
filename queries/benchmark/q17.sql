select
    sum(l.extendedprice) / 7.0 as avg_yearly
from
    lineitem l,
    part p
where
    p.partkey = l.partkey
    and p.brand = 'Brand#42'
    and p.container = 'JUMBO PACK'
    and l.quantity < (
        select
            0.2 * avg(l.quantity)
        from
            lineitem l
        where
            l.partkey = p.partkey
    );
