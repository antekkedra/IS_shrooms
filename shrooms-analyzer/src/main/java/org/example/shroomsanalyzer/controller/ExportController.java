package org.example.shroomsanalyzer.controller;

import org.example.shroomsanalyzer.dto.xml.AnalysisListXml;
import org.example.shroomsanalyzer.dto.xml.FungiListXml;
import org.example.shroomsanalyzer.dto.xml.SoilListXml;
import org.example.shroomsanalyzer.service.AnalysisService;
import org.example.shroomsanalyzer.service.FungiService;
import org.example.shroomsanalyzer.service.SoilService;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/export")
public class ExportController {

    private final FungiService fungiService;
    private final SoilService soilService;
    private final AnalysisService analysisService;

    public ExportController(FungiService fungiService, SoilService soilService, AnalysisService analysisService) {
        this.fungiService = fungiService;
        this.soilService = soilService;
        this.analysisService = analysisService;
    }

    @GetMapping(value = "/fungi", produces = MediaType.APPLICATION_XML_VALUE)
    public FungiListXml exportFungi() {
        return new FungiListXml(fungiService.getAllFungi());
    }

    @GetMapping(value = "/soil", produces = MediaType.APPLICATION_XML_VALUE)
    public SoilListXml exportSoil() {
        return new SoilListXml(soilService.getAllSoil());
    }

    @GetMapping(value = "/analysis", produces = MediaType.APPLICATION_XML_VALUE)
    public AnalysisListXml exportAnalysis() {
        return new AnalysisListXml(analysisService.getAllAnalysis());
    }
}
