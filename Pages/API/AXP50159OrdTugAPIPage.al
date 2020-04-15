page 50159 AXPOrdTugAPI
{
    PageType = API;
    APIPublisher = 'AXPULSE';
    APIGroup = 'SchedulerServices';
    APIVersion = 'v1.0';
    EntityName = 'OrdTug';
    EntitySetName = 'OrdTugs';
    Caption = 'Ord Tug API';
    SourceTable = OrdTug;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            field(ORDocNumber; ORDocNumber)
            {
            }
            field(LineItem; LineItem)
            {
            }
            field(TugDetNumber; TugDetNumber)
            {
            }
            field(TugId; TugId)
            {
            }
            field(confirmFlag; confirmFlag)
            {
            }
            field(TugLineItem; LineItem)
            {
            }
            field(TugName; TugName)
            {
            }
        }
    }
}