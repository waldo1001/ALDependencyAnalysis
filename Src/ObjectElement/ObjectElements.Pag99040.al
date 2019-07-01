page 99040 "ALDA Object Elements"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "ALDA Object Element";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(UID; "UID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Element; "Element")
                {
                    ApplicationArea = All;
                }

                field("Object UID"; "Object UID")
                {
                    ApplicationArea = All;
                    Visible = false;
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
        }
    }
}