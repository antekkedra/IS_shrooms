package org.example.shroomsanalyzer.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Entity
@Table(name = "weather_data")
@Getter
@Setter
public class WeatherData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Double latitude;

    private Double longitude;

    @Column(name = "weather_date")
    private LocalDate weatherDate;

    @Column(name = "temperature_mean")
    private Double temperatureMean;

    @Column(name = "precipitation_sum")
    private Double precipitationSum;

    @Column(name = "wind_speed_mean")
    private Double windSpeedMean;
}
