page 50165 AXPLocationRegisterAPI
{
    PageType = API;
    APIPublisher = 'AXPULSE';
    APIGroup = 'SchedulerServices';
    APIVersion = 'v1.0';
    EntityName = 'LocRegister';
    EntitySetName = 'LocRegisters';
    Caption = 'Location Register API';
    SourceTable = "Location Register";
    DelayedInsert = true;
    Editable = false;
    Permissions = tabledata "Location Register" = r;
    layout
    {
        area(Content)
        {
            field(LocId; LocId)
            {
            }
            field(Description; Description)
            { }
            field(araId; araId)
            { }
            field(PrtId; PrtId)
            { }
            field(Status; Status)
            { }
            field(type; type)
            { }
        }
    }
}