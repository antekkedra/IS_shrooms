package org.example.shroomsanalyzer.repository;

import org.example.shroomsanalyzer.dto.AnalyzeFamilyDTO;
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
}