table 99000 "ALDA Configuration"
{
    DataClassification = ToBeClassified;
    LookupPageId = "ALDA Configurations";
    DrillDownPageId = "ALDA Configurations";

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }

        field(10; "Match WebUrl"; Code[200])
        {
            Caption = 'Match WebUrl';
            DataClassification = ToBeClassified;
        }

        // field(98010; "REST Endpoint UID"; Guid)
        // {
        //     Caption = 'Endpoint UID';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "REST Endpoint".UID;
        //     ValidateTableRelation = true;
        // }

        // field(98011; "REST Endpoint Name"; Code[30])
        // {
        //     Caption = 'Endpoint';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup ("REST Endpoint".Name where (uid = field ("REST Endpoint UID")));
        //     Editable = false;
        // }

        // field(98012; "REST Endpoint Base Uri"; Text[200])
        // {
        //     Caption = 'Base Uri';
        //     FieldClass = FlowField;
        //     CalcFormula = lookup ("REST Endpoint"."Base Uri" where (uid = field ("REST Endpoint UID")));
        //     Editable = false;
        // }

    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    procedure GetConfiguration()
    var
        ALDAConfiguration: Codeunit "ALDA Configuration";
    begin
        ALDAConfiguration.GetConfiguration(Rec);
    END;

    // procedure InvokeAPICall(ApiPath: Text; QueryString: Text; RESTSOAPRequest: Codeunit "REST SOAP Request"): Text;
    // var
    //     ALDAConfiguration: Codeunit "ALDA Configuration";
    // begin
    //     exit(ALDAConfiguration.InvokeAPICall(Rec, ApiPath, QueryString, RESTSOAPRequest));
    // end;

}