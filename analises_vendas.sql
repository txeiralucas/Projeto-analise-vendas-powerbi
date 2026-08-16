-- ========================================
-- PROJETO 1 — ANÁLISE DE VENDAS
-- Dataset: Sample Sales Data (Kaggle)
-- Ferramenta: SQLiteOnline
-- ========================================


-- ========================================
-- BLOCO 1 — VISÃO GERAL DO NEGÓCIO
-- ========================================

-- Conta quantos pedidos únicos existem no dataset.
-- Usamos DISTINCT pois o mesmo pedido aparece em várias
-- linhas — uma para cada produto dentro do pedido.
SELECT COUNT(DISTINCT ORDERNUMBER) AS total_pedidos
FROM sales_data_sample;

-- Soma o valor total de todas as vendas realizadas.
-- Representa o faturamento bruto do negócio.
SELECT SUM(SALES) AS faturamento_total
FROM sales_data_sample;

-- Calcula o valor médio de cada venda.
-- Útil para entender o padrão de compra dos clientes.
SELECT AVG(SALES) AS media_de_vendas
FROM sales_data_sample;

-- Faturamento agrupado por ano.
-- Permite identificar tendência de crescimento ou queda.
SELECT YEAR_ID AS ano,
       SUM(SALES) AS faturamento
FROM sales_data_sample
GROUP BY YEAR_ID
ORDER BY YEAR_ID;

-- Lista os meses disponíveis em 2005.
-- Necessário para verificar se o ano está completo
-- antes de comparar com anos anteriores.
SELECT DISTINCT QTR_ID, MONTH_ID, YEAR_ID
FROM sales_data_sample
WHERE YEAR_ID = 2005;

-- Faturamento apenas nos primeiros 5 meses de cada ano.
-- Como 2005 só tem dados até maio, filtramos o mesmo
-- período nos outros anos para comparação justa.
SELECT YEAR_ID,
       SUM(SALES) AS faturamento
FROM sales_data_sample
WHERE MONTH_ID BETWEEN 1 AND 5
GROUP BY YEAR_ID;


-- ========================================
-- BLOCO 2 — ANÁLISE POR PRODUTO
-- ========================================

-- Faturamento total por linha de produto, do maior para o menor.
-- Identifica quais categorias são mais rentáveis para o negócio.
SELECT PRODUCTLINE,
       SUM(SALES) AS faturamento_por_produto
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY faturamento_por_produto DESC;

-- Quantidade total de itens vendidos por categoria.
-- Permite comparar se alto faturamento vem de volume ou de preço.
SELECT PRODUCTLINE,
       SUM(QUANTITYORDERED) AS total_itens_vendidos
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY total_itens_vendidos DESC;

-- Preço médio por categoria de produto.
-- Valida hipóteses sobre diferenças de faturamento
-- entre categorias com volume similar de vendas.
SELECT PRODUCTLINE,
       AVG(PRICEEACH) AS media_de_preco
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY media_de_preco DESC;


-- ========================================
-- BLOCO 3 — ANÁLISE POR CLIENTE
-- ========================================

-- Top 10 clientes por faturamento total.
-- Identifica concentração de receita e clientes estratégicos.
SELECT CUSTOMERNAME,
       SUM(SALES) AS faturamento_total
FROM sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY faturamento_total DESC
LIMIT 10;

-- Top 10 clientes por número de pedidos e faturamento.
-- Clientes com mesmo número de pedidos mas faturamentos
-- diferentes indicam ticket médio distinto por cliente.
SELECT CUSTOMERNAME,
       COUNT(DISTINCT ORDERNUMBER) AS quantidade_de_pedidos,
       SUM(SALES) AS faturamento_total
FROM sales_data_sample
GROUP BY CUSTOMERNAME
ORDER BY quantidade_de_pedidos DESC
LIMIT 10;


-- ========================================
-- BLOCO 4 — ANÁLISE POR PAÍS E REGIÃO
-- ========================================

-- Top 10 países por faturamento.
-- Revela dependência de mercados específicos.
SELECT COUNTRY,
       SUM(SALES) AS faturamento_total
FROM sales_data_sample
GROUP BY COUNTRY
ORDER BY faturamento_total DESC
LIMIT 10;

-- Faturamento por território (visão macro por região).
-- EMEA agrega vários países europeus, o que explica
-- por que supera NA mesmo com EUA sendo o maior país isolado.
SELECT TERRITORY,
       SUM(SALES) AS faturamento_total
FROM sales_data_sample
GROUP BY TERRITORY
ORDER BY faturamento_total DESC;
