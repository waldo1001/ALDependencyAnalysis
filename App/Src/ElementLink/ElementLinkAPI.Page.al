page 99053 "ALDA Element Link API"
{
    PageType = API;
    Caption = 'restApi';
    APIPublisher = 'waldo';
    APIGroup = 'alDependency';
    APIVersion = 'v1.0';
    EntityName = 'alDAElementLink';
    EntitySetName = 'alDAElementLinks';
    ChangeTrackingAllowed = true;
    ODataKeyFields = UID;
    SourceTable = "ALDA Element Link";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(uid; "UID")
                {
                    Caption = 'uid';
                    ApplicationArea = All;
                }

                field(sourceObjectType; "Source Object Type")
                {
                    Caption = 'sourceObjectType';
                    ApplicationArea = All;
                }

                field(sourceObjectID; "Source Object ID")
                {
                    Caption = 'sourceObjectID';
                    ApplicationArea = All;
                }
                field(sourceObjectName; SourceObjectNameTmp)
                {
                    Caption = 'sourceObjectName';
                    ApplicationArea = All;
                }

                field(sourceModule; SourceModuleTmp)
                {
                    Caption = 'sourceModule';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ALDAModuleNameHelper: Codeunit "ALDA Model Object";
                    begin
                        SourceModuleTmp := ALDAModuleNameHelper.GetModuleName("Source Object ID", SourceObjectNameTmp, SourceModuleTmp);
                        Validate("Source Module", SourceModuleTmp);
                    end;
                }

                field(sourceElement; "Source Element")
                {
                    Caption = 'sourceElement';
                    ApplicationArea = All;
                }

                field(targetObjectType; "Target Object Type")
                {
                    Caption = 'targetObjectType';
                    ApplicationArea = All;
                }

                field(targetObjectID; "Target Object ID")
                {
                    Caption = 'targetObjectID';
                    ApplicationArea = All;
                }
                field(targetObjectName; TargetObjectNameTmp)
                {
                    Caption = 'targetObjectName';
                    ApplicationArea = All;
                }

                field(targetModule; TargetModuleTmp)
                {
                    Caption = 'targetModule';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ALDAModuleNameHelper: Codeunit "ALDA Model Object";
                    begin
                        TargetModuleTmp := ALDAModuleNameHelper.GetModuleName("Target Object ID", TargetObjectNameTmp, TargetModuleTmp);
                        Validate("Target Module", TargetModuleTmp);
                    end;
                }

                field(targetElement; "Target Element")
                {
                    Caption = 'targetElement';
                    ApplicationArea = All;
                }

            }
        }
    }

    var
        SourceModuleTmp: Text;
        TargetModuleTmp: Text;
        SourceObjectNameTmp: Text;
        TargetObjectNameTmp: Text;

}