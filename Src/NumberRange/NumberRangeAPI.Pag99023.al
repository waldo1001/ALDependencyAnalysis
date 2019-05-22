page 99023 "ALDA Number Range API"
{
    PageType = API;
    Caption = 'restApi';
    APIPublisher = 'bartbourgeois';
    APIGroup = 'navmgt';
    //APIVersion = 'VersionList';
    EntityName = 'ALDANumberRange';
    EntitySetName = 'ALDANumberRanges';
    ChangeTrackingAllowed = true;
    ODataKeyFields = Code;
    SourceTable = "ALDA Number Range";
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

                field("fromID"; "From ID")
                {
                    Caption = 'fromID';
                    ApplicationArea = All;
                }

                field("toID"; "To ID")
                {
                    Caption = 'toID';
                    ApplicationArea = All;
                }
            }
        }
    }
}