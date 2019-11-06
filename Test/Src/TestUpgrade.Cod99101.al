codeunit 99101 "ALDA Test Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        TestInstall: Codeunit "ALDA Test Install";
    begin
        TestInstall.SetupTestSuite();
    end;

    procedure test(bleh: boolean)
    begin

    end;

    procedure testtest()
    begin
        test(true);
    end;
}