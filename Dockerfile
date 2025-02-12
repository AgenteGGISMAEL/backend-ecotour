# Usa una imagen de OpenJDK 17 como base
FROM openjdk:17-jdk-slim

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia todos los archivos del proyecto al contenedor
COPY . .

# Da permisos de ejecución a Maven Wrapper
RUN chmod +x mvnw

# Construye el backend con Maven sin ejecutar pruebas
RUN ./mvnw clean package -DskipTests

# Expone el puerto 8080
EXPOSE 8080

# Ejecuta la aplicación con el JAR generado
CMD ["sh", "-c", "java -jar target/*.jar"]



