SELECT t1.*,
    t2.vlPreco

FROM silver.pizza_query.item_pedido AS t1

LEFT JOIN silver.pizza_query.produto AS t2
ON t1.descItem = t2.descItem
