table 99090 "ALDA Number Range Cue"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(20; "ALDA Apps"; Integer)
        {
            Caption = 'Apps';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA App");
        }
        field(30; "ALDA Modules"; Integer)
        {
            Caption = 'Modules';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Module");
        }
        field(40; "Number Ranges"; Integer)
        {
            Caption = 'Number Ranges';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Object Number Range");
        }
        field(50; "Field Nos"; Integer)
        {
            Caption = 'Field Nos';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Field Number Range");
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}