CREATE VIEW OrdersView AS
SELECT `LittleLemonDB`.`Orders`.OrderID, `LittleLemonDB`.`Orders`.Quantity, `LittleLemonDB`.`Orders`.TotalCost
FROM `LitteLemonDB`.Orders
WHERE `LitteLemonDB`.Orders.Quantity > 2