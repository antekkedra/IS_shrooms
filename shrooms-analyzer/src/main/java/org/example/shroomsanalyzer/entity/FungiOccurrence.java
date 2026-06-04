package org.example.shroomsanalyzer.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "fungi_occurrence")
@Getter
@Setter
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class FungiOccurrence {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String species;

    private String genus;

    private String family;

    private Double latitude;

    private Double longitude;

    @Column(name = "event_date")
    private String eventDate;

    private String country;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "soil_data_id")
    private SoilData soilData;
}