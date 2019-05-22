table 99070 "ALDA App"
{
    DataClassification = ToBeClassified;
    LookupPageId = "ALDA Apps";
    DrillDownPageId = "ALDA Apps";

    fields
    {
        field(1; "App"; Code[20])
        {
            Caption = 'App';
            DataClassification = ToBeClassified;
        }

        field(10; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(20; "NA"; Boolean)
        {
            Caption = 'NA';
            DataClassification = ToBeClassified;
        }
        field(30; "Number Range From"; integer)
        {
            Caption = 'Number Range From';
            DataClassification = SystemMetadata;
        }
        field(40; "Number Range To"; Integer)
        {
            Caption = 'Number Range To';
            DataClassification = SystemMetadata;
        }


        field(1020; "GraphMediaSet"; MediaSet)
        {
            Caption = 'GraphMediaSet';
        }

        field(99011; "Codeunits"; Integer)
        {
            Caption = 'Codeunits';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Model Object" where (App = field (App), "Object Type" = const ('CODEUNIT')));
            Editable = false;
        }

        field(99030; "Modules"; Integer)
        {
            Caption = 'Modules';
            FieldClass = FlowField;
            CalcFormula = count ("ALDA Module" where (App = field (App)));
            Editable = false;
        }




    }

    keys
    {
        key(PK; "App")
        {
            Clustered = true;
        }
    }

    // procedure MakeGraph()
    // var
    //     ALDAApp: Codeunit "ALDA App";
    // begin
    //     ALDAApp.MakeGraph(Rec);
    // end;

    procedure MakeGraphText(): Text
    var
        ALDAApp: Codeunit "ALDA App";
    begin
        exit(ALDAApp.MakeGraphText(Rec, false));
    end;

    procedure MakeFullGraphText(): Text
    var
        ALDAApp: Codeunit "ALDA App";
    begin
        exit(ALDAApp.MakeGraphText(Rec, true));
    end;

}