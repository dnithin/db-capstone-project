DELIMITER //

CREATE PROCEDURE AddValidBooking (
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    DECLARE table_exists INT;
   
    START TRANSACTION;

    
    SELECT COUNT(*) INTO table_exists
    FROM Bookings
    WHERE Booking_date = booking_date AND TableNumber = table_number;

    IF table_exists > 0 THEN
        ROLLBACK;
        SELECT 'Table ' + CAST(table_number AS CHAR) + ' is already booked on ' + CAST(booking_date AS CHAR) + '.' AS Message;
    ELSE
        INSERT INTO Bookings (BookingDate, TableNumber)
        VALUES (booking_date, table_number);
        
        COMMIT;
        SELECT 'Booking for table ' + CAST(table_number AS CHAR) + ' on ' + CAST(booking_date AS CHAR) + ' added successfully.' AS Message;
    END IF;
END//

DELIMITER ;

    
