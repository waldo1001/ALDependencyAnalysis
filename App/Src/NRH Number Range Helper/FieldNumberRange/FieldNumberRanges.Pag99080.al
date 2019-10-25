page 99080 "ALDA Field Number Ranges"
{

    PageType = List;
    SourceTable = "ALDA Field Number Range";
    Caption = 'Field Number Ranges';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table Id"; "Table Id")
                {
                    ApplicationArea = All;
                }
                field("Field Id"; "Field Id")
                {
                    ApplicationArea = All;
                }
                field(Comment; "Comment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
