package org.example.shroomsanalyzer.service;

import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.example.shroomsanalyzer.repository.FungiOccurrenceRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class FungiService {
    private FungiOccurrenceRepository repository;

    public FungiService(FungiOccurrenceRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<FungiOccurrence> getAllFungi() {
        return repository.findAll();
    }

    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Optional<FungiOccurrence> getFungiById(Integer id) {
        return repository.findById(id);
    }

    // REPEATABLE_READ: wyniki wyszukiwania muszą być spójne przy wielokrotnym
    // odczycie w tej samej transakcji (zapobiega phantom reads dla paginacji)
    @Transactional(readOnly = true, isolation = Isolation.REPEATABLE_READ)
    public List<FungiOccurrence> getFungiBySpeciesContaining(String species) {
        return repository.findBySpeciesContaining(species);
    }
}
