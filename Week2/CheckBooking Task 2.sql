DELIMITER //


CREATE PROCEDURE CheckBooking(IN BookingDate DATE, IN TableNumber INT)
BEGIN
	
    IF Exists (SELECT BookingDate, TableNumber WHERE exists (SELECT * from Booking where Date = BookingDate and TableNumber = TableNumber))
    THEN SELECT 'Table ' + CAST(TableNumber AS CHAR) + ' is already booked' AS 'Booking Status';
    
    ELSE SELECT 'Table ' + CAST(TableNumber AS CHAR) + ' is not booked on ' + BookingDate  AS 'Booking Status';
	
    END IF;
    
END//

DELIMITER ; 


