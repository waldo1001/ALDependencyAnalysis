page 99095 "ALDA Number Range Activities"
{
    PageType = CardPart;
    SourceTable = "ALDA Number Range Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Number Ranges")
            {
                field("Apps"; "ALDA Apps")
                {
                    ApplicationArea = All;
                }
                field("Modules"; "ALDA Modules")
                {
                    ApplicationArea = All;
                }
                field("NumberRanges"; "Number Ranges")
                {
                    ApplicationArea = All;
                }
                field("Field Nos"; "Field Nos")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF NOT GET() then begin
            INIT();
            INSERT()
            ;
        END;
    end;
}