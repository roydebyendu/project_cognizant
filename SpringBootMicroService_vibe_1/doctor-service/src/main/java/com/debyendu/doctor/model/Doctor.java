package com.debyendu.doctor.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.time.LocalTime;

@Table("doctors")
public class Doctor {
   
    @Id
    private Long id;
   
    @NotBlank(message = "First name is required")
    private String firstName;
   
    @NotBlank(message = "Last name is required")
    private String lastName;
   
    @Email(message = "Email should be valid")
    private String email;
   
    @Pattern(regexp = "^\\+?[1-9]\\d{1,14}$", message = "Phone number should be valid")
    private String phoneNumber;
   
    @NotBlank(message = "Specialization is required")
    private String specialization;
   
    @NotBlank(message = "License number is required")
    private String licenseNumber;
   
    private String department;
   
    private Integer experienceYears;
   
    private String qualifications;
   
    private BigDecimal consultationFee;
   
    private LocalTime availableFromTime;
   
    private LocalTime availableToTime;
   
    private String availableDays;
   
    private String clinicAddress;
   
    // Constructors
    public Doctor() {}
   
    public Doctor(String firstName, String lastName, String email, String phoneNumber,
                  String specialization, String licenseNumber, String department,
                  Integer experienceYears, String qualifications, BigDecimal consultationFee,
                  LocalTime availableFromTime, LocalTime availableToTime, String availableDays,
                  String clinicAddress) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.specialization = specialization;
        this.licenseNumber = licenseNumber;
        this.department = department;
        this.experienceYears = experienceYears;
        this.qualifications = qualifications;
        this.consultationFee = consultationFee;
        this.availableFromTime = availableFromTime;
        this.availableToTime = availableToTime;
        this.availableDays = availableDays;
        this.clinicAddress = clinicAddress;
    }
   
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
   
    public LocalTime getAvailableFromTime() { return availableFromTime; }
    public void setAvailableFromTime(LocalTime availableFromTime) { this.availableFromTime = availableFromTime; }
   
    public LocalTime getAvailableToTime() { return availableToTime; }
    public void setAvailableToTime(LocalTime availableToTime) { this.availableToTime = availableToTime; }
   
    public String getAvailableDays() { return availableDays; }
    public void setAvailableDays(String availableDays) { this.availableDays = availableDays; }
   
    public String getClinicAddress() { return clinicAddress; }
    public void setClinicAddress(String clinicAddress) { this.clinicAddress = clinicAddress; }
}