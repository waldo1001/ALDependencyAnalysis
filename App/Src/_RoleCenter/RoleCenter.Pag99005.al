page 99005 "ALDA Role Center"
{
    PageType = RoleCenter;
    Caption = 'ALDA Control Center';

    layout
    {
        area(RoleCenter)
        {
            group(General)
            {
                ShowCaption = false;

                part(NumberRange; "ALDA Activities")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(ALDA)
            {

                action(Object)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = page "ALDA Model Objects";
                    AccessByPermission = tabledata "ALDA Model Object" = R;
                }

                action(Module)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = page "ALDA Modules";
                    AccessByPermission = tabledata "ALDA Module" = R;
                }

                action("Number Ranges")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = page "ALDA Number Ranges";
                    AccessByPermission = tabledata "ALDA Number Range" = R;
                }

                action("Module Link")
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = page "ALDA Module Links";
                    AccessByPermission = tabledata "ALDA Module Link" = R;
                }

                action(Apps)
                {
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = page "ALDA Apps";
                    AccessByPermission = tabledata "ALDA App" = R;
                }

            }
        }


        area(Processing)
        {

        }
    }
}