page 50164 AXPTugBoatAPI
{
    PageType = API;
    APIPublisher = 'AXPULSE';
    APIGroup = 'SchedulerServices';
    APIVersion = 'v1.0';
    EntityName = 'TugBoat';
    EntitySetName = 'TugBoats';
    Caption = 'Tug Boat API';
    SourceTable = "Tug Boat";
    DelayedInsert = true;
    Permissions = tabledata "Tug Boat" = r;
    Editable = false;
    layout
    {
        area(Content)
        {
            field(TugId; TugId)
            {
            }
            field(AccountCC; AccountCC)
            { }
            field(Class; Class)
            { }
            field(CmpId; CmpId)
            { }
            field(Memo; Memo)
            { }
            field(Name; Name)
            { }
            field(Power; Power)
            { }
            field(Status; Status)
            { }
            field(type; type)
            { }
        }
    }
}
