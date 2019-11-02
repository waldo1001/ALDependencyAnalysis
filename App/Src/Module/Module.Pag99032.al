page 99032 "ALDA Module"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ALDA Module";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Code"; "Code")
                {
                    ApplicationArea = All;
                }

                field(Description; "Description")
                {
                    ApplicationArea = All;
                }

                field(App; "App")
                {
                    ApplicationArea = All;
                }

                field(NA; "NA")
                {
                    ApplicationArea = All;
                }

                field(Modified; "Modified")
                {
                    ApplicationArea = All;
                }

            }

            part("SourceModuleLink"; "ALDA Module Link Sub")
            {
                Caption = 'Using';
                ApplicationArea = All;
                SubPageLink = "Source Module" = field(Code);
            }

            part("TargetModuleLink"; "ALDA Module Link Sub")
            {
                Caption = 'UsedBy';
                ApplicationArea = All;
                SubPageLink = "Target Module" = field(Code);
            }
        }

        area(Factboxes)
        {
            part("Picture"; "ALDA Module Picture")
            {
                Caption = 'Picture';
                ApplicationArea = All;
                SubPageLink = Code = field(Code);
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

            action("Show Graphviz")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Message(MakeGraphText());
                end;
            }

            action("Show Picture")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = page "ALDA Module Picture";
                RunPageOnRec = true;
                RunPageMode = View;
                Visible = false;
            }

            action("Toggle Ignore")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    ToggleIgnore();
                end;
            }

            action("Ignore All Links")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    IgnoreAllLinks();
                end;
            }
        }
    }
}