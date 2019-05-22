codeunit 99102 "ALDA ValidateObjNrRange Meth"
{
    procedure ValidateObjectNumberRange(var ObjectNumberRange: Record "ALDA Object Number Range");
    var
        Handled: Boolean;
    begin
        OnBeforeValidateObjectNumberRange(ObjectNumberRange, Handled);

        DoValidateObjectNumberRange(ObjectNumberRange, Handled);

        OnAfterValidateObjectNumberRange();
    end;

    local procedure DoValidateObjectNumberRange(var ObjectNumberRange: Record "ALDA Object Number Range"; var Handled: Boolean);
    begin
        if Handled then
            exit;

        if not IsValidNumber(ObjectNumberRange) then
            error('The assigned numbers are outside the ALDA App-range!');

    end;

    local procedure IsValidNumber(var ObjectNumberRange: Record "ALDA Object Number Range"): Boolean
    var
        App: Record "ALDA App";
    begin
        App.get(ObjectNumberRange."ALDA App Code");

        exit((ObjectNumberRange."Object Id From" >= App."Number Range From") and (ObjectNumberRange."Object Id To" <= App."Number Range To"))
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateObjectNumberRange(var ObjectNumberRange: Record "ALDA Object Number Range"; var Handled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateObjectNumberRange();
    begin
    end;
}