@echo off
echo ========================================================
echo   INICIANDO MICROSERVICIOS TALLER EUREKA + GATEWAY
echo ========================================================

echo 1. Iniciando Eureka Server en el puerto 9099...
start "Eureka Server (9099)" cmd /k "cd /d %~dp0EurekaServerService && java -jar target\EurekaServerService-0.0.1-SNAPSHOT.jar"

echo Esperando 12 segundos para la inicializacion de Eureka Server...
timeout /t 12 /nobreak >nul

echo 2. Iniciando UserService en el puerto 8086...
start "UserService (8086)" cmd /k "cd /d %~dp0UserService && java -jar target\UserService-0.0.1-SNAPSHOT.jar"

echo Esperando 6 segundos...
timeout /t 6 /nobreak >nul

echo 3. Iniciando API Gateway en el puerto 9056...
start "ApiGateway (9056)" cmd /k "cd /d %~dp0ApiGateway && java -jar target\ApiGateway-0.0.1-SNAPSHOT.jar"

echo ========================================================
echo Los 3 servicios han sido lanzados en ventanas independientes.
echo - Eureka Dashboard: http://localhost:9099
echo - Endpoint directo UserService: http://localhost:8086/client
echo - Endpoint enrutado via API Gateway: http://localhost:9056/client
echo ========================================================
pause
