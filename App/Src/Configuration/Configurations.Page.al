page 99000 "ALDA Configurations"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ALDA Configuration";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; "Code")
                {
                    ApplicationArea = All;
                }

                field("Match WebUrl"; "Match WebUrl")
                {
                    ApplicationArea = All;
                }

                // field("REST Endpoint UID"; "REST Endpoint UID")
                // {
                //     ApplicationArea = All;
                // }

                // field("REST Endpoint Name"; "REST Endpoint Name")
                // {
                //     ApplicationArea = All;
                // }

                // field("REST Endpoint Base Uri"; "REST Endpoint Base Uri")
                // {
                //     ApplicationArea = All;
                // }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(Test)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                //RESTSOAPRequest: Codeunit "REST SOAP Request";
                begin
                    message(GetUrl(ClientType::Web));
                    /*
                    RESTSOAPRequest.CreateEnvelope('GetALDAChangesets', 'urn:microsoft-dynamics-schemas/codeunit/ALDA_Powershell');
                    RESTSOAPRequest.AddParameter('fromChangeSetID', 100);
                    RESTSOAPRequest.AddParameter('userCreated', '');
                    RESTSOAPRequest.AddParameter('commentFilter', '');
                    RESTSOAPRequest.AddParameter('environmentUID', 0);
                    RESTSOAPRequest.AddParameter('recordLimit', 10);
                    RESTSOAPRequest.AddParameter('taskIDFilter', '');
                    RESTSOAPRequest.AddParameter('ALDAChangesets', '');

                    Message(InvokeAPICall('/WS/iFacto%20NV/Codeunit/ALDA_Powershell', 'tenant=00000000', RESTSOAPRequest));
                    */
                end;
            }

            // action(Graphviz)
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedIsBig = true;

            //     trigger OnAction()
            //     var
            //         RESTRequest: Record "REST Request";
            //     begin

            //         clear(RESTRequest);
            //         RESTRequest."Endpoint UID" := 'B9EA4365-B5CD-45F9-9B65-ACBDA69AE190';
            //         RESTRequest.Method := RESTRequest.Method::Post;
            //         RESTRequest.SetBodyContent('digraph G { "Welcome" -> "To" "To" -> "Web" "To" -> "GraphViz!" }');
            //         RESTRequest.Insert(true);
            //         Commit();
            //         Message(format(RESTRequest.InvokeAPICall()));
            //     end;
            // }

            action(GraphvizContent)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ALDAModule: Record "ALDA Module";
                    GraphVizText: TextBuilder;
                begin
                    ALDAModule.SetRange(NA, false);
                    if (not ALDAModule.FindSet()) then
                        exit;

                    GraphVizText.AppendLine('digraph G {');

                    repeat
                        GraphVizText.AppendLine(ALDAModule.MakeGraphText());
                    until ALDAModule.Next() < 1;

                    GraphVizText.AppendLine('}');

                    Message(GraphVizText.ToText());
                end;
            }

        }
    }
}