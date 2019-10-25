function Get-Recursive() {
    param(
        [string] $MainModule,
        [int] $CurrentLevel,
        [string] $FullLink,
        $ModuleToProcess,
        [ref]$AlreadyProcessed
    )
    foreach ($Sub in $ModuleToProcess) {
        if ($CurrentLevel -gt 30) {
            write-host "levels too damn high, aborting [$FullLink]"
            continue
        }
        if ($AlreadyProcessed.value -contains $Sub) {
            continue
        }        
        if ($Sub -eq $MainModule) {
            Write-Host "$($FullLink)$($Sub) [$CurrentLevel deep]"
            $Global:Total += 1
            continue
        }

        $AlreadyProcessed.value += $Sub

        $SubModule = $ModuleLink[$Sub]
        Get-Recursive -MainModule $MainModule -CurrentLevel ($CurrentLevel + 1) -FullLink ($FullLink + $Sub + ' > ') -ModuleToProcess $Submodule -AlreadyProcessed $AlreadyProcessed

    }
}

$Global:Total = 0

foreach ($Module in $ModuleLink.GetEnumerator()) {
    $already = @()
    Get-Recursive -MainModule $Module.key -CurrentLevel 1 -FullLink ($Module.Name + ' > ') -ModuleToProcess $Module.Value -AlreadyProcessed ([ref]$already)
}

Write-Host "$($Global:Total) deep links detected"