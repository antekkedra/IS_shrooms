package org.example.shroomsanalyzer.controller;

import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.example.shroomsanalyzer.service.FungiService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("api/fungi")
public class FungiController {
    private final FungiService service;

    public FungiController(FungiService service){
        this.service = service;
    }

    @GetMapping
    public List<FungiOccurrence> getAllFungi() {
        return service.getAllFungi();
    }

    @GetMapping("/{id}")
    public Optional<FungiOccurrence> getFungiById(@PathVariable Integer id) {
        return  service.getFungiById(id);
    }

    @GetMapping("/species/{species}")
    public List<FungiOccurrence> getFungiBySpeciesContaining(@PathVariable String species) {
        return service.getFungiBySpeciesContaining(species);
    }
}
