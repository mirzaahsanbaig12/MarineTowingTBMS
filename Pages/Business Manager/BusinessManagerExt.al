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

                //group("Smart List")
                //{
                /*action("Area State")
                {
                    ApplicationArea = All;
                    RunObject = page "Area State List";

                }
                */

                action("Captain")
                {
                    ApplicationArea = All;
                    RunObject = page "Captain Register List";

                }

                /*action("Traffic Type")
                {
                    ApplicationArea = All;
                    RunObject = page "Traffic Type";
                }
                */

                action("Revenue/Tracking")
                {
                    ApplicationArea = All;
                    RunObject = page "Revenue Tracking Register";
                }
                action("Port/Zone")
                {
                    ApplicationArea = All;
                    RunObject = page "Port Zone Register List";
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

                action("Tariff")
                {
                    ApplicationArea = All;
                    RunObject = page "Tariff Register List";
                }

                action("Tug Boat")
                {
                    ApplicationArea = All;
                    RunObject = page "Tug Boat Register List";
                }

                action("Location")
                {
                    ApplicationArea = All;
                    RunObject = page "Location Register List";
                }

                action("Pilot Association")
                {
                    ApplicationArea = All;
                    RunObject = page "Pilot Association List";
                }

                action("Vessel")
                {
                    ApplicationArea = All;
                    RunObject = page "Vessel Register List";
                }

                action("Customer List")
                {
                    ApplicationArea = All;
                    RunObject = page "Customer List";
                }

                action("Contract")
                {
                    ApplicationArea = all;
                    RunObject = page "Contract List";
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
            }


            //}
        }
    }

    var
        myInt: Integer;
}