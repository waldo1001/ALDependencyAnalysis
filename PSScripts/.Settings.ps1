$ContainerName = 'bcaldep'
$UID = 'admin'
$Password = 'Waldo1234'
$APIBaseURL = "http://$($ContainerName):7048/BC/api/waldo/alDependency/v1.0"

#Load Vars

$admin = Get-NavContainerNavUser -containerName $ContainerName | where UserName -eq $UID


if ($admin) {
    $pwd = $admin.WebServicesKey
}
else {
    $password = ConvertTo-SecureString $Password -AsPlainText -Force
    New-NCHNAVSuperUser -ContainerName $ContainerName -Username $UID -Password $Password -CreateWebServicesKey
    $admin = Get-NavContainerNavUser -containerName $ContainerName | where UserName -eq $UID
    $pwd = $admin.WebServicesKey
}

$password = ConvertTo-SecureString $pwd -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($admin.UserName, $password)
