codeunit 99020 "ALDA Number Range"
{
    procedure SetDefaultModule(var ALDANumberRange: Record "ALDA Number Range")
    var
        ALDAModelObject: Record "ALDA Model Object";
    begin
        if (ALDANumberRange."Default Module" = '') then
            exit;

        ALDAModelObject.SetCurrentKey("Number Range");
        ALDAModelObject.SetRange("Number Range", ALDANumberRange.Code);
        ALDAModelObject.SetFilter(Module, '%1', '');
        ALDAModelObject.ModifyAll(Module, ALDANumberRange."Default Module", false);
    end;
}