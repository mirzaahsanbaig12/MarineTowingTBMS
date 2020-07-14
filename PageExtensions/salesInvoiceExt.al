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
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}