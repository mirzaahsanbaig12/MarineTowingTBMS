page 50162 AXPPilotAPI
{
    PageType = API;
    APIPublisher = 'AXPULSE';
    APIGroup = 'SchedulerServices';
    APIVersion = 'v1.0';
    EntityName = 'Pilot';
    EntitySetName = 'Pilots';
    Caption = 'Pilot API';
    SourceTable = Pilot;
    DelayedInsert = true;
    Permissions = tabledata Pilot = r;
    Editable = false;
    layout
    {
        area(Content)
        {
            field(PilId; PilId)
            {
            }
            field(PaId; PaId)
            { }
            field(Name; Name)
            { }
            field(Status; Status)
            { }
        }
    }
}
