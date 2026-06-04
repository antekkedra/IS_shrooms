package org.example.shroomsanalyzer.dto;

public record UserResponse(
        Integer id,
        String username,
        String role
) {}
