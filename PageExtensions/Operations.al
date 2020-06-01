pageextension 50115 Operations extends "Order Processor Role Center"
{
    actions
    {
        addafter(Action76)
        {
            group(TBMS)
            {
                Caption = 'TBMS';
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
                    RunObject = page "Contract List";
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

                action("Vessels")
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

                action("Zone")
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

                action("Compare Tariffs")
                {
                    ApplicationArea = All;
                    RunObject = report "Billing Tariff";
                }

                action("Billing Tariff")
                {
                    ApplicationArea = All;
                    Caption = 'Billing Tariff';
                    RunObject = report "Billing Tariff Single";
                }

                action("SalesOrder")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Orders';
                    RunObject = page "Sales Order List";
                }
            }
            // Add changes to page actions here
        }

    }
}