package com.debyendu.patient.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDate;

@Entity
@Table(name = "patients")
public class Patient {
   
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
   
    @NotNull(message = "Date of birth is required")
    @Past(message = "Date of birth must be in the past")
    @Column(name = "date_of_birth", nullable = false)
    private LocalDate dateOfBirth;
   
    @NotBlank(message = "Address is required")
    @Column(name = "address", nullable = false, length = 500)
    private String address;
   
    @Column(name = "medical_history", length = 1000)
    private String medicalHistory;
   
    // Constructors
    public Patient() {}
   
    public Patient(String firstName, String lastName, String email, String phone,
                  LocalDate dateOfBirth, String address, String medicalHistory) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.medicalHistory = medicalHistory;
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
   
    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }
   
    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
   
    public String getAddress() {
        return address;
    }
   
    public void setAddress(String address) {
        this.address = address;
    }
   
    public String getMedicalHistory() {
        return medicalHistory;
    }
   
    public void setMedicalHistory(String medicalHistory) {
        this.medicalHistory = medicalHistory;
    }
   
    public String getFullName() {
        return firstName + " " + lastName;
    }
}