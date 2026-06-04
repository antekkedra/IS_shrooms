package org.example.shroomsanalyzer.dto;

public record CreateUserRequest(
        String username,
        String password,
        String role
) {
}
