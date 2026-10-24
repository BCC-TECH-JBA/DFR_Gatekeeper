DROP DATABASE IF EXISTS fixTrackDB;
CREATE DATABASE IF NOT EXISTS fixTrackDB;
USE fixTrackDB;

CREATE TABLE IF NOT EXISTS `client` (
    `client_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `contact_num` VARCHAR(100),
    `messenger_account` VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS `staff` (
    `staff_id` INT AUTO_INCREMENT PRIMARY KEY, 
    `name` VARCHAR(100) NOT NULL,
    `role` ENUM('TECHNICIAN') NOT NULL
);

CREATE TABLE IF NOT EXISTS `device` (
    `device_id` INT AUTO_INCREMENT PRIMARY KEY,
    `device_type` ENUM('PRINTER', 'COMPUTER', 'LAPTOP', 'CCTV', 'CELLPHONE') NOT NULL,
    `device_name` VARCHAR(100) NOT NULL,
    `issue` TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS `repair_job` (
    `repair_job_id` INT AUTO_INCREMENT PRIMARY KEY,
    `client_id` INT,
    `device_id` INT,
    `staff_id` INT,
    `service_type` ENUM('WALK_IN', 'ON_SITE') NOT NULL,
    `address` VARCHAR(100),
    `status` ENUM('IN_PROGRESS', 'READY_FOR_PICKUP', 'RELEASED', 'CANCELLED') NOT NULL,
    `date_received` DATE NOT NULL,
    `date_ready` DATE,
    `date_claimed` DATE,
    FOREIGN KEY(client_id) REFERENCES client(client_id),
    FOREIGN KEY(device_id) REFERENCES device(device_id),
    FOREIGN KEY(staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE IF NOT EXISTS `warranty` (
    `warranty_id` INT AUTO_INCREMENT PRIMARY KEY,
    `repair_job_id` INT,
    `status` ENUM('ACTIVE', 'EXPIRED', 'NONE') NOT NULL,
    `date_issued` DATE NOT NULL,
    `duration_type` ENUM ('MONTH', 'YEAR'),
    `duration` INT,
    FOREIGN KEY(repair_job_id) REFERENCES repair_job(repair_job_id)
);

CREATE TABLE IF NOT EXISTS `repair_cost_estimates` (
    `repair_cost_estimates_id` INT AUTO_INCREMENT PRIMARY KEY,
    `repair_job_id` INT,
    `service_fee` INT NOT NULL,
    `parts_cost` INT NOT NULL,
    FOREIGN KEY(repair_job_id) REFERENCES repair_job(repair_job_id)
);

CREATE TABLE IF NOT EXISTS `payment` (
    `payment_id` INT AUTO_INCREMENT PRIMARY KEY,
    `repair_job_id` INT,
    `repair_cost` DECIMAL(10, 2) NOT NULL,
    `downpayment` DECIMAL(10, 2) NOT NULL, 
    `payment_status` ENUM('INCOMPLETE', 'COMPLETED') NOT NULL,
    `payment_date` DATE NOT NULL,
    FOREIGN KEY (repair_job_id) REFERENCES repair_job(repair_job_id)
);