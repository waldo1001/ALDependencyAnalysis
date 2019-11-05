codeunit 99001 "ALDA ShowFieldNos Meth"
{
    procedure ShowFieldNos(ObjectNumberRange: record "ALDA Object Number Range");
    var
        Handled: Boolean;
    begin
        OnBeforeShowFieldNos(Handled);

        DoShowFieldNos(ObjectNumberRange, Handled);

        OnAfterShowFieldNos();
    end;

    local procedure DoShowFieldNos(var ObjectNumberRange: record "ALDA Object Number Range"; var Handled: Boolean);
    begin
        if Handled then
            exit;

        ShowFieldNosPage(ObjectNumberRange);
    end;

    local procedure ShowFieldNosPage(var ObjectNumberRange: record "ALDA Object Number Range")
    var
        FieldNumberRange: Record "ALDA Field Number Range";
        FieldNumberRanges: page "ALDA Field number ranges";
    begin
        FieldNumberRanges.SetRecord(FieldNumberRange);
        FieldNumberRanges.SetTableView(FieldNumberRange);
        FieldNumberRanges.LookupMode(false);
        FieldNumberRanges.Editable(true);

        FieldNumberRanges.RunModal();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowFieldNos(var Handled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterShowFieldNos();
    begin
    end;
}