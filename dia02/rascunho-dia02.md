
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




- Adicionar mais uma condição

~~~~SQL
SELECT *
FROM silver.pizza_query.pedido
WHERE flKetchup = TRUE
AND 
~~~~

