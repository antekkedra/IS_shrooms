package org.example.shroomsanalyzer.repository;

import org.example.shroomsanalyzer.dto.AnalyzeFamilyDTO;
import org.example.shroomsanalyzer.dto.OccurrenceDataDTO;
import org.example.shroomsanalyzer.dto.SpeciesChartDTO;
import org.example.shroomsanalyzer.entity.FungiOccurrence;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FungiOccurrenceRepository
        extends JpaRepository<FungiOccurrence, Integer> {
    List<FungiOccurrence> findBySpeciesContaining(String species);

    @Query("""
SELECT new org.example.shroomsanalyzer.dto.AnalyzeFamilyDTO(
    fo.family,
    COUNT(fo.id),
    AVG(sd.ph),
    AVG(sd.soilMoisture),
    AVG(sd.organicCarbon)
)
FROM FungiOccurrence fo
JOIN fo.soilData sd
WHERE fo.family = :family
GROUP BY fo.family
""")
    AnalyzeFamilyDTO analyzeByFamily(@Param("family") String family);

    @Query("""
SELECT new org.example.shroomsanalyzer.dto.SpeciesChartDTO(
    fo.species,
    COUNT(fo.id),
    AVG(sd.ph),
    AVG(sd.soilMoisture),
    AVG(sd.organicCarbon)
)
FROM FungiOccurrence fo
JOIN fo.soilData sd
GROUP BY fo.species
ORDER BY COUNT(fo.id) DESC
""")
    List<SpeciesChartDTO> getChartDataBySpecies();

    @Query("""
SELECT new org.example.shroomsanalyzer.dto.OccurrenceDataDTO(
    fo.family,
    sd.ph,
    sd.soilMoisture,
    sd.organicCarbon
)
FROM FungiOccurrence fo
JOIN fo.soilData sd
""")
    List<OccurrenceDataDTO> getOccurrenceData();

    @Query("""
SELECT new org.example.shroomsanalyzer.dto.WeatherOccurrenceDTO(
    wd.temperatureMean,
    wd.precipitationSum,
    wd.windSpeedMean
)
FROM FungiOccurrence fo, WeatherData wd
WHERE fo.latitude = wd.latitude AND fo.longitude = wd.longitude
""")
    List<org.example.shroomsanalyzer.dto.WeatherOccurrenceDTO> getWeatherOccurrenceData();

    @Query("""
SELECT DISTINCT fo
FROM FungiOccurrence fo, WeatherData wd
WHERE fo.latitude = wd.latitude
  AND fo.longitude = wd.longitude
  AND wd.temperatureMean BETWEEN :tempMin AND :tempMax
  AND wd.precipitationSum BETWEEN :precipMin AND :precipMax
  AND wd.windSpeedMean BETWEEN :windMin AND :windMax
""")
    List<FungiOccurrence> findByWeatherConditions(
            @Param("tempMin") Double tempMin,
            @Param("tempMax") Double tempMax,
            @Param("precipMin") Double precipMin,
            @Param("precipMax") Double precipMax,
            @Param("windMin") Double windMin,
            @Param("windMax") Double windMax
    );
}