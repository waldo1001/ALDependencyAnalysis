codeunit 99070 "ALDA App"
{

    local procedure AddTempLink(var ALDAModuleLinkTemp: record "ALDA Module Link" temporary; SourceApp: code[20]; TargetApp: code[20]; LinkSource: code[20]; LinkTarget: code[20])
    var
        ALDAApp: Record "ALDA App";
    begin
        ALDAapp.Get(SourceApp);
        if ALDAapp.NA then
            exit;

        ALDAApp.get(TargetApp);
        if ALDAApp.NA then
            exit;

        ALDAModuleLinkTemp.Reset();
        ALDAModuleLinkTemp.SetRange("Source Module", SourceApp);
        ALDAModuleLinkTemp.SetRange("Target Module", TargetApp);
        if ALDAModuleLinkTemp.IsEmpty() then begin
            ALDAModuleLinkTemp.Init();
            ALDAModuleLinkTemp."Source Module" := SourceApp;
            ALDAModuleLinkTemp."Target Module" := TargetApp;
            ALDAModuleLinkTemp."Link Source" := LinkSource;
            ALDAModuleLinkTemp."Link Target" := LinkTarget;
            ALDAModuleLinkTemp.Insert(false);
        end;
    end;

    local procedure GenerateTempTable(var ALDAModuleLinkTemp: record "ALDA Module Link" temporary; AppId: code[20]; FullGraph: Boolean)
    var
        ALDAModuleLink: Record "ALDA Module Link";
    begin
        ALDAModuleLinkTemp.Reset();
        ALDAModuleLinkTemp.DeleteAll();

        clear(ALDAModuleLink);
        ALDAModuleLink.SetAutoCalcFields("Source Module App", "Target Module App");
        if not FullGraph then
            ALDAModuleLink.SetRange("Source Module App", AppId)
        else
            ALDAModuleLink.setfilter("Source Module App", '<>%1', '');

        ALDAModuleLink.SetFilter("Target Module App", '<>%1', '');
        ALDAModuleLink.SetFilter(Links, '>%1', 0);
        ALDAModuleLink.SetRange("Self Reference", false);
        ALDAModuleLink.SetRange(Ignore, false);
        if (ALDAModuleLink.FindSet()) then
            repeat
                AddTempLink(ALDAModuleLinkTemp, ALDAModuleLink."Source Module App", ALDAModuleLink."Target Module App", ALDAModuleLink."Source Module", ALDAModuleLink."Target Module");
            until ALDAModuleLink.Next() < 1;

        if not FullGraph then begin
            clear(ALDAModuleLink);
            ALDAModuleLink.SetAutoCalcFields("Source Module App", "Target Module App");
            ALDAModuleLink.SetRange("Target Module App", AppId);
            ALDAModuleLink.SetFilter("Source Module App", '<>%1', '');
            ALDAModuleLink.SetFilter(Links, '>%1', 0);
            ALDAModuleLink.SetRange("Self Reference", false);
            ALDAModuleLink.SetRange(Ignore, false);
            if (ALDAModuleLink.FindSet()) then
                repeat
                    AddTempLink(ALDAModuleLinkTemp, ALDAModuleLink."Source Module App", ALDAModuleLink."Target Module App", ALDAModuleLink."Source Module", ALDAModuleLink."Target Module");
                until ALDAModuleLink.Next() < 1;
        end;
    end;

    local procedure CalculateCircular(var ALDAModuleLinkTemp: Record "ALDA Module Link" temporary)
    var
        ALDAModuleLinkFind: Record "ALDA Module Link" temporary;
    begin
        Clear(ALDAModuleLinkTemp);
        if ALDAModuleLinkTemp.FindSet() then
            repeat
                ALDAModuleLinkFind := ALDAModuleLinkTemp;
                ALDAModuleLinkFind.Insert();
            until ALDAModuleLinkTemp.Next() < 1;

        if ALDAModuleLinkTemp.FindSet() then
            repeat
                ALDAModuleLinkTemp."Self Reference" := ALDAModuleLinkTemp."Source Module" = ALDAModuleLinkTemp."Target Module";

                Clear(ALDAModuleLinkFind);
                ALDAModuleLinkFind.SetRange("Target Module", ALDAModuleLinkTemp."Source Module");
                ALDAModuleLinkFind.SetRange("Source Module", ALDAModuleLinkTemp."Target Module");
                ALDAModuleLinkFind.SetRange(Ignore, false);

                ALDAModuleLinkTemp.Circular := ((not ALDAModuleLinkTemp."Self Reference") AND ALDAModuleLinkFind.FindFirst());
                if ALDAModuleLinkTemp.Circular then
                    ALDAModuleLinkTemp.link := CopyStr(StrSubstNo('%1 - %2 \n %3 - %4', ALDAModuleLinkTemp."Link Source", ALDAModuleLinkTemp."Link Target", ALDAModuleLinkFind."Link Source", ALDAModuleLinkFind."Link Target"), 1, MaxStrLen(ALDAModuleLinkTemp.Link))
                else
                    ALDAModuleLinkTemp.link := '';//CopyStr(StrSubstNo('%1 - %2', ALDAModuleLinkTemp."Link Source", ALDAModuleLinkTemp."Link Target"), 1, MaxStrLen(ALDAModuleLinkTemp.Link));
                ALDAModuleLinkTemp.Modify();
            until ALDAModuleLinkTemp.Next() < 1;
    end;

    procedure MakeGraphText(var ALDAApp: Record "ALDA App"; FullGraph: Boolean): Text
    var
        ALDAAppAll: Record "ALDA App";
        ALDAModuleLinkTemp: Record "ALDA Module Link" temporary;
        GraphVizText: TextBuilder;
    begin

        GenerateTempTable(ALDAModuleLinkTemp, ALDAApp.App, FullGraph);
        CalculateCircular(ALDAModuleLinkTemp);
        if not FullGraph then
            GraphVizText.AppendLine('"' + ALDAApp.App + '";')
        else begin
            ALDAAppAll.Reset();
            ALDAAppAll.setrange(NA, false);
            if ALDAAppAll.FindSet() then
                repeat
                    GraphVizText.AppendLine('"' + ALDAAppAll.App + '";');
                until ALDAAppAll.Next() = 0;
        end;

        clear(ALDAModuleLinkTemp);
        if not FullGraph then
            ALDAModuleLinkTemp.SetRange("Source Module", ALDAApp.App);
        ALDAModuleLinkTemp.SetRange(Circular, true);
        ALDAModuleLinkTemp.SetRange("Self Reference", false);
        if (ALDAModuleLinkTemp.FindSet()) then
            repeat
                GraphVizText.AppendLine(StrSubstNo('   "%1" -> "%2" [dir=both color="red" label="%3"] ;', ALDAModuleLinkTemp."Source Module", ALDAModuleLinkTemp."Target Module", ALDAModuleLinkTemp.link));
            until ALDAModuleLinkTemp.Next() < 1;

        clear(ALDAModuleLinkTemp);
        if not FullGraph then
            ALDAModuleLinkTemp.SetRange("Source Module", ALDAApp.App);
        ALDAModuleLinkTemp.SetRange(Circular, false);
        ALDAModuleLinkTemp.SetRange("Self Reference", false);
        if (ALDAModuleLinkTemp.FindSet()) then
            repeat
                GraphVizText.AppendLine(StrSubstNo('   "%1" -> "%2" [label="%3"];', ALDAModuleLinkTemp."Source Module", ALDAModuleLinkTemp."Target Module", ALDAModuleLinkTemp.Link));
            until ALDAModuleLinkTemp.Next() < 1;

        if not FullGraph then begin
            clear(ALDAModuleLinkTemp);
            ALDAModuleLinkTemp.SetRange("Target Module", ALDAApp.App);
            ALDAModuleLinkTemp.SetRange("Self Reference", false);
            ALDAModuleLinkTemp.SetRange(Circular, false);
            if (ALDAModuleLinkTemp.FindSet()) then
                repeat
                    GraphVizText.AppendLine(StrSubstNo('   "%1" -> "%2" [label="%3"];', ALDAModuleLinkTemp."Source Module", ALDAModuleLinkTemp."Target Module", ALDAModuleLinkTemp.Link));
                until ALDAModuleLinkTemp.Next() < 1;
        end;

        exit(GraphVizText.ToText());
    end;

    // procedure MakeGraph(var ALDAApp: Record "ALDA App")
    // var
    //     RESTRequest: Record "REST Request";
    //     ALDAConfiguration: Record "ALDA Configuration";
    //     contentStream: InStream;
    //     GraphVizText: TextBuilder;
    // begin
    //     ALDAConfiguration.GetConfiguration();

    //     GraphVizText.AppendLine('digraph G {');
    //     GraphVizText.AppendLine(MakeGraphText(ALDAApp, false));
    //     GraphVizText.AppendLine('}');

    //     clear(RESTRequest);
    //     RESTRequest."Endpoint UID" := ALDAConfiguration."REST Endpoint UID";
    //     RESTRequest.Method := RESTRequest.Method::Post;
    //     RESTRequest.SetBodyContent(GraphVizText.ToText());
    //     RESTRequest.Insert(true);
    //     Commit();
    //     RESTRequest.InvokeAPICall();

    //     RESTRequest.CalcFields("Response Blob");

    //     RESTRequest."Response Blob".CreateInStream(contentStream);

    //     clear(ALDAApp.GraphMediaSet);

    //     if (ALDAApp.GraphMediaSet.Count() > 0) then
    //         ALDAApp.GraphMediaSet.Remove(ALDAApp.GraphMediaSet.Item(1));
    //     ALDAApp.GraphMediaSet.ImportStream(contentStream, 'Graph');
    //     ALDAApp.Modify();

    // end;
}