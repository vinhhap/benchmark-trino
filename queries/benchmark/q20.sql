select
    s.name,
    s.address
from
    supplier s,
    nation n
where
    s.suppkey in (
        select
            ps.suppkey
        from
            partsupp ps
        where
            ps.partkey in (
                select
                    p.partkey
                from
                    part p
                where
                    p.name like 'magenta%'
            )
            and ps.availqty > (
                select
                    0.5 * sum(l.quantity)
                from
                    lineitem l
                where
                    l.partkey = ps.partkey
                    and l.suppkey = ps.suppkey
                    and l.shipdate >= date '1996-01-01'
                    and l.shipdate < date_add('year', 1, date '1996-01-01')
            )
    )
    and s.nationkey = n.nationkey
    and n.name = 'RUSSIA'
order by
    s.name;

