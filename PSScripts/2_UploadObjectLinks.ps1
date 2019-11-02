
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

    # $LogEntry.SourceModuleMatch = $null -ne ($DistriRanges | Where-Object { $_.Code.ToUpper() -eq $LogEntry.SourceModule.ToUpper() } | select-object -first 1)
    # $LogEntry.UsedByModuleMatch = $null -ne ($DistriRanges | Where-Object { $_.Code.ToUpper() -eq $LogEntry.UsedByModule.ToUpper() } | select-object -first 1)   

    if ($LogEntry.SourceModuleMatch -and $LogEntry.UsedByModuleMatch) {
        $LogEntry.SelfReference = ($LogEntry.SourceModule -eq $LogEntry.UsedByModule)
    }
    
    $LogEntries += $LogEntry  
}

$UploadEntries = $LogEntries | where-object { (-not $_.SelfReference) -and (($_.UsedByModuleMatch -ne $true) -or ($_.SourceModuleMatch -ne $true)) }

#TODO: only a fraction of the links

#Add them to the database
foreach($UploadEntrie in $UploadEntries){
    New-ALDAElementLink -sourceObjectType $UploadEntrie.SourceObjectType `
                        -sourceObjectID $UploadEntrie.SourceObjectID `
                        -sourceModule $UploadEntrie.SourceModule `
                        -sourceElement $UploadEntrie.Source `
                        -targetObjectType $UploadEntrie.UsedByObjectType `
                        -targetObjectID $UploadEntrie.UsedByObjectID `
                        -targetModule $UploadEntrie.UsedByModule `
                        -targetElement $UploadEntrie.UsedBy
}