page 99084 "ALDA FieldNumberRange Factbox"
{

    PageType = ListPart;
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
                field("Object Id"; "Table Id")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Field Id"; "Field Id")
                {
                    ApplicationArea = All;
                }
                field("Comment"; "Comment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    /*     trigger OnNewRecord(BelowxRec: Boolean)
        begin
            case GetFilter("Object Type").ToLower() of
                'pageextension':
                    "Object Type" := "Object Type"::"pageextension";
                'tableextension':
                    "Object Type" := "Object Type"::"tableextension";
            end;
        end; */
}
