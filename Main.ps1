# Importation des cmdlets de différents modules pour la gestion des logs, du contexte d'exécution et des performances
. .\Cmdlets\LogCmdlets.ps1
. .\Cmdlets\ContextCmdlets.ps1
. .\Cmdlets\PerformanceCmdlets.ps1

# Définition des chemins pour le dossier et le fichier de log
$logFolder = ".\Logs"
$logFile = "$logFolder\Logs.csv"

# Création et initialisation du dossier et du fichier de log
New-LogFolder -path $logFolder  # Crée le dossier de log si nécessaire
Initialize-LogFile -path $logFile  # Initialise le fichier de log avec un en-tête

# Bloc try-catch pour gérer les erreurs et mesurer les performances du script
try {
    # Enregistrement du démarrage du script dans le log et affichage dans la console
    Write-Log -file $logFile -status "Info" -message "Démarrage du script." -showInConsole

    # Démarrage du chronomètre pour mesurer le temps d'exécution
    $StopWatch = Start-MeasureScript

    # Obtention d'informations sur l'environnement d'exécution
    $Context = Get-ExecutionContextInfo
    
    # Enregistrement de diverses informations sur l'environnement d'exécution
    Write-Log -file $logFile -status "Info" -message "PowerShell : $($Context.PowerShellVersion)" -showInConsole
    Write-Log -file $logFile -status "Info" -message "Path : $($Context.ScriptPath)" -showInConsole
    Write-Log -file $logFile -status "Info" -message "Utilisateur : $($Context.CurrentUser)" -showInConsole

    # Arrêt du chronomètre et récupération du temps d'exécution
    $ExecutionTime = Stop-MeasureScript -StopWatch $StopWatch

    # Enregistrement du succès de l'exécution dans le log
    Write-Log -file $logFile -status "Success" -message "Script exécuté avec succès." -showInConsole

}
catch {
    # Récupération du numéro de ligne où l'erreur s'est produite
    $line = $_.InvocationInfo.ScriptLineNumber
    $scriptName = $_.InvocationInfo.ScriptName
    # Récupération du message d'erreur
    $errorMessage = $_.Exception.Message
    # Enregistrement de l'erreur dans le log et affichage dans la console
    Write-Log -file $logFile -status "Error" -message "Erreur à la ligne $line dans $scriptName : $errorMessage" -showInConsole
}
finally {
    # Enregistrement du temps d'exécution total dans le log
    Write-Log -file $logFile -status "Info" -message "Temps d'exécution : $ExecutionTime" -showInConsole
}

# Enregistrement de la fin du script dans le log
Write-Log -file $logFile -status "Info" -message "Fin du script." -showInConsole
