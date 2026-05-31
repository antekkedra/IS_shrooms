package org.example.shroomsanalyzer.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "soil_data")
@Getter
@Setter
public class SoilData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "ph")
    private Double ph;

    @Column(name = "organic_carbon")
    private Double organicCarbon;

    private Double clay;

    private Double sand;

    private Double silt;

    @Column(name = "soil_moisture")
    private Double soilMoisture;

    private Integer depth;

    private Double longitude;

    private Double latitude;
}