pageextension 50121 BusinessManagerExt extends "Business Manager Role Center"
{
    layout
    {

    }

    actions
    {
        addafter(Action39)
        {
            group(TBMS)
            {
                Caption = 'SmartList';
                Image = Journals;
                ToolTip = 'Tug Boat Management System';

                action("Customer List")
                {
                    Caption = 'Customer';
                    ApplicationArea = All;
                    RunObject = page "Customer List";
                }

                action("Contract")
                {
                    ApplicationArea = All;
                    RunObject = page "Contract List2";
                }
                action("Logs")
                {
                    ApplicationArea = All;
                    RunObject = page "Log Billing List";
                }

                group("Scheduler")
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


                }

                action("Tariff")
                {
                    ApplicationArea = All;
                    RunObject = page "Tariff Register List";
                }

                action("Dispatcher")
                {
                    ApplicationArea = All;
                    RunObject = page "Dispatcher Register List";
                }

                action("Company")
                {
                    ApplicationArea = All;
                    RunObject = page "Company Register List";
                }

                action("Vessel")
                {
                    ApplicationArea = All;
                    RunObject = page "Vessel Register List";
                }

                action("Tug Boat")
                {
                    ApplicationArea = All;
                    RunObject = page "Tug Boat Register List";
                }


                action("Captain")
                {
                    ApplicationArea = All;
                    RunObject = page "Captain Register List";

                }

                action("Pilot")
                {
                    ApplicationArea = All;
                    RunObject = page "Pilot Association List";
                }

                action("Location")
                {
                    ApplicationArea = All;
                    RunObject = page "Location Register List";
                }

                action("Port")
                {
                    ApplicationArea = All;
                    RunObject = page "Port Zone Register List";
                }

                action("Revenue")
                {
                    ApplicationArea = All;
                    RunObject = page "Revenue Tracking Register";
                }


                action("Fuel Cost")
                {
                    ApplicationArea = All;
                    RunObject = page "Fuel Cost List";
                }

                action("Invoice Notes")
                {
                    ApplicationArea = All;
                    RunObject = page "Invoice Notes List";
                }
            }

        }
    }

    var
        myInt: Integer;
}