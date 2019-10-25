table 99050 "ALDA Element Link"
{
    DataClassification = ToBeClassified;
    LookupPageId = "ALDA Element Links";
    DrillDownPageId = "ALDA Element Links";

    fields
    {
        field(1; UID; Guid)
        {
            Caption = 'UID';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(1000; "Source Object Type"; Code[20])
        {
            Caption = 'Source Object Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(1010; "Source Object ID"; Integer)
        {
            Caption = 'Source Object ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(1020; "Source Element"; Text[250])
        {
            Caption = 'Source Element';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(1030; "Source Module"; Text[20])
        {
            Caption = 'Source Module';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(2000; "Target Object Type"; Code[20])
        {
            Caption = 'Target Object Type';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(2010; "Target Object ID"; Integer)
        {
            Caption = 'Target Object ID';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(2020; "Target Element"; Text[250])
        {
            Caption = 'Target Element';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(2030; "Target Module"; Text[20])
        {
            Caption = 'Target Module';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50000; Modified; Boolean)
        {
            Caption = 'Modified';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50030; Ignore; Boolean)
        {
            Caption = 'Ignore';
            DataClassification = ToBeClassified;
        }

        field(50040; Remark; Text[200])
        {
            Caption = 'Remark';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "UID")
        {
            Clustered = true;
        }

        key(Module; "Source Module", "Target Module")
        {

        }

        key(SourceModule; "Source Module")
        {

        }

        key(TargetModule; "Target Module")
        {

        }

        key(SourceObject; "Source Object Type", "Source Object ID")
        {

        }

        key(TargetObject; "Target Object Type", "Target Object ID")
        {

        }
    }

    trigger OnInsert()
    begin
        SetLink();
    end;

    trigger OnModify()
    begin
        Modified := true;
        SetLink();
    end;

    trigger OnDelete()
    begin
        Error('Not allowed');
    end;

    trigger OnRename()
    begin
        Error('Not allowed');
    end;

    procedure SetLink()
    var
        ALDAModuleLink: Record "ALDA Module Link";
    begin
        if (("Source Module" = '') or ("Target Module" = '')) then
            exit;

        if (ALDAModuleLink.Get("Source Module", "Target Module")) then
            exit;

        clear(ALDAModuleLink);
        ALDAModuleLink."Source Module" := "Source Module";
        ALDAModuleLink."Target Module" := "Target Module";
        ALDAModuleLink.Insert();
    end;

    procedure ToggleIgnore()
    var
        ALDAElementLink: Codeunit "ALDA Element Link";
    begin
        ALDAElementLink.ToggleIgnore(Rec);
    end;
}