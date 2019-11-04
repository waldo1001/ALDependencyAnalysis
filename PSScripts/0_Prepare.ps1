. (join-path $PSScriptRoot "./.Settings.ps1")

$ObjectsFile = "C:\_Source\Community\ALDependencyAnalysis\PSScripts\Objects\DistriModified.txt"
$ModuleFilter = @('WTF','NF','WMS','VMF','RH','DH','CASHR','WMS','SCF','SCFP','EDI','HIS','ECF','VM','CHF','CRT','ZIP','CM','CMA','SUP','II','TH','CI','TAX','VVC')

$Url = "http://bccurrent:7048/BC/api/waldo/alDependency/v1.0"

$ModuleToolAPIPath = "C:\_Source\Community\Waldo.Model.Tools\The Magic\NavModelToolsAPI.dll"
import-module $ModuleToolAPIPath -WarningAction SilentlyContinue -Verbose

$Model = Get-NAVObjectModel -NavObjectsTextFile $ObjectsFile -TimeExecution 


#Get Companies
$Companies = Invoke-RestMethod -Method Get `
    -Uri "$($url)/companies" `
    -Credential $Credential `
    -ContentType "application/json" 

