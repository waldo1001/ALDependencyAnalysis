table 99010 "ALDA Model Object"
{
    DataClassification = ToBeClassified;
    LookupPageId = "ALDA Model Objects";
    DrillDownPageId = "ALDA Model Objects";

    fields
    {
        field(1; UID; Guid)
        {
            Caption = 'UID';
            DataClassification = ToBeClassified;
        }
        field(10; "Object Type"; Code[20])
        {
            Caption = 'Object Type';
            DataClassification = ToBeClassified;
        }

        field(20; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            DataClassification = ToBeClassified;
        }

        field(30; "Object Name"; Text[50])
        {
            Caption = 'Object Name';
            DataClassification = ToBeClassified;
        }

        field(40; "Link Updated"; Boolean)
        {
            Caption = 'Link Updated';
            DataClassification = ToBeClassified;
        }

        field(50000; Modified; Boolean)
        {
            Caption = 'Modified';
            DataClassification = ToBeClassified;
        }

        field(99020; "Number Range"; Code[20])
        {
            Caption = 'Number Range';
            DataClassification = ToBeClassified;
            TableRelation = "ALDA Number Range".Code;
            ValidateTableRelation = true;
        }

        field(99030; Module; Code[20])
        {
            Caption = 'Module';
            DataClassification = ToBeClassified;
            TableRelation = "ALDA Module".Code;
            ValidateTableRelation = true;
        }

        field(99031; App; Code[20])
        {
            Caption = 'App';
            FieldClass = FlowField;
            CalcFormula = lookup ("ALDA Module".App where (Code = field (Module)));
            Editable = false;
        }

        field(99040; Elements; Integer)
        {
            Caption = 'Elements';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Object Element" where ("Object UID" = field (UID)));
            Editable = false;
        }

        field(99050; Using; Integer)
        {
            Caption = 'Using';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Element Link" where ("Target Object Type" = field ("Object Type"), "Target Object ID" = field ("Object ID")));
            Editable = false;
        }

        field(99051; "Used By"; Integer)
        {
            Caption = 'Used By';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Element Link" where ("Source Object Type" = field ("Object Type"), "Source Object ID" = field ("Object ID")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "UID")
        {
            Clustered = true;
        }
        key(Object; "Object Type", "Object ID")
        {
        }

        key(NumberRange; "Number Range")
        {

        }

        key(ObjectName; "Object Name")
        {

        }

        key(Module; "Module")
        {

        }
    }

    trigger OnModify()

    begin
        Modified := true;

        CopyDownModule();
    end;

    trigger OnDelete()
    begin
        Error('Not allowed');
    end;

    trigger OnRename()
    begin
        Error('Not allowed');
    end;

    procedure CopyDownModule()
    var
        ALDAModelObject: Codeunit "ALDA Model Object";
    begin
        ALDAModelObject.CopyDownModule(Rec);
    end;

}