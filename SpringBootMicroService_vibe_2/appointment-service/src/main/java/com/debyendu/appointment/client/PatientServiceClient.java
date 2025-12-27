package com.debyendu.appointment.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "patient-service")
public interface PatientServiceClient {
   
    @GetMapping("/patients/{id}/exists")
    Boolean patientExists(@PathVariable("id") Long id);
}