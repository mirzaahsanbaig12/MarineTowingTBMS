pageextension 50114 DispatcherExt extends "Service Dispatcher Role Center"
{
    layout
    {

    }

    actions
    {

        addafter("Service Management")
        {

            group(TBMS)
            {
                group(scheduler)
                {
                    action("Outbound Vessel1")
                    {
                        Caption = 'Outbound Vessel';
                        ApplicationArea = All;
                        RunObject = page "Outbound Ord Doc List";
                    }

                    action("Inbound Vessel1")
                    {
                        Caption = 'Inbound Vessel';
                        ApplicationArea = All;
                        RunObject = page "InBound Ord Doc List";
                    }
                }

                action("Logs1")
                {
                    Caption = 'Logs';
                    ApplicationArea = All;
                    RunObject = page "Log Billing List";
                }

                action("Vessel1")

                {
                    Caption = 'Vessel';
                    ApplicationArea = All;
                    RunObject = page "Vessel Register List";
                }
            }
        }
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