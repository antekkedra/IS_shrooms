package org.example.shroomsanalyzer.dto;

public record WeatherOccurrenceDTO(
        Double temperatureMean,
        Double precipitationSum,
        Double windSpeedMean
) {}
