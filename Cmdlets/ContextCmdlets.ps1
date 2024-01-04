function Get-ExecutionContextInfo {
    [CmdletBinding()]
    Param ()

    try {
        # Récupération du chemin complet du script en cours d'exécution
        $scriptPath = $PSScriptRoot

        # Récupération de la version de PowerShell
        $psVersion = $PSVersionTable.PSVersion.ToString()

        # Récupération de l'utilisateur courant
        $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

        # Création d'un objet personnalisé pour retourner les informations
        $executionInfo = New-Object PSObject -Property @{
            ScriptPath = $scriptPath
            PowerShellVersion = $psVersion
            CurrentUser = $currentUser
        }

        # Retourne l'objet
        return $executionInfo
    } catch {
        Write-Error "Impossible de déterminer les informations d'exécution."
    }
}
