table 99080 "ALDA Field Number Range"
{
    DataClassification = ToBeClassified;
    LookupPageId = "ALDA Field Number Ranges";
    DrillDownPageId = "ALDA Field Number Ranges";

    fields
    {

        field(10; "Table Id"; Integer)
        {
            Caption = 'Object Id';
            DataClassification = SystemMetadata;
        }
        field(20; "Field Id"; Integer)
        {
            Caption = 'Field Id';
            DataClassification = SystemMetadata;
        }
        field(30; Comment; text[250])
        {
            Caption = 'Comment';
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; "Table Id", "Field Id")
        {
            Clustered = true;
        }
    }

}