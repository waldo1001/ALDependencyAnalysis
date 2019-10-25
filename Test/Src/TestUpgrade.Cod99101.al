codeunit 99101 "ALDA Test Upgrade"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    var
        BASETestInstall: Codeunit "ALDA Test Install";
    begin
        BASETestInstall.SetupTestSuite();
    end;
}