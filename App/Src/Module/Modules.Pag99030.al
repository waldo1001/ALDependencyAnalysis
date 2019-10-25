page 99030 "ALDA Modules"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ALDA Module";
    CardPageId = "ALDA Module";

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

                field(Objects; "Objects")
                {
                    ApplicationArea = All;
                }

                field(Using; "Using")
                {
                    ApplicationArea = All;
                }

                field(UsedBy; "UsedBy")
                {
                    ApplicationArea = All;
                }

                field(Circular; "Circular")
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
            part(NumberRange; "ALDA ObjectNumberRange FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "ALDA App Code" = field(App), "Module Code" = field(Code);
            }
            part(FieldNumberRanges; "ALDA FieldNumberRange Factbox")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(NumberRanges)
            {
                ApplicationArea = All;
                Caption = 'Number Ranges';
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "ALDA Object Number Ranges";
                RunPageLink = "ALDA App Code" = field(App), "Module Code" = field(Code);
            }
            action(FieldNos)
            {
                ApplicationArea = All;
                Caption = 'Field Number Ranges';
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ObjectNumberRange: record "ALDA Object Number Range";
                begin
                    CurrPage.NumberRange.Page.GetRecord(ObjectNumberRange);
                    ObjectNumberRange.ShowFieldNos();
                end;
            }
        }

        area(Processing)
        {
            // action("Make Graph")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     Scope = Page;

            //     trigger OnAction()
            //     var
            //         ALDAModules: Record "ALDA Module";
            //     begin
            //         CurrPage.SetSelectionFilter(ALDAModules);
            //         if (not ALDAModules.FindSet()) then
            //             exit;

            //         repeat
            //             ALDAModules.MakeGraph();
            //         until ALDAModules.Next() < 1;
            //     end;
            // }
        }
    }

    [ServiceEnabled]
    procedure TestAPIAction(): Text
    begin
        exit('Got: ');
    end;
}