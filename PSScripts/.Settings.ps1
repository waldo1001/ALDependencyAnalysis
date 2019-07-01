$ContainerName = 'bccurrent'
$UID = 'admin'
$APIBaseURL = "http://$($ContainerName):7048/NAV/api/beta"

#Load Vars

$admin = Get-NavContainerNavUser -containerName bccurrent | where UserName -eq $UID


if ($admin) {
    $pwd = $admin.WebServicesKey
}
else {
    New-NCHNAVSuperUser -ContainerName $ContainerName -Username $UID -Password $Password -CreateWebServicesKey
    $admin = Get-NavContainerNavUser -containerName bccurrent | where UserName -eq $UID
    $pwd = $admin.WebServicesKey
}

$password = ConvertTo-SecureString $pwd -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($admin.UserName, $password)
