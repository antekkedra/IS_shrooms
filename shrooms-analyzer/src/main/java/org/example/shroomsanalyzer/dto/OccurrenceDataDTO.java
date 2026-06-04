package org.example.shroomsanalyzer.dto;

public class OccurrenceDataDTO {
    private String family;
    private Double ph;
    private Double soilMoisture;
    private Double organicCarbon;

    public OccurrenceDataDTO(String family, Double ph, Double soilMoisture, Double organicCarbon) {
        this.family = family;
        this.ph = ph;
        this.soilMoisture = soilMoisture;
        this.organicCarbon = organicCarbon;
    }

    public String getFamily() { return family; }
    public Double getPh() { return ph; }
    public Double getSoilMoisture() { return soilMoisture; }
    public Double getOrganicCarbon() { return organicCarbon; }
}
