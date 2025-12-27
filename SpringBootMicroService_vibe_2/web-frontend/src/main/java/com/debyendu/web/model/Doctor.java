package com.debyendu.web.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.math.BigDecimal;
import java.util.Date;

public class Doctor {
   
    private Long id;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
    private String specialization;
    private String licenseNumber;
    private String department;
    private Integer experienceYears;
    private String qualifications;
    private BigDecimal consultationFee;
   
    @JsonFormat(pattern = "HH:mm")
    private Date availableFromTime;
   
    @JsonFormat(pattern = "HH:mm")
    private Date availableToTime;
   
    private String availableDays;
    private String clinicAddress;
   
    // Constructors
    public Doctor() {}
   
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
   
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
   
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
   
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
   
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
   
    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }
   
    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }
   
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
   
    public Integer getExperienceYears() { return experienceYears; }
    public void setExperienceYears(Integer experienceYears) { this.experienceYears = experienceYears; }
   
    public String getQualifications() { return qualifications; }
    public void setQualifications(String qualifications) { this.qualifications = qualifications; }
   
    public BigDecimal getConsultationFee() { return consultationFee; }
    public void setConsultationFee(BigDecimal consultationFee) { this.consultationFee = consultationFee; }
   
    public Date getAvailableFromTime() { return availableFromTime; }
    public void setAvailableFromTime(Date availableFromTime) { this.availableFromTime = availableFromTime; }
   
    public Date getAvailableToTime() { return availableToTime; }
    public void setAvailableToTime(Date availableToTime) { this.availableToTime = availableToTime; }
   
    public String getAvailableDays() { return availableDays; }
    public void setAvailableDays(String availableDays) { this.availableDays = availableDays; }
   
    public String getClinicAddress() { return clinicAddress; }
    public void setClinicAddress(String clinicAddress) { this.clinicAddress = clinicAddress; }
   
    public String getFullName() {
        return "Dr. " + firstName + " " + lastName;
    }
}