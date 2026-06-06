package org.example.shroomsanalyzer.controller;

import org.example.shroomsanalyzer.dto.WeatherOccurrenceDTO;
import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.example.shroomsanalyzer.repository.FungiOccurrenceRepository;
import org.example.shroomsanalyzer.service.FungiService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/public/weather")
public class WeatherController {

    private final FungiService fungiService;
    private final FungiOccurrenceRepository fungiRepository;

    public WeatherController(FungiService fungiService, FungiOccurrenceRepository fungiRepository) {
        this.fungiService = fungiService;
        this.fungiRepository = fungiRepository;
    }

    @GetMapping("/occurrence-data")
    public List<WeatherOccurrenceDTO> getWeatherOccurrenceData() {
        return fungiRepository.getWeatherOccurrenceData();
    }

    @GetMapping("/fungi-by-conditions")
    public List<FungiOccurrence> getFungiByWeatherConditions(
            @RequestParam(defaultValue = "-10") double tempMin,
            @RequestParam(defaultValue = "35")  double tempMax,
            @RequestParam(defaultValue = "0")   double precipMin,
            @RequestParam(defaultValue = "50")  double precipMax,
            @RequestParam(defaultValue = "0")   double windMin,
            @RequestParam(defaultValue = "40")  double windMax) {

        return fungiService.getFungiByWeatherConditions(
                tempMin, tempMax, precipMin, precipMax, windMin, windMax);
    }
}
