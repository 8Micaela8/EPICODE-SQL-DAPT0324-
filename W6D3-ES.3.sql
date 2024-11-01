/*
1.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto
anche la sua sottocategoria (DimProduct, DimProductSubcategory).
*/

SELECT 
    p.ProductKey,
    p.EnglishProductName,
    sc.EnglishProductSubcategoryName,
    p.ProductSubcategoryKey,
    sc.ProductSubcategoryKey
FROM
    dimproduct AS p
        JOIN
    dimproductsubcategory AS sc
    ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey;

/*
2.Esponi l’anagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria
e la sua categoria (DimProduct, DimProductSubcategory, DimProductCategory).
*/

SELECT 
    p.ProductKey,
    p.EnglishProductName,
    c.EnglishProductCategoryName,
    sc.EnglishProductSubcategoryName,
    c.ProductCategoryKey,
    sc.ProductCategoryKey,
    p.ProductSubcategoryKey,
    sc.ProductSubcategoryKey
FROM
    dimproduct AS p
        JOIN
    dimproductcategory AS c
        JOIN
    dimproductsubcategory AS sc
    ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
    AND c.ProductCategoryKey = sc.ProductCategoryKey;

/*
3.Esponi l’elenco dei soli prodotti venduti (DimProduct, FactResellerSales).
*/

SELECT DISTINCT
    p.ProductKey AS Product_Key
FROM
    dimproduct AS p
WHERE
    p.ProductKey IN (SELECT rs.ProductKey
                     FROM factresellersales AS rs);

/*
4.Esponi l’elenco dei prodotti non venduti (considera i soli prodotti finiti
cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1).
*/

SELECT DISTINCT
    p.ProductKey,
    p.ProductAlternateKey,
    p.EnglishProductName AS ProductName,
    s.ProductKey AS ProductKeyFACT,
    FinishedGoodsFlag
FROM
    dimproduct p
	LEFT JOIN
    factresellersales s ON p.ProductKey = s.ProductKey
WHERE
    s.ProductKey IS NULL
     AND FinishedGoodsFlag = 1;
     
  SELECT
    ProductKey Product_Key, EnglishProductName Model_Color_Size
FROM
    dimproduct
WHERE
    ProductKey NOT IN (SELECT 
            ProductKey
        FROM
            factsales UNION SELECT 
            ProductKey
        FROM
            factinternetsales UNION SELECT 
            ProductKey
        FROM
            factresellersales) AND FinishedGoodsFlag = 1; 
    
/*
5.Esponi l’elenco delle transazioni di vendita (FactResellerSales)
indicando anche il nome del prodotto venduto (DimProduct)
*/

SELECT
rs.SalesOrderNumber,
p.EnglishProductName,
rs.SalesOrderLineNumber,
rs.OrderDate,
rs.OrderQuantity,
rs.SalesAmount,
p.ProductKey,
rs.ProductKey
FROM factresellersales AS rs
JOIN 
dimproduct AS p
ON p.ProductKey = rs.ProductKey;

/*
6.Esponi l’elenco delle transazioni di vendita indicando la categoria
di appartenenza di ciascun prodotto venduto.
*/

SELECT
rs.SalesOrderNumber,
p.EnglishProductName,
c.EnglishProductCategoryName,
sc.EnglishProductSubcategoryName,
rs.OrderDate,
rs.OrderQuantity,
rs.SalesAmount
FROM factresellersales AS rs
     JOIN 
     dimproduct AS p
     JOIN
     dimproductsubcategory AS sc
     JOIN
     dimproductcategory AS c
ON p.ProductKey = rs.ProductKey
AND sc.ProductCategoryKey = c.ProductCategoryKey
AND p.ProductSubcategoryKey = sc.ProductSubcategoryKey;

/*
7.Esplora la tabella DimReseller.
*/

SELECT *
FROM dimreseller;

/*
8.Esponi in output l’elenco dei reseller indicando,
per ciascun reseller, anche la sua area geografica.
*/

SELECT DISTINCT
res.ResellerKey,
res.ResellerName,
geo.EnglishCountryRegionName,
geo.City
FROM dimreseller AS res
JOIN
dimgeography AS geo
ON res.GeographyKey = geo.GeographyKey;

/*
9. Esponi l’elenco delle transazioni di vendita. Il result set deve esporre i campi:
SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto,
il nome del reseller e l’area geografica.
*/

SELECT 
    fsr.SalesOrderNumber Order_Number,
    fsr.SalesOrderLineNumber Order_Line_Number,
    fsr.OrderDate Order_Date,
    fsr.UnitPrice Price,
    fsr.OrderQuantity Quantity,
    fsr.TotalProductCost Product_Cost,
    dp.EnglishProductName Product_Name,
    dpc.EnglishProductCategoryname Category,
    sc.EnglishProductSubcategoryName Sub_Category,
    res.ResellerName Reseller,
    geo.EnglishCountryRegionName Country
FROM
    factresellersales fsr
        JOIN
    dimproduct dp
        JOIN
    dimproductcategory dpc
        JOIN
    dimproductsubcategory sc
        JOIN
    dimreseller res
        JOIN
    dimgeography geo
        ON fsr.ProductKey = dp.ProductKey
        AND sc.ProductCategoryKey = dpc.ProductCategoryKey
        AND dp.ProductSubcategoryKey = sc.ProductSubcategoryKey
        AND res.GeographyKey = geo.GeographyKey
        AND res.ResellerKey = fsr.ResellerKey;