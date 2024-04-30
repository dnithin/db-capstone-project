DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
	SELECT MAX(Orders.Quantity) as 'Max Quantity in Order'
	FROM `LitteLemonDB`.Orders;

END//

DELIMITER ;