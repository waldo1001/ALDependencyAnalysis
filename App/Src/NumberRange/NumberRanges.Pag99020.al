page 99020 "ALDA Number Ranges"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ALDA Number Range";
    CardPageId = "ALDA Number Range";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; "Code")
                {
                    ApplicationArea = All;
                }

                field("From ID"; "From ID")
                {
                    ApplicationArea = All;
                }

                field("To ID"; "To ID")
                {
                    ApplicationArea = All;
                }

                field("Default Module"; "Default Module")
                {
                    ApplicationArea = All;
                }

                field(Modified; "Modified")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Set Default Module")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    SetDefaultModule();
                end;
            }
        }
    }
}