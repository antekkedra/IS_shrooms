package org.example.shroomsanalyzer.repository;

import org.example.shroomsanalyzer.entity.WeatherData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WeatherDataRepository extends JpaRepository<WeatherData, Integer> {
}
