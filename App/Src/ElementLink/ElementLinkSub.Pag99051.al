page 99051 "ALDA Element Link Sub"
{
    PageType = ListPart;
    SourceTable = "ALDA Element Link";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(UID; "UID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Source Object Type"; "Source Object Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Source Object ID"; "Source Object ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Source Module"; "Source Module")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Source Element"; "Source Element")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Target Object Type"; "Target Object Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Target Object ID"; "Target Object ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Target Module"; "Target Module")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Target Element"; "Target Element")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remark; "Remark")
                {
                    ApplicationArea = All;
                }

                field(Modified; "Modified")
                {
                    ApplicationArea = All;
                    Editable = false;
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