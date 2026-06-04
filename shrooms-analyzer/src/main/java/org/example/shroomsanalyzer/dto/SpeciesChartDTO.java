package org.example.shroomsanalyzer.dto;

public class SpeciesChartDTO {
    private String species;
    private Long occurrences;
    private Double avgPh;
    private Double avgMoisture;
    private Double avgCarbon;

    public SpeciesChartDTO(String species, Long occurrences, Double avgPh, Double avgMoisture, Double avgCarbon) {
        this.species = species;
        this.occurrences = occurrences;
        this.avgPh = avgPh;
        this.avgMoisture = avgMoisture;
        this.avgCarbon = avgCarbon;
    }

    public String getSpecies() { return species; }
    public Long getOccurrences() { return occurrences; }
    public Double getAvgPh() { return avgPh; }
    public Double getAvgMoisture() { return avgMoisture; }
    public Double getAvgCarbon() { return avgCarbon; }
}
