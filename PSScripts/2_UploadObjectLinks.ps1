
#Load Functions

function Get-ExternalReferences() {
    param
    (
        [NavModelToolsAPI.Parsing.NAVObjectModel] $ObjectModel,
        [string] $ModuleName
    )

    $ModuleObjects = $ObjectModel.NAVObjects | where-object { $_.ParentObjectName.StartsWith("$($ModuleName) ") }
    return $ModuleObjects.Using | Where-Object { ([string]::IsNullOrEmpty($_.UsingElement.ParentObjectName)) -or (-not $_.UsingElement.ParentObjectName.StartsWith("$($ModuleName) ")) }
}

function New-ALDAElementLink() {
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
        -Uri "$($Url)//companies($($Companies.value[0].id))/alDAElementLinks" `
        -Credential $Credential `
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

#Add them to the db
$ExternalReferences = $model.NAVObjects.UsedBy

$LogEntries = @()
foreach ($ExternalReference in $ExternalReferences) {
    $LogEntry = [PSCustomObject]@{
        Source            = $ExternalReference.UsingElement.FullNameWithID
        SourceCategory    = ''#(Get-NumberRangeCategory -ObjectID $ExternalReference.UsingElement.ParentObjectID)
        SourceObjectType  = $ExternalReference.UsingElement.ParentObjectType
        SourceObjectID    = $ExternalReference.UsingElement.ParentObjectID
        SourceObjectName  = $ExternalReference.UsingElement.ParentObjectName
        SourceModule      = $ExternalReference.UsingElement.ParentObjectName.Split(" ")[0].Split("-")[0]
        SourceModuleMatch = $false  

        UsedBy            = $ExternalReference.SourceElement.FullNameWithID
        UsedByObjectType  = $ExternalReference.SourceElement.ParentObjectType
        UsedByObjectID    = $ExternalReference.SourceElement.ParentObjectID
        UsedByObjectName  = $ExternalReference.SourceElement.ParentObjectName
        UsedByCategory    = ''#(Get-NumberRangeCategory -ObjectID $ExternalReference.SourceElement.ParentObjectID)
        UsedByModule      = $ExternalReference.SourceElement.ParentObjectName.Split(" ")[0].Split("-")[0]          
        UsedByModuleMatch = $false

        SelfReference     = $false
    }

    if ($LogEntry.SourceModuleMatch -and $LogEntry.UsedByModuleMatch) {
        $LogEntry.SelfReference = ($LogEntry.SourceModule -eq $LogEntry.UsedByModule)
    }
    
    $LogEntries += $LogEntry  
}

$UploadEntries = $LogEntries | where-object { (-not $_.SelfReference) -and (($_.UsedByModuleMatch -ne $true) -or ($_.SourceModuleMatch -ne $true)) }

#Add them to the database
$start = Get-Date

foreach ($UploadEntry in $UploadEntries) {
    if ((($UploadEntry.SourceModule -in $ModuleFilter) -and ($UploadEntry.UsedByModule -in $ModuleFilter)) -or (-not $ModuleFilter.Count)) {
        write-host "$($UploadEntry.SourceModule) - $($UploadEntry.UsedByModule)"
        New-ALDAElementLink -sourceObjectType $UploadEntry.SourceObjectType `
            -sourceObjectID $UploadEntry.SourceObjectID `
            -sourceElement $UploadEntry.Source `
            -targetObjectType $UploadEntry.UsedByObjectType `
            -targetObjectID $UploadEntry.UsedByObjectID `
            -targetElement $UploadEntry.UsedBy
        #-sourceModule $UploadEntrie.SourceModule ` #will be filled in from AL 
        #-targetModule $UploadEntrie.UsedByModule `
    }
}

$Stop = get-date
write-host "That just took $(($Stop - $Start).TotalSeconds) seconds"