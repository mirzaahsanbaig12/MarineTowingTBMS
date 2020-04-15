page 50163 AXPVesselAPI
{
    PageType = API;
    APIPublisher = 'AXPULSE';
    APIGroup = 'SchedulerServices';
    APIVersion = 'v1.0';
    EntityName = 'Vessel';
    EntitySetName = 'Vessels';
    Caption = 'Vessel API';
    SourceTable = Vessel_PK;
    DelayedInsert = true;
    Permissions = tabledata Vessel_PK = r;
    Editable = false;
    layout
    {
        area(Content)
        {
            field(VesId; VesId)
            {
            }
            field(VesId50; VesId50)
            { }
            field(VesType; VesType)
            { }
            field(Tonnage; Tonnage)
            { }
            field(BusLa; BusLa)
            { }
            field(Status; Status)
            { }
            field(BusOc; BusOc)
            { }
            field(Name; Name)
            { }
            field(RevId; RevId)
            { }
            field(DefaultFlag; DefaultFlag)
            { }
            field(LockFlag; LockFlag)
            { }
        }
    }
}
