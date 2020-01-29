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
                Caption = 'TBMS';
                Image = Journals;
                ToolTip = 'Tug Boat Management System';
                group("Smart List")
                {
                    action("Area State")
                    {
                        ApplicationArea = All;
                        RunObject = page "Area State List";

                    }

                    action("Captain Register")
                    {
                        ApplicationArea = All;
                        RunObject = page "Captain Register List";

                    }

                    action("Traffic Type")
                    {
                        ApplicationArea = All;
                        RunObject = page "Traffic Type";

                    }

                    action("Revenue/Tracking Register")
                    {
                        ApplicationArea = All;
                        RunObject = page "Revenue Tracking Register";
                    }
                    action("Port/Zone Register")
                    {
                        ApplicationArea = All;
                        RunObject = page "Port Zone Register List";
                    }

                    action("Dispatcher Register")
                    {
                        ApplicationArea = All;
                        RunObject = page "Dispatcher Register List";
                    }

                    action("Company Register")
                    {
                        ApplicationArea = All;
                        RunObject = page "Company Register List";
                    }

                    action("Tariff Register")
                    {
                        ApplicationArea = All;
                        RunObject = page "Tariff Register List";
                    }

                    action("Tug Boat Register")
                    {
                        ApplicationArea = All;
                        RunObject = page "Tug Boat Register List";
                    }

                    action("Location")
                    {
                        ApplicationArea = All;
                        RunObject = page "Location Register List";
                    }


                    action("Address")
                    {
                        ApplicationArea = All;
                        RunObject = page "Address Register List";
                    }
                }


            }
        }
    }

    var
        myInt: Integer;
}