package org.example.shroomsanalyzer.controller;

import lombok.RequiredArgsConstructor;
import org.example.shroomsanalyzer.service.DatabaseUpdateService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/admin/database")
@RequiredArgsConstructor
public class DatabaseAdminController {

    private final DatabaseUpdateService databaseUpdateService;

    @PostMapping("/update")
    public ResponseEntity<Void> startUpdate() {

        databaseUpdateService.startUpdate();

        return ResponseEntity.accepted().build();
    }

    @GetMapping("/status")
    public Map<String, String> getStatus() {

        return Map.of(
                "status", databaseUpdateService.getStatus().name(),
                "message", databaseUpdateService.getMessage()
        );
    }
}
