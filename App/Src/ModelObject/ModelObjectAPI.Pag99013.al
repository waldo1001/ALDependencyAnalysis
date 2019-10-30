page 99013 "ALDA Model Object API"
{
    PageType = API;
    Caption = 'restApi';
    APIPublisher = 'waldo';
    APIGroup = 'alDependency';
    APIVersion = 'v1.0';
    EntityName = 'alDAModelObject';
    EntitySetName = 'alDAModelObjects';
    ChangeTrackingAllowed = true;
    ODataKeyFields = UID;
    SourceTable = "ALDA Model Object";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(uid; "UID")
                {
                    Caption = 'uid';
                    ApplicationArea = All;
                }

                field(objectType; "Object Type")
                {
                    Caption = 'objectType';
                    ApplicationArea = All;
                }

                field(objectID; "Object ID")
                {
                    Caption = 'objectID';
                    ApplicationArea = All;
                }

                field(objectName; "Object Name")
                {
                    Caption = 'objectName';
                    ApplicationArea = All;
                }

                field(numberRange; "Number Range")
                {
                    Caption = 'numberRange';
                    ApplicationArea = All;
                }

                field(module; ModuleName)
                {
                    Caption = 'module';
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        ModuleName: code[20];

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ProcessModule();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        ProcessModule();
    end;

    local procedure ProcessModule()
    var
        ALDAModule: Record "ALDA Module";
    begin
        if ("Object ID" < 50000) or ("Object ID" > 99000000) then
            ModuleName := 'DEFAULT';

        if not ALDAModule.Get(ModuleName) then begin
            ALDAModule.Init();
            ALDAModule.validate(Code, ModuleName);
            ALDAModule.Insert(true);
        end;

        validate(Module, ModuleName);
    end;


}