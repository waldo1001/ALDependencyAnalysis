page 99053 "ALDA Element Link API"
{
    PageType = API;
    Caption = 'restApi';
    APIPublisher = 'waldo';
    APIGroup = 'alDependency';
    APIVersion = 'v1.0';
    EntityName = 'alDAElementLink';
    EntitySetName = 'alDAElementLinks';
    ChangeTrackingAllowed = true;
    ODataKeyFields = UID;
    SourceTable = "ALDA Element Link";
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

                field(sourceObjectType; "Source Object Type")
                {
                    Caption = 'sourceObjectType';
                    ApplicationArea = All;
                }

                field(sourceObjectID; "Source Object ID")
                {
                    Caption = 'sourceObjectID';
                    ApplicationArea = All;
                }

                field(sourceModule; "Source Module")
                {
                    Caption = 'sourceModule';
                    ApplicationArea = All;
                }

                field(sourceElement; "Source Element")
                {
                    Caption = 'sourceElement';
                    ApplicationArea = All;
                }

                field(targetObjectType; "Target Object Type")
                {
                    Caption = 'targetObjectType';
                    ApplicationArea = All;
                }

                field(targetObjectID; "Target Object ID")
                {
                    Caption = 'targetObjectID';
                    ApplicationArea = All;
                }

                field(targetModule; "Target Module")
                {
                    Caption = 'targetModule';
                    ApplicationArea = All;
                }

                field(targetElement; "Target Element")
                {
                    Caption = 'targetElement';
                    ApplicationArea = All;
                }

            }
        }
    }
}