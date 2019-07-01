page 99013 "ALDA Model Object API"
{
    PageType = API;
    Caption = 'restApi';
    APIPublisher = 'waldo';
    APIGroup = 'alDependency';
    //APIVersion = 'VersionList';
    EntityName = 'alDAModelObject';
    EntitySetName = 'alDAModelObjects';
    ChangeTrackingAllowed = true;
    ODataKeyFields = UID;
    SourceTable = "ALDA Model Object";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(uid; "UID")
                {
                    Caption = 'uid';
                    ApplicationArea = All;
                }

                field(objectType; "Object Type")
                {
                    Caption = 'objectType';
                    ApplicationArea = All;
                }

                field(objectID; "Object ID")
                {
                    Caption = 'objectID';
                    ApplicationArea = All;
                }

                field(objectName; "Object Name")
                {
                    Caption = 'objectName';
                    ApplicationArea = All;
                }

                field(numberRange; "Number Range")
                {
                    Caption = 'numberRange';
                    ApplicationArea = All;
                }

                field(module; "Module")
                {
                    Caption = 'module';
                    ApplicationArea = All;
                }
            }
        }
    }
}