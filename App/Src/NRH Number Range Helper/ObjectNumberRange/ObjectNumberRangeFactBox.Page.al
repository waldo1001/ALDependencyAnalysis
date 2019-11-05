page 99001 "ALDA ObjectNumberRange FactBox"
{
    PageType = ListPart;
    SourceTable = "ALDA Object Number Range";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(NumberRanges)
            {
                field("Module Code"; "Module Code")
                {
                    ApplicationArea = All;
                }
                field("Object Id From"; "Object Id From")
                {
                    ApplicationArea = All;
                }
                field("Object Id To"; "Object Id To")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(FieldNumberRanges)
            {
                ApplicationArea = All;
                caption = 'Field Nos';
                image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "ALDA Field number ranges";
            }
        }
    }
}