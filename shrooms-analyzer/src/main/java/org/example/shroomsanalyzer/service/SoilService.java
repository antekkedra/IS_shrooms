package org.example.shroomsanalyzer.service;

import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.example.shroomsanalyzer.entity.SoilData;
import org.example.shroomsanalyzer.repository.SoilDataRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SoilService {
    private SoilDataRepository repository;
    public SoilService(SoilDataRepository repository){
        this.repository = repository;
    }

    public List<SoilData> getAllSoil(){
        return repository.findAll();
    }

    public Optional<SoilData> getSoilById(Integer id) {
        return repository.findById(id);
    }

}
