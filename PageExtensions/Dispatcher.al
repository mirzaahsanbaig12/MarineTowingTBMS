pageextension 50114 DispatcherExt extends "Service Dispatcher Role Center"
{
    layout
    {

    }

    actions
    {
        addafter(Customers)
        {

            action("Outbound Vessel")
            {
                ApplicationArea = All;
                RunObject = page "Outbound Ord Doc List";
            }

            action("Inbound Vessel")
            {
                ApplicationArea = All;
                RunObject = page "InBound Ord Doc List";
            }

            action("Logs")
            {
                ApplicationArea = All;
                RunObject = page "Log Billing List";
            }

            action("Vessel")

            {
                ApplicationArea = All;
                RunObject = page "Vessel Register List";
            }




        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}