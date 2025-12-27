package com.debyendu.web.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class Patient {
   
    private Long id;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNumber;
   
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date dateOfBirth;
   
    private String address;
    private String gender;
    private String bloodType;
    private String emergencyContact;
    private String emergencyContactPhone;
   
    // Constructors
    public Patient() {}
   
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
   
    public Date getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }
   
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
   
    public String getFullName() {
        return firstName + " " + lastName;
    }
}