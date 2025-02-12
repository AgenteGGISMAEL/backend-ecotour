# Usa una imagen base con JDK 17
FROM openjdk:17-jdk-slim

# Instala Maven
RUN apt-get update && apt-get install -y maven

# Define el directorio de trabajo
WORKDIR /app

# Copia el archivo pom.xml y las dependencias a la imagen
COPY pom.xml ./

# Usa Maven para descargar las dependencias en modo offline
RUN mvn dependency:go-offline

# Copia el código fuente al contenedor
COPY src ./src

# Construye el JAR usando Maven
RUN mvn clean package -DskipTests

# Expon el puerto 8080 para la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "target/backend-ecotour.jar"]


