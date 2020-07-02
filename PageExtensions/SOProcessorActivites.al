pageextension 50116 SOPrcoessorActivities extends "SO Processor Activities"
{
    layout
    {

        modify("Sales Quotes - Open")
        {
            Visible = false;
        }

        addafter("Sales Quotes - Open")
        {
            field(FuelCost; FuelCost)
            {
                ApplicationArea = all;
                DrillDownPageId = "Fuel Cost List";
            }
        }
        addafter("Sales Orders - Open")
        {




            field("AXP unposted sales Invoice Tot"; "AXP unposted sales Invoice Tot")
            {

                ApplicationArea = All;
                DrillDownPageId = "Sales Invoice List";
            }

            field("AXP posted sales Invoice Tot"; "AXP posted sales Invoice Tot")
            {
                ApplicationArea = All;
                DrillDownPageId = "Posted Sales Invoices";
            }

            field("AXP unposted purch Invoice Tot"; "AXP unposted purch Invoice Tot")
            {
                ApplicationArea = All;
                DrillDownPageId = "Purchase Invoices";
            }

            field("AXP posted purch Invoice Tot"; "AXP posted purch Invoice Tot")
            {
                ApplicationArea = All;
                DrillDownPageId = "Posted Purchase Invoices";
            }



            field("AXP unposted sales invoice"; "AXP unposted sales invoice")
            {
                ApplicationArea = All;
                DrillDownPageId = "Sales Invoice List";
            }

            field("AXP posted sales invoice"; "AXP posted sales invoice")
            {
                ApplicationArea = All;
                DrillDownPageId = "Posted Sales Invoices";
            }

            field("AXP unposted purchase invoice"; "AXP unposted purchase invoice")
            {
                Visible = false;
                ApplicationArea = All;
                DrillDownPageId = "Purchase Invoices";
            }

            field("AXP posted purchase invoice"; "AXP posted purchase invoice")
            {
                Visible = false;
                ApplicationArea = All;
                DrillDownPageId = "Posted Purchase Invoices";
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    begin
        FuelCost := GetFuelCost.GetFuelCost();
        CurrPage.Update();
    End;

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
    end;


    var
        FuelCost: Decimal;
        GetFuelCost: Codeunit GetData;
}