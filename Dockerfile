# Usa una imagen base con JDK 17
FROM openjdk:17-jdk-slim

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Instala Maven si no está en la imagen base
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Copia los archivos necesarios del proyecto al contenedor
COPY .mvn/ .mvn
COPY mvnw mvnw.cmd pom.xml ./

# Da permisos de ejecución a Maven Wrapper
RUN chmod +x mvnw

# Descarga las dependencias en modo offline
RUN ./mvnw dependency:go-offline

# Copia el código fuente al contenedor
COPY src ./src

# Construye el JAR usando Maven sin ejecutar pruebas
RUN ./mvnw clean package -DskipTests

# Expone el puerto 8080 para la aplicación
EXPOSE 8080

# Ejecuta la aplicación con el JAR generado
CMD ["sh", "-c", "java -jar target/*.jar"]




