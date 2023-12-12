select
    sum(l.extendedprice * l.discount) as revenue
from
    lineitem l
where
    l.shipdate >= date '1994-01-01'
    and l.shipdate < date_add('year', 1, date '1994-01-01')
    and l.discount between 0.06 - 0.01 and 0.06 + 0.01
    and l.quantity < 24;