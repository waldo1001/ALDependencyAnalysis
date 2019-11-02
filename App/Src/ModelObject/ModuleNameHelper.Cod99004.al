codeunit 99004 "ALDA Module Name Helper"
{
    Procedure GetModuleName(ObjectId: Integer; ObjectName: Text; ModuleName: Text): Text;
    begin
        if (ObjectId < 2000000) or (ObjectId > 99000000) then
            ModuleName := '_DEFAULT'
        else
            if strlen(ModuleName) > 5 then
                if ObjectName.ToLower().EndsWith('hook') then
                    ModuleName := '_HOOK'
                else
                    ModuleName := '_UNKNOWN';

        exit(ModuleName);
    end;

}