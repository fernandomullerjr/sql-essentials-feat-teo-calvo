
# Dia02

eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github

git add .
git commit -m "SQL Essential - Dia02"
git push


## Dia 25/05/2023

- EFETUADO

        - Criar Github para Pam
        - Forkar pra ela
        - Configurar git no Databricks




SELECT * FROM silver.pizza_query.pedido




SELECT * FROM silver.pizza_query.produto



- Selecionando apenas 1 coluna
~~~~SQL
SELECT descItem
FROM silver.pizza_query.produto
~~~~




- Selecionando apenas várias colunas

~~~~SQL
SELECT descItem,
        vlPreco
FROM silver.pizza_query.produto
~~~~




- Simulando erro

~~~~SQL
SELECT descItem,
        dtValidades
FROM silver.pizza_query.produto
~~~~


- ERRO

~~~~BASH
Error in SQL statement: AnalysisException: [UNRESOLVED_COLUMN.WITH_SUGGESTION] A column or function parameter with name `dtValidades` cannot be resolved. Did you mean one of the following? [`silver`.`pizza_query`.`produto`.`descItem`, `silver`.`pizza_query`.`produto`.`vlPreco`].; line 2 pos 8;
'Project [descItem#6244, 'dtValidades]
+- SubqueryAlias silver.pizza_query.produto
   +- Relation silver.pizza_query.produto[descItem#6244,vlPreco#6245] parquet

~~~~








- Selecionando apenas várias colunas

~~~~SQL
SELECT descItem,
        vlPreco,
        21 +21 AS vl42
FROM silver.pizza_query.produto
~~~~









## WHERE

- Selecionando pedidos que tenham Ketchup

~~~~SQL
SELECT *
FROM silver.pizza_query.pedido
WHERE flKetchup = TRUE
~~~~


COMANDOS
SQL não é case sensitive!
SQL não é case sensitive!
SQL não é case sensitive!
SQL não é case sensitive!




- Adicionar mais uma condição, usando AND no caso:

~~~~SQL
SELECT *
FROM silver.pizza_query.pedido
WHERE flKetchup = TRUE
AND descUF = 'Rio de Janeiro'
~~~~






## COUNT

- Efetuando uso da função COUNT:

~~~~SQL
SELECT count(*)  -- linhas não nulas
FROM silver.pizza_query.pedido
~~~~


- Usando o count(1), o efeito é o mesmo:

~~~~SQL
SELECT count(1)  -- linhas não nulas
FROM silver.pizza_query.pedido
~~~~



- Contando apenas por 1 coluna, o que reduz o consumo de CPU, pois faz uma contagem baseada em apenas 1 coluna:

~~~~SQL
SELECT count(idPedido)
FROM silver.pizza_query.pedido
~~~~








- Filtrando para que não traga valores nulos:

~~~~SQL
SELECT *
FROM silver.pizza_query.pedido
WHERE flKetchup IS NOT null
~~~~





- Contando registros que não traga valores nulos:

~~~~SQL
SELECT count(*)
FROM silver.pizza_query.pedido
WHERE flKetchup IS NOT null
~~~~





- Selecionando pedidos do Paraná:

~~~~SQL
SELECT *
FROM silver.pizza_query.pedido
WHERE descUF = 'Paraná'
~~~~



- Contando pedidos do Paraná:

~~~~SQL
SELECT count(*)
FROM silver.pizza_query.pedido
WHERE descUF = 'Paraná'
~~~~








## GROUP BY

agrupar

- Agrupar por descUF

~~~~SQL
SELECT descUF,
      count(*)
FROM silver.pizza_query.pedido
GROUP BY descUF
~~~~


descUF
count(1)
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
Santa Catarina
46
Mato Grosso do Sul
6
Goiás
35
Mato Grosso
11
Ceará
44
Piauí
5






- Ordenado decrescente:

~~~~SQL
SELECT descUF,
      count(*)
FROM silver.pizza_query.pedido
GROUP BY descUF
ORDER BY count(1) DESC
~~~~





- Selecionando e filtrando UF:

~~~~SQL
SELECT descUF,
      count(*) AS qtdePedidos
FROM silver.pizza_query.pedido

WHERE descUF != 'São Paulo'

GROUP BY descUF
ORDER BY qtdePedidos DESC

LIMIT 6
~~~~










## LIKE

- Usando LIKE para filtrar:

~~~~SQL
SELECT *
FROM silver.pizza_query.produto
WHERE descItem LIKE 'suco%'
~~~~


- Evitar uso do LIKE, pois é muito custoso!
- Evitar uso do LIKE, pois é muito custoso!
- Evitar uso do LIKE, pois é muito custoso!
- Evitar uso do LIKE, pois é muito custoso!
- Evitar uso do LIKE, pois é muito custoso!



- Usando LIKE para filtrar:

~~~~SQL
SELECT *
FROM silver.pizza_query.produto
WHERE descItem LIKE '%laranja%'
~~~~



- Usando LIKE para filtrar:

~~~~SQL
SELECT *
FROM silver.pizza_query.produto
WHERE descItem LIKE '%abacaxi%'
~~~~








- Filtrando por pedidos maiores que 75:
usar o HAVING

~~~~SQL
SELECT descUF,
      count(*) AS qtdePedidos
FROM silver.pizza_query.pedido

WHERE descUF != 'São Paulo'

GROUP BY descUF

HAVING qtdePedidos >= 75

ORDER BY qtdePedidos DESC

LIMIT 6
~~~~

descUF
qtdePedidos
1
2
3
Rio de Janeiro
103
Minas Gerais
92
Paraná
76





- Sempre ao pensar em select, é colunas
- Sempre ao pensar em select, é colunas
- Sempre ao pensar em select, é colunas
- Sempre ao pensar em select, é colunas





~~~~SQL
SELECT *
FROM silver.pizza_query.pedido
~~~~




~~~~SQL
SELECT descUF,
    flKetchup,
    count(*)
FROM silver.pizza_query.pedido
~~~~

Error in SQL statement: AnalysisException: [MISSING_GROUP_BY] The query does not include a GROUP BY clause. Add GROUP BY or turn it into the window functions using OVER clauses.; line 1 pos 0;
Aggregate [descUF#20770, flKetchup#20769, count(1) AS count(1)#20773L]
+- SubqueryAlias silver.pizza_query.pedido
   +- Relation silver.pizza_query.pedido[idPedido#20767,dtPedido#20768,flKetchup#20769,descUF#20770,txtRecado#20771] parquet
Command took 0.43 seconds -- by fernandomj90@gmail.com at 25/05/2023, 20:15:42 on 04 - Unity-Cluster
Shift+Enter to run






- 

~~~~SQL
SELECT descUF,
    flKetchup,
    count(*)
FROM silver.pizza_query.pedido

GROUP BY descUF, flKetchup
~~~~