package org.example.shroomsanalyzer.service;

import org.example.shroomsanalyzer.dto.*;

import java.util.List;

public interface AdminUserService {

    List<UserResponse> getAllUsers();

    UserResponse getUserById(Integer id);

    UserResponse createUser(CreateUserRequest request);

    UserResponse updateUser(Integer id, UpdateUserRequest request);

    void deleteUser(Integer id);

    void changePassword(Integer id, ChangePasswordRequest request);
}