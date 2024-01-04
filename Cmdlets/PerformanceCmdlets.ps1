function Start-MeasureScript {
    [CmdletBinding()]
    Param ()

    # Crée et démarre un nouveau Stopwatch
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    return $stopwatch
}

function Stop-MeasureScript {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [System.Diagnostics.Stopwatch]$Stopwatch
    )

    # Arrête le Stopwatch et retourne le temps écoulé
    $Stopwatch.Stop()
    return $Stopwatch.Elapsed
}
