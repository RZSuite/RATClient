# Definir URL de descarga de PSTools
$url = "https://download.sysinternals.com/files/PSTools.zip"

# Definir la ruta de instalación local
$destino = "C:\PSTools"
$zipFile = "$destino\PSTools.zip"

# Crear directorio si no existe
if (-not (Test-Path -Path $destino)) {
    New-Item -ItemType Directory -Path $destino
}

# Descargar PSTools
Invoke-WebRequest -Uri $url -OutFile $zipFile

# Extraer el archivo ZIP
Expand-Archive -LiteralPath $zipFile -DestinationPath $destino

# Eliminar el archivo ZIP después de la extracción
Remove-Item -Path $zipFile

# Agregar la ruta de PSTools al PATH del sistema
$envPath = [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
if (-not ($envPath -like "*$destino*")) {
    [System.Environment]::SetEnvironmentVariable('Path', "$envPath;$destino", [System.EnvironmentVariableTarget]::Machine)
}

# Mostrar mensaje de finalización
Write-Host "PSTools instalado y agregado al PATH del sistema."
