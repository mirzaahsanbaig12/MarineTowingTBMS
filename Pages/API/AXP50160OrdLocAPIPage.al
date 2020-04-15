page 50160 AXPOrdLocAPI
{
    PageType = API;
    APIPublisher = 'AXPULSE';
    APIGroup = 'SchedulerServices';
    APIVersion = 'v1.0';
    EntityName = 'OrdLoc';
    EntitySetName = 'OrdLocs';
    Caption = 'Ord Loc API';
    SourceTable = OrdLoc;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            field(ORDocNumber; ORDocNumber)
            {
            }
            field(LocationId; LocId)
            {
            }
            field(LineNumber; LineNumber)
            {
            }
            field(LocationName; LocationName)
            {
            }
            field(PositionType; PositionType)
            {
            }
            field(LocDetNumber; LocDetNumber)
            {
            }
        }
    }
}
