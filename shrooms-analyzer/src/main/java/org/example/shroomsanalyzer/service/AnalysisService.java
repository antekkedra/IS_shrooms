package org.example.shroomsanalyzer.service;

import org.example.shroomsanalyzer.dto.AnalyzeFamilyDTO;
import org.example.shroomsanalyzer.dto.OccurrenceDataDTO;
import org.example.shroomsanalyzer.dto.SpeciesChartDTO;
import org.example.shroomsanalyzer.entity.AnalysisResult;
import org.example.shroomsanalyzer.repository.AnalysisResultRepository;
import org.example.shroomsanalyzer.repository.FungiOccurrenceRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class AnalysisService {
    private AnalysisResultRepository analysisResultRepository;
    private FungiOccurrenceRepository fungiOccurrenceRepository;

    public AnalysisService(FungiOccurrenceRepository fungiOccurrenceRepository, AnalysisResultRepository analysisResultRepository) {
        this.fungiOccurrenceRepository = fungiOccurrenceRepository;
        this.analysisResultRepository = analysisResultRepository;
    }

    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<AnalysisResult> getAllAnalysis() {
        return analysisResultRepository.findAll();
    }

    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Optional<AnalysisResult> getAnalysisById(Integer id) {
        return analysisResultRepository.findById(id);
    }

    @Transactional(readOnly = true, isolation = Isolation.REPEATABLE_READ)
    public AnalyzeFamilyDTO analyzeByFamily(String family) {
        return fungiOccurrenceRepository.analyzeByFamily(family);
    }

    @Transactional(readOnly = true, isolation = Isolation.REPEATABLE_READ)
    public List<SpeciesChartDTO> getChartDataBySpecies() {
        return fungiOccurrenceRepository.getChartDataBySpecies();
    }

    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<OccurrenceDataDTO> getOccurrenceData() {
        return fungiOccurrenceRepository.getOccurrenceData();
    }
}
