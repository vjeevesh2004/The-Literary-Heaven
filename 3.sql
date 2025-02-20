-- Popular Books
SELECT 
    B.Title, 
    COUNT(P.PurchaseID) AS PurchaseCount 
FROM 
    Books B
JOIN 
    Purchases P ON B.BookID = P.BookID
GROUP BY 
    B.BookID, B.Title
ORDER BY 
    PurchaseCount DESC
LIMIT 15;  -- (Top 15 books)


-- Frequently Browsed Genres
SELECT 
    B.Genre, 
    COUNT(I.InteractionID) AS BrowseCount 
FROM 
    Interactions I
JOIN 
    Books B ON I.BookID = B.BookID
WHERE 
    I.InteractionType = 'view'  -- Filter for 'view' interactions
GROUP BY 
    B.Genre
ORDER BY 
    BrowseCount DESC
LIMIT 10;  -- Top 10 frequently browsed genres

