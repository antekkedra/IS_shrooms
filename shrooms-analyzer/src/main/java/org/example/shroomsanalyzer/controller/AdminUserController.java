package org.example.shroomsanalyzer.controller;

import lombok.RequiredArgsConstructor;
import org.example.shroomsanalyzer.dto.*;
import org.example.shroomsanalyzer.service.AdminUserService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/users")
@RequiredArgsConstructor
public class AdminUserController {

    private final AdminUserService adminUserService;

    @GetMapping
    public List<UserResponse> getAllUsers() {
        return adminUserService.getAllUsers();
    }

    @GetMapping("/{id}")
    public UserResponse getUser(@PathVariable Integer id) {
        return adminUserService.getUserById(id);
    }

    @PostMapping
    public UserResponse createUser(
            @RequestBody CreateUserRequest request) {

        return adminUserService.createUser(request);
    }

    @PutMapping("/{id}")
    public UserResponse updateUser(
            @PathVariable Integer id,
            @RequestBody UpdateUserRequest request) {

        return adminUserService.updateUser(id, request);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(
            @PathVariable Integer id) {

        adminUserService.deleteUser(id);

        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}/password")
    public ResponseEntity<Void> changePassword(
            @PathVariable Integer id,
            @RequestBody ChangePasswordRequest request) {

        adminUserService.changePassword(id, request);

        return ResponseEntity.noContent().build();
    }
}