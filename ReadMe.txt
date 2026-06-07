Wymagania systemowe:
Java 21
Maven
Docker

Dane do połączenia z bazą ustawiane są w pliku docker-compose.yml:
  db:
    environment:
      POSTGRES_DB: shroomsDB
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: haslo

  app:
    environment:
      SPRING_DATASOURCE_URL: jdbc:postgresql://db:5432/shroomsDB
      SPRING_DATASOURCE_USERNAME: postgres
      SPRING_DATASOURCE_PASSWORD: haslo

Polecenia do uruchomienia aplikacji:
cd shrooms-analyzer
mvn clean package -DskipTests=true
cd ..
docker compose build
docker compose up

Aplikacja dostępna jest pod adresem: http://localhost:8080/
