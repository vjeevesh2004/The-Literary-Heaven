 -- Inventory Turnover Rate Tracking
 -- to track how quickly books are sold and identify which titles are moving quickly or slowly.
SELECT 
    B.Title, 
    COUNT(P.BookID) AS TotalSales,  -- Count of purchases for each book
    (SELECT COUNT(*) FROM Books) AS AverageInventory,  -- Total number of books as a proxy for inventory
    (COUNT(P.BookID) / (SELECT COUNT(*) FROM Books)) AS TurnoverRate  -- Turnover rate calculation
FROM 
    Purchases P
JOIN 
    Books B ON P.BookID = B.BookID
GROUP BY 
    B.Title;

-- Stock-Level Recommendations
--  Optimize stock levels based on sales data and user interest.
SELECT 
    B.Title, 
    B.Price, 
    COUNT(P.PurchaseID) AS SalesCount, 
    B.NoOfRevisedVersions
FROM 
    Books B
LEFT JOIN 
    Purchases P ON B.BookID = P.BookID
GROUP BY 
    B.BookID, B.Title, B.Price, B.NoOfRevisedVersions  -- Include all selected columns in GROUP BY
HAVING 
    COUNT(P.PurchaseID) < B.NoOfRevisedVersions;  -- Criteria for low stock

-- Purchase Timing Analysis
-- Identify patterns in user purchasing behavior based on time and day.
SELECT 
    HOUR(P.PurchaseDate) AS PurchaseHour, 
    DAYOFWEEK(P.PurchaseDate) AS PurchaseDay, 
    COUNT(P.PurchaseID) AS PurchaseCount
FROM 
    Purchases P
GROUP BY 
    HOUR(P.PurchaseDate), DAYOFWEEK(P.PurchaseDate)  -- Include functions in GROUP BY
ORDER BY 
    PurchaseCount DESC;
