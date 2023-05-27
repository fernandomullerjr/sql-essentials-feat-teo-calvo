SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem = 'borda'

GROUP BY descItem
ORDER BY qtdePedido DESC

LIMIT 1