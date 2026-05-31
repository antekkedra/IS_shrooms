package org.example.shroomsanalyzer.repository;

import org.example.shroomsanalyzer.entity.SoilData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SoilDataRepository
        extends JpaRepository<SoilData, Integer> {
}