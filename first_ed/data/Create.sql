DROP SCHEMA IF EXISTS `proj` ;
CREATE SCHEMA IF NOT EXISTS `proj` DEFAULT CHARACTER SET utf8mb4 ;
USE `proj` ;

-- -----------------------------------------------------
-- Create Table `proj`.`sign_up_records`
-- -----------------------------------------------------
CREATE TABLE `sign_up_records` (
    `record_id` INT PRIMARY KEY,
    `first_name` VARCHAR(255),
    `last_name` VARCHAR(255),
    `login_name` VARCHAR(255),
    `login_password` VARCHAR(255),
    `gender` VARCHAR(10),
    `birth` DATE,
    `phone` VARCHAR(20)
);

-- -----------------------------------------------------
-- Create Table `proj`.`customer`
-- -----------------------------------------------------
CREATE TABLE `customer` (
    `customer_id` INT PRIMARY KEY,
    `record_id` INT,
    `customer_name` VARCHAR(255), -- login_name in sign_up_records
    `customer_gender` VARCHAR(10),
    `customer_birth` DATE,
    `customer_phone` VARCHAR(20),
    `customer_password` VARCHAR(255),
    FOREIGN KEY (`record_id`) REFERENCES `sign_up_records`(`record_id`)
);

-- -----------------------------------------------------
-- Create Table `proj`.`store`
-- -----------------------------------------------------
CREATE TABLE `store` (
    `store_id` INT PRIMARY KEY,
    `store_name` VARCHAR(255),
    `store_sales` DECIMAL(10, 2),
    `store_address` VARCHAR(255)
);

-- -----------------------------------------------------
-- Create Table `proj`.`item`
-- -----------------------------------------------------
CREATE TABLE `item` (
    `item_id` INT PRIMARY KEY,
    `store_id` INT,
    `item_name` VARCHAR(255),
    `item_price` DECIMAL(10, 2),
    `item_type` VARCHAR(255),
    `item_inventory` INT,
    FOREIGN KEY (`store_id`) REFERENCES `store`(`store_id`)
);

-- -----------------------------------------------------
-- Create Table `proj`.`orderform`
-- -----------------------------------------------------
CREATE TABLE `order` (
    `order_id` INT PRIMARY KEY,
    `store_id` INT,
    `customer_id` INT,
    `order_time` DATETIME,
    `order_status` VARCHAR(255),
    FOREIGN KEY (`store_id`) REFERENCES `store`(`store_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`)
);

-- -----------------------------------------------------
-- Create Table `proj`.`order_item`
-- -----------------------------------------------------

CREATE TABLE `order_item` (
    `order_id` INT,
    `item_id` INT,
    `quantity` INT,
    `store_id` INT,
    PRIMARY KEY (`order_id`, `item_id`),
    FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`),
    FOREIGN KEY (`item_id`) REFERENCES `item`(`item_id`)
);


-- Inserting data into sign_up_records table
INSERT INTO `sign_up_records` (record_id, first_name, last_name, login_name, login_password, gender, birth, phone)
VALUES
(1, 'Alice', 'Zhang', 'alicez', 'pass123', 'Female', '1992-07-12', '1234567890'),
(2, 'Bob', 'Wang', 'bobwang', 'pass456', 'Male', '1988-03-25', '0987654321'),
(3, 'Cathy', 'Li', 'cathyl', 'pass789', 'Female', '1995-12-01', '2345678901'),
(4, 'David', 'Sun', 'davids', 'pass101', 'Male', '1982-10-14', '8765432109');

-- Inserting data into customer table
-- Assuming record_id already exists in the sign_up_records table
INSERT INTO `customer` (customer_id, record_id, customer_name, customer_gender, customer_birth, customer_phone, customer_password)
VALUES
(1, 1, 'Alice Zhang', 'Female', '1992-07-12', '1234567890', 'pass123'),
(2, 2, 'Bob Wang', 'Male', '1988-03-25', '0987654321', 'pass456'),
(3, 3, 'Cathy Li', 'Female', '1995-12-01', '2345678901', 'pass789'),
(4, 4, 'David Sun', 'Male', '1982-10-14', '8765432109', 'pass101');

-- Inserting data into store table
INSERT INTO `store` (store_id, store_name, store_sales, store_address)
VALUES
(1, 'Book Heaven', 25000.00, '123 Library St'),
(2, 'Gadget World', 50000.00, '456 Technology Ave'),
(3, 'Fashion Hub', 40000.00, '789 Fashion Blvd');

-- Inserting data into item table
INSERT INTO `item` (item_id, store_id, item_name, item_price, item_type, item_inventory)
VALUES
(1, 1, 'Mystery Novel', 15.99, 'Book', 50),
(2, 1, 'Science Fiction Novel', 17.99, 'Book', 30),
(3, 2, 'Smartphone', 999.99, 'Electronics', 25),
(4, 2, 'Laptop', 1200.00, 'Electronics', 20),
(5, 3, 'Dress', 89.99, 'Clothing', 40),
(6, 3, 'Suit', 249.99, 'Clothing', 15);

-- Inserting data into order table
INSERT INTO `order` (order_id, store_id, customer_id, order_time, order_status)
VALUES
(1, 1, 1, '2024-04-20 08:00:00', 'Completed'),
(2, 2, 2, '2024-04-20 09:00:00', 'Pending'),
(3, 3, 3, '2024-04-20 10:00:00', 'Shipped'),
(4, 2, 4, '2024-04-20 11:00:00', 'Processing');

-- Inserting data into order_item table
-- Assuming order_id and item_id already exist
INSERT INTO `order_item` (order_id, item_id, quantity, store_id)
VALUES
(1, 1, 2, 1),
(2, 3, 1, 2),
(3, 5, 3, 3),
(4, 4, 1, 2);