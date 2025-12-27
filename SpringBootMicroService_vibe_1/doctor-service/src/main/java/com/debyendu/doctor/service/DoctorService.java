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
        return (List<Doctor>) doctorRepository.findAll();
    }
   
    public Optional<Doctor> getDoctorById(Long id) {
        return doctorRepository.findById(id);
    }
   
    public Doctor saveDoctor(Doctor doctor) {
        return doctorRepository.save(doctor);
    }
   
    public Doctor updateDoctor(Long id, Doctor doctorDetails) {
        Optional<Doctor> optionalDoctor = doctorRepository.findById(id);
        if (optionalDoctor.isPresent()) {
            Doctor doctor = optionalDoctor.get();
            doctor.setFirstName(doctorDetails.getFirstName());
            doctor.setLastName(doctorDetails.getLastName());
            doctor.setEmail(doctorDetails.getEmail());
            doctor.setPhoneNumber(doctorDetails.getPhoneNumber());
            doctor.setSpecialization(doctorDetails.getSpecialization());
            doctor.setLicenseNumber(doctorDetails.getLicenseNumber());
            doctor.setDepartment(doctorDetails.getDepartment());
            doctor.setExperienceYears(doctorDetails.getExperienceYears());
            doctor.setQualifications(doctorDetails.getQualifications());
            doctor.setConsultationFee(doctorDetails.getConsultationFee());
            doctor.setAvailableFromTime(doctorDetails.getAvailableFromTime());
            doctor.setAvailableToTime(doctorDetails.getAvailableToTime());
            doctor.setAvailableDays(doctorDetails.getAvailableDays());
            doctor.setClinicAddress(doctorDetails.getClinicAddress());
            return doctorRepository.save(doctor);
        }
        return null;
    }
   
    public boolean deleteDoctor(Long id) {
        if (doctorRepository.existsById(id)) {
            doctorRepository.deleteById(id);
            return true;
        }
        return false;
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
   
    public List<Doctor> getDoctorsByDepartment(String department) {
        return doctorRepository.findByDepartment(department);
    }
   
    public List<Doctor> searchDoctors(String firstName, String lastName) {
        return doctorRepository.findByFirstNameContainingAndLastNameContaining(firstName, lastName);
    }
   
    public List<Doctor> getDoctorsByMinExperience(Integer minYears) {
        return doctorRepository.findByExperienceYearsGreaterThanEqual(minYears);
    }
}