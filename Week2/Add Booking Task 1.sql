DELIMITER //

CREATE PROCEDURE AddBooking (
    IN booking_id INT,
    IN customer_id INT,
    IN booking_date DATE,
    IN table_number INT
)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber)
    VALUES (booking_id, customer_id, booking_date, table_number);
    
    SELECT 'Booking added successfully.' AS Message;
END//

DELIMITER ;
