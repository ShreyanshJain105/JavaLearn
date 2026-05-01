package com.williamcallahan.javachat.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;

@RestController
public class HealthCheckController {

    @GetMapping("/")
    public ResponseEntity<String> rootHealth() {
        return ResponseEntity.ok("JavaLearn Backend is Live");
    }
}
