page 50158 SchedulerAPIPage
{
    PageType = API;
    APIPublisher = 'AXPULSE';
    APIGroup = 'SchedulerServices';
    APIVersion = 'v1.0';
    EntityName = 'Scheduler';
    EntitySetName = 'Schedulers';
    Caption = 'Scheduler API';
    SourceTable = OrdDoc;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            field(ORDocNumber; ORDocNumber)
            {
            }
            field(DocumentType; DocType)
            {
            }
            field(DocumentDate; DocDate)
            {
            }
            field(SchedulerType; InboundOutbound)
            {
            }
            field(Agent; BusLA)
            {
            }
            field(LocationDetNumber; LocDetNumber)
            {
            }
            field(DispatcherMemo; DispatcherMemo)
            {
            }
            field(JobDate; JobDate)
            {
            }
            field(JobType; JobType)
            {
            }
            field(ManagerMemo; ManagerMemo)
            {
            }
            field(PilotId; PilId)
            {
            }
            field(Status; Status)
            {
            }
            field(Tonnage; Tonnage)
            {
            }
            field(TugOrderDescr; TugOrderDescr)
            {
            }
            field(VesselId; VesIdPk)
            {
            }
        }
    }
}
