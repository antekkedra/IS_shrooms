package org.example.shroomsanalyzer.service;

import org.example.shroomsanalyzer.entity.SoilData;
import org.example.shroomsanalyzer.repository.SoilDataRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class SoilService {
    private SoilDataRepository repository;

    public SoilService(SoilDataRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public List<SoilData> getAllSoil() {
        return repository.findAll();
    }

    @Transactional(readOnly = true, isolation = Isolation.READ_COMMITTED)
    public Optional<SoilData> getSoilById(Integer id) {
        return repository.findById(id);
    }
}
