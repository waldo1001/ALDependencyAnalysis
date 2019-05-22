page 99070 "ALDA Apps"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ALDA App";
    CardPageId = "ALDA App";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("App"; "App")
                {
                    ApplicationArea = All;
                }

                field("Description"; "Description")
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

                field("NA"; "NA")
                {
                    ApplicationArea = All;
                }

                field("Modules"; "Modules")
                {
                    ApplicationArea = All;
                }

                field("Codeunits"; "Codeunits")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
            part(NumberRange; "ALDA ObjectNumberRange FactBox")
            {
                SubPageLink = "ALDA App Code" = field (App);
            }
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
        area(Navigation)
        {
            action("NumberRanges")
            {
                Caption = 'Number Ranges';
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "ALDA Object Number Ranges";
                RunPageLink = "ALDA App Code" = field (App);
            }
            action("FieldNumberRangesAction")
            {
                caption = 'Field Nos';
                image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "ALDA Field number ranges";
            }

        }
        area(Processing)
        {
            // action("Make Graph")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     Scope = Repeater;

            //     trigger OnAction()
            //     var
            //         ALDAApps: Record "ALDA App";
            //     begin
            //         CurrPage.SetSelectionFilter(ALDAApps);
            //         if (not ALDAApps.FindSet()) then
            //             exit;

            //         repeat
            //             ALDAApps.MakeGraph();
            //         until ALDAApps.Next() < 1;
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
                    Message(rec.MakeGraphText());
                end;
            }

            action("Get Full Graph Text")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Scope = Page;

                trigger OnAction()
                begin
                    Message(rec.MakeFullGraphText());
                end;
            }
        }
    }
}