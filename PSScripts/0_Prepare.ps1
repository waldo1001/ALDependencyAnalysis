. (join-path $PSScriptRoot "./.Settings.ps1")
# . (join-path $PSScriptRoot "./.SettingsWindows.ps1")


$ObjectsFile = "C:\_Source\Community\ALDependencyAnalysis\PSScripts\Objects\DistriModified.txt"
#$ObjectsFile = "C:\_Source\Community\ALDependencyAnalysis\PSScripts\Objects\DistriAll.txt"

$ModuleFilter = @('WTF', 'NF', 'WMS', 'VMF', 'RH', 'DH', 'CASHR', 'WMS', 'SCF', 'SCFP', 'EDI', 'HIS', 'ECF', 'VM', 'CHF', 'CRT', 'ZIP', 'CM', 'CMA', 'SUP', 'II', 'TH', 'CI', 'TAX', 'VVC')
$MOduleFilter = @()

$Url = "http://$($ContainerName):7048/BC/api/waldo/alDependency/v1.0"
# $Url = "https://33af107beb.infra.ifacto.be/BC/API/waldo/alDependency/v1.0"

$ModuleToolAPIPath = "C:\_Source\Community\Waldo.Model.Tools\The Magic\NavModelToolsAPI.dll"
import-module $ModuleToolAPIPath -WarningAction SilentlyContinue -Verbose

$Model = Get-NAVObjectModel -NavObjectsTextFile $ObjectsFile -TimeExecution 


#Get Companies
$Companies = Invoke-RestMethod -Method Get `
    -Uri "$($url)/companies" `
    -Credential $Credential `
    -ContentType "application/json" 

