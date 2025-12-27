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
