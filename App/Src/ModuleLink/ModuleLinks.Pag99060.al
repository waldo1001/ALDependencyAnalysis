page 99060 "ALDA Module Links"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
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

                field("Source Module Exists"; "Source Module Exists")
                {
                    ApplicationArea = All;
                }

                field("Target Module"; "Target Module")
                {
                    ApplicationArea = All;
                }

                field("Target Module Exists"; "Target Module Exists")
                {
                    ApplicationArea = All;
                }

                field(Links; "Links")
                {
                    ApplicationArea = All;
                }

                field(Circular; Circular)
                {
                    ApplicationArea = All;
                }
                field(MultiLevelCircularCount; MultiLevelCircularCount)
                {
                    ApplicationArea = All;
                }

                field(Ignore; "Ignore")
                {
                    ApplicationArea = All;
                }

                field(Ignored; "Ignored")
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
            action("Remove Empty Links")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ALDAModuleLink: Record "ALDA Module Link";
                begin
                    clear(ALDAModuleLink);
                    ALDAModuleLink.SetRange(Links, 0);
                    ALDAModuleLink.DeleteAll();
                end;
            }

            action("Calculate Direct Circular")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ALDAModuleLink: Record "ALDA Module Link";
                begin
                    clear(ALDAModuleLink);
                    ALDAModuleLink.ModifyAll(Circular, false);

                    if (not ALDAModuleLink.FindSet()) then
                        exit;

                    repeat
                        ALDAModuleLink.CalculateDirectCircular();
                    until ALDAModuleLink.Next() < 1;
                end;
            }
            action("Calculate Multi Level Circular")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ALDAModuleLink: Record "ALDA Module Link";
                begin
                    clear(ALDAModuleLink);
                    ALDAModuleLink.ModifyAll(MultiLevelCircularCount, 0);
                    commit();

                    ALDAModuleLink.Reset();
                    if (not ALDAModuleLink.FindSet()) then
                        exit;

                    repeat
                        ALDAModuleLink.CalculateMultiLevelCircular();
                    until ALDAModuleLink.Next() < 1;
                end;
            }

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