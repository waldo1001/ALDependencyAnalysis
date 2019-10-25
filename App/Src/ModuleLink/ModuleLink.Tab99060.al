table 99060 "ALDA Module Link"
{
    DataClassification = ToBeClassified;
    LookupPageId = "ALDA Module Links";
    DrillDownPageId = "ALDA Module Links";

    fields
    {
        field(10; "Source Module"; Code[20])
        {
            Caption = 'Source Module';
            DataClassification = ToBeClassified;
        }

        field(11; "Source Module Exists"; Boolean)
        {
            Caption = 'Source Module Exists';
            FieldClass = FlowField;
            CalcFormula = exist ("ALDA Module" where (Code = field ("Source Module")));
            Editable = false;
        }

        field(15; "Source Module App"; Code[20])
        {
            Caption = 'Source Module App';
            FieldClass = FlowField;
            CalcFormula = lookup ("ALDA Module".App where (Code = field ("Source Module")));
            Editable = false;
        }

        field(20; "Target Module"; Code[20])
        {
            Caption = 'Target Module';
            DataClassification = ToBeClassified;
        }

        field(21; "Target Module Exists"; Boolean)
        {
            Caption = 'Target Module Exists';
            FieldClass = FlowField;
            CalcFormula = exist ("ALDA Module" where (Code = field ("Target Module")));
            Editable = false;
        }

        field(25; "Target Module App"; Code[20])
        {
            Caption = 'Target Module App';
            FieldClass = FlowField;
            CalcFormula = lookup ("ALDA Module".App where (Code = field ("Target Module")));
            Editable = false;
        }

        field(50000; Modified; Boolean)
        {
            Caption = 'Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50010; Circular; Boolean)
        {
            Caption = 'Circular';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50020; "Self Reference"; Boolean)
        {
            Caption = 'Self Reference';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50030; Ignore; Boolean)
        {
            Caption = 'Ignore';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(99050; Links; Integer)
        {
            Caption = 'Links';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Element Link" where ("Source Module" = field ("Source Module"), "Target Module" = field ("Target Module"), Ignore = const (false)));
            Editable = false;
        }

        field(99051; Ignored; Integer)
        {
            Caption = 'Ignored';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Element Link" where ("Source Module" = field ("Source Module"), "Target Module" = field ("Target Module"), Ignore = const (true)));
            Editable = false;
        }

        field(99060; Link; Text[100])
        {
            Caption = 'Link';
            DataClassification = ToBeClassified;
        }
        field(99061; "Link Source"; Code[20])
        {
            Caption = 'Link Source';
            DataClassification = ToBeClassified;
        }

        field(99062; "Link Target"; Code[20])
        {
            Caption = 'Link Target';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Source Module", "Target Module")
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

    procedure ToggleIgnore()
    var
        ALDAModuleLink: Codeunit "ALDA Module Link";
    begin
        ALDAModuleLink.ToggleIgnore(Rec);
    end;

    procedure CalculateCircular()
    var
        ALDAModuleLink: Codeunit "ALDA Module Link";
    begin
        ALDAModuleLink.CalculateCircular(Rec);
    end;
}