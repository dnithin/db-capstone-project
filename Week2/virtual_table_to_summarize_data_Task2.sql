CREATE VIEW OrdersView2 AS
SELECT `LitteLemonDB`.Customers.CustomerID,`LitteLemonDB`.Customers.FullName, `LitteLemonDB`.Order.OrderID,`LitteLemonDB`.Orders Orders.TotalCost
FROM Customer INNER JOIN orders
WHERE Orders.TotalCost > 150
ORDER BY Orders.TotalCost DESC;