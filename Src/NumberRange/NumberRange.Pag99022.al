page 99022 "ALDA Number Range"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ALDA Number Range";

    layout
    {
        area(Content)
        {
            group("GroupName")
            {
                field("Code"; "Code")
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

                field("Modified"; "Modified")
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