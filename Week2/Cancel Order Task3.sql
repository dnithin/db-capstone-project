DELIMITER //

CREATE PROCEDURE  CancelOrder (
    IN orderId INT
)
BEGIN
    DECLARE rowCount INT;

    DELETE FROM Orders WHERE OrderID = orderId;

    SELECT ROW_COUNT() INTO rowCount;

    IF rowCount > 0 THEN
        SELECT 'Record with primary key ' + CAST(orderId AS CHAR) + ' deleted successfully.' AS Confrimation;
    ELSE
        SELECT 'Record with primary key ' + CAST(orderId AS CHAR) + ' does not exist.' AS Message;
    END IF;
END//

DELIMITER ;
