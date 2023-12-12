select
    100.00 * sum(case
        when p.type like 'PROMO%'
            then l.extendedprice * (1 - l.discount)
        else 0
    end) / sum(l.extendedprice * (1 - l.discount)) as promo_revenue
from
    lineitem l,
    part p
where
    l.partkey = p.partkey
    and l.shipdate >= date '1994-11-01'
    and l.shipdate < date_add('month', 1, date '1994-11-01');
