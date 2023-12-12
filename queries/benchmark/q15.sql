create view revenue0 as
    select
        l.suppkey as supplier_no,
        sum(l.extendedprice * (1 - l.discount)) as total_revenue
    from
        lineitem l
    where
        l.shipdate >= date '1997-10-01'
        and l.shipdate < date_add('month', 3, date '1997-10-01')
    group by
        l.suppkey;
select
    s.suppkey,
    s.name,
    s.address,
    s.phone,
    total_revenue
from
    supplier s,
    revenue0
where
    s.suppkey = supplier_no
    and total_revenue = (
        select
            max(total_revenue)
        from
            revenue0
    )
order by
    s.suppkey;
drop view revenue0;
