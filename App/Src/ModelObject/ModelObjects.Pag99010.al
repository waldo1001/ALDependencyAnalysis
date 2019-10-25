page 99010 "ALDA Model Objects"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ALDA Model Object";
    CardPageId = "ALDA Model Object";
    SourceTableView = sorting ("Object Type", "Object ID");

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Object Type"; "Object Type")
                {
                    ApplicationArea = All;
                }

                field("Object ID"; "Object ID")
                {
                    ApplicationArea = All;
                }

                field("Object Name"; "Object Name")
                {
                    ApplicationArea = All;
                }

                field("Number Range"; "Number Range")
                {
                    ApplicationArea = All;
                }

                field(Module; "Module")
                {
                    ApplicationArea = All;
                }

                field(Modified; "Modified")
                {
                    ApplicationArea = All;
                }

                field(Elements; "Elements")
                {
                    ApplicationArea = All;
                }

                field(Using; "Using")
                {
                    ApplicationArea = All;
                }

                field("Used By"; "Used By")
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
        }
    }
}