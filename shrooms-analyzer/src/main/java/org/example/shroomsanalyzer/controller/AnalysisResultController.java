package org.example.shroomsanalyzer.controller;

import org.example.shroomsanalyzer.dto.AnalyzeFamilyDTO;
import org.example.shroomsanalyzer.dto.OccurrenceDataDTO;
import org.example.shroomsanalyzer.dto.SpeciesChartDTO;
import org.example.shroomsanalyzer.entity.AnalysisResult;
import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.example.shroomsanalyzer.service.AnalysisService;
import org.example.shroomsanalyzer.service.FungiService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("api/public/analysis")
public class AnalysisResultController {
    private final AnalysisService analysisService;
    private final FungiService fungiService;

    private AnalysisResultController(FungiService fungiService, AnalysisService analysisService){
        this.fungiService = fungiService;
        this.analysisService = analysisService;
    }

    @GetMapping
    public List<AnalysisResult> getAllFungi() {
        return analysisService.getAllAnalysis();
    }

    @GetMapping("/{id}")
    public Optional<AnalysisResult> getFungiById(@PathVariable Integer id) {
        return  analysisService.getAnalysisById(id);
    }

    @GetMapping("/family/{family}")
    public AnalyzeFamilyDTO analyzeByFamily(@PathVariable String family){
        return analysisService.analyzeByFamily(family);
    }

    @GetMapping("/chart-data")
    public List<SpeciesChartDTO> getChartData() {
        return analysisService.getChartDataBySpecies();
    }

    @GetMapping("/occurrence-data")
    public List<OccurrenceDataDTO> getOccurrenceData() {
        return analysisService.getOccurrenceData();
    }
}
