$CCNAVMgtApi = "https://control.ifacto.be/cc_bourgba/api/bartbourgeois/navmgt/beta"

### Modules ####
function New-RepoModule() {
    param
    (
        [string] $Code,
        [string] $Description
    )

    Invoke-RestMethod -Method Post `
        -Uri "$($CCNAVMgtApi)/repoModules" `
        -Credential $CCRedential `
        -ContentType "application/json" `
        -Body (@{ "code" = $Code; "description" = $Description } | ConvertTo-Json -Depth 100)
}

$DistriRanges = get-content -Path "H:\DistriRanges.csv" | ConvertFrom-Csv -Delimiter ";"
foreach ($DistriRange in $DistriRanges) {
    New-RepoModule -Code $DistriRange.Code -Description $DistriRange.Description
}

### Objects
function New-RepoModelObject() {
    param
    (
        [string] $ObjectType,
        [int] $ObjectID,
        [string] $ObjectName,
        [string] $NumberRange,
        [string] $Module
    )

    $UID = [Guid]::NewGuid()
    Invoke-RestMethod -Method Post `
        -Uri "$($CCNAVMgtApi)/repoModelObjects" `
        -Credential $CCRedential `
        -ContentType "application/json" `
        -Body (@{ 
            "uid"         = $UID; 
            "objectType"  = $ObjectType;
            "objectID"    = $ObjectID;
            "objectName"  = $ObjectName;
            "numberRange" = $NumberRange;
            "module"      = $Module;
        } | ConvertTo-Json -Depth 100)  
}


function New-RepoElementLink() {
    param
    (
        [string] $sourceObjectType,
        [int] $sourceObjectID,
        [string] $sourceModule,
        [string] $sourceElement,
        [string] $targetObjectType,
        [int] $targetObjectID,
        [string] $targetModule,
        [string] $targetElement
    )

    $UID = [Guid]::NewGuid()
    Invoke-RestMethod -Method Post `
        -Uri "$($CCNAVMgtApi)/repoElementLinks" `
        -Credential $CCRedential `
        -ContentType "application/json" `
        -Body (@{ 
            "uid"              = $UID; 
            "sourceObjectType" = $sourceObjectType;
            "sourceObjectID"   = $sourceObjectID;
            "sourceModule"     = $sourceModule;
            "sourceElement"    = $sourceElement;
            "targetObjectType" = $targetObjectType;
            "targetObjectID"   = $targetObjectID;
            "targetModule"     = $targetModule;
            "targetElement"    = $targetElement;
        } | ConvertTo-Json -Depth 100)  
}


foreach ($ModelObject in $model.NAVObjects) {
    New-RepoModelObject -ObjectType $ModelObject.ParentObjectType `
        -ObjectID $ModelObject.ParentObjectID `
        -ObjectName $ModelObject.ParentObjectName `
        -NumberRange "" `
        -Module ""
} 

