page 99043 "ALDA Object Element API"
{
    PageType = API;
    Caption = 'restApi';
    APIPublisher = 'waldo';
    APIGroup = 'alDependency';
    APIVersion = 'v1.0';
    EntityName = 'alDAObjectElement';
    EntitySetName = 'alDAObjectElements';
    ChangeTrackingAllowed = true;
    ODataKeyFields = UID;
    SourceTable = "ALDA Object Element";
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

                field(element; "Element")
                {
                    Caption = 'element';
                    ApplicationArea = All;
                }

                field(objectUID; "Object UID")
                {
                    Caption = 'objectUID';
                    ApplicationArea = All;
                }
            }
        }
    }
}