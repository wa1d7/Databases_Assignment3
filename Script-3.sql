create or replace function calculate_order_total(p_order_id int)
returns numeric(10,2) as $$
declare
    total numeric(10,2);
begin
    select coalesce(sum(quantity * price), 0) into total
    from order_items
    where order_id = p_order_id;
    return total;
end;
$$ language plpgsql;
create or replace procedure create_order(p_customer_id int)
as $$
begin
    if not exists (select 1 from customers where customer_id = p_customer_id) then
        raise exception 'customer with id % does not exist', p_customer_id;
    end if;
    insert into orders (customer_id, order_date, total_amount)
    values (p_customer_id, current_timestamp, 0);
end;
$$ language plpgsql;
create or replace procedure add_product_to_order(
    p_order_id int,
    p_product_id int,
    p_quantity int
)
as $$
declare
    v_price numeric(10,2);
    v_stock int;
begin
    if p_quantity <= 0 then
        raise exception 'quantity must be greater than zero';
    end if;
    select price, stock_quantity into v_price, v_stock
    from products
    where product_id = p_product_id;
    if not found then
        raise exception 'product with id % not found', p_product_id;
    end if;
    if v_stock < p_quantity then
        raise exception 'not enough stock. available: %', v_stock;
    end if;
    insert into order_items (order_id, product_id, quantity, price)
    values (p_order_id, p_product_id, p_quantity, v_price);
    update products
    set stock_quantity = stock_quantity - p_quantity
    where product_id = p_product_id;
end;
$$ language plpgsql;
