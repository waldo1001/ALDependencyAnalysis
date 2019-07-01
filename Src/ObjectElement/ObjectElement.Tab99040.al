table 99040 "ALDA Object Element"
{
    DataClassification = ToBeClassified;
    LookupPageId = "ALDA Object Elements";
    DrillDownPageId = "ALDA Object Elements";

    fields
    {
        field(1; UID; Guid)
        {
            Caption = 'UID';
            DataClassification = ToBeClassified;
        }

        field(10; Element; Text[250])
        {
            Caption = 'Element';
            DataClassification = ToBeClassified;
        }

        field(50000; Modified; Boolean)
        {
            Caption = 'Modified';
            DataClassification = ToBeClassified;
        }
        field(99010; "Object UID"; Guid)
        {
            Caption = 'Object UID';
            DataClassification = ToBeClassified;
            TableRelation = "ALDA Model Object".UID;
            ValidateTableRelation = true;
        }
    }

    keys
    {
        key(PK; "UID")
        {
            Clustered = true;
        }

        key(Element; "Element")
        {

        }

        key(ObjectUID; "Object UID")
        {

        }
    }

    trigger OnModify()
    begin
        Modified := true;
    end;

    trigger OnDelete()
    begin
        Error('Not allowed');
    end;

    trigger OnRename()
    begin
        Error('Not allowed');
    end;

}