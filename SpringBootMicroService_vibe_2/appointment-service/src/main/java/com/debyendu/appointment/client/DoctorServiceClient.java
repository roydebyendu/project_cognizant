package com.debyendu.appointment.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "doctor-service")
public interface DoctorServiceClient {
   
    @GetMapping("/doctors/{id}/exists")
    Boolean doctorExists(@PathVariable("id") Long id);
}