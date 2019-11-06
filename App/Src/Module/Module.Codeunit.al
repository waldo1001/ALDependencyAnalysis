codeunit 99030 "ALDA Module"
{
    procedure MakeGraphText(var ALDAModule: Record "ALDA Module"): Text
    var
        ALDAModuleLink: Record "ALDA Module Link";
        GraphVizText: TextBuilder;
        Circle: Dictionary of [Text, Text];
        ALDAModuleLinkClass: Codeunit "ALDA Module Link";
        Module: Text;
        GraphvizTextItem: Text;
    // TempModuleLink: record "ALDA Module Link" temporary;
    begin
        //GraphVizText.AppendLine('digraph G {');

        GraphVizText.AppendLine('"' + ALDAModule.Code + '";');


        clear(ALDAModuleLink);
        ALDAModuleLink.SetRange("Source Module", ALDAModule.Code);
        //ALDAModuleLink.SetFilter(Links, '>%1', 0);
        ALDAModuleLink.SetRange("Self Reference", false);
        ALDAModuleLink.SetFilter(MultiLevelCircularCount, '>%1', 0);
        ALDAModuleLink.SetRange(Ignore, false);
        if (ALDAModuleLink.FindSet()) then
            repeat
                clear(Circle);
                Circle.Add(ALDAModuleLink."Source Module", '');
                ALDAModuleLinkClass.GetMultiLevelCircularWebGraphvizText(ALDAModuleLink, Circle);
                foreach GraphvizTextItem in Circle.Values() do
                    GraphVizText.AppendLine(GraphvizTextItem);

            until ALDAModuleLink.Next() < 1;
        // if ALDAModuleLink.FindFirst() then begin
        //     clear(Circle);
        //     ALDAModuleLinkClass.GetMultiLevelCircularWebGraphvizText(ALDAModuleLink, Circle, GraphVizText);
        // end;

        // message('Count TempModuleLink: %1', TempModuleLink.Count());


        //Direct Circular
        // clear(ALDAModuleLink);
        // ALDAModuleLink.SetRange("Source Module", ALDAModule.Code);
        // ALDAModuleLink.SetFilter(Links, '>%1', 0);
        // ALDAModuleLink.SetRange("Self Reference", false);
        // ALDAModuleLink.SetRange(Circular, true);
        // ALDAModuleLink.SetRange(Ignore, false);
        // if (ALDAModuleLink.FindSet()) then
        //     repeat
        //         GraphVizText.AppendLine(StrSubstNo('   "%1" -> "%2" [dir=both color="red"] ;', ALDAModuleLink."Source Module", ALDAModuleLink."Target Module"));
        //     until ALDAModuleLink.Next() < 1;


        clear(ALDAModuleLink);
        ALDAModuleLink.SetRange("Source Module", ALDAModule.Code);
        ALDAModuleLink.SetFilter(Links, '>%1', 0);
        ALDAModuleLink.SetRange("Self Reference", false);
        ALDAModuleLink.SetRange(Circular, false);
        ALDAModuleLink.SetRange(Ignore, false);
        if (ALDAModuleLink.FindSet()) then
            repeat
                GraphVizText.AppendLine(StrSubstNo('   "%1" -> "%2" ;', ALDAModuleLink."Source Module", ALDAModuleLink."Target Module"));
            until ALDAModuleLink.Next() < 1;

        clear(ALDAModuleLink);
        ALDAModuleLink.SetRange("Target Module", ALDAModule.Code);
        ALDAModuleLink.SetFilter(Links, '>%1', 0);
        ALDAModuleLink.SetRange("Self Reference", false);
        ALDAModuleLink.SetRange(Circular, false);
        ALDAModuleLink.SetRange(Ignore, false);
        if (ALDAModuleLink.FindSet()) then
            repeat
                GraphVizText.AppendLine(StrSubstNo('   "%1" -> "%2" ;', ALDAModuleLink."Source Module", ALDAModuleLink."Target Module"));
            until ALDAModuleLink.Next() < 1;



        // GraphVizText.AppendLine('}');

        exit(GraphVizText.ToText());
    end;

    procedure MakeFullGraphText(): Text;
    var
        ALDAModuleLink: Record "ALDA Module Link";
        GraphVizText: TextBuilder;
    begin
        ALDAModuleLink.SetRange(Ignore, false);
        ALDAModuleLink.SetRange("Self Reference", false);
        if ALDAModuleLink.FindSet() then
            repeat
                if ALDAModuleLink.Circular or (ALDAModuleLink.MultiLevelCircularCount > 0) then
                    GraphVizText.AppendLine(StrSubstNo('   "%1" -> "%2" [color="red"] ;', ALDAModuleLink."Source Module", ALDAModuleLink."Target Module"))
                else
                    GraphVizText.AppendLine(StrSubstNo('   "%1" -> "%2" ;', ALDAModuleLink."Source Module", ALDAModuleLink."Target Module"));

            until ALDAModuleLink.Next() < 1;

        exit(GraphVizText.ToText());
    end;


    // procedure MakeGraph(var ALDAModule: Record "ALDA Module")
    // var
    //     RESTRequest: Record "REST Request";
    //     ALDAConfiguration: record "ALDA Configuration";
    //     contentStream: InStream;
    //     GraphVizText: TextBuilder;
    // begin
    //     GraphVizText.AppendLine('digraph G {');
    //     GraphVizText.AppendLine(MakeGraphText(ALDAModule));
    //     GraphVizText.AppendLine('}');

    //     ALDAConfiguration.GetConfiguration();

    //     clear(RESTRequest);
    //     RESTRequest."Endpoint UID" := ALDAConfiguration."REST Endpoint UID";
    //     RESTRequest.Method := RESTRequest.Method::Post;
    //     RESTRequest.SetBodyContent(GraphVizText.ToText());
    //     RESTRequest.Insert(true);
    //     Commit();
    //     RESTRequest.InvokeAPICall();

    //     RESTRequest.CalcFields("Response Blob");

    //     RESTRequest."Response Blob".CreateInStream(contentStream);

    //     clear(ALDAModule.GraphMediaSet);
    //     //ALDAModule.Graph := RESTRequest."Response Blob";

    //     if (ALDAModule.GraphMediaSet.Count() > 0) then
    //         ALDAModule.GraphMediaSet.Remove(ALDAModule.GraphMediaSet.Item(1));
    //     ALDAModule.GraphMediaSet.ImportStream(contentStream, 'Test');
    //     //ALDAModule.GraphMedia.ImportStream(contentStream, 'Test');
    //     ALDAModule.Modify();

    // end;

    procedure ToggleIgnore(var ALDAModule: Record "ALDA Module")
    var
        ALDAModuleLink: Record "ALDA Module Link";
        lblConfirm: Label 'Are you sure you wish to toggle ignore for the complete module?';
    begin
        if GuiAllowed() then
            if not Confirm(lblConfirm, false) then
                exit;

        ALDAModuleLink.Reset();
        ALDAModuleLink.SetRange("Source Module", ALDAModule.Code);
        if ALDAModuleLink.FindSet() then
            repeat
                ALDAModuleLink.ToggleIgnore();
            until ALDAModuleLink.Next() = 0;

        ALDAModuleLink.Reset();
        ALDAModuleLink.SetRange("Target Module", ALDAModule.Code);
        if ALDAModuleLink.FindSet() then
            repeat
                ALDAModuleLink.ToggleIgnore();
            until ALDAModuleLink.Next() = 0;

        ALDAModule.NA := not ALDAModule.NA;
        ALDAModule.Modify(true);
    end;

    procedure IgnoreAllLinks(var ALDAModule: Record "ALDA Module")
    var
        ALDAModuleLink: Record "ALDA Module Link";
        lblConfirm: Label 'Are you sure you wish to ignore all links for the complete module?';
    begin
        if GuiAllowed() then
            if not Confirm(lblConfirm, false) then
                exit;

        ALDAModuleLink.Reset();
        ALDAModuleLink.SetRange("Source Module", ALDAModule.Code);
        ALDAModuleLink.SetRange(Ignore, false);
        if ALDAModuleLink.FindSet() then
            repeat
                ALDAModuleLink.ToggleIgnore();
            until ALDAModuleLink.Next() = 0;

        ALDAModuleLink.Reset();
        ALDAModuleLink.SetRange("Target Module", ALDAModule.Code);
        ALDAModuleLink.SetRange(Ignore, false);
        if ALDAModuleLink.FindSet() then
            repeat
                ALDAModuleLink.ToggleIgnore();
            until ALDAModuleLink.Next() = 0;
    end;
}