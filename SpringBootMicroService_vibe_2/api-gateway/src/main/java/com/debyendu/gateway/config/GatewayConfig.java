package com.debyendu.gateway.config;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {

    @Bean
    public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
        return builder.routes()
                // Patient Service Routes
                .route("patient-service", r -> r.path("/patients/**")
                        .uri("lb://patient-service"))
               
                // Doctor Service Routes
                .route("doctor-service", r -> r.path("/doctors/**")
                        .uri("lb://doctor-service"))
               
                // Appointment Service Routes
                .route("appointment-service", r -> r.path("/appointments/**")
                        .uri("lb://appointment-service"))
               
                .build();
    }
}