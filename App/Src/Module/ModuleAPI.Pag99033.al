page 99033 "ALDA Module API"
{
    PageType = API;
    Caption = 'restApi';
    APIPublisher = 'waldo';
    APIGroup = 'alDependency';
    APIVersion = 'v1.0';
    EntityName = 'alDAModule';
    EntitySetName = 'alDAModules';
    ChangeTrackingAllowed = true;
    ODataKeyFields = Code;
    SourceTable = "ALDA Module";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(code; "Code")
                {
                    Caption = 'code';
                    ApplicationArea = All;
                }

                field(description; "Description")
                {
                    Caption = 'description';
                    ApplicationArea = All;
                }

            }
        }
    }

    [ServiceEnabled]
    procedure TestAPIAction(): Text
    begin
        exit('Got: ');
    end;
}