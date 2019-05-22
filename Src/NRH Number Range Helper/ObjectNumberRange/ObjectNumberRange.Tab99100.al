table 99100 "ALDA Object Number Range"
{
    DrillDownPageId = "ALDA Object Number Ranges";
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "ALDA App Code"; code[10])
        {
            Caption = 'ALDA App Code';
            TableRelation = "ALDA App".App;
            DataClassification = SystemMetadata;
        }
        field(20; "Module Code"; code[10])
        {
            Caption = 'Module Prefix';
            TableRelation = "ALDA module".Code;
            DataClassification = SystemMetadata;
        }
        field(40; "Object Id From"; Integer)
        {
            Caption = 'From';
            DataClassification = SystemMetadata;
        }
        field(50; "Object Id To"; Integer)
        {
            Caption = 'To';
            DataClassification = SystemMetadata;
        }
        field(60; "Comment"; text[250])
        {
            Caption = 'Comment';
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; "ALDA App Code", "Module Code", "Object Id From")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestField("ALDA App Code");
        TestField("Module Code");

        ValidateObjectNumberRange();
    end;

    procedure ShowFieldNos()
    var
        ShowFieldNosMeth: Codeunit "ALDA ShowFieldNos Meth";
    begin
        ShowFieldNosMeth.ShowFieldNos(Rec);
    end;

    procedure ValidateObjectNumberRange()
    var
        ValidateObjectNumberRangeMeth: Codeunit "ALDA ValidateObjNrRange Meth";
    begin
        ValidateObjectNumberRangeMeth.ValidateObjectNumberRange(Rec);
    end;
}