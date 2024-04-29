DELIMITER //

CREATE PROCEDURE UpdateBooking (
    IN booking_id INT,
    IN new_booking_date DATE
)
BEGIN
    -- Update booking date for the specified booking id
    UPDATE bookings
    SET booking_date = new_booking_date
    WHERE booking_id = booking_id;
    
    SELECT 'Booking updated successfully.' AS Message;
END//

DELIMITER ;
