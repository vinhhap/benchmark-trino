select
        cntrycode,
        count(*) as numcust,
        sum(acctbal) as totacctbal
from
        (
                select
                        substring(c.phone from 1 for 2) as cntrycode,
                        c.acctbal
                from
                        customer c
                where
                        substring(c.phone from 1 for 2) in
                                ('13', '31', '23', '29', '30', '18', '17')
                        and c.acctbal > (
                                select
                                        avg(c.acctbal)
                                from
                                        customer c
                                where
                                        c.acctbal > 0.00
                                        and substring(c.phone from 1 for 2) in
                                                ('13', '31', '23', '29', '30', '18', '17')
                        )
                        and not exists (
                                select
                                        *
                                from
                                        orders o
                                where
                                        o.custkey = c.custkey
                        )
        ) as custsale
group by
        cntrycode
order by
        cntrycode;
