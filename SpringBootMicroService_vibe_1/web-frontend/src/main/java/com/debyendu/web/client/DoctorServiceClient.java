package com.debyendu.web.client;

import com.debyendu.web.model.Doctor;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@FeignClient(name = "doctor-service", url = "${api.gateway.url}")
public interface DoctorServiceClient {
   
    @GetMapping("/api/doctors")
    List<Doctor> getAllDoctors();
   
    @GetMapping("/api/doctors/{id}")
    Doctor getDoctorById(@PathVariable("id") Long id);
   
    @PostMapping("/api/doctors")
    Doctor createDoctor(@RequestBody Doctor doctor);
   
    @PutMapping("/api/doctors/{id}")
    Doctor updateDoctor(@PathVariable("id") Long id, @RequestBody Doctor doctor);
   
    @DeleteMapping("/api/doctors/{id}")
    void deleteDoctor(@PathVariable("id") Long id);
   
    @GetMapping("/api/doctors/specialization/{specialization}")
    List<Doctor> getDoctorsBySpecialization(@PathVariable("specialization") String specialization);
   
    @GetMapping("/api/doctors/department/{department}")
    List<Doctor> getDoctorsByDepartment(@PathVariable("department") String department);
   
    @GetMapping("/api/doctors/search")
    List<Doctor> searchDoctors(@RequestParam("firstName") String firstName,
                              @RequestParam("lastName") String lastName);
}