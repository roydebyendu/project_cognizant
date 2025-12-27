CREATE DATABASE IF NOT EXISTS doctor_db;
USE doctor_db;

CREATE TABLE IF NOT EXISTS doctors (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    specialization VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    department VARCHAR(100),
    experience_years INT,
    qualifications TEXT,
    consultation_fee DECIMAL(10,2),
    available_from_time TIME,
    available_to_time TIME,
    available_days VARCHAR(100),
    clinic_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);