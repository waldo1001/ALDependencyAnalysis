codeunit 99003 "ALDA SetDefaultRoleCenter"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Action Triggers", 'GetDefaultRoleCenterID', '', false, false)]
    local procedure SetMyRoleCenterDefault(var ID: Integer)
    begin
        ID := page::"ALDA Role Center";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Default Role Center", 'OnBeforeGetDefaultRoleCenter', '', false, false)]
    local procedure SetMyRoleCenterDefault2(var RoleCenterId: Integer; var Handled: Boolean)
    begin
        RoleCenterId := page::"ALDA Role Center";
        Handled := true;
    end;

}