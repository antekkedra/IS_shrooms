package org.example.shroomsanalyzer.dto;

public record UpdateUserRequest(
        String username,
        String role
) {
}
