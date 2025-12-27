package com.debyendu.doctor.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(name = "doctors")
public class Doctor {
   
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
   
    @NotBlank(message = "First name is required")
    @Column(name = "first_name", nullable = false)
    private String firstName;
   
    @NotBlank(message = "Last name is required")
    @Column(name = "last_name", nullable = false)
    private String lastName;
   
    @Email(message = "Email should be valid")
    @NotBlank(message = "Email is required")
    @Column(name = "email", nullable = false, unique = true)
    private String email;
   
    @NotBlank(message = "Phone number is required")
    @Pattern(regexp = "^[0-9]{10}$", message = "Phone number should be 10 digits")
    @Column(name = "phone", nullable = false)
    private String phone;
   
    @NotBlank(message = "Specialization is required")
    @Column(name = "specialization", nullable = false)
    private String specialization;
   
    @NotNull(message = "Years of experience is required")
    @Min(value = 0, message = "Years of experience cannot be negative")
    @Column(name = "years_of_experience", nullable = false)
    private Integer yearsOfExperience;
   
    @NotBlank(message = "License number is required")
    @Column(name = "license_number", nullable = false, unique = true)
    private String licenseNumber;
   
    // Constructors
    public Doctor() {}
   
    public Doctor(String firstName, String lastName, String email, String phone,
                 String specialization, Integer yearsOfExperience, String licenseNumber) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.specialization = specialization;
        this.yearsOfExperience = yearsOfExperience;
        this.licenseNumber = licenseNumber;
    }
   
    // Getters and Setters
    public Long getId() {
        return id;
    }
   
    public void setId(Long id) {
        this.id = id;
    }
   
    public String getFirstName() {
        return firstName;
    }
   
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
   
    public String getLastName() {
        return lastName;
    }
   
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
   
    public String getEmail() {
        return email;
    }
   
    public void setEmail(String email) {
        this.email = email;
    }
   
    public String getPhone() {
        return phone;
    }
   
    public void setPhone(String phone) {
        this.phone = phone;
    }
   
    public String getSpecialization() {
        return specialization;
    }
   
    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }
   
    public Integer getYearsOfExperience() {
        return yearsOfExperience;
    }
   
    public void setYearsOfExperience(Integer yearsOfExperience) {
        this.yearsOfExperience = yearsOfExperience;
    }
   
    public String getLicenseNumber() {
        return licenseNumber;
    }
   
    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
   
    public String getFullName() {
        return "Dr. " + firstName + " " + lastName;
    }
}