-- Patient Record Management System Database Setup Script
-- Run this script in MySQL to create all required databases

-- Create Patient Database
CREATE DATABASE IF NOT EXISTS patient_db;
USE patient_db;

CREATE TABLE IF NOT EXISTS patients (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    date_of_birth DATE,
    address TEXT,
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    emergency_contact VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Doctor Database
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

-- Create Appointment Database
CREATE DATABASE IF NOT EXISTS appointment_db;
USE appointment_db;

CREATE TABLE IF NOT EXISTS appointments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    patient_id BIGINT NOT NULL,
    doctor_id BIGINT NOT NULL,
    appointment_date_time DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'SCHEDULED',
    reason TEXT,
    notes TEXT,
    consultation_fee DECIMAL(10,2),
    duration INT DEFAULT 30,
    appointment_type VARCHAR(20) DEFAULT 'IN_PERSON',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_patient_id (patient_id),
    INDEX idx_doctor_id (doctor_id),
    INDEX idx_appointment_date_time (appointment_date_time),
    INDEX idx_status (status)
);

-- Insert sample data
USE patient_db;
INSERT INTO patients (first_name, last_name, email, phone_number, date_of_birth, gender, blood_type, address) VALUES
('John', 'Doe', 'john.doe@email.com', '+1234567890', '1990-05-15', 'Male', 'O+', '123 Main St, City, State'),
('Jane', 'Smith', 'jane.smith@email.com', '+1234567891', '1985-08-22', 'Female', 'A+', '456 Oak Ave, City, State');

USE doctor_db;
INSERT INTO doctors (first_name, last_name, email, phone_number, specialization, license_number, department, experience_years, consultation_fee, available_from_time, available_to_time, available_days) VALUES
('Dr. Robert', 'Johnson', 'dr.johnson@hospital.com', '+1234567892', 'Cardiology', 'MD12345', 'Cardiology', 15, 150.00, '09:00:00', '17:00:00', 'Monday,Tuesday,Wednesday,Thursday,Friday'),
('Dr. Sarah', 'Williams', 'dr.williams@hospital.com', '+1234567893', 'Pediatrics', 'MD12346', 'Pediatrics', 8, 120.00, '08:00:00', '16:00:00', 'Monday,Tuesday,Wednesday,Thursday,Friday');

USE appointment_db;
INSERT INTO appointments (patient_id, doctor_id, appointment_date_time, status, reason, consultation_fee, duration) VALUES
(1, 1, '2025-09-01 10:00:00', 'SCHEDULED', 'Regular checkup', 150.00, 30),
(2, 2, '2025-09-02 14:00:00', 'SCHEDULED', 'Child vaccination', 120.00, 20);
