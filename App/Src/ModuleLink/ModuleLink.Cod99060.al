codeunit 99060 "ALDA Module Link"
{
    procedure ToggleIgnore(var ALDAModuleLink: Record "ALDA Module Link")
    var
        ALDAElementLink: Record "ALDA Element Link";
    begin
        ALDAModuleLink.Ignore := not ALDAModuleLink.Ignore;
        ALDAModuleLink.Modify();

        clear(ALDAElementLink);
        ALDAElementLink.SetRange("Source Module", ALDAModuleLink."Source Module");
        ALDAElementLink.SetRange("Target Module", ALDAModuleLink."Target Module");
        ALDAElementLink.SetRange(Ignore, not ALDAModuleLink.Ignore);
        ALDAElementLink.ModifyAll(Ignore, ALDAModuleLink.Ignore);

        CalculateCircular(ALDAModuleLink);
    end;

    procedure CalculateCircular(var ALDAModuleLink: Record "ALDA Module Link")
    var
        ALDAModuleLinkFind: Record "ALDA Module Link";
    begin
        ALDAModuleLink."Self Reference" := ALDAModuleLink."Source Module" = ALDAModuleLink."Target Module";
        ALDAModuleLink.CalcFields(Links);

        clear(ALDAModuleLinkFind);
        ALDAModuleLinkFind.SetRange("Target Module", ALDAModuleLink."Source Module");
        ALDAModuleLinkFind.SetRange("Source Module", ALDAModuleLink."Target Module");
        ALDAModuleLinkFind.SetRange(Ignore, false);
        ALDAModuleLinkFind.SetFilter(Links, '>%1', 0);

        ALDAModuleLink.Circular := ((not ALDAModuleLink."Self Reference") AND (not ALDAModuleLinkFind.IsEmpty()) AND (ALDAModuleLink.Links > 0));
        ALDAModuleLink.Modify();
    end;
}