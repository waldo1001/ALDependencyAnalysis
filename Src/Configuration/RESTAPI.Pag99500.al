// page 99500 "ALDA REST API"
// {
//     PageType = API;
//     Caption = 'restApi';
//     APIPublisher = 'bartbourgeois';
//     APIGroup = 'navmgt';
//     //APIVersion = 'beta';
//     ChangeTrackingAllowed = true;
//     ODataKeyFields = UID;
//     EntityName = 'restRequest';
//     EntitySetName = 'restRequests';
//     SourceTable = "REST Request";
//     DelayedInsert = true;

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field("id"; "UID")
//                 {
//                     Caption = 'id';
//                     ApplicationArea = All;
//                 }

//                 field("method"; "Method")
//                 {
//                     Caption = 'method';
//                     ApplicationArea = All;
//                 }

//                 field("endpointName"; "Endpoint Name")
//                 {
//                     Caption = 'endpointName';
//                     ApplicationArea = All;
//                 }

//                 field("endpointBaseUri"; "Endpoint Base Uri")
//                 {
//                     Caption = 'endpointBaseUri';
//                     ApplicationArea = All;
//                 }

//                 field("createdDT"; "Created DT")
//                 {
//                     Caption = 'createdDT';
//                     ApplicationArea = All;
//                 }

//                 field("duration"; "Duration")
//                 {
//                     Caption = 'duration';
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

// }