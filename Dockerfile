# Usar una imagen base de Java (JRE en lugar de JDK para menor tamaño)
FROM eclipse-temurin:17-jre-alpine

# Directorio de trabajo en el contenedor
WORKDIR /app

# Copiamos el archivo JAR compilado (asegúrate de que el nombre coincida)
# Por defecto Spring Boot genera algo como app-0.0.1-SNAPSHOT.jar en la carpeta target/
COPY target/app-springboot-0.0.1-SNAPSHOT.jar app.jar

# Puerto que expone la aplicación
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
