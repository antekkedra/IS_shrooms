package org.example.shroomsanalyzer.security;

import lombok.RequiredArgsConstructor;
import org.example.shroomsanalyzer.entity.User;
import org.example.shroomsanalyzer.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@RequiredArgsConstructor
public class DataInitializer {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Bean
    CommandLineRunner initUsers() {

        return args -> {

            if (userRepository.findByUsername("admin").isEmpty()) {

                User admin = new User();
                admin.setUsername("admin");
                admin.setPasswordHash(
                        passwordEncoder.encode("admin123"));
                admin.setRole("ADMIN");

                userRepository.save(admin);
            }

            if (userRepository.findByUsername("user").isEmpty()) {

                User user = new User();
                user.setUsername("user");
                user.setPasswordHash(
                        passwordEncoder.encode("user123"));
                user.setRole("USER");

                userRepository.save(user);
            }
        };
    }
}