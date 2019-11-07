$Secret = Get-ObjectFromJSON  -Path (join-path $PSScriptRoot "Secret.json")

$password = ConvertTo-SecureString $Secret.pwd -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($Secret.uid, $password)
