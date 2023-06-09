
# Dia03

eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github

git add .
git commit -m "SQL Essential - Dia03"
git push



## Dia 26/05/2023


- Aprender sobre o JOIN, para cruzar dados




~~~~SQL
SELECT * FROM silver.pizza_query.pedido
ORDER BY 
LIMIT 100
~~~~




~~~~SQL
SELECT * FROM silver.pizza_query.produto
ORDER BY descItem
LIMIT 100
~~~~




~~~~SQL
SELECT * FROM silver.pizza_query.produto
~~~~






~~~~SQL
SELECT * FROM silver.pizza_query.item_pedido
~~~~

 
idPedido
descTipoItem
descItem
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
0
bebida
refrigerante
0
borda
borda tradicional
0
ingrediente 1
pepperoni
0
ingrediente 2
orégano
0
ingrediente 3
frango
0
ingrediente 4
calabresa



- Tabela da esquerda, vem do FROM
- Depois é definida a referencia.
- Tabela da direita é o nosso JOIN.
- Depois os dados







## LEFT JOIN

~~~~SQL
SELECT * FROM silver.pizza_query.item_pedido LEFT JOIN silver.pizza_query.produto ON descItem
~~~~

- ERRO
Error in SQL statement: AnalysisException: [AMBIGUOUS_REFERENCE] Reference `descItem` is ambiguous, could be: [`silver`.`pizza_query`.`item_pedido`.`descItem`, `silver`.`pizza_query`.`produto`.`descItem`].; line 1 pos 85
Command took 0.45 seconds -- by fernandomj90@gmail.com at 26/05/2023, 19:28:05 on 04 - Unity-Cluster



O erro ocorre porque a coluna "descItem" é ambígua, ou seja, existe em mais de uma tabela mencionada na cláusula JOIN. O SQL não consegue determinar qual tabela você está referenciando quando utiliza o nome da coluna sem especificar a tabela.

Para corrigir o erro, você precisa especificar a tabela correta para a coluna "descItem" na sua cláusula JOIN. Por exemplo:

sql

SELECT *
FROM silver.pizza_query.item_pedido
LEFT JOIN silver.pizza_query.produto ON silver.pizza_query.item_pedido.descItem = silver.pizza_query.produto.descItem;

Neste exemplo, eu especifiquei a tabela "silver.pizza_query.item_pedido.descItem" na cláusula ON, indicando que é essa a coluna que deve ser usada para a junção entre as tabelas "item_pedido" e "produto". Certifique-se de substituir o nome da tabela e as colunas pelos nomes corretos de acordo com a estrutura do seu banco de dados.







## INNER JOIN

~~~~SQL
SELECT * FROM silver.pizza_query.item_pedido INNER JOIN silver.pizza_query.produto ON descItem
~~~~

## RIGHT JOIN

~~~~SQL
SELECT * FROM silver.pizza_query.item_pedido RIGHT JOIN silver.pizza_query.produto ON descItem
~~~~








- Definindo como referencia a tabela
- o "ON" é usada para conectar as tabelas

- Neste formato, traz todas as colunas das tabelas:

~~~~SQL
SELECT *

FROM silver.pizza_query.item_pedido AS t1

LEFT JOIN silver.pizza_query.produto AS t2
ON t1.descItem = t2.descItem
~~~~



- Filtrando, trazendo todas as colunas da t1 e apenas 1 coluna da t2:

~~~~SQL
SELECT t1.*,
    t2.vlPreco

FROM silver.pizza_query.item_pedido AS t1

LEFT JOIN silver.pizza_query.produto AS t2
ON t1.descItem = t2.descItem
~~~~










~~~~SQL
SELECT t1.idPedido,
    SUM(t2.vlPreco) AS vlPedido

FROM silver.pizza_query.item_pedido AS t1

LEFT JOIN silver.pizza_query.produto AS t2
ON t1.descItem = t2.descItem

WHERE t1.descTipoItem <> 'bebida'

GROUP BY t1.idPedido

-- 148 R$48,25
~~~~







- Apache Spark filtra antes de bater no S3.





~~~~SQL
SELECT *

FROM silver.pizza_query.item_pedido

~~~~






- Trampo de corno


~~~~SQL
SELECT *

FROM silver.pizza_query.item_pedido

WHERE descTipoItem = 'borda'
~~~~






- Fazendo contagem


~~~~SQL
SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem = 'borda'

GROUP BY descItem
ORDER BY qtdePedido DESC

LIMIT 1
~~~~






- Massas mais pedidas


~~~~SQL
SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem = 'massa'

GROUP BY descItem
ORDER BY qtdePedido DESC

~~~~




- Obtendo todos os queijos mais pedidos, usando LIKE

~~~~SQL
SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem LIKE '%queijo%'

GROUP BY descItem
ORDER BY qtdePedido DESC

~~~~







- Obtendo todos os ingredientes mais pedidos, usando LIKE, fazendo o top 5 usando o LIMIT

~~~~SQL
SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem LIKE '%ingrediente%'

GROUP BY descItem
ORDER BY qtdePedido DESC

LIMIT 5
~~~~








## juntando tudo

- Para juntar todos os top itens
- Usar o "UNION ALL"

~~~~SQL
(SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem LIKE '%ingrediente%'

GROUP BY descItem
ORDER BY qtdePedido DESC

LIMIT 5)

UNION ALL

(SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem LIKE '%queijo%'

GROUP BY descItem
ORDER BY qtdePedido DESC

LIMIT 5)

UNION ALL

(SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem LIKE '%ingrediente%'

GROUP BY descItem
ORDER BY qtdePedido DESC

LIMIT 5)

UNION ALL

(SELECT descItem,
    count(*) AS qtdePedido

FROM silver.pizza_query.item_pedido

WHERE descTipoItem LIKE '%bebida%'

GROUP BY descItem
ORDER BY qtdePedido DESC

LIMIT 5)
~~~~










- Fazendo subquery


~~~~SQL
SELECT *
FROM(

    (SELECT descItem,
        count(*) AS qtdePedido

    FROM silver.pizza_query.item_pedido

    WHERE descTipoItem LIKE '%ingrediente%'

    GROUP BY descItem
    ORDER BY qtdePedido DESC

    LIMIT 5)

    UNION ALL

    (SELECT descItem,
        count(*) AS qtdePedido

    FROM silver.pizza_query.item_pedido

    WHERE descTipoItem LIKE '%queijo%'

    GROUP BY descItem
    ORDER BY qtdePedido DESC

    LIMIT 5)

    UNION ALL

    (SELECT descItem,
        count(*) AS qtdePedido

    FROM silver.pizza_query.item_pedido

    WHERE descTipoItem LIKE '%ingrediente%'

    GROUP BY descItem
    ORDER BY qtdePedido DESC

    LIMIT 5)

    UNION ALL

    (SELECT descItem,
        count(*) AS qtdePedido

    FROM silver.pizza_query.item_pedido

    WHERE descTipoItem LIKE '%bebida%'

    GROUP BY descItem
    ORDER BY qtdePedido DESC

    LIMIT 5)

) AS t1

LEFT JOIN 
~~~~











- Fazendo subquery


~~~~SQL
SELECT sum(vlPreco)

FROM(

    (SELECT descItem,
        count(*) AS qtdePedido

    FROM silver.pizza_query.item_pedido

    WHERE descTipoItem LIKE '%ingrediente%'

    GROUP BY descItem
    ORDER BY qtdePedido DESC

    LIMIT 5)

    UNION ALL

    (SELECT descItem,
        count(*) AS qtdePedido

    FROM silver.pizza_query.item_pedido

    WHERE descTipoItem LIKE '%queijo%'

    GROUP BY descItem
    ORDER BY qtdePedido DESC

    LIMIT 5)

    UNION ALL

    (SELECT descItem,
        count(*) AS qtdePedido

    FROM silver.pizza_query.item_pedido

    WHERE descTipoItem LIKE '%ingrediente%'

    GROUP BY descItem
    ORDER BY qtdePedido DESC

    LIMIT 5)

    UNION ALL

    (SELECT descItem,
        count(*) AS qtdePedido

    FROM silver.pizza_query.item_pedido

    WHERE descTipoItem LIKE '%bebida%'

    GROUP BY descItem
    ORDER BY qtdePedido DESC

    LIMIT 5)

) AS t1

LEFT JOIN 
~~~~













## PENDENTE
- Corrigir a query que usa UNION ALL.
- Corrigir a query que usa UNION ALL.
- Corrigir a query que usa UNION ALL.
- Corrigir a query que usa UNION ALL.
- Repassar a parte sobre Subquery.
- Repassar a parte sobre Subquery.
- Repassar a parte sobre Subquery.
- Repassar a parte sobre Subquery.
- Repassar a parte sobre Subquery.