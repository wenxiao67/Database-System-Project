-- Parameters: first_name, last_name, login_name, gender, birth, phone, login_password

-- Start a transaction
START TRANSACTION;

-- User input values
SET @first_name = '%s';
SET @last_name = '%s';
SET @login_name = '%s';
SET @gender = '%s';
SET @birth = '%s';
SET @phone = '%s';
SET @login_password = '%s';

-- Calculate next record_id
SELECT IFNULL(MAX(record_id), 0) + 1 INTO @new_record_id FROM sign_up_records;

-- Insert into sign_up_records
INSERT INTO sign_up_records (record_id, first_name, last_name, login_name, login_password, gender, birth, phone)
VALUES (@new_record_id, @first_name, @last_name, @login_name, @login_password, @gender, @birth, @phone);

-- Calculate next customer_id
SELECT IFNULL(MAX(customer_id), 0) + 1 INTO @new_customer_id FROM customer;

-- Insert into customer
INSERT INTO customer (customer_id, record_id, customer_name, customer_gender, customer_birth, customer_phone, customer_password)
VALUES (@new_customer_id, @new_record_id, @login_name, @gender, @birth, @phone, @login_password);

-- Commit the transaction
COMMIT;