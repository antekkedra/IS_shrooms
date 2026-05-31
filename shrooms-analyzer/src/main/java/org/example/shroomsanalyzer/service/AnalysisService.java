package org.example.shroomsanalyzer.service;


import org.example.shroomsanalyzer.dto.AnalyzeFamilyDTO;
import org.example.shroomsanalyzer.entity.AnalysisResult;
import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.example.shroomsanalyzer.repository.AnalysisResultRepository;
import org.example.shroomsanalyzer.repository.FungiOccurrenceRepository;
import org.springframework.stereotype.Service;

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

    public List<AnalysisResult> getAllAnalysis() {
        return analysisResultRepository.findAll();
    }

    public Optional<AnalysisResult> getAnalysisById(Integer id) {
        return analysisResultRepository.findById(id);
    }

    public AnalyzeFamilyDTO analyzeByFamily(String family){
        return fungiOccurrenceRepository.analyzeByFamily(family);
    }

}
