USE BikeStores

--Conhecendo os dados das tabelas
SELECT
	*
FROM Production.Brand

SELECT
	*
FROM Production.Category

SELECT
	*
FROM Production.Product

SELECT
	*
FROM Production.Stock

SELECT
	*
FROM SALES.Customer

SELECT
	*
FROM SALES.Employee

SELECT
	*
FROM Sales.[Order]

SELECT
	*
FROM SALES.OrderItem

SELECT
	*
FROM SALES.Store

-- Quantidade de compras no dia 01/01/2009
SELECT
	*
FROM Sales.[Order]
WHERE OrderDate = '2009-01-01'

-- Quantos clientes realizaram compras no dia 01/01/2009
SELECT
	DISTINCT CustomerID
FROM Sales.[Order]
WHERE OrderDate = '2009-01-01'

-- Qual o valor gasto por cada cliente no dia 01/01/2009
SELECT
	CustomerID
	,SUM(OrderTotal) AS VALOR_GASTO
FROM Sales.[Order]
WHERE OrderDate = '2009-01-01'
GROUP BY CustomerID
ORDER BY VALOR_GASTO DESC

-- Nome de cada um dos clientes do tema anterior
SELECT
	SO.CustomerID AS ID_CLIENTE
	,SC.FirstName + ' ' + SC.LastName AS NOME_CLIENTE
	,SUM(OrderTotal) AS VALOR_GASTO
FROM Sales.[Order] AS SO
INNER JOIN Sales.Customer AS SC ON SC.CustomerID = SO.CustomerID
WHERE OrderDate = '2009-01-01'
GROUP BY SO.CustomerID, SC.FirstName + ' ' + SC.LastName
ORDER BY VALOR_GASTO DESC

-- Compras realizadas no ano de 2012
SELECT
	*
FROM Sales.[Order]
WHERE OrderDate BETWEEN '01-01-2012' AND '31-12-2012'

-- No ano de 2012, qual o valor total de compras na loja ID 1
SELECT
	StoreID
	,SUM(OrderTotal) AS TOTAL_LOJA_1
FROM Sales.[Order]
WHERE StoreID = 1
GROUP BY StoreID