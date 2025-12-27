package com.debyendu.doctor.service;

import com.debyendu.doctor.model.Doctor;
import com.debyendu.doctor.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
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
   
    public List<Doctor> getDoctorsBySpecialization(String specialization) {
        return doctorRepository.findBySpecialization(specialization);
    }
   
    public List<Doctor> searchDoctorsByName(String name) {
        return doctorRepository.findByNameContaining(name);
    }
   
    public List<Doctor> getDoctorsByExperience(Integer minYears) {
        return doctorRepository.findByYearsOfExperienceGreaterThanEqual(minYears);
    }
   
    public Doctor createDoctor(Doctor doctor) {
        if (doctorRepository.existsByEmail(doctor.getEmail())) {
            throw new RuntimeException("Doctor with email " + doctor.getEmail() + " already exists");
        }
        if (doctorRepository.existsByLicenseNumber(doctor.getLicenseNumber())) {
            throw new RuntimeException("Doctor with license number " + doctor.getLicenseNumber() + " already exists");
        }
        if (doctorRepository.existsByPhone(doctor.getPhone())) {
            throw new RuntimeException("Doctor with phone " + doctor.getPhone() + " already exists");
        }
        return doctorRepository.save(doctor);
    }
   
    public Doctor updateDoctor(Long id, Doctor doctorDetails) {
        Doctor doctor = doctorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found with id: " + id));
       
        // Check if email is being changed and if new email already exists
        if (!doctor.getEmail().equals(doctorDetails.getEmail()) &&
            doctorRepository.existsByEmail(doctorDetails.getEmail())) {
            throw new RuntimeException("Doctor with email " + doctorDetails.getEmail() + " already exists");
        }
       
        // Check if license number is being changed and if new license number already exists
        if (!doctor.getLicenseNumber().equals(doctorDetails.getLicenseNumber()) &&
            doctorRepository.existsByLicenseNumber(doctorDetails.getLicenseNumber())) {
            throw new RuntimeException("Doctor with license number " + doctorDetails.getLicenseNumber() + " already exists");
        }
       
        // Check if phone is being changed and if new phone already exists
        if (!doctor.getPhone().equals(doctorDetails.getPhone()) &&
            doctorRepository.existsByPhone(doctorDetails.getPhone())) {
            throw new RuntimeException("Doctor with phone " + doctorDetails.getPhone() + " already exists");
        }
       
        doctor.setFirstName(doctorDetails.getFirstName());
        doctor.setLastName(doctorDetails.getLastName());
        doctor.setEmail(doctorDetails.getEmail());
        doctor.setPhone(doctorDetails.getPhone());
        doctor.setSpecialization(doctorDetails.getSpecialization());
        doctor.setYearsOfExperience(doctorDetails.getYearsOfExperience());
        doctor.setLicenseNumber(doctorDetails.getLicenseNumber());
       
        return doctorRepository.save(doctor);
    }
   
    public void deleteDoctor(Long id) {
        Doctor doctor = doctorRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Doctor not found with id: " + id));
        doctorRepository.delete(doctor);
    }
   
    public boolean existsById(Long id) {
        return doctorRepository.existsById(id);
    }
}