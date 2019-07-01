page 99061 "ALDA Module Link Sub"
{
    PageType = ListPart;
    SourceTable = "ALDA Module Link";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Source Module"; "Source Module")
                {
                    ApplicationArea = All;
                }

                field("Target Module"; "Target Module")
                {
                    ApplicationArea = All;
                }

                field(Links; "Links")
                {
                    ApplicationArea = All;
                }

                field(Ignored; "Ignored")
                {
                    ApplicationArea = All;
                }

                field(Circular; "Circular")
                {
                    ApplicationArea = All;
                }

                field(Ignore; "Ignore")
                {
                    ApplicationArea = All;
                }

                field(Modified; "Modified")
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
            action("Toggle Ignore")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Scope = "Repeater";

                trigger OnAction()
                begin
                    ToggleIgnore();
                end;
            }
        }
    }
}