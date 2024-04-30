PREPARE GetOrderDetail from 'SELECT OrderID, Quantity, TotalCost from `LitteLemonDB`.Orders where OrderID=?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;