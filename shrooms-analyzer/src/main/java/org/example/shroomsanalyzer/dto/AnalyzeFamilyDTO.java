package org.example.shroomsanalyzer.dto;

public class AnalyzeFamilyDTO {
    private String family;
    private Long occurrences;
    private Double avgPh;
    private Double avgMoisture;
    private Double avgCarbon;

    public AnalyzeFamilyDTO(String family, Long occurrences, Double avgPh, Double avgMoisture, Double avgCarbon) {
        this.family = family;
        this.occurrences = occurrences;
        this.avgPh = avgPh;
        this.avgMoisture = avgMoisture;
        this.avgCarbon = avgCarbon;
    }

    public String getFamily() {
        return family;
    }

    public void setFamily(String family) {
        this.family = family;
    }

    public Long getOccurrences() {
        return occurrences;
    }

    public void setOccurrences(Long occurrences) {
        this.occurrences = occurrences;
    }

    public Double getAvgPh() {
        return avgPh;
    }

    public void setAvgPh(Double avgPh) {
        this.avgPh = avgPh;
    }

    public Double getAvgMoisture() {
        return avgMoisture;
    }

    public void setAvgMoisture(Double avgMoisture) {
        this.avgMoisture = avgMoisture;
    }

    public Double getAvgCarbon() {
        return avgCarbon;
    }

    public void setAvgCarbon(Double avgCarbon) {
        this.avgCarbon = avgCarbon;
    }
}
