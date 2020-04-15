
page 50161 AXPAgentAPI
{
    PageType = API;
    APIPublisher = 'AXPULSE';
    APIGroup = 'SchedulerServices';
    APIVersion = 'v1.0';
    EntityName = 'Agent';
    EntitySetName = 'Agents';
    Caption = 'Agent API';
    SourceTable = Customer;
    SourceTableView = where(TBMSAgent = const(true));
    DelayedInsert = true;
    Permissions = tabledata Customer = r;
    Editable = false;
    layout
    {
        area(Content)
        {
            field(Name; Name)
            {
            }
            field(No; "No.")
            { }
        }
    }
}