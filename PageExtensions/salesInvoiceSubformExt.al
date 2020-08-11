pageextension 50125 SalesInvoiceLineExt extends "Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Posting Date"; "Posting Date")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter(Description)
        {
            field(LogDocNumber; LogDocNumber)
            {
                ApplicationArea = All;
                Caption = 'Log #';
                Editable = false;
                DrillDown = true;
                DrillDownPageId = "Log Billing";
            }

            field(LogJobType; LogJobType)
            {
                ApplicationArea = All;
            }

            field(TBMSlongDesc; TBMSlongDesc)
            {
                ApplicationArea = ALL;
            }
        }

        modify(Description)
        {
            Visible = false;
        }
    }

    actions
    {


        // Add changes to page actions here
    }

    var
        myInt: Integer;
}