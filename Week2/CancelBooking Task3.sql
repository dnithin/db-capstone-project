DELIMITER //

CREATE PROCEDURE CancelBooking (
    IN booking_id INT
)
BEGIN
    
    DELETE FROM LittleLemonDB.Bookings
    WHERE BookingID = booking_id;
    
    SELECT 'Booking canceled successfully.' AS Message;
END//

DELIMITER ;
