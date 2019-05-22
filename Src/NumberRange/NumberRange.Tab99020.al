table 99020 "ALDA Number Range"
{
    DataClassification = ToBeClassified;
    LookupPageId = "ALDA Number Ranges";
    DrillDownPageId = "ALDA Number Ranges";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }

        field(10; "From ID"; Integer)
        {
            Caption = 'From ID';
            DataClassification = ToBeClassified;
        }

        field(20; "To ID"; Integer)
        {
            Caption = 'To ID';
            DataClassification = ToBeClassified;
        }

        field(50000; "Modified"; Boolean)
        {
            Caption = 'Modified';
            DataClassification = ToBeClassified;
        }

        field(99010; "Objects"; Integer)
        {
            Caption = 'Objects';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Model Object" where ("Number Range" = field (Code)));
            Editable = false;
        }

        field(99030; "Default Module"; Code[20])
        {
            Caption = 'Default Module';
            DataClassification = ToBeClassified;
            TableRelation = "ALDA Module".Code;
            ValidateTableRelation = true;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
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

    procedure SetDefaultModule()
    var
        ALDANumberRange: Codeunit "ALDA Number Range";
    begin
        ALDANumberRange.SetDefaultModule(Rec);
    end;

}