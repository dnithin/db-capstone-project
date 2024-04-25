CREATE VIEW OrdersView2 AS
SELECT Customer.CustomerID, Customer.FullName, Orders.OrderID, Orders.TotalCost
FROM Customer INNER JOIN orders
WHERE Orders.TotalCost > 150
ORDER BY Orders.TotalCost DESC;