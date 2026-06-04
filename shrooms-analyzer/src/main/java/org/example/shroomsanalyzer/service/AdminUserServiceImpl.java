package org.example.shroomsanalyzer.service;

import lombok.RequiredArgsConstructor;
import org.example.shroomsanalyzer.dto.*;
import org.example.shroomsanalyzer.entity.User;
import org.example.shroomsanalyzer.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminUserServiceImpl implements AdminUserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public List<UserResponse> getAllUsers() {

        return userRepository.findAll()
                .stream()
                .map(this::mapToResponse)
                .toList();
    }

    @Override
    public UserResponse getUserById(Integer id) {

        User user = findUser(id);

        return mapToResponse(user);
    }

    @Override
    public UserResponse createUser(CreateUserRequest request) {

        if (userRepository.findByUsername(request.username()).isPresent()) {
            throw new RuntimeException("Username already exists");
        }

        User user = new User();

        user.setUsername(request.username());
        user.setPasswordHash(
                passwordEncoder.encode(request.password())
        );
        user.setRole(request.role());

        return mapToResponse(
                userRepository.save(user)
        );
    }

    @Override
    public UserResponse updateUser(Integer id,
                                   UpdateUserRequest request) {

        User user = findUser(id);

        user.setUsername(request.username());
        user.setRole(request.role());

        return mapToResponse(
                userRepository.save(user)
        );
    }

    @Override
    public void deleteUser(Integer id) {

        User user = findUser(id);

        userRepository.delete(user);
    }

    @Override
    public void changePassword(Integer id,
                               ChangePasswordRequest request) {

        User user = findUser(id);

        user.setPasswordHash(
                passwordEncoder.encode(request.password())
        );

        userRepository.save(user);
    }

    private User findUser(Integer id) {
        return userRepository.findById(id)
                .orElseThrow(() ->
                        new RuntimeException("User not found"));
    }

    private UserResponse mapToResponse(User user) {

        return new UserResponse(
                user.getId(),
                user.getUsername(),
                user.getRole()
        );
    }
}