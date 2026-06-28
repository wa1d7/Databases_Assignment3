# Databases_Assignment3 Query Analysis

explain analyze
select
    oi.order_id,
    p.product_name,
    oi.quantity,
    oi.price,
    oi.quantity * oi.price as item_total
from order_items oi
join products p on oi.product_id = p.product_id
where oi.order_id = 1;

Hash Join  (cost=27.09..41.32 rows=7 width=274) (actual time=0.074..0.081 rows=2.00 loops=1)
  Hash Cond: (p.product_id = oi.product_id)
  Buffers: shared hit=2
  ->  Seq Scan on products p  (cost=0.00..13.00 rows=300 width=222) (actual time=0.023..0.024 rows=5.00 loops=1)
        Buffers: shared hit=1
  ->  Hash  (cost=27.00..27.00 rows=7 width=28) (actual time=0.039..0.040 rows=2.00 loops=1)
        Buckets: 1024  Batches: 1  Memory Usage: 9kB
        Buffers: shared hit=1
        ->  Seq Scan on order_items oi  (cost=0.00..27.00 rows=7 width=28) (actual time=0.026..0.029 rows=2.00 loops=1)
              Filter: (order_id = 1)
              Rows Removed by Filter: 5
              Buffers: shared hit=1
Planning:
  Buffers: shared hit=9
Planning Time: 0.448 ms
Execution Time: 0.134 ms
