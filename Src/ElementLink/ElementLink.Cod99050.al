codeunit 99050 "ALDA Element Link"
{
    procedure ToggleIgnore(var ALDAElementLink: Record "ALDA Element Link")
    begin
        ALDAElementLink.Ignore := not ALDAElementLink.Ignore;
        ALDAElementLink.Modify();
    end;
}