package org.example.shroomsanalyzer.service;

import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.example.shroomsanalyzer.repository.FungiOccurrenceRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class FungiService {
    private FungiOccurrenceRepository repository;

    public FungiService(FungiOccurrenceRepository repository) {
        this.repository = repository;
    }

    public List<FungiOccurrence> getAllFungi() {
        return repository.findAll();
    }

    public Optional<FungiOccurrence> getFungiById(Integer id) {
        return repository.findById(id);
    }

    public List<FungiOccurrence> getFungiBySpeciesContaining(String species) {
        return repository.findBySpeciesContaining(species);
    }
}
