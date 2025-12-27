package com.debyendu.patient.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import java.time.LocalDate;

@Table("patients")
public class Patient {
   
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
   
    private LocalDate dateOfBirth;
   
    private String address;
   
    private String gender;
   
    private String bloodType;
   
    private String emergencyContact;
   
    private String emergencyContactPhone;
   
    // Constructors
    public Patient() {}
   
    public Patient(String firstName, String lastName, String email, String phoneNumber,
                   LocalDate dateOfBirth, String address, String gender, String bloodType,
                   String emergencyContact, String emergencyContactPhone) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.gender = gender;
        this.bloodType = bloodType;
        this.emergencyContact = emergencyContact;
        this.emergencyContactPhone = emergencyContactPhone;
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
   
    public LocalDate getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }
   
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
   
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
   
    public String getBloodType() { return bloodType; }
    public void setBloodType(String bloodType) { this.bloodType = bloodType; }
   
    public String getEmergencyContact() { return emergencyContact; }
    public void setEmergencyContact(String emergencyContact) { this.emergencyContact = emergencyContact; }
   
    public String getEmergencyContactPhone() { return emergencyContactPhone; }
    public void setEmergencyContactPhone(String emergencyContactPhone) { this.emergencyContactPhone = emergencyContactPhone; }
}