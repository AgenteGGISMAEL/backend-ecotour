# Usa una imagen de OpenJDK 17
FROM openjdk:17-jdk-slim

# Crea el directorio de la aplicación dentro del contenedor
WORKDIR /app

# Copia los archivos del proyecto al contenedor
COPY . .

# Construye el backend con Maven
RUN ./mvnw clean install

# Expone el puerto 8080
EXPOSE 8080

# Ejecuta la aplicación
CMD ["java", "-jar", "target/*.jar"]
