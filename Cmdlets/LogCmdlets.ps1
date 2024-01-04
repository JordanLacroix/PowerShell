# Cmdlet pour créer un nouveau dossier pour les logs
function New-LogFolder {
    Param (
        [string]$path  # Chemin du dossier de log
    )
    # Vérifie si le chemin n'existe pas et crée le dossier
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
    }
}

# Cmdlet pour initialiser le fichier de log
function Initialize-LogFile {
    Param (
        [string]$path  # Chemin du fichier de log
    )
    # Vérifie si le fichier de log n'existe pas et crée le fichier avec un en-tête
    if (-not (Test-Path $path)) {
        "Date,Status,Message" | Set-Content $path
    }
}

# Cmdlet pour écrire dans le fichier de log
function Write-Log {
    Param (
        [string]$file,    # Chemin du fichier de log
        [string]$status,  # Statut du message (ex. Success, Error)
        [string]$message, # Message à enregistrer
        [switch]$showInConsole # Afficher le log dans la console
    )
    # Crée une entrée de log avec la date, le statut et le message
    $logEntry = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss"),$status,$message"
    # Ajoute l'entrée au fichier de log
    Add-content $file -value $logEntry

    # Affiche le log dans la console si demandé
    if ($showInConsole) {
        switch ($status) {
            "Info" { $color = "White" }
            "Success" { $color = "Green" }
            "Warning" { $color = "Yellow" }
            "Error" { $color = "Red" }
            default { $color = "White" }
        }
        Write-Host "$(Get-Date -Format "dd-MM-yyyy HH:mm:ss") - $status - $message" -ForegroundColor $color
    }
}
