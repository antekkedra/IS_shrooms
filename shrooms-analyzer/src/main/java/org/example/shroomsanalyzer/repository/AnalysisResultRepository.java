package org.example.shroomsanalyzer.repository;

import org.example.shroomsanalyzer.entity.AnalysisResult;
import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AnalysisResultRepository
        extends JpaRepository<AnalysisResult, Integer> {

}