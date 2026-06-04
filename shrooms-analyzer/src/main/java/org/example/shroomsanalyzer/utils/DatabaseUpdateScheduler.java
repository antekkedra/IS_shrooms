package org.example.shroomsanalyzer.utils;

import lombok.RequiredArgsConstructor;
import org.example.shroomsanalyzer.service.DatabaseUpdateService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class DatabaseUpdateScheduler {

    private final DatabaseUpdateService databaseUpdateService;

    @Scheduled(cron = "0 30 2 * * *")
    public void nightlyUpdate() {
        databaseUpdateService.startUpdate();
    }
}
