-- Create database
CREATE DATABASE IF NOT EXISTS patient_management_db;
USE patient_management_db;

-- Create patients table
CREATE TABLE IF NOT EXISTS patients (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(10) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(500) NOT NULL,
    medical_history TEXT
);

-- Create doctors table
CREATE TABLE IF NOT EXISTS doctors (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(10) NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    years_of_experience INT NOT NULL,
    license_number VARCHAR(255) NOT NULL UNIQUE
);

-- Create appointments table
CREATE TABLE IF NOT EXISTS appointments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    patient_id BIGINT NOT NULL,
    doctor_id BIGINT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('SCHEDULED', 'COMPLETED', 'CANCELLED', 'RESCHEDULED') NOT NULL DEFAULT 'SCHEDULED',
    notes TEXT
);

-- Insert sample data
INSERT INTO patients (first_name, last_name, email, phone, date_of_birth, address, medical_history) VALUES
('John', 'Doe', 'john.doe@email.com', '1234567890', '1990-05-15', '123 Main St, City, State 12345', 'No known allergies'),
('Jane', 'Smith', 'jane.smith@email.com', '2345678901', '1985-08-22', '456 Oak Ave, City, State 12345', 'Allergic to penicillin'),
('Bob', 'Johnson', 'bob.johnson@email.com', '3456789012', '1978-12-10', '789 Pine Rd, City, State 12345', 'Diabetes Type 2'),
('Alice', 'Williams', 'alice.williams@email.com', '4567890123', '1992-03-28', '321 Elm St, City, State 12345', 'Hypertension'),
('Charlie', 'Brown', 'charlie.brown@email.com', '5678901234', '1995-07-14', '654 Maple Dr, City, State 12345', 'No medical history');

INSERT INTO doctors (first_name, last_name, email, phone, specialization, years_of_experience, license_number) VALUES
('Sarah', 'Johnson', 'dr.sarah.johnson@hospital.com', '6789012345', 'Cardiology', 15, 'LIC123456'),
('Michael', 'Davis', 'dr.michael.davis@hospital.com', '7890123456', 'Pediatrics', 10, 'LIC234567'),
('Emily', 'Wilson', 'dr.emily.wilson@hospital.com', '8901234567', 'Dermatology', 8, 'LIC345678'),
('David', 'Miller', 'dr.david.miller@hospital.com', '9012345678', 'Orthopedics', 12, 'LIC456789'),
('Lisa', 'Anderson', 'dr.lisa.anderson@hospital.com', '0123456789', 'Neurology', 20, 'LIC567890');

-- Note: Sample appointments should be added with future dates when the application is running