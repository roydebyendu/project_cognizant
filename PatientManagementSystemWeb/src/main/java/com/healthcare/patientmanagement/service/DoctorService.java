package com.healthcare.patientmanagement.service;

import com.healthcare.patientmanagement.entity.Doctor;
import com.healthcare.patientmanagement.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class DoctorService {
   
    @Autowired
    private DoctorRepository doctorRepository;
   
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }
   
    public Optional<Doctor> getDoctorById(Long id) {
        return doctorRepository.findById(id);
    }
   
    public Optional<Doctor> getDoctorByEmail(String email) {
        return doctorRepository.findByEmail(email);
    }
   
    public Optional<Doctor> getDoctorByLicenseNumber(String licenseNumber) {
        return doctorRepository.findByLicenseNumber(licenseNumber);
    }
   
    public Doctor saveDoctor(Doctor doctor) {
        validateDoctor(doctor);
        return doctorRepository.save(doctor);
    }
   
    public Doctor updateDoctor(Long id, Doctor doctorDetails) {
        Doctor doctor = doctorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found with id: " + id));
       
        doctor.setFirstName(doctorDetails.getFirstName());
        doctor.setLastName(doctorDetails.getLastName());
        doctor.setEmail(doctorDetails.getEmail());
        doctor.setPhoneNumber(doctorDetails.getPhoneNumber());
        doctor.setSpecialization(doctorDetails.getSpecialization());
        doctor.setLicenseNumber(doctorDetails.getLicenseNumber());
        doctor.setDepartment(doctorDetails.getDepartment());
        doctor.setExperienceYears(doctorDetails.getExperienceYears());
        doctor.setQualification(doctorDetails.getQualification());
        doctor.setConsultationFee(doctorDetails.getConsultationFee());
        doctor.setIsAvailable(doctorDetails.getIsAvailable());
       
        return doctorRepository.save(doctor);
    }
   
    public void deleteDoctor(Long id) {
        Doctor doctor = doctorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found with id: " + id));
        doctorRepository.delete(doctor);
    }
   
    public List<Doctor> searchDoctors(String searchTerm) {
        return doctorRepository.searchDoctors(searchTerm);
    }
   
    public List<Doctor> getDoctorsBySpecialization(String specialization) {
        return doctorRepository.findBySpecializationContainingIgnoreCase(specialization);
    }
   
    public List<Doctor> getDoctorsByDepartment(String department) {
        return doctorRepository.findByDepartmentContainingIgnoreCase(department);
    }
   
    public List<Doctor> getAvailableDoctors() {
        return doctorRepository.findByIsAvailable(true);
    }
   
    public List<Doctor> getAvailableDoctorsBySpecialization(String specialization) {
        return doctorRepository.findAvailableDoctorsBySpecialization(specialization);
    }
   
    public Doctor setDoctorAvailability(Long id, Boolean isAvailable) {
        Doctor doctor = doctorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found with id: " + id));
        doctor.setIsAvailable(isAvailable);
        return doctorRepository.save(doctor);
    }
   
    public boolean existsByEmail(String email) {
        return doctorRepository.existsByEmail(email);
    }
   
    public boolean existsByLicenseNumber(String licenseNumber) {
        return doctorRepository.existsByLicenseNumber(licenseNumber);
    }
   
    private void validateDoctor(Doctor doctor) {
        if (doctor.getId() == null && existsByEmail(doctor.getEmail())) {
            throw new RuntimeException("Doctor with email " + doctor.getEmail() + " already exists");
        }
       
        if (doctor.getId() == null && existsByLicenseNumber(doctor.getLicenseNumber())) {
            throw new RuntimeException("Doctor with license number " + doctor.getLicenseNumber() + " already exists");
        }
    }
}