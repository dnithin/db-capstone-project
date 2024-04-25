CREATE VIEW OrdersView AS
SELECT Orders.OrderID, orders.Quantity, orders.TotalCost
FROM Orders
WHERE Orders.Quantity > 2