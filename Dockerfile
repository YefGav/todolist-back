# Etapa 1: Build de la app con Maven
FROM maven:3.9.6-eclipse-temurin-21 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etapa 2: Imagen final liviana con JDK
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# Copiamos solo el .jar
COPY --from=builder /app/target/*.jar app.jar

# Exponemos el puerto
EXPOSE 8080

# ENTRYPOINT preparado para usar variables externas si se pasan
ENTRYPOINT ["java", "-jar", "app.jar"]
