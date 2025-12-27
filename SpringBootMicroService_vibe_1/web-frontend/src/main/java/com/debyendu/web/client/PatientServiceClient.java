package com.debyendu.web.client;

import com.debyendu.web.model.Patient;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@FeignClient(name = "patient-service", url = "${api.gateway.url}")
public interface PatientServiceClient {
   
    @GetMapping("/api/patients")
    List<Patient> getAllPatients();
   
    @GetMapping("/api/patients/{id}")
    Patient getPatientById(@PathVariable("id") Long id);
   
    @PostMapping("/api/patients")
    Patient createPatient(@RequestBody Patient patient);
   
    @PutMapping("/api/patients/{id}")
    Patient updatePatient(@PathVariable("id") Long id, @RequestBody Patient patient);
   
    @DeleteMapping("/api/patients/{id}")
    void deletePatient(@PathVariable("id") Long id);
   
    @GetMapping("/api/patients/search")
    List<Patient> searchPatients(@RequestParam("firstName") String firstName,
                                @RequestParam("lastName") String lastName);
   
    @GetMapping("/api/patients/blood-type/{bloodType}")
    List<Patient> getPatientsByBloodType(@PathVariable("bloodType") String bloodType);
}