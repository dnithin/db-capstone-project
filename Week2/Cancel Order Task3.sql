use LittleLemonDB;


DELIMITER //

CREATE PROCEDURE CancelOrder (
    IN orderId INT
)
BEGIN
    DECLARE rowCount INT;

    DELETE FROM LittleLemonDB.Orders WHERE OrderID = orderId;

    SELECT ROW_COUNT() INTO rowCount;

    IF rowCount > 0 THEN
        SELECT 'Record with Order ID ' + CAST(orderId AS CHAR) + ' deleted successfully.' AS Confrimation;
    ELSE
        SELECT 'Record with Order ID ' + CAST(orderId AS CHAR) + ' does not exist.' AS Message;
    END IF;
END//

DELIMITER ;
