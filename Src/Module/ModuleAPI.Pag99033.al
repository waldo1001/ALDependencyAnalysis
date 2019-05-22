page 99033 "ALDA Module API"
{
    PageType = API;
    Caption = 'restApi';
    APIPublisher = 'bartbourgeois';
    APIGroup = 'navmgt';
    //APIVersion = 'VersionList';
    EntityName = 'ALDAModule';
    EntitySetName = 'ALDAModules';
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
                field("code"; "Code")
                {
                    Caption = 'code';
                    ApplicationArea = All;
                }

                field("description"; "Description")
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