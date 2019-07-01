page 99072 "ALDA App"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ALDA App";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(App; "App")
                {
                    ApplicationArea = All;
                }
                field(Description; "Description")
                {
                    ApplicationArea = All;
                }

                field(NA; "NA")
                {
                    ApplicationArea = All;
                }
                field("Number Range From"; "Number Range From")
                {
                    ApplicationArea = All;
                }
                field("Number Range To"; "Number Range To")
                {
                    ApplicationArea = All;
                }
            }
        }

        area(Factboxes)
        {
            part("Picture"; "ALDA App Picture")
            {
                Caption = 'Picture';
                ApplicationArea = All;
                SubPageLink = App = field (App);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action("Make Graph")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     begin
            //         MakeGraph();
            //         CurrPage.Update(false);
            //     end;
            // }

            action("Get Graph Text")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Scope = Repeater;

                trigger OnAction()
                begin
                    Message(MakeGraphText());
                end;
            }
        }
    }
}