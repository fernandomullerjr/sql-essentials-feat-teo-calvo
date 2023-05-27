SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem = 'massa'

GROUP BY descItem
ORDER BY qtdePedido DESC