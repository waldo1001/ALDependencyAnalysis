codeunit 99000 "ALDA Configuration"
{
    procedure GetConfiguration(var ALDAConfiguration: Record "ALDA Configuration")
    begin
        ALDAConfiguration.SetRange("Match WebUrl", CopyStr(GetUrl(ClientType::Web), 1, MaxStrLen(ALDAConfiguration."Match WebUrl")));
        ALDAConfiguration.FindFirst();
    end;

    // procedure InvokeAPICall(var ALDAConfiguration: Record "ALDA Configuration"; ApiPath: Text; QueryString: Text; RESTSOAPRequest: Codeunit "REST SOAP Request"): Text;
    // var
    //     RESTRequest: Record "REST Request";
    // begin
    //     if (not ALDAConfiguration.FindFirst()) then
    //         ALDAConfiguration.Init();
    //     ALDAConfiguration.TestField("REST Endpoint UID");

    //     clear(RESTRequest);
    //     RESTRequest."Endpoint UID" := ALDAConfiguration."REST Endpoint UID";
    //     RESTRequest.Method := RESTRequest.Method::Post;
    //     RESTRequest."Relative Path" := CopyStr(ApiPath, 1, MaxStrLen(RESTRequest."Relative Path"));
    //     RESTRequest."Query String" := CopyStr(QueryString, 1, MaxStrLen(RESTRequest."Query String"));
    //     RESTRequest."Content Type" := 'text/xml';
    //     RESTRequest.SetBodyContent(RESTSOAPRequest.GetSOAPEnvelope());
    //     RESTRequest.Insert(true);

    //     RESTRequest.UpsertHeader('SOAPAction', CopyStr(RESTSOAPRequest.GetSOAPAction(), 1, 200));

    //     Commit();
    //     exit(RESTRequest.InvokeAPICall());
    // end;
}