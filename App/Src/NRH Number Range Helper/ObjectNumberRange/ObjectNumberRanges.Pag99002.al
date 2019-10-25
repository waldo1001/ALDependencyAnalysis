page 99002 "ALDA Object Number Ranges"
{

    PageType = List;
    SourceTable = "ALDA Object Number Range";
    Caption = 'Module Number Ranges';
    ApplicationArea = All;
    UsageCategory = Lists;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("ALDA App Code"; "ALDA App Code")
                {
                    ApplicationArea = All;
                }
                field("Module Prefix"; "Module Code")
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
                field(Comment; "Comment")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(FieldNumberRanges; "ALDA FieldNumberRange Factbox")
            {
                ApplicationArea = All;
                /*Provider = NumberRange;
                 SubPageLink = "Object Type" = field ("Object Type"),
                                "Object Id" = field ("Base Object Id"); */
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(FieldNumberRangesAction)
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
