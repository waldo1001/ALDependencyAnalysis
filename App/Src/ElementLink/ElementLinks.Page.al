page 99050 "ALDA Element Links"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ALDA Element Link";
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Element; "Target Element")
                {
                    ApplicationArea = All;
                }
                field(UID; "UID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Source Object Type"; "Source Object Type")
                {
                    ApplicationArea = All;
                }

                field("Source Object ID"; "Source Object ID")
                {
                    ApplicationArea = All;
                }

                field("Source Module"; "Source Module")
                {
                    ApplicationArea = All;
                }

                field("Source Element"; "Source Element")
                {
                    ApplicationArea = All;
                }

                field("Target Object Type"; "Target Object Type")
                {
                    ApplicationArea = All;
                }

                field("Target Object ID"; "Target Object ID")
                {
                    ApplicationArea = All;
                }

                field("Target Module"; "Target Module")
                {
                    ApplicationArea = All;
                }

                field("Target Element"; "Target Element")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Remark; "Remark")
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
            action(UpdateLinks)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ALDAElementLink: Record "ALDA Element Link";
                    ALDAObject: Record "ALDA Model Object";
                begin
                    if (not ALDAObject.FindSet()) then
                        exit;

                    repeat
                        clear(ALDAElementLink);
                        ALDAElementLink.SetCurrentKey("Source Object Type", "Source Object ID");
                        ALDAElementLink.SetRange("Source Object Type", ALDAObject."Object Type");
                        ALDAElementLink.SetRange("Source Object ID", ALDAObject."Object ID");
                        ALDAElementLink.ModifyAll("Source Module", ALDAObject.Module, true);

                        clear(ALDAElementLink);
                        ALDAElementLink.SetCurrentKey("Target Object Type", "Target Object ID");
                        ALDAElementLink.SetRange("Target Object Type", ALDAObject."Object Type");
                        ALDAElementLink.SetRange("Target Object ID", ALDAObject."Object ID");
                        ALDAElementLink.ModifyAll("Target Module", ALDAObject.Module, true);

                        ALDAObject."Link Updated" := true;
                        ALDAObject.Modify();

                        Commit();
                    until ALDAObject.Next() < 1;
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