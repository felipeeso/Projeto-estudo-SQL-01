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
WHERE StoreID = 1 AND OrderDate BETWEEN '01-01-2012' AND '31-12-2012'
GROUP BY StoreID

-- No ano de 2012, quais são os principais vendedores da loja ID 1
SELECT
	SO.EmployeeID
	,SE.FullName
	,SUM(OrderTotal) AS VENDA_TOTAL_VENDEDOR
FROM Sales.[Order] AS SO
INNER JOIN SALES.Employee AS SE ON SE.EmployeeID = SO.EmployeeID
WHERE SO.StoreID = 1 AND OrderDate BETWEEN '01-01-2012' AND '31-12-2012'
GROUP BY SO.EmployeeID, SE.FullName

-- Melhorando a visualização dos dados da tabela acima

   -- Melhorando o número
SELECT
	SO.EmployeeID
	,SE.FullName
	,FORMAT(SUM(OrderTotal), 'C', 'en-US') AS VENDA_TOTAL_VENDEDOR
FROM Sales.[Order] AS SO
INNER JOIN SALES.Employee AS SE ON SE.EmployeeID = SO.EmployeeID
WHERE SO.StoreID = 1 AND OrderDate BETWEEN '01-01-2012' AND '31-12-2012'
GROUP BY SO.EmployeeID, SE.FullName

  --Melhorando o nome
SELECT
	SO.EmployeeID
	,CONCAT(TRIM(SUBSTRING(SE.FullName, CHARINDEX(',' ,SE.FullName)+1, LEN(SE.FullName))),' ',TRIM(SUBSTRING(SE.FullName,1,CHARINDEX(',' ,SE.FullName)-1))) AS NOME_SOBRENOME
	,FORMAT(SUM(OrderTotal), 'C', 'en-US') AS VENDA_TOTAL_VENDEDOR 
FROM Sales.[Order] AS SO
INNER JOIN SALES.Employee AS SE ON SE.EmployeeID = SO.EmployeeID
WHERE SO.StoreID = 1 AND OrderDate BETWEEN '01-01-2012' AND '31-12-2012'
GROUP BY SO.EmployeeID, SE.FullName

  -- Na tabela tem os dados de first name e last name, logo outra alternativa seria:
 SELECT
	SO.EmployeeID
	,SE.FirstName + ' ' + SE.LastName AS NOME_SOBRENOME
	,FORMAT(SUM(OrderTotal), 'C', 'en-US') AS VENDA_TOTAL_VENDEDOR 
FROM Sales.[Order] AS SO
INNER JOIN SALES.Employee AS SE ON SE.EmployeeID = SO.EmployeeID
WHERE SO.StoreID = 1 AND OrderDate BETWEEN '01-01-2012' AND '31-12-2012'
GROUP BY SO.EmployeeID, SE.FirstName + ' ' + SE.LastName