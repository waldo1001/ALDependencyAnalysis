function Get-Recursive() {
    param(
        [string] $MainModule,
        [int] $CurrentLevel,
        [string] $FullLink,
        $ModuleToProcess,
        $AlreadyProcessed
    )
    foreach ($Sub in $ModuleToProcess) {
        if ($CurrentLevel -gt 30) {
            write-host "levels too damn high, aborting [$FullLink]"
            continue
        }
        if ($AlreadyProcessed -contains $Sub) {
            continue
        }
        $AlreadyProcessed += $Sub
        if ($Sub -eq $MainModule) {
            Write-Host "$($FullLink)$($Sub) [$CurrentLevel deep]"
            $Global:Total += 1
            continue
        }

        $SubModule = $ModuleLink[$Sub]
        Get-Recursive -MainModule $MainModule -CurrentLevel ($CurrentLevel + 1) -FullLink ($FullLink + $Sub + ' > ') -ModuleToProcess $Submodule -AlreadyProcessed $AlreadyProcessed

    }
}

$Global:Total = 0

foreach ($Module in $ModuleLink.GetEnumerator()) {
    Get-Recursive -MainModule $Module.key -CurrentLevel 1 -FullLink ($Module.Name + ' > ') -ModuleToProcess $Module.Value -AlreadyProcessed @()
}

Write-Host "$($Global:Total) deep links detected"