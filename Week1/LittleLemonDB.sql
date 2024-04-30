-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `CustomerID` INT NOT NULL,
  `FullName` VARCHAR(255) NOT NULL,
  `Contact` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `BookingDate` DATETIME NOT NULL,
  `TableNumber` INT NOT NULL,
  `Customer_ID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `Customer_ID_idx` (`Customer_ID` ASC),
  CONSTRAINT `Customer_ID`
    FOREIGN KEY (`Customer_ID`)
    REFERENCES `LittleLemonDB`.`Customer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(255) NOT NULL,
  `Cuisine` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDelivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDelivery` (
  `OrderDelivery_ID` INT NOT NULL,
  `OrderDel_Date` DATETIME NOT NULL,
  `Order_Status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`OrderDelivery_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `Staff_ID` INT NOT NULL,
  `Staff_Name` VARCHAR(100) NOT NULL,
  `Contact` VARCHAR(45) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Salary` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Staff_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATETIME NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` DECIMAL(2,0) NOT NULL,
  `Book_Booking_ID` INT NOT NULL,
  `Menu_MenuID` INT NOT NULL,
  `OrderDel_OrderdelID` INT NOT NULL,
  `Staff_StaffID` INT NOT NULL,
  `Cust_CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `MenuID_idx` (`Menu_MenuID` ASC) visible,
  INDEX `BookingID_idx` (`Book_Booking_ID` ASC) VISIBLE,
  INDEX `OrderDeliveryID_idx` (`OrderDel_OrderdelID` ASC) VISIBLE,
  INDEX `StaffID_idx` (`Staff_StaffID` ASC) VISIBLE,
  INDEX `CustomerID_idx` (`Cust_CustomerID` ASC) VISIBLE,
  CONSTRAINT `BookingID`
    FOREIGN KEY (`Book_Booking_ID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`Menu_MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `OrderDeliveryID`
    FOREIGN KEY (`OrderDel_OrderdelID`)
    REFERENCES `LittleLemonDB`.`OrderDelivery` (`OrderDelivery_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `StaffID`
    FOREIGN KEY (`Staff_StaffID`)
    REFERENCES `LittleLemonDB`.`Staff` (`Staff_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`Cust_CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- procedure CancelOrder
-- -----------------------------------------------------

DELIMITER $$
USE `LittleLemonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CancelOrder`(
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
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure GetMaxQuantity
-- -----------------------------------------------------

DELIMITER $$
USE `LittleLemonDB`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetMaxQuantity`()
SELECT MAX(orders.Quantity) as 'Max Quantity in Order'
FROM orders$$

DELIMITER ;
USE `LittleLemonDB`;

-- -----------------------------------------------------
-- Placeholder table for view `littlelemondb`.`ordersview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`ordersview` (`OrderID` INT, `Quantity` INT, `TotalCost` INT);

-- -----------------------------------------------------
-- Placeholder table for view `littlelemondb`.`ordersview2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`ordersview2` (`CustomerID` INT, `FullName` INT, `OrderID` INT, `TotalCost` INT);

-- -----------------------------------------------------
-- View `littlelemondb`.`ordersview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`ordersview`;
USE `LittleLemonDB`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `LittleLemonDB`.`ordersview` AS select `LitteLemonDB`.`orders`.`OrderID` AS `OrderID`,`LitteLemonDB`.`orders`.`Quantity` AS `Quantity`,`LitteLemonDB`.`orders`.`TotalCost` AS `TotalCost` from `LitteLemonDB`.`orders` where (`LitteLemonDB`.`orders`.`Quantity` > 2);

-- -----------------------------------------------------
-- View `littlelemondb`.`ordersview2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LitteLemonDB`.`ordersview2`;
USE `LitteLemonDB`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `LitteLemonDB`.`ordersview2` AS select `LitteLemonDB`.`customer`.`CustomerID` AS `CustomerID`,`LitteLemonDB`.`customer`.`FullName` AS `FullName`,`LitteLemonDB`.`orders`.`OrderID` AS `OrderID`,`LitteLemonDB`.`orders`.`TotalCost` AS `TotalCost` from (`LitteLemonDB`.`customer` join `LitteLemonDB`.`orders`) where (`LitteLemonDB`.`orders`.`TotalCost` > 150) order by `LitteLemonDB`.`orders`.`TotalCost` desc;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
