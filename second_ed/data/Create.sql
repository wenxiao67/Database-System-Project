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

