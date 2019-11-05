page 99095 "ALDA Activities"
{
    PageType = CardPart;
    SourceTable = "ALDA Number Range Cue";

    layout
    {
        area(Content)
        {
            cuegroup(Activities)
            {
                ShowCaption = false;

                field(Objects; "ALDA Objects")
                {
                    ApplicationArea = All;
                }
                field(Modules; "ALDA Modules")
                {
                    ApplicationArea = All;
                }
                field("Object Links"; "ALDA Object Links")
                {
                    ApplicationArea = All;
                }
                field("ALDA Module Links"; "ALDA Module Links")
                {
                    ApplicationArea = All;
                }
                field(Apps; "ALDA Apps")
                {
                    ApplicationArea = All;
                }
                // field(NumberRanges; "Number Ranges")
                // {
                //     ApplicationArea = All;
                // }
                // field("Field Nos"; "Field Nos")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF NOT GET() then begin
            INIT();
            INSERT();
        END;

    end;
}