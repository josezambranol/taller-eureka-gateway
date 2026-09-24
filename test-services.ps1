Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "  TEST AUTOMATIZADO - TALLER SPRING BOOT + EUREKA + GATEWAY" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

Write-Host "`n[1] Verificando Eureka Server (http://localhost:9099/eureka/apps)..." -ForegroundColor Yellow
try {
    $eureka = Invoke-RestMethod -Uri "http://localhost:9099/eureka/apps" -Headers @{ "Accept" = "application/json" } -Method Get -TimeoutSec 5
    $apps = $eureka.applications.application
    if ($apps) {
        Write-Host " [OK] Eureka Server esta activo. Servicios registrados:" -ForegroundColor Green
        foreach ($app in $apps) {
            Write-Host "      - $($app.name) (Instancias: $($app.instance.Count), Estado: $($app.instance.status))" -ForegroundColor Gray
        }
    } else {
        Write-Host " [AVISO] Eureka esta respondiendo pero no hay servicios registrados aun." -ForegroundColor Yellow
    }
} catch {
    Write-Host " [ERROR] No se pudo conectar a Eureka Server: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n[2] Verificando Endpoint Directo de UserService (http://localhost:8086/client)..." -ForegroundColor Yellow
try {
    $userRes = Invoke-RestMethod -Uri "http://localhost:8086/client" -Method Get -TimeoutSec 5
    Write-Host " [OK] Respuesta directa de UserService recibida:" -ForegroundColor Green
    Write-Host "      Contenido: `"$userRes`"" -ForegroundColor Gray
} catch {
    Write-Host " [ERROR] Fallo al invocar UserService: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n[3] Verificando Enrutamiento Dinamico via API Gateway (http://localhost:9056/client)..." -ForegroundColor Yellow
try {
    $gwRes = Invoke-RestMethod -Uri "http://localhost:9056/client" -Method Get -TimeoutSec 5
    Write-Host " [OK] Dynamic Routing via API Gateway exitoso:" -ForegroundColor Green
    Write-Host "      Contenido: `"$gwRes`"" -ForegroundColor Gray
} catch {
    Write-Host " [ERROR] Fallo enrutamiento a traves de API Gateway: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "  FIN DE PRUEBAS" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
