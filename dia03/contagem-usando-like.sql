SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem LIKE '%queijo%'

GROUP BY descItem
ORDER BY qtdePedido DESC