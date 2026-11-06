USE [AdventureWorks2019];


-- SELECT 
--     object_name(cols.object_id) tabla
--     ,cols.name columna
--     ,ind.name indice
--     ,ind.type_desc tipo
--     ,ind.is_unique 
--     FROM 
--     sys.columns cols, sys.indexes ind , sys.index_columns ind_cols
--     where 
--     cols.object_id = ind.object_id
--     and cols.object_id = ind_cols.object_id
--     and cols.column_id = ind_cols.column_id
--     and ind.index_id = ind_cols.index_id
--     and object_name(cols.object_id) LIKE 'Employee'
--     order by object_name(cols.object_id), ind.name;

-- 0.1. Explique el funcionamiento de las siguientes consultas y por qu´e los planes de ejecuci´on son diferentes.
-- SELECT P.Name , P.ProductNumber
-- FROM Production.Product P
-- WHERE ProductNumber ='EC-R098'

-- SELECT P.ProductID , P.ProductNumber
-- FROM Production.Product P
-- WHERE ProductNumber ='EC-R098'

GO


-- 0.2. Estas dos consultas son similares sin embargo los planes son diferentes. Explique lo que
-- est´a ocurriendo

SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 58950

SELECT SalesOrderID, SalesOrderDetailID
FROM Sales.SalesOrderDetail
WHERE SalesOrderDetailID = 68531

GO


-- 0.3. Mire detalladamente estas consultas y explique los planes de ejecuci´on
-- SELECT SalesOrderID, SalesOrderDetailID
-- FROM Sales.SalesOrderDetail
-- WHERE SalesOrderID = 43683 AND SalesOrderDetailID = 240

-- SELECT SalesOrderID, SalesOrderDetailID
-- FROM Sales.SalesOrderDetail
-- WHERE SalesOrderID = 43683 OR SalesOrderDetailID = 240

GO

-- 0.4. Compare los planes de ejecuci´on de las siguientes tres consultas. Explique que hace cada
-- uno y por qu´e se eligen mecanismos de junta diferentes.

-- SELECT ProductID, PV.BusinessEntityID, Name
-- FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
-- ON (PPV.BusinessEntityID =PV.BusinessEntityID)

-- SELECT ProductID, PV.BusinessEntityID, Name
-- FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
-- ON (PPV.BusinessEntityID =PV.BusinessEntityID)
-- WHERE StandardPrice > $10

-- SELECT ProductID, PV.BusinessEntityID, Name
-- FROM Purchasing.ProductVendor PPV JOIN Purchasing.Vendor PV
-- ON (PPV.BusinessEntityID =PV.BusinessEntityID)
-- WHERE StandardPrice > $10 AND Name LIKE N'F%'


GO

-- 0.5. Compare los planes de ejecuci´on de las siguientes consultas. Explique que hace cada uno y en que se basa la elecci´on del optimizador
-- SELECT P.Name, PSC.Name SubCatrom
-- FROM Production.Product P
-- JOIN Production.ProductSubcategory PSC
-- ON p.ProductSubcategoryID = psc.ProductSubcategoryID

-- SELECT P.Name, PSC.Name SubCatrom
-- FROM Production.Product P
-- JOIN Production.ProductSubcategory PSC
-- ON p.ProductSubcategoryID = psc.ProductSubcategoryID
-- ORDER BY psc.ProductSubcategoryID

GO

-- 0.6. Compare las siguientes dos consultas y explique la diferencia de planes
-- SELECT count(NameStyle) FROM Person.Person

-- SELECT count(Title) FROM Person.Person

GO

-- 0.7. Analice los planes de las siguientes consultas

-- SELECT jc.Resume FROM HumanResources.JobCandidate jc
-- INNER JOIN HumanResources.Employee e on jc.BusinessEntityID =e.BusinessEntityID
-- ORDER BY e.BusinessEntityID,jc.JobCandidateID

-- SELECT JobCandidateID FROM HumanResources.JobCandidate jc
-- INNER JOIN HumanResources.Employee e on jc.BusinessEntityID =e.BusinessEntityID
-- ORDER BY e.BusinessEntityID,jc.JobCandidateID

GO
