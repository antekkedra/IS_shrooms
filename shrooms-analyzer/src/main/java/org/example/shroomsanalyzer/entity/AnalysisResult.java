package org.example.shroomsanalyzer.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Entity
@Table(name = "analysis_result")
@Getter
@Setter
public class AnalysisResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @OneToOne
    @JoinColumn(name = "fungi_occurrence_id")
    private FungiOccurrence fungiOccurrence;

    @OneToOne
    @JoinColumn(name = "soil_data_id")
    private SoilData soilData;

    @Column(name = "correlation_value")
    private Double correlationValue;

    @Column(name = "created_at")
    private Date createdAt;
}
