codeunit 99100 "ALDA Test Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        SetupTestSuite();
    end;

    procedure SetupTestSuite()
    var
        ALTestSuite: Record "AL Test Suite";
        TestSuiteMgt: Codeunit "Test Suite Mgt.";
        SuiteName: Code[10];
        Me: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(Me);
        SuiteName := 'DEFAULT';//copystr(me.Name().ToUpper(), 1, MaxStrLen(SuiteName));

        if ALTestSuite.Get(SuiteName) then
            ALTestSuite.DELETE(true);

        TestSuiteMgt.CreateTestSuite(SuiteName);
        //Commit();
        ALTestSuite.Get(SuiteName);

        TestSuiteMgt.SelectTestMethodsByExtension(ALTestSuite, me.Id());
    end;
}