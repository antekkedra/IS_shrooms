package org.example.shroomsanalyzer.controller;

import org.example.shroomsanalyzer.entity.SoilData;
import org.example.shroomsanalyzer.service.SoilService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/public/soil")
public class SoilController {
    private final SoilService service;

    public SoilController(SoilService service){
        this.service = service;
    }

    @GetMapping
    public List<SoilData> getAllFungi() {
        return service.getAllSoil();
    }

    @GetMapping("/{id}")
    public Optional<SoilData> getFungiById(@PathVariable Integer id) {
        return  service.getSoilById(id);
    }
}
